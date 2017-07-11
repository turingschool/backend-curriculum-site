---
title: FactoryGirl
length: 60
tags: factorygirl, rails
---


# FactoryGirl

## Intro

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

This gets quite repetitive once multiple tests need that same data.

FactoryGirl becomes a tool we can leverage to remove this bloat from our test files. Rather than taking the time and energy to hand-write each individual piece of data needed for a spec, we can set up "factories" for each resource we're using (`Trip`, `Station`, `WeatherCondition`, etc.). These factories become available for us to use when and where we'd like throughout our tests.

Still not sure what the purpose of FactoryGirl is? Check out [this StackOverflow answer](http://stackoverflow.com/questions/5183975/factory-girl-whats-the-purpose).

## Directions

We'll be working with an existing Rails application to refactor existing (and passing) tests to use FactoryGirl. This should give us plenty of comfort and agency to begin using FactoryGirl on our own in future applications.

1. Clone down and set up [this repo](https://github.com/turingschool-examples/relationship_practice_exercises/tree/factory-girl).

2. Work through this [playlist](https://www.youtube.com/playlist?list=PLf6E_SWaTZjH9V9-eeqH5oAXL-q7GcBm9) of tutorials alongside the repository cloned in the step above.
  * **TIP**: Try increasing the speed of the videos once you get the hang of FactoryGirl (settings in the gear button on the YouTube video frame).

3. Head to the [FactoryGirl Docs](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#configure-your-test-suite) and try to implement the following:
  * Aliases
  * Inheritance
  * Dependent attributes
  * Overriding association attribtues
  * Generic sequences with `#generate` (e.g., the `name` attribute exists on many models)
  * More traits
  * Anything else that looks interesting to you!

## TLDR; FactoryGirl Setup

In your Gemfile:

```ruby
gem "factory_girl_rails"
```

#### Using RSpec

Create a file `spec/support/factory_girl.rb`. Inside of that file:

```ruby
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
```

This allows you to use FactoryGirl methods like `#create` in your RSpec files without explicitly declaring `FactoryGirl` before it. Instead of `FactoryGirl.create`, you can just call `create` on its own.

#### Using Test::Unit

Inside of `test/test_helper.rb`:

```ruby
class Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end
```

Factories are automatically loaded if they are in following directories:

```
# RSpec
spec/factories.rb
spec/factories/*.rb

# Test::Unit
test/factories.rb
test/factories/*.rb
```

### Example of `test/factories/users.rb`:

```ruby
FactoryGirl.define do
  factory :user do
    first_name "Taylor"
    last_name  "Swift"
    username   "tswizzle"
    admin      false
  end

  # Want to call your factory "admin" but use the `User` class? Use an alias like this.
  factory :admin, class: User do
    first_name "sally"
    last_name  "genericlastname"
    username   "sg"
    admin      true
  end
end
```

Having the above factory allows you to do this:

```ruby
# Unsaved user (Ruby land):
user = build(:user)

# Saved user (Ruby and database land):
user = create(:user)

# Admin user:
admin = create(:admin)

# Hash of attributes for a user:
attributes = attributes_for(:user)
```

* You can override attributes in factories with `create(:user, first_name: "Joe")`
* dynamic vs. static values: "2015-03-05 11:14:47 -0700", { Time.now } or lazy attributes with block:

```ruby
factory :user do
  # ...
  activation_code { User.generate_activation_code }
  date_of_birth   { 21.years.ago }
end
```

* dependent attributes:

```ruby
factory :user do
  first_name "Joe"
  last_name  "Blow"
  email { "#{first_name}.#{last_name}@example.com".downcase }
end

create(:user, last_name: "Doe").email
```

* shared traits:

```ruby
FactoryGirl.define do
  factory :post do
    title 'New post'
  end

  factory :page do
    title 'New page'
  end

  trait :published do
    published_at Date.new(2012, 12, 3)
  end

  trait :draft do
    published_at nil
  end
end

FactoryGirl.create(:post, :published)
FactoryGirl.create(:page, :draft)
