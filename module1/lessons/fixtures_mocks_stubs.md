---
layout: page
title: Fixtures, Mocks and Stubs
---

## Learning Goals

*   Understand what stubbing is, how to stub in Ruby with Minitest, when to use it
*   Understand what mocking is, how to mock in Ruby with Minitest, and when to use it
*   Understand what a fixture is and how to create one
*   What’s the difference between behavior and state testing

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

## Mocks and Stubs

To get access to methods that create mocks and stubs, we'll need to install and require `mocha`.

```bash
gem install mocha
```

Once that's set, require `mocha/mini_test` in your test_helper.rb.

### Mocks

Mocks are objects that stand in for other objects. The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation.

Let's imagine we wanted to test `Bob`'s `paint_palatte` method to see that it returns a collection of `Paint` instances.

Does it seem entirely necessary to create and test `Paint` instances within a `BobTest`?

#### A First Mock

A mock is a simple object that stands in for another object. At the base level, a mock is just a "thing" -- a blank canvas that we can use for just about anything. You create a mock like this:

```ruby
my_thing = mock('name')
```

Looks weird, right? Read this code carefully and figure out:

* what is `mock`, from a Ruby perspective? (like an "object", "integer", what?)
* what type thing is `'name'`?

Let's try to put it to use. Add within our `test_paint_palatte` method a mock for the `Paint` class.

```ruby
paint_1 = mock('paint')
paint_2 = mock('paint')
binding.pry
```

Run your test and pry should pause things. Figure out what the class of `paint_1` and `paint_2` is. Find the documentation for this class on the web to get an idea of what's possible. Query the `paint_1` object to find out what methods it has. Exit pry.

Remove the `binding.pry`, run the test, and it still fails. Add the functionality needed to `Bob` to make it work!

Now that your tests are passing, notice how the mocks allowed you to build out the `Bob` functionality without actually implementing a `Paint` class.

#### Mock Expectations

Mocks can do more than just stand there.

Imagine we want to test a `paint_colors` method that returns an array of colors as strings.

Also imagine our future `Paint` class will be initialized with a parameter of `color` that will be returned to us by a `color` method on it.

Again, we're focusing on tests for `Bob`, so we shouldn't get sidetracked by the `Paint` class requirements.

When you look at the mocha documentation you'll find that a mock has methods we can call on it.

* `.expects` defines a method that can be called on the mock
* `.returns` defines the value that the expected method should return

Putting that together we can do the following within `BobTest`:

```ruby
paint_1 = mock('paint')
paint_1.expects(:color).returns("Alizarin Crimson")
paint_2 = mock('paint')
paint_2.expects(:color).returns("Van Dyke Brown")
binding.pry
```

Once you're in pry, try calling the `color` method on `paint_1`. Does it work? Call it again? Does it work?

Now go ahead and implement the `paint_colors` method in `Bob` to make the test pass.

That's how mocks work. You create a mock to stand in for other objects and can add some simple capabilities to get you the functionality you need.

### Stubs

A stub is a fake method added to or overriding an existing method on an object. It's really just syntactic sugar for the `expects` & `returns` duo with Mocks above - just more straightforward!

So why would we use a stub over an expectation? Stubs take precedence. From the Mocha docs:

```
> if you create an expectation and then a stub for the same method, the stub will always override the expectation and the expectation will never be met.

> if you create a stub and then an expectation for the same method, the expectation will match, and when it stops matching the stub will be used instead, possibly masking test failures.

> if you create different expectations for the same method, they will be invoked in the opposite order than that in which they were specified, rather than the same order
```

#### A First Stub

Let's create another test for `Bob` that checks how much paint he has left with a `paint_amount` method.

Let's set up our `Paint` instances with an `amount` method that returns something numeric.

```ruby
paint_1.stubs(:amount).returns(22)
paint_2.stubs(:amount).returns(40)
```

With these in place, let's leverage our advanced enum knowledge to get this test to pass with a total `paint_amount` of 62.

### Check for Understanding

With your partners, teach back the difference between stubs and mocks. Check the [mocha docs](https://github.com/freerange/mocha) for more details.

## The Ultimate CFU

* How will you know you're writing a test that might be appropriate for stubbing or mocking?
* When would you use a stub over a mock with expectations and returns?
* How many lines of data should you include in your fixture files?

## Further Reading

-  Martin Fowler - Test Double: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
- Gerard Meszaros - Test Double: link [here](http://xunitpatterns.com/Test%20Double.html)
