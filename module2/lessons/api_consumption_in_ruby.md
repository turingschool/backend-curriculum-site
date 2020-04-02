---
layout: page
title: API Consumption in Ruby
tags: API, APIs, Ruby, refactoring, services
---



Today we are going to consume an API in Ruby.

What we are going to do is we are going to write a bit of code which will get all of the vehicles listed in the Star Wars api, and it will print out a name of the craft and the number of crew that it holds.

So let's create a directory for our code.

```
mkdir star_war
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
touch lib/crew_search.rb
```

Calling it `crew_search` because I'm searching for the crews of ships.

At the top, lets
```
require 'faraday'
```

We are going to use Faraday in order to reach out to our API and get the results. We look at the documentation for the Star Wars API, `https://swapi.co/documentation#vehicles` and we see that the endpoint we have to hit is `https://swapi.co/api/vehicles`

The basic syntax for how we can get a response from an API is `Faraday.get()`, where we pass the URL for the endpoint as an argument as a string.

```
response = Faraday.get("https://swapi.co/api/vehicles/")
```

The get method from Faraday returns us a special response object. Let's throw a binding.pry in there and see what we get.
```
#<Faraday::Response:0x00007fbdf55d1550
 @env=
  #<struct Faraday::Env
   method=:get,
   request_body=nil,
   url=#<URI::HTTPS https://swapi.co/api/vehicles>,
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
   request_headers={"User-Agent"=>"Faraday v1.0.0"},
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
     private_key=nil,
     verify_depth=nil,
     version=nil,
     min_version=nil,
     max_version=nil>,
   parallel_manager=nil,
   params=nil,
   response=#<Faraday::Response:0x00007fbdf55d1550 ...>,
   response_headers=
    {"date"=>"Thu, 27 Feb 2020 14:38:55 GMT",
```

There's a lot of information in there, but we are really only concerned with the payload of the response, the meat, the information we are looking for, which is stored in the body.

So we look at what `response.body` will return.

