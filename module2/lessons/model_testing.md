---
layout: page
title: Model Testing
tags: rails, models, testing
---

## Learning Goals

* Write model tests for relationships
* Become familiar with the ShouldaMatchers gem
* Write model tests for class and instance methods

## Setup

This lesson builds off of the [Feature Testing Lesson](./feature_testing). You can find the completed code from this lesson on the `feature_testing` branch of [this repo](https://github.com/turingschool-examples/set_list/tree/feature_testing)

## Why Model Test?

As Backend developers, our job is to handle data. We need to add data, retrieve data, manipulate data, validate data, analyze data, etc. and we cannot afford to have any errors when handling data. Since our Models are the thing in our Rails apps that interact with the data, we write tests specifically for the models to ensure that we are handling data properly. These tests should fully cover all of the data logic in our application.

## Shouldamatchers

We're going to use the handy dandy gem [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) to give us some streamlined syntax to use in testing our validations and relationships.

- Add `gem 'shoulda-matchers', '~> 3.1'` to `group :development, :test` in your `Gemfile`  
- run `bundle install`
- Put the following in `rails_helper.rb`:

```ruby
Shoulda::Matchers.configure do |config|
 config.integrate do |with|
   with.test_framework :rspec
   with.library :rails
 end
end
```

## Testing Relationships

The first thing we are going to test is our Model Relationships. Let's start by creating a test file for the Song class:

`mkdir spec/models`  
`touch spec/models/artist_spec.rb`

It is important that these folders are named `spec` and `models`, respectively.

In our new test file, add the following:


```ruby
require 'rails_helper'

describe Artist, type: :model do

end
```

This is the basic set up for any model test. `describe Artist` tells our test that we are testing the Artist class. `type: :model` tells our test that it is a model test. You can optionally leave this out since our test will recognize that it is a model test because it is defined inside `spec/models`. Yes, the name of the folders and files will affect how your tests run.

Inside our model test, let's add a section for relationship tests, as well as a test for the Song relationship:

```ruby
require 'rails_helper'

describe Artist, type: :model do
  describe 'relationships' do
    it { should have_many :songs }
  end
end
```

This test is taking advantage of the Shouldamatchers syntax for testing relationships.

## Testing Methods

We also need to test any methods that we create on our models. Let's add a test for our `average_song_length` method:

```ruby
require 'rails_helper'

describe Artist, type: :model do
  describe 'relationships' do
    it { should have_many :songs }
  end

  describe 'instance methods' do
    describe '#average_song_length' do
      it 'returns the average song length' do
        talking_heads = Artist.create!(name: 'Talking Heads')
        she_was = talking_heads.songs.create!(title: 'And She Was', length: 234, play_count: 34)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45)

        expect(talking_heads.average_song_length).to eq(345)
      end
    end
  end
end
```

Additionally, we said early that our model tests should **fully** cover our models. This means that it would be a good idea to also test for some edge cases.

## Practice

* Add a test for the `average_song_length` method that ensures that this method works when the result is not a whole number
* Add a test for the `average_song_length` method that checks what value should be returned when an artist has no songs
* Create a Song model test that includes a test for the relationship to an Artist
* Create a test for a method on the Song model that finds the number of songs above a given threshold for play_count
* Write a test that finds the two shortest songs by length
