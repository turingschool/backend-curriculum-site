---
layout: page
title: Testing with Fixtures
length: 60
tags: ruby, testing, fixtures, test helper
---

# Testing with Fixtures

## Learning Goals

* Implement a test helper
* Understand what test fixtures are and why they are useful
* Implement a test fixture

Slides [here](../slides/fixtures)

## Vocabulary 
* Test Fixture 

## Warmup

* What makes testing easy?
* What makes testing hard?
* What challenges are you finding in testing Black Thursday?
* What might be some disadvantages to testing with a large dataset?
* What might be some alternatives?

## Fixtures

You may not have fully noticed yet, but all that data processing we're testing is really starting to affect our test suite's performance. Let's see if we can _fix_ that up.

### Basics

* Create smaller copies of files you'll use in production
* Mimic a request to an external dependency within testing environment, making calls

Let's set up a quick `learning_fixtures` project folder in our `classwork` directory complete with `lib`, `data`, and `test` directories.

We're going to test-drive iterating over an absurdly long CSV.

But first, you'll need to download [this](https://gist.github.com/laurenfazah/3390b8417274f11dee87eef02ea3c4db) and save it in `data`.

Let's use our CSV knowledge to create a hash based on the values contained in the CSV. We'll just create a new hash based on a few _key_ headers and redefine those values with each new row in our CSV. We'll assert that the last `"EPISODE"` key's value is from the last row of the CSV.

Seem pointless? We really just want to create a task that will take significantly long to perform, but would be relatively quick with a customized fixture.

```ruby
# test/bob_test.rb

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/bob'

class BobTest < Minitest::Test
  def test_it_exists
    assert_instance_of Bob, Bob.new('./data/bob_elements.csv')
  end

  def test_time_to_run_long_iteration
    bob = Bob.new('./data/bob_elements.csv')

    assert_equal "S31E13", bob.final_episode
  end
end
```

## Test Helpers

Tired of writing all those `require` statements at the top of each file? Let's start thinking of our test files in a more DRY fashion.

Creating a `test_helper.rb` that our test files require allows us to store the rest of our repetitive setup in one centralized location.

```ruby
# test/test_helper.rb

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
```

Now you can remove that from your test and simply
```ruby
require './test/test_helper'
```

```ruby
# lib/bob.rb

require 'csv'
require 'pry'

class Bob
  
  def initialize(filepath)
    @filepath = filepath
  end

  def final_episode
    current_episode = {}
    
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      current_episode['episode_number'] = row[:episode]
    end
    
    current_episode['episode_number']
  end
  
end
```

```
> Want to see approximately how long your tests take to run? Use the `-v` flag when running your tests and Minitest will be more verbose.
```

Once this is running, let's speed things up with a `bob_elements_truncated.csv` fixture.

```
.
├── data
|   └── bob_elements.csv
├── lib
|   └── bob.rb
└── test
    ├── bob_test.rb
    ├── test_helper.rb
    └── fixtures
        └── bob_elements_truncated.csv
```

## Wrap-up

* Why would you want to use a test helper?
* How can test fixtures improve your testing suite?
* How many lines of data should you include in your fixture files?

