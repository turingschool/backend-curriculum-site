---
title: Factory Girl in Rails
length: 90
tags: factories, factory_girl, rails, testing, tdd
---

## Goals

* Configure a Rails app to use FactoryGirl's domain-specific language.
* Practice reading through documentation efficiently (find the most important information).
* Speak to the purposes of:
  * `trait` blocks
  * `before`, `after`, and  `trait` blocks
  * `sequencing` attributes
  * `transient` attributes
  * Creating multiple records
* Be able to create:
  * Factories without associations
  * Factories with associations
* Explain how to DRY up tests with factories.

## Structure

| 5  | Warm Up  |
| 20 | Examples |
| 5  | Break    |
| 25 | Examples |

## Warm Up

Bike Share show and tell: who had some ugly `Station.create(...)` chaos in their specs? It's okay. Here's one from my group's project:

```ruby
before do
  %w(Denver Aurora Centennial).each {|city| City.create(name: city) }
  %w(Subscriber Customer).each {|type| SubscriptionType.create(subscription_type: type) }
  denver, aurora, centennial = City.find(1), City.find(2), City.find(3)
  denver.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
  denver.stations.create(name: "San Jose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
  aurora.stations.create(name: "Jan Sose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
  aurora.stations.create(name: "Jan Sose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
  centennial.stations.create(name: "Naj Esos Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
  centennial.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
  Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 1, end_date: "2013-08-29", end_station_id: 2, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
  Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 2, end_date: "2013-08-29", end_station_id: 4, bike_id: 501, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
  Trip.create(duration: 100, start_date: "2013-07-30", start_station_id: 5, end_date: "2013-07-30", end_station_id: 1, bike_id: 50, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
  Trip.create(duration: 100, start_date: "2014-08-09", start_station_id: 4, end_date: "2014-08-10", end_station_id: 3, bike_id: 52, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
  Trip.create(duration: 100, start_date: "2013-01-02", start_station_id: 3, end_date: "2013-01-10", end_station_id: 5, bike_id: 20, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
  Trip.create(duration: 100, start_date: "1992-02-11", start_station_id: 6, end_date: "1992-02-11", end_station_id: 6, bike_id: 131, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
  WeatherCondition.create(date: "2013-08-29", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 2, mean_wind_speed_mph: 0, precipitation_inches: 0.0, zip_code: 94107)
  WeatherCondition.create(date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
  WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82, zip_code: 94107)
  WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1, zip_code: 94107)
  WeatherCondition.create(date: "1992-02-11", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
  WeatherCondition.create(date: "1991-01-02", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
end
```

## Lecture

A factory is an object whose job it is to create other objects. What's the purpose of Factory Girl? Check out [this StackOverflow answer](http://stackoverflow.com/questions/5183975/factory-girl-whats-the-purpose).

### Setup

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
```

* callbacks

```ruby
after(:build) # called after a factory is built (via FactoryGirl.build, FactoryGirl.create)
before(:create) # called before a factory is saved (via FactoryGirl.create)
after(:create) # called after a factory is saved (via FactoryGirl.create)

# E.g.,

factory :user do
  first_name "Joe"
  last_name  "Blow"
  email { "#{first_name}.#{last_name}@example.com".downcase }

  factory :user_with_profile do
    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end
```

* transient attributes:

```ruby
factory :post do
  trait :with_comments do
    transient do
      number_of_comments 3
    end

    after :create do |post, evaluator|
      create_list(:comment, evaluator.number_of_comments, post: post)
    end
  end
end
```

This allows:

```ruby
post = create(:post, :with_comments)
post.comments.count #=> 3
```

And transient attribtues can be modified:

```ruby
post = create(:post, :with_comments, number_of_comments: 10)
post.comments.count #=> 10
```

* Building or Creating Multiple Records

```ruby
built_users   = build_list(:user, 25)
created_users = create_list(:user, 10)

built_users.count #=> 25
created_users.count #=> 10
```

* sequences for attributes that need to be unique:

```ruby
# Defines a new sequence
FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

generate :email
# => "person1@example.com"

generate :email
# => "person2@example.com"
```

* associations

```ruby
FactoryGirl.define do
  factory :user do
    username 'rwarbelow'
  end

  factory :post do
    user
  end
end

create(:post).user #=> rwarbelow
```

* build on top of simple factories to customize

`test/factories/posts.rb`:

```ruby
FactoryGirl.define do
  # post factory (posts belong to users)
  factory :post do
    title "How to Use Factory Girl"
    user  # this will associate a user (created with the user factory) with this post
  end
end
```

`test/factories/users.rb`:

```ruby
FactoryGirl.define do
  factory :user do
    name "John Doe"

    factory :user_with_posts do
      transient do
        posts_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
```

This association will allow the following:

```ruby
create(:user).posts.length # => 0
create(:user_with_posts).posts.length # => 3
create(:user_with_posts, posts_count: 10).posts.length # => 10
```

* associations after create with traits:

```ruby
FactoryGirl.define do
  factory :post do
    title 'New post'
  end

  trait :with_comments do
    after :create do |post|
      FactoryGirl.create_list :comment, 3, post: post
    end
  end
end

FactoryGirl.create(:post, :with_comments)
```

### Tips

* don't use Faker for factories (Faker is better for seeds)
* test for explicit values -- avoid false positives

```ruby
FactoryGirl.define do
  factory :post do
    title { Forgery(:lorem_ipsum).words(5) }
  end
end

# don't do this:
describe 'Blog' do
  it 'should show the post title on the page' do
    post = create(:post)
    visit '/blog'
    expect(page).to have_content(post.title)
  end
end

# do this:
it 'should show the post title on the page' do
  post = create(:post, title: 'My example post')
  visit '/blog'
  page.should have_content('My example post')
end
```

* Set up RSpec and FactoryGirl before making any models. `rails g model ...` will automatically create factories upon running your model migrations.

## Closing

* Comfort with FactoryGirl docs?
* Configure RSpec for FactoryGirl syntax 
* `trait` blocks
* `before`, `after`, and  `trait` blocks
* `sequencing` attributes
* `transient` attributes
* Creating multiple records
* Factories without associations
* Factories with associations
* Tests and factories

### Further Reading

* [Getting Started with Factory Girl](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md)
* [Use Factory Girl's Build Stubbed for a Faster Test](https://robots.thoughtbot.com/use-factory-girls-build-stubbed-for-a-faster-test)
* [FactoryGirl Tips](http://arjanvandergaag.nl/blog/factory_girl_tips.html)