```
"{\"count\":39,\"next\":\"https://swapi.co/api/vehicles/?page=2\",\"previous\":null,\"results\":[{\"name\":\"Sand Crawler\",\"model\":\"Digger Crawler\",\"manufacturer\":\"Corellia Mining Corporation\",\"cost_in_credits\":\"150000\",\"length\":\"36.8\",\"max_atmosphering_speed\":\"30\",\"crew\":\"46\",\"passengers\":\"30\",\"cargo_capacity\":\"50000\",\"consumables\":\"2 months\",\"vehicle_class\":\"wheeled\",\"pilots\":[],\"films\":[\"https://swapi.co/api/films/5/\",\"https://swapi.co/api/films/1/\"],\"created\":\"2014-12-10T15:36:25.724000Z\",\"edited\":\"2014-12-22T18:21:15.523587Z\",\"url\":\"https://swapi.co/api/vehicles/4/\"},{\"name\":\"T-16 skyhopper\",\"model\":\"T-16 skyhopper\",\"manufacturer\":\"Incom Corporation\",\"cost_in_credits\":\"14500\",\"length\":\"10.4\",\"max_atmosphering_speed\":\"1200\",\"crew\":\"1\",\"passengers\":\"1\",\"cargo_capacity\":\"50\",\"consumables\":\"0\",\"vehicle_class\":\"repulsorcraft\",\"pilots\":[],\"films\":[\"https://swapi.co/api/films/1/\"],\"created\":\"2014-12-10T16:01:52.434000Z\",\"edited\":\"2014-12-22T18:21:15.552614Z\",\"url\":\"https://swapi.co/api/vehicles/6/\"},{\"name\":\"X-34 landspeeder\",\"model\":\"X-34 landspeeder\",\"manufacturer\":\"SoroSuub Corporation\",\"cost_in_credits\":\"10550\",\"length\":\"3.4\",\"max_atmosphering_speed\":\"250\",\"crew\":\"1\",\"passengers\":\"1\",\"cargo_capacity\":\"5\",\"consumables\":\"unknown\",\"vehicle_class\":\"repulsorcraft\",\"pilots\":[],\"films\":[\"https://swapi.co/api/films/1/\"],\"created\":\"2014-12-10T16:13:52.586000Z\",\"edited\":\"2014-12-22T18:21:15.583700Z\",\"url\":\"https://swapi.co/api/vehicles/7/\"},{\"name\":\"TIE/LN starfighter\",\"model\":\"Twin Ion Engine/Ln Starfighter\",\"manufacturer\":\"Sienar Fleet Systems\",\"cost_in_credits\":\"unknown\",\"length\":\"6.4\",\"max_atmosphering_speed\":\"1200\",\"crew\":\"1\",\"passengers\":\"0\",\"cargo_capacity\":\"65\",\"consumables\":\"2 days\",\"vehicle_class\":\"starfighter\",\"pilots\":[],\"films\":[\"https://swapi.co/api/films/2/\",\"https://swapi.co/api/films/3/\",\"https://swapi.co/api/films/1/\"],\"created\":\"2014-12-10T16:33:52.860000Z\",\"edited\":\"2014-12-22T18:21:15.606149Z\",\"url\":\"https://swapi.co/api/vehicles/8/\"},{\"name\":\"Snowspeeder\",\"model\":\"t-47 airspeeder\",\"manufacturer\":\"Incom corporation\",\"cost_in_credits\":\"unknown\",\"length\":\"4.5\",\"max_atmosphering_speed\":\"650\",\"crew\":\"2\",\"passengers\":\"0\",\"cargo_capacity\":\"10\",\"consumables\":\"none\",\"vehicle_class\":\"airspeeder\",\"pilots\":[\"https://swapi.co/api/people/1/\",\"https://swapi.co/api/people/18/\"],\"films\":[\"https://swapi.co/api/films/2/\"],\"created\":\"2014-12-15T12:22:12Z\",\"edited\":\"2014-12-22T18:21:15.623033Z\",\"url\":\"https://swapi.co/api/vehicles/14/\"},{\"name\":\"TIE bomber\",\"model\":\"TIE/sa bomber\",\"manufacturer\":\"Sienar Fleet Systems\",\"cost_in_credits\":\"unknown\",\"length\":\"7.8\",\"max_atmosphering_speed\":\"850\",\"crew\":\"1\",\"passengers\":\"0\",\"cargo_capacity\":\"none\",\"consumables\":\"2 days\",\"vehicle_class\":\"space/planetary bomber\",\"pilots\":[],\"films\":[\"https://swapi.co/api/films/2/\",\"https://swapi.co/api/films/3/\"],\"created\":\"2014-12-15T12:33:15.838000Z\",\"edited\":\"2014-12-22T18:21:15.667730Z\",\"url\":\"https://swapi.co/api/vehicles/16/\"},{\"name\":\"AT-AT\",\"model\":\"All Terrain Armored Transport\",\"manufacturer\":\"Kuat Drive Yards, Imperial Department of Military Research\",\"cost_in_credits\":\"unknown\",\"length\":\"20\",\"max_atmosphering_speed\":\"60\",\"crew\":\"5\",\"passengers\":\"40\",\"cargo_capacity\":\"1000\",\"consumables\":\"unknown\",\"vehicle_class\":\"assault walker\",\"pilots\":[],\"films\":[\"https://swapi.co/api/films/2/\",\"https://swapi.co/api/films/3/\"],\"created\":\"2014-12-15T12:38:25.937000Z\",\"edited\":\"2014-12-22T18:21:15.714673Z\",\"url\":\"https://swapi.co/api/vehicles/18/\"},{\"name\":\"AT-ST\",\"model\":\"All Terrain Scout Transport\",\"manufacturer\":\"Kuat Drive Yards, Imperial Department of Military Research\",\"cost_in_credits\":\"unknown\",\"length\":\"2\",\"max_atmosphering_speed\":\"90\",\"crew\":\"2\",\"passengers\":\"0\",\"cargo_capacity\":\"200\",\"consumables\":\"none\",\"vehicle_class\":\"walker\",\"pilots\":[\"https://swapi.co/api/people/13/\"],\"films\":[\"https://swapi.co/api/films/2/\",\"https://swapi.co/api/films/3/\"],\"created\":\"2014-12-15T12:46:42.384000Z\",\"edited\":\"2014-12-22T18:21:15.761584Z\",\"url\":\"https://swapi.co/api/vehicles/19/\"},{\"name\":\"Storm IV Twin-Pod cloud car\",\"model\":\"Storm IV Twin-Pod\",\"manufacturer\":\"Bespin Motors\",\"cost_in_credits\":\"75000\",\"length\":\"7\",\"max_atmosphering_speed\":\"1500\",\"crew\":\"2\",\"passengers\":\"0\",\"cargo_capacity\":\"10\",\"consumables\":\"1 day\",\"vehicle_class\":\"repulsorcraft\",\"pilots\":[],\"films\":[\"https://swapi.co/api/films/2/\"],\"created\":\"2014-12-15T12:58:50.530000Z\",\"edited\":\"2014-12-22T18:21:15.783232Z\",\"url\":\"https://swapi.co/api/vehicles/20/\"},{\"name\":\"Sail barge\",\"model\":\"Modified Luxury Sail Barge\",\"manufacturer\":\"Ubrikkian Industries Custom Vehicle Division\",\"cost_in_credits\":\"285000\",\"length\":\"30\",\"max_atmosphering_speed\":\"100\",\"crew\":\"26\",\"passengers\":\"500\",\"cargo_capacity\":\"2000000\",\"consumables\":\"Live food tanks\",\"vehicle_class\":\"sail barge\",\"pilots\":[],\"films\":[\"https://swapi.co/a
```

That's a JSON object, which is fine, but we don't want to work in JSON, we want to work in something we are familiar with and easier to handle, a Ruby hash. So how can we convert one to the other?

