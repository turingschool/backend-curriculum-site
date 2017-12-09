---
title: FactoryBot
length: 60
tags: factorygirl, rails, testing, tdd
---

## Intro to Factory Bot

By now we've test-driven a few different Rails applications. We know RSpec is our friend, but it might not be evident by the amount of "seed" data we need to set up for each of our tests.

Does this look familiar?

```ruby
%w(Denver Aurora Centennial).each {|city| City.create(name: city) }
denver, aurora, centennial = City.find(1), City.find(2), City.find(3)
denver.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
aurora.stations.create(name: "Jan Sose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
aurora.stations.create(name: "Jan Sose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
centennial.stations.create(name: "Naj Esos Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
centennial.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 1, end_date: "2013-08-29", end_station_id: 2, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 2, end_date: "2013-08-29", end_station_id: 4, bike_id: 501, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
Trip.create(duration: 100, start_date: "2013-07-30", start_station_id: 5, end_date: "2013-07-30", end_station_id: 1, bike_id: 50, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82, zip_code: 94107)
WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1, zip_code: 94107)
```

This gets quite repetitive once multiple tests need that same data. FactoryGirl becomes a tool we can leverage to remove this bloat from our test files.

Rather than taking the time and energy to hand-write each individual piece of data needed for a spec, we can set up "factories" for each resource we're using (`Movie`, `Director`, `Actor`, etc.). These factories become available for us to use when and where we'd like throughout our tests.

Still not sure what the purpose of FactoryGirl is? Check out [this StackOverflow answer](http://stackoverflow.com/questions/5183975/factory-girl-whats-the-purpose).

## Learning Goals

* Install and configure the FactoryBot gem in a rails application.
* Understand the relationship between FactoryBot and a test vs. development environment.
* Create a single object using FactoryBot syntax and methods.
* Create a relationship between two objects in a factory.

## Vocab
* test data
* factory 
* dummy data

## Directions

We'll be working with our existing Rails (`movie_mania`) application to refactor existing (and passing) tests to use FactoryBot. This should give us plenty of comfort and agency to begin using FactoryBot on our own in future applications.

## FactoryGirl Setup

In your Gemfile:

```ruby
group :development, :test do
  gem "factory_bot_rails"
end
```

#### Using RSpec

Create a directory and file `spec/support/factory_bot.rb`. Inside of that file:

```ruby
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

This allows you to use FactoryBot methods like `#create` in your RSpec files without explicitly declaring `FactoryBot` before it. Instead of `FactoryBot.create`, you can just call `create` on its own.

The following line should currently be commented out in `rails_helper.rb`. Find it and uncomment it. This line will allow us to require all ruby files that we put inside of the `spec/support` directory.

```ruby
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
```

Factories are automatically loaded if they are in the following directories:

```
# RSpec
spec/factories.rb
spec/factories/*.rb
```

### Example of `spec/factories/directors.rb`:

```ruby
FactoryBot.define do
  factory :director do
    name "Ilana Corson"
  end
end
```

Having the above factory allows you to do this:

```ruby
#from a test somewhere

# Unsaved director (Ruby land):
director = build(:director)

# Saved director (Ruby and database land):
director = create(:director)

# Admin director:
admin = create(:admin)
```

* alias
Want to call your factory "admin" but use the `Director` class? Use an alias like this. You can call create(:admin) and it will give you a Director object.

```
FactoryBot.define do
  factory :admin, class: Director do
    name "Ilana Corson"
  end
end
```

* relationships
Want to create an object but it has a belongs_to and needs an associated object to be created?

```ruby
#spec/factories/movies.rb
factory :movie do
  title "Joe Black"
  description  "Maybe brad pitt is in it?"
  director
end
```

* sequences
Want to create unique content? You might use a sequence to put a number in each value.

```ruby
factory :movie do
  sequence(:title) {|n| "Title #{n}" }
  sequence(:description) {|n| "This is a description #{n}" }
end
```

* overriding 
When creating a new instance you can override attributes in factories `create(:director, name: "Sal Espinosa")`

* lists 
Want to create multiple of the same type of resource?  
`directors = create_list(:director, 2)`
or 
`director_1, director_2 = create_list(:director, 2)`


* Dynamic Values
Want to be able to dynamically create values?
use `{Time.now}` instead of `"2015-03-05 11:14:47 -0700"`


### Additional Resources

- Work through this [playlist](https://www.youtube.com/playlist?list=PLf6E_SWaTZjH9V9-eeqH5oAXL-q7GcBm9) of tutorials alongside this clone [repository](https://github.com/turingschool-examples/factory_girl_intro) . 
  * **TIP**: Try increasing the speed of the videos once you get the hang of FactoryBot (settings in the gear button on the YouTube video frame).

## WrapUp
* How do you create a factory for a single resource?
* How do you create a factory for a resource that belongs_to another resource?
* Why might you use a tool like FactoryBot?
