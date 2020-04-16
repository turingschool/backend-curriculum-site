---
layout: page
title: API Consumption in Ruby
tags: API, APIs, Ruby, refactoring, services
---



Today we are going to consume an API in Ruby.

What we are going to do is we are going to write a bit of code which will get all of the films listed in a Studio Ghibli api, and it will print out information about the films.

So let's create a directory for our code.

```
mkdir ghibli
cd ghibli
```

And let's make a lib folder for our code.

```
mkdir lib
```

To consume an API, we are going to have to bring in some gems. Let's create a `Gemfile` in our root directory and fill it with what we need.

```
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'faraday'
gem 'pry'
```

Now that we have our Gemfile in place, let's get the gem and its dependencies.

```
bundle install
```

Let's now make a file so that we can work.
```
touch lib/ghibli_films.rb
```

Calling it `ghibli_films` because I'm searching for all of the Studio Ghibli films.

At the top, lets
```
require 'faraday'
require 'json' 
require 'pry'
```

We are going to use Faraday in order to reach out to our API and get the results. We look at the documentation for the Ghibli Films API, `https://ghibliapi.herokuapp.com/#tag/Films` and we see that the endpoint we have to hit is `https://ghibliapi.herokuapp.com/films`

The basic syntax for how we can get a response from an API is `Faraday.get()`, where we pass the URL for the endpoint as an argument as a string.

```
response = Faraday.get("https://ghibliapi.herokuapp.com/films")
```

The get method from Faraday returns us a special response object. Let's throw a binding.pry in there and see what we get.
```
#<Faraday::Response:0x00007ff89e39b798
 @env=
  #<struct Faraday::Env
   method=:get,
   request_body=nil,
   url=#<URI::HTTPS https://ghibliapi.herokuapp.com/films>,
   request=
    #<struct Faraday::RequestOptions
     params_encoder=nil,
     proxy=nil,
     bind=nil,
     timeout=nil,
     open_timeout=nil,
     read_timeout=nil,
     write_timeout=nil,
     boundary=nil,
     oauth=nil,
     context=nil,
     on_data=nil>,
   request_headers={"User-Agent"=>"Faraday v1.0.1"},
   ssl=
    #<struct Faraday::SSLOptions
     verify=true,
     ca_file=nil,
     ca_path=nil,
     verify_mode=nil,
     cert_store=nil,
     client_cert=nil,
     client_key=nil,
     certificate=nil,
 ...
```

There's a lot of information in there, but we are really only concerned with the payload of the response, the meat, the information we are looking for, which is stored in the body.

So we look at what `response.body` will return.

```
"[\n  {\n    \"id\": \"2baf70d1-42bb-4437-b551-e5fed5a87abe\",\n    \"title\": \"Castle in the Sky\",\n    \"description\": \"The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.\",\n    \"director\": \"Hayao Miyazaki\",\n    \"producer\": \"Isao Takahata\",\n    \"release_date\": \"1986\",\n    \"rt_score\": \"95\",\n    \"people\": [\n      \"https://ghibliapi.herokuapp.com/people/\"\n    ],\n    \"species\": [\n      \"https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2\"\n    ],\n    \"locations\": [\n      \"https://ghibliapi.herokuapp.com/locations/\"\n    ],\n    \"vehicles\": [\n      \"https://ghibliapi.herokuapp.com/vehicles/\"\n    ],\n    \"url\": \"https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe\"\n  },\n  {\n    \"id\": \"12cfb892-aac0-4c5b-94af-521852e46d6a\",\n    \"title\": \"Grave of the Fireflies\",\n    \"description\": \"In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.\",\n    \"director\": \"Isao Takahata\",\n    \"producer\": \"Toru Hara\",\n    \"release_date\": \"1988\",\n    \"rt_score\": \"97\",\n    \"people\": [\n      \"https://ghibliapi.herokuapp.com/people/\"\n    ],\n    \"species\": [\n      \"https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2\"\n    ],\n    \"locations\": [\n      \"https://ghibliapi.herokuapp.com/locations/\"\n    ],\n    \"vehicles\": [\n      \"https://ghibliapi.herokuapp.com/vehicles/\"\n    ],\n    \"url\": \"https://ghibliapi.herokuapp.com/films/12cfb892-aac0-4c5b-94af-521852e46d6a\"\n  },\n  {\n    \"id\": \"58611129-2dbc-4a81-a72f-77ddfc1b1b49\",\n    \"title\": \"My Neighbor Totoro\",\n    \"description\": \"Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.\",\n    \"director\": \"Hayao Miyazaki\",\n    \"producer\": \"Hayao Miyazaki\",\n    \"release_date\": \"1988\",\n    \"rt_score\": \"93\",\n    \"people\": [\n      \"https://ghibliapi.herokuapp.com/people/986faac6-67e3-4fb8-a9ee-bad077c2e7fe\",\n      \"https://ghibliapi.herokuapp.com/people/d5df3c04-f355-4038-833c-83bd3502b6b9\",\n      \"https://ghibliapi.herokuapp.com/people/3031caa8-eb1a-41c6-ab93-dd091b541e11\",\n
```