```
parsed = JSON.parse(response.body, symbolize_names: true)
```

The `symbolize_names: true` converts the keys to symbols so we can use symbols instead of strings. Makes things a little lighter, and easier to work with.

So we now have this:

```
{:count=>39,
 :next=>"https://swapi.co/api/vehicles/?page=2",
 :previous=>nil,
 :results=>
  [{:name=>"Sand Crawler",
    :model=>"Digger Crawler",
    :manufacturer=>"Corellia Mining Corporation",
    :cost_in_credits=>"150000",
    :length=>"36.8",
    :max_atmosphering_speed=>"30",
    :crew=>"46",
    :passengers=>"30",
    :cargo_capacity=>"50000",
    :consumables=>"2 months",
    :vehicle_class=>"wheeled",
    :pilots=>[],
    :films=>["https://swapi.co/api/films/5/", "https://swapi.co/api/films/1/"],
    :created=>"2014-12-10T15:36:25.724000Z",
    :edited=>"2014-12-22T18:21:15.523587Z",
    :url=>"https://swapi.co/api/vehicles/4/"},
   {:name=>"T-16 skyhopper",
    :model=>"T-16 skyhopper",
    :manufacturer=>"Incom Corporation",
    :cost_in_credits=>"14500",
    :length=>"10.4",
    :max_atmosphering_speed=>"1200",
    :crew=>"1",
    :passengers=>"1",
    :cargo_capacity=>"50",
    :consumables=>"0",
    :vehicle_class=>"repulsorcraft",
    :pilots=>[],
    :films=>["https://swapi.co/api/films/1/"],
    :created=>"2014-12-10T16:01:52.434000Z",
    :edited=>"2014-12-22T18:21:15.552614Z",
    :url=>"https://swapi.co/api/vehicles/6/"},
   {:name=>"X-34 landspeeder",
    :model=>"X-34 landspeeder",
    :manufacturer=>"SoroSuub Corporation",
    :cost_in_credits=>"10550",
```

When we look at the structure and shape of this parsed JSON, we see that what we really want is in the results key. The stuff outside of it has some data about the response, such as the total number of vehicles. But right now we just want the vehicles, so we can get to that array of vehicles with:

```
raw_vehicle_data = parsed[:results]
```

So now we have an array of hashes. Do we like this? Well hashes are fine, but what we want to really do is create an object to represent our ships.

```
class Ship
  attr_reader :name,
              :crew
  def initialize(data)
    @name = data[:name]
    @crew = data[:crew]
  end
end
```

And now we iterate over our array and create our objects.

```
ships = raw_vehicle_data.map do |data|
  Ship.new(data)
end
```

And we can loop through our collection of ships, and print out the name and crew count of each.

```
ships.each do |ship|
  puts "Ship: #{ship.name} : #{ship.crew}"
end
```
Are we happy with the code that we've written here?

How do you think it could be improved?

Right now we can think of the work that is being done by this code and divide it up into three pieces, the display of the data, the creation of the `Ship` objects and the talking to the API.

The first refactoring step would be to move everything into an object that will give us the results that we want.

```
class StarWarSearch
  def ship_crew_information
    response = Faraday.get("https://swapi.co/api/vehicles/")
    raw_ship_data = JSON.parse(response, symbolize_names: true)[:results]
    raw_ship_data.map do |data|
      Ship.new(data)
    end
  end
end
```

This is a step in the right direction. But if we were to describe the `ship_crew_information` method, it is still doing too much. The StarWarSearch class should be responsible for taking information and formatting it, not reaching out to the API to get the appropriate information. What should be in charge of talking to API is what we call a service. We want to move the API specific bits to a service, because we might want to contact the API to get other information later.

Let's dream drive our Search object a bit to make the code look like how we would want it to look.

```
class StarWarSearch
  def ship_crew_information
   service = StarWarService.new
    service.ships.map do |data|
      Ship.new(data)
    end
  end
end
```

This looks so much better. We're just instantiating a service and asking the service, hey get me the ships. We can take it one step further.

```
class StarWarSearch
  def ship_crew_information
    service.ships.map do |data|
      Ship.new(data)
    end
  end

  def service
    StarWarService.new
  end
end
```

This is a little more reusable.

So now, let's move onto the service.

```
class StarWarService
  def ships
    response = Faraday.get("https://swapi.co/api/vehicles/")
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
```

This is good so far, but if we want to reuse the service, we want to reuse some code we can make this a bit more flexible.

```
class StarWarService
  def ships
    get_url("https://swapi.co/api/vehicles/")

  end

  def get_url(url)
    response = Faraday.get(url)
    JSON.parse(response.body, symoblize_names: true)[:results]
  end
end
```

An alternative:

```
class StarWarService
  def ships
    get_url("/vehicles/")
  end

  def planets
    get_url("/planets/")
  end

  def get_url(url)
    response = Faraday.get("https://swapi.co/api#{url}")
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
```



