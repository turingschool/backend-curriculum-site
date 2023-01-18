---
layout: page
title: API Consumption in Ruby
tags: API, APIs, Ruby, refactoring, services
---

## Learning Goals
- Define and describe an API
- Implement an external API in Ruby with adherence to the single-responsibilty principle

## Vocabulary
- API
- JSON
- Response Object
- Service (in code)


## Intro

Today we are going to consume an API in Ruby.

At the end of this lesson, we will have created an application which will list out information about Studio Ghibli films using an external API.

## Setup

To start, let's create a directory for our code...

```
mkdir ghibli
cd ghibli
```

...and let's make a lib folder for our code.

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

gem 'httparty'
gem 'pry'
```

Now that we have our Gemfile in place, let's get the gem and its dependencies.

```
bundle install
```

Let's now make a file that we can work in... We'll call it `ghibli_films` beacuse we're searching for all of the Studio Ghibli films. 
```
touch lib/ghibli_films.rb
```


At the top of our new file, let's require the gems we'll need: 
```
require 'httparty'
require 'json'
require 'pry'
```

We are going to use HTTParty in order to reach out to our API and get the results. The endpoint we have to hit is `https://limitless-castle-00011.herokuapp.com/films`. (As of January 2023, an older service is no longer working, so there's no documentation for this new API yet.)

The basic syntax for how we can get a response from an API is `HTTParty.get()`, where we pass the URL for the endpoint as an argument as a string.

```
response = HTTParty.get("https://limitless-castle-00011.herokuapp.com/films")
```

The get method from HTTParty returns us a special **response object**. Let's throw a `binding.pry` in there and see what we get.
```
[{"id"=>"2baf70d1-42bb-4437-b551-e5fed5a87abe",
  "title"=>"Castle in the Sky",
  "original_title"=>"天空の城ラピュタ",
  "original_title_romanised"=>"Tenkū no shiro Rapyuta",
  "image"=>"https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg",
  "movie_banner"=>"https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
  "description"=>
   "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
  "director"=>"Hayao Miyazaki",
  "producer"=>"Isao Takahata",
  "release_date"=>"1986",
  "running_time"=>"124",
  "rt_score"=>"95",
  "people"=>
   ["https://limitless-castle-00011.herokuapp.com/people/598f7048-74ff-41e0-92ef-87dc1ad980a9",
    "https://limitless-castle-00011.herokuapp.com/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01",
    "https://limitless-castle-00011.herokuapp.com/people/3bc0b41e-3569-4d20-ae73-2da329bf0786",
    "https://limitless-castle-00011.herokuapp.com/people/40c005ce-3725-4f15-8409-3e1b1b14b583",
    "https://limitless-castle-00011.herokuapp.com/people/5c83c12a-62d5-4e92-8672-33ac76ae1fa0",
    "https://limitless-castle-00011.herokuapp.com/people/e08880d0-6938-44f3-b179-81947e7873fc",
    "https://limitless-castle-00011.herokuapp.com/people/2a1dad70-802a-459d-8cc2-4ebd8821248b"],
  "species"=>["https://limitless-castle-00011.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"],
  "locations"=>["https://limitless-castle-00011.herokuapp.com/locations/"],
  "vehicles"=>["https://limitless-castle-00011.herokuapp.com/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb"],
  "url"=>"https://limitless-castle-00011.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe"},
```
This looks like it's just JSON object, but it's actually a **response object**. We can verify this by calling the class method on it. HTTParty is designed to let us see the response's body if we just look at the object.

There's a lot of information in there, but we are really only concerned with the payload of the response, the meat, the information we are looking for, which is stored in the body.

So we look at what `response.body` will return.

```
"[\n  {\n    \"id\": \"2baf70d1-42bb-4437-b551-e5fed5a87abe\",\n    \"title\": \"Castle in the Sky\",\n    \"description\": \"The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.\",\n    \"director\": \"Hayao Miyazaki\",\n    \"producer\": \"Isao Takahata\",\n    \"release_date\": \"1986\",\n    \"rt_score\": \"95\",\n    \"people\": [\n      \"https://limitless-castle-00011.herokuapp.com/people/\"\n    ],\n    \"species\": [\n      \"https://limitless-castle-00011.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2\"\n    ],\n    \"locations\": [\n      \"https://limitless-castle-00011.herokuapp.com/locations/\"\n    ],\n    \"vehicles\": [\n      \"https://limitless-castle-00011.herokuapp.com/vehicles/\"\n    ],\n    \"url\": \"https://limitless-castle-00011.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe\"\n  },\n  {\n    \"id\": \"12cfb892-aac0-4c5b-94af-521852e46d6a\",\n    \"title\": \"Grave of the Fireflies\",\n    \"description\": \"In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.\",\n    \"director\": \"Isao Takahata\",\n    \"producer\": \"Toru Hara\",\n    \"release_date\": \"1988\",\n    \"rt_score\": \"97\",\n    \"people\": [\n      \"https://limitless-castle-00011.herokuapp.com/people/\"\n    ],\n    \"species\": [\n      \"https://limitless-castle-00011.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2\"\n    ],\n    \"locations\": [\n      \"https://limitless-castle-00011.herokuapp.com/locations/\"\n    ],\n    \"vehicles\": [\n      \"https://limitless-castle-00011.herokuapp.com/vehicles/\"\n    ],\n    \"url\": \"https://limitless-castle-00011.herokuapp.com/films/12cfb892-aac0-4c5b-94af-521852e46d6a\"\n  },\n  {\n    \"id\": \"58611129-2dbc-4a81-a72f-77ddfc1b1b49\",\n    \"title\": \"My Neighbor Totoro\",\n    \"description\": \"Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.\",\n    \"director\": \"Hayao Miyazaki\",\n    \"producer\": \"Hayao Miyazaki\",\n    \"release_date\": \"1988\",\n    \"rt_score\": \"93\",\n    \"people\": [\n      \"https://limitless-castle-00011.herokuapp.com/people/986faac6-67e3-4fb8-a9ee-bad077c2e7fe\",\n      \"https://limitless-castle-00011.herokuapp.com/people/d5df3c04-f355-4038-833c-83bd3502b6b9\",\n      \"https://limitless-castle-00011.herokuapp.com/people/3031caa8-eb1a-41c6-ab93-dd091b541e11\",\n
```