That's a JSON object, which is fine, but we don't want to work in JSON, we want to work in something we are familiar with and easier to handle, a Ruby hash. So how can we convert one to the other?

```
parsed = JSON.parse(response.body, symbolize_names: true)
```

The `symbolize_names: true` converts the keys to symbols so we can use symbols instead of strings. Makes things a little lighter, and easier to work with.

So we now have this:

```
[{:id=>"2baf70d1-42bb-4437-b551-e5fed5a87abe",
  :title=>"Castle in the Sky",
  :description=>
   "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
  :director=>"Hayao Miyazaki",
  :producer=>"Isao Takahata",
  :release_date=>"1986",
  :rt_score=>"95",
  :people=>["https://ghibliapi.herokuapp.com/people/"],
  :species=>["https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"],
  :locations=>["https://ghibliapi.herokuapp.com/locations/"],
  :vehicles=>["https://ghibliapi.herokuapp.com/vehicles/"],
  :url=>"https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe"},
 {:id=>"12cfb892-aac0-4c5b-94af-521852e46d6a",
  :title=>"Grave of the Fireflies",
  :description=>
   "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
  :director=>"Isao Takahata",
  :producer=>"Toru Hara",
  :release_date=>"1988",
  :rt_score=>"97",
  :people=>["https://ghibliapi.herokuapp.com/people/"],
  :species=>["https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"],
  :locations=>["https://ghibliapi.herokuapp.com/locations/"],
...
```

When we look at the structure and shape of this parsed JSON, we see that we are getting an array of hashes, and each hash appears to be information about an individual film.

So now we have an array of hashes. Do we like this? Well hashes are fine, but what we want to really do is create an object to represent our ships.

```
class Film
  attr_reader :title,
              :description,
              :director,
              :producer,
              :release_date,
              :rotten_tomatoes
  def initialize(data)
  	@title = data[:title]
	@description = data[:description]
	@director = data[:director]
  	@producer = data[:producer]
  	@release_date = data[:release_date]
  	@rotten_tomatoes = data[:rt_score]
  end
end
```

And now we iterate over our array and create our objects.

```
films = parsed.map do |data|
  Film.new(data)
end
```

And we can loop through our collection of ships, and print out the name and crew count of each.

```
films.each do |film|
  puts film.title
  puts "Directed By: #{film.director}"
  puts "Produced By: #{film.producer}"
  puts "Rotten Tomatoes Score: #{film.rotten_tomatoes}"
  puts "" 
end
```
Are we happy with the code that we've written here?

How do you think it could be improved?

Right now we can think of the work that is being done by this code and divide it up into three pieces, the display of the data, the creation of the `Film` objects and the talking to the API.

The first refactoring step would be to move everything into an object that will give us the results that we want.

```
class FilmSearch
  def film_information
    response = Faraday.get("https://ghibliapi.herokuapp.com/films")
    parsed_films = JSON.parse(response, symbolize_names: true)
    parsed_films.map do |data|
      Film.new(data)
    end
  end
end
```

This is a step in the right direction. But if we were to describe the `film_information` method, it is still doing too much. The FilmSearch class should be responsible for taking information and formatting it, not reaching out to the API to get the appropriate information. What should be in charge of talking to API is what we call a service. We want to move the API specific bits to a service, because we might want to contact the API to get other information later.

Let's dream drive our Search object a bit to make the code look like how we would want it to look.

```
class FilmSearch
  def film_information
   service = GhibliService.new
    service.films.map do |data|
      Film.new(data)
    end
  end
end
```

This looks so much better. We're just instantiating a service and asking the service, hey get me the ships. We can take it one step further.

```
class FilmSearch
  def films
    service.films.map do |data|
      Film.new(data)
    end
  end

  def service
    GhibliService.new
  end
end
```

This is a little more reusable.

So now, let's move onto the service.

```
class GhibliService
  def films
    response = Faraday.get("https://ghibliapi.herokuapp.com/films")
    JSON.parse(response.body, symbolize_names: true)
  end
end
```

This is good so far, but if we want to reuse the service, we want to reuse some code we can make this a bit more flexible.

```
class GhibliService
  def films
    get_url("https://ghibliapi.herokuapp.com/films")
  end

  def get_url(url)
    response = Faraday.get(url)
    JSON.parse(response.body, symoblize_names: true)
  end
end
```

An alternative:

```
class GhibliService
  def films
    get_url("/films")
  end

  def get_url(url)
    response = Faraday.get("https://ghibliapi.herokuapp.com#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
```

