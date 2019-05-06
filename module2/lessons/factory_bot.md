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

This gets quite repetitive once multiple tests need that same data. FactoryBot becomes a tool we can leverage to remove this bloat from our test files.

Rather than taking the time and energy to hand-write each individual piece of data needed for a spec, we can set up "factories" for each resource we're using (`Song`, `Artist`, `Playlist`, etc.). These factories become available for us to use when and where we'd like throughout our tests.

Still not sure what the purpose of FactoryBot is? Check out [this StackOverflow answer](http://stackoverflow.com/questions/5183975/factory-girl-whats-the-purpose).

## Learning Goals

* Install and configure the FactoryBot gem in a rails application.
* Understand the relationship between FactoryBot and a test vs. development environment.
* Create a single object using FactoryBot syntax and methods.
* Create a relationship between two objects in a factory.

## Vocab
* test data
* factory
* dummy data

## WarmUp
* What has your experience been of creating the setup portion of each test?
* What strategies have you used to make things more DRY?

## Directions

We'll be working with our existing Jukebox Rails application to refactor existing (and passing) tests to use [FactoryBot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#configure-your-test-suite). This should give us plenty of comfort and agency to begin using FactoryBot on our own in future applications.

## FactoryBot Setup

In your Gemfile:

```ruby
group :development, :test do
  gem "factory_bot_rails"
end
```

#### Using RSpec

Create a directory for our configuration of FactoryBot   
`mkdir spec/support`  
Add a factory_bot.rb file.  
`touch spec/support/factory_bot.rb`

Inside of that file:  

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

### Example of Making an Artist

`spec/factories/artist.rb`:

```ruby
FactoryBot.define do
  factory :artist do
    name { "Imagine Dragons" }
  end
end
```

Pull up your feature test about "a user can create a song". Within this test you likely are creating a artist with something like `artist = Artist.create(name: "ArtistName")`

Having the above factory allows you to do this:

```ruby
# Unsaved artist, like doing Artist.new
artist = build(:artist)

# Saved artist, like doing Artist.create
artist = create(:artist)
```

**Overriding**  

When creating a new instance you can override attributes in factories `create(:artist, name: "Journey")`

**Lists**  

Want to create multiple of the same type of resource?

Let's look at our feature test about "users see all songs".

Here we are creating two songs. Let's DRY this up a bit.

We need to create the "factory" for it first in `spec/factories/song.rb`:

```ruby
FactoryBot.define do
  factory :song do
    title { "Billie Jean" }
    length { 5 }
    play_count { 0 }
  end
end
```

`songs = create_list(:songs, 2)`
or
`songs_1, songs_2 = create_list(:song, 2)`

In this case, this WON'T work for us, because Songs require that we have an artist associated with them (because of nested resources), so we need to associate these in a relationship check:


**Relationships**  

Want to create an object but it has a belongs_to and needs an associated object to be created? Now we have a artist or two created and two songs. We have more tools to DRY this up even more. If we create our song prepopulated with a artist, we don't need to create artists in our song index test.

```ruby
#spec/factories/song.rb

FactoryBot.define do
  factory :song do
    title { "Billie Jean" }
    length { 5 }
    play_count { 0 }
    artist
  end
end
```

The benefit to this is that our test no longer has to `create(:artist)`, just making a song will generate an artist for us as part of creating a song!


**Sequences**  

Want to create unique content? You might use a sequence to put a number in each value.
What if we want our songs to have different titles?

```ruby
#spec/factories/song.rb

FactoryBot.define do
  factory :song do
    sequence(:title) {|n| "Title #{n}" }
    sequence(:length) {|n| n*10 }
    play_count { 0 }
    artist
  end
end
```

**Alias**  

Want to call your factory "admin" but use the `Artist` class? Use an alias like this. You can call create(:admin) and it will give you a Artist object.

Maybe you want to be able to create a regular old artist as well as a super-artist of sorts, an `:admin`.

```ruby
#spec/factories/admin_artist.rb

FactoryBot.define do
  factory :admin, class: Artist do
    name "Queen"
  end
end
```

**Dynamic Values**

Want to be able to dynamically create values?

use `{Time.now}` instead of `"2015-03-05 11:14:47 -0700"`


### Additional Resources

- [FactoryBot Getting Started Guide](https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md)
- Work through this [playlist](https://www.youtube.com/playlist?list=PLf6E_SWaTZjH9V9-eeqH5oAXL-q7GcBm9) of tutorials alongside this clone [repository](https://github.com/turingschool-examples/factory_girl_intro).
  * **TIP**: Try increasing the speed of the videos once you get the hang of FactoryBot (settings in the gear button on the YouTube video frame).

## WrapUp

* How do you create a factory for a single resource?
* How do you create a factory for a resource that belongs_to another resource?
* Why might you use a tool like FactoryBot?
