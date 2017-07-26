---
layout: page
title: Fixtures
---

## Learning Goals

*   Understand what a fixture is and how to create one

Slides [here](../slides/fixtures_mocks_stubs)

## Test Helper: A Preface

Tired of writing all those `require` statements at the top of each file? Let's start thinking of our test files in a more DRY fashion.

Creating a `test_helper.rb` that our test files require allows us to store the rest of our repetitive setup in one centralized location.

## Fixtures

You may not have fully noticed yet, but all that data processing we're testing is really starting to affect our test suite's performance. Let's see if we can _fix_ that up.

### Basics

*   Create smaller copies of files you'll use in production
*   Mimic a request to an external dependency within testing environment, making calls
Let's set up a quick `learning_fixtures` project folder in our `classwork` directory complete with `lib`, `data`, and `test` directories.

We're going to test-drive iterating over an absurdly long CSV.

But first, you'll need to download [this](https://gist.github.com/laurenfazah/3390b8417274f11dee87eef02ea3c4db) and save it in `data`.

Let's use our CSV knowledge create a hash based on the values contained in the CSV. We'll just create a new hash based on a few _key_ headers and redefine those values with each new row in our CSV. We'll assert that the last `"EPISODE"` key's value is from the last row of the CSV.

Seems pointless? We really just want to create a task that will take significantly long to perform, but would be relatively quick with a customized fixture.

```ruby
require 'csv'
require 'pry'

class Bob
  def initialize(filename)
    @filename = filename
  end

  def final_episode
    episode = {}

    CSV.foreach(@filename, headers: true) do |row|
      episode["EPISODE"] = row["EPISODE"]
    end

    episode["EPISODE"]
  end
end
```

```ruby
require './test/test_helper'
require './lib/bob'

class BobTest < Minitest::Test
  def test_it_exists
    assert_instance_of Bob, Bob.new('./data/bob_elements.csv')
  end

  def test_pointless_iteration
    bob = Bob.new('./data/bob_elements.csv')

    assert_equal "S31E13", bob.final_episode
  end
end
```

```
> Want to see approximately how long your tests take to run? Use the `-v` flag when running your tests and Minitest will be more verbose.
```

Once this is running, let's speed things up with a `bob_elements_truncated.csv` fixture.

## The Ultimate CFU

* How many lines of data should you include in your fixture files?