That's a JSON object, which is fine, but we don't want to work in JSON, we want to work in something we are familiar with and easier to handle, like a Ruby hash. So, how can we convert one to the other?

```
parsed = JSON.parse(response.body, symbolize_names: true)
```

The `symbolize_names: true` parameter converts the keys to symbols so we can use symbols instead of strings. Makes things a little lighter and easier to work with.

So, we now have this:

```
[{:id=>"2baf70d1-42bb-4437-b551-e5fed5a87abe",
  :title=>"Castle in the Sky",
  :description=>
   "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
  :director=>"Hayao Miyazaki",
  :producer=>"Isao Takahata",
  :release_date=>"1986",
  :rt_score=>"95",
  :people=>["https://limitless-castle-00011.herokuapp.com/people/"],
  :species=>["https://limitless-castle-00011.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"],
  :locations=>["https://limitless-castle-00011.herokuapp.com/locations/"],
  :vehicles=>["https://limitless-castle-00011.herokuapp.com/vehicles/"],
  :url=>"https://limitless-castle-00011.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe"},
 {:id=>"12cfb892-aac0-4c5b-94af-521852e46d6a",
  :title=>"Grave of the Fireflies",
  :description=>
   "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
  :director=>"Isao Takahata",
  :producer=>"Toru Hara",
  :release_date=>"1988",
  :rt_score=>"97",
  :people=>["https://limitless-castle-00011.herokuapp.com/people/"],
  :species=>["https://limitless-castle-00011.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"],
  :locations=>["https://limitless-castle-00011.herokuapp.com/locations/"],
...
```

When we look at the structure and shape of this parsed JSON, we see that we are getting an array of hashes, and each hash appears to be information about an individual film.

So now we have an array of hashes. Do we like this? Well, hashes are fine, but what we really want to do is create an object to represent our films.

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

Now, we can iterate over our array and create our objects.

```
films = parsed.map do |data|
  Film.new(data)
end
```

And we can loop through our collection of films, and print out the name and crew count of each.

```
films.each do |film|
  puts film.title
  puts "Directed By: #{film.director}"
  puts "Produced By: #{film.producer}"
  puts "Rotten Tomatoes Score: #{film.rotten_tomatoes}"
  puts ""
end
```

Run the base file and look at the output. Success! 

## Refactoring
Are we happy with the code that we've written here?

How do you think it could be improved?

Right now, we can think of the work that is being done by this code as divided into three pieces: 
1. display of the data, 
1. creation of the `Film` objects, 
1. talking to the API.

The first refactoring step would be to move everything into an **object** that will give us the results that we want.

```
class FilmSearch
  def film_information
    response = HTTParty.get("https://limitless-castle-00011.herokuapp.com/films")
    parsed_films = JSON.parse(response, symbolize_names: true)
    parsed_films.map do |data|
      Film.new(data)
    end
  end
end
```

This is a step in the right direction. But, if we were to describe the `film_information` method, it is still doing too much. The FilmSearch class should be responsible for taking information and formatting it, not reaching out to the API to get the appropriate information. What should be in charge of talking to API is what we call a **service**. We want to move the API specific bits to a service, because we might want to contact the API to get other information later.

Let's dream-drive our Search object a bit to make the code look like how we would want it to look.

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

This looks so much better. We're just instantiating a service and asking the service, "hey, get me the films." We can even take it one step further:

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

So now, let's move onto the service:

```
class GhibliService
  def films
    response = HTTParty.get("https://limitless-castle-00011.herokuapp.com/films")
    JSON.parse(response.body, symbolize_names: true)
  end
end
```

This is good so far, but if we want to reuse the service, we want to refactor this code even further so we can make this a bit more flexible:

```
class GhibliService
  def films
    get_url("https://limitless-castle-00011.herokuapp.com/films")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
```

## Practice

Write code to print out the names of all People from Studio Ghibili films.

Look through the rest of the JSON from the base request and figure out other GET requests you could make. 

## Extension

In addition to printing the name for each person, print out the name of each film they appear in.

There are multiple ways to go about this. Here are some tips:

* Don't be afraid to make multiple API calls
* Try to make the API do as much work for you as possible

## Checks for Understanding
1. What are some use cases for consuming an API?
1. What is the difference between a JSON object an an API's response object?
1. Why should we structure/refactor our code into objects and classes when consuming an API? 
