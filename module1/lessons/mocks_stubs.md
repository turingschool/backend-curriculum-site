---
layout: page
title: Mocks and Stubs
---

## Learning Goals

* Understand what mocking and stubbing is and why we would use it.
  * Understand the difference between a mock and a stub.
* Learn the syntax for mocks and stubs with mocha.
* Pracice creating stubs to help with integration tests.

## Vocabulary

* Mock
* Stub
* Unit Test
* Integration Test

## Warmup

* Thinking back to your first two projects - was there any functionality for which you could **not** write tests?
* Can you think of any scenarios where a method would return an _unknowable_ value?

## Syntax Overview

### Setup

1. Clone the [Bob Ross repo](https://github.com/turingschool/bob_ross) onto your local computer.
2. cd bob_ross

To get access to methods that create mocks and stubs, we'll need to install and require the `mocha` gem. A gem is a package of code that someone else wrote. We bring them in to projects to make our lives easier!

```bash
gem install mocha
```

Once that's set, we can now require mocha at the top of our bob_test.rb:

```ruby
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/bob'

```

### Mocks

In the test below, we are testing `Bob`'s `paints` method to see that it returns a collection of `Paint` instances.

```ruby
def test_it_can_have_paint
  bob = Bob.new
  paint_1 = Paint.new("Alizarin Crimson")
  paint_2 = Paint.new("Van Dyke Brown")

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  assert_equal [paint_1, paint_2], bob.paints
end
```

**Turn and Talk:**

Run the test - why is it so slow?

In this particular example, we are relying on creating an object that takes a loooong time to create.  In this example, we have forced the issue by putting a `sleep` in the Paint class; but in the real world, this kind of slow down could be caused by a lengthy API call, or perhaps another team is working on the Paint class, and we don't have the class yet (and it is not our task to create the class).  In order to focus our test more distincly on the Bob class, we can use a Mock.

**Mocks are objects that stand in for other objects.** The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation. You can think of a mock as fake or a dummy object.

In the test above, we are going to use a Mock object to stand in for a Paint object.

```ruby
paint_1 = mock("paint")
```

The argument to the `mock` method is an identifier. You can leave it out:

```ruby
paint_2 = mock
```

Remember, a mock is a simple object that stands in for another object. At the base level, a mock is just a "thing" -- a blank canvas that we can use for just about anything.


Let's update this test so that it uses Mocks instead of Paints.

### Stubs

In our next test, we are testing that we can get an array of the paint colors (not just paint objects).

```ruby
def test_it_can_return_colors
  bob = Bob.new
  paint_1 = mock("paint 1")
  paint_2 = mock("paint 2")
  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  assert_equal ["Alizarin Crimson", "Van Dyke Brown"], bob.paint_colors
end
```

**A stub is a fake method.** It can be added to an object that doesn't have that method, or it can override an existing method. We can add a stub to a mock so our fake object will now have a fake method:

```ruby
paint_1 = mock
paint_1.stubs(:color).returns("Van Dyke Brown")
```

Now, whenever we call `paint_1.color` it will return `"Van Dyke Brown"`.


Let's update this test so that it stubs out the color method for the Mock objects.

### Mock Expectations

Replace your existing `paint_colors` method with the following:

```ruby
def paint_colors
  ["Alizarin Crimson", "Van Dyke Brown"]
end
```

Run your test. What happens?

Mocks can do more than just stand there. **They can also verify that they have been called.** Why might we want that functionality when using stubs?

```ruby
paint_1 = mock
paint_1.expects(:color).returns("Van Dyke Brown")
```

Run your tests and you will notice they now fail. Read the failure carefully.

Change your `paint_colors` method to pass the test.

**Pair Work:**

With that last test, update it to use mocks and stubs so that you can make it pass without invoking the Paint class. (Your tests should run in under 1second)

```ruby
  def test_it_can_total_paint_amount
    bob = Bob.new
    paint_1 = Paint.new("Alizarin Crimson", 42)
    paint_2 = Paint.new("Van Dyke Brown", 25)

    bob.add_paint(paint_1)
    bob.add_paint(paint_2)

    assert_equal 67, bob.total_paint_amount
  end
```

### Individiual Practice:

**Setup:**

1. Clone down the [User Image Generator](https://github.com/turingschool-examples/user_image_generator).
2. cd user_image_generator
3. gem install mocha

**Directions:**

* Review the Image Generator class and corresponding test file to familiarize yourself with the functionality
* Leveraging stubs, write tests for `#generate_images` and `#change_max_size`
* Move on to the `user_test.rb`
* Run the tests, and read through the comments carefully
* Using stubs and/or mocks, write the tests to confirm the rest of the functionality that exists in ``./lib/user.rb`

### Interview Question

What are mocks and stubs? When would you use them?

## Further Reading

- Martin Fowler - Test Double: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
- Gerard Meszaros - Test Double: link [here](http://xunitpatterns.com/Test%20Double.html)
