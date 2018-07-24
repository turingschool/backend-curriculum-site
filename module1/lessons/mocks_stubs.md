---
layout: page
title: Mocks and Stubs
---

## Learning Goals

*   Understand what stubbing is, how to stub in Ruby with Minitest, when to use it
*   Understand what mocking is, how to mock in Ruby with Minitest, and when to use it
*   What’s the difference between behavior and state testing

## Vocabulary
* Mock Object
* Stub
* Test Optimization

## Slides

Available [here](../slides/mocks_stubs)

## Warmup

* Why do we write tests?
* In Black Thursday, how many of your tests are loading CSV data?
* Have you attempted to adjust those tests/your code to not rely on CSV data? Had any luck?

## Discussion

Talk to your partner to come up with answers to these questions

- What is "test value"?
- How can you determine the "value" of any individual test?
- How does the Single Responsibility Principle apply to unit testing?

### Mocks

Mocks are objects that stand in for other objects. The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation.

```ruby
my_mock = mock("paint")
```

### Stubs

A stub is a fake method added to or overriding an existing method on an object. It can exist as a method on an existing mock, or be created on its own as an object that will return a value that you provide when a specific method that you identify is called.

```ruby
my_stub = stub(color: "Alizarin Crimson")
my_mock = mock("paint")
my_mock.stubs(:color).returns("Van Dyke Brown")
```

### Mock Expectations

Mocks can do more than just stand there. They can also verify tht they have been called:

```ruby
my_mock = mock("paint")
my_mock.expects(:color).returns("Van Dyke Brown")
```

### Paired Exercise

We're going to be creating a `Bob` class that can store a collection of instances of a `Paint` class (in a bit of an homage to [Bob Ross](https://en.wikipedia.org/wiki/Bob_Ross)).

We want to explore and push on this idea of using mocks and stubs in place of live objects.

#### Getting Started

To get access to methods that create mocks and stubs, we'll need to install and require `mocha`.

```bash
gem install mocha
```

Once that's set, create a `bob_ross` directory with `lib` and `test` sub-directories. Create a `bob_test.rb` file in your `test` directory.

#### Testing for Bob

Let's start by adding a test for Bob. Inside of our `bob_test.rb` file, add the following code.

```ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/bob'

class BobTest < Minitest::Test
  def test_it_exists
    bob = Bob.new

    assert_instance_of Bob, bob
    assert_equal [], bob.paints
  end
end
```

Work with your partner to make that test pass.

#### Testing that Bob Can Add Paints

Let's imagine we wanted to test `Bob`'s `paints` method to see that it returns a collection of `Paint` instances. We might write a test like the following.

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

Go ahead and write that test. Run it.

* What happens?
* Why?
* What would you need to do to make this test pass?

#### A First Mock

In this particular example, we could go work to make the Paint class to move this test forward. That wouldn't be too bad. However, we might have a case where our teammate is already working on that class and we don't want to duplicate work. We may also want to isolate this test from that particular interaction so that if a test breaks it is easier to identify what exactly has broken.

Instead of moving to build out the paint class, we're going to use a mock.

Remember, a mock is a simple object that stands in for another object. At the base level, a mock is just a "thing" -- a blank canvas that we can use for just about anything. You create a mock like this:

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

Run your test and pry should pause things. Identify the class of `paint_1` and `paint_2` is. Find the documentation for this class on the web to get an idea of what's possible. Query the `paint_1` object to find out what methods it has. Exit pry.

Remove the `binding.pry`, run the test, and it still fails.

Add the functionality needed to `Bob` to make it work!

Now that your tests are passing, notice how the mocks allowed you to build out the `Bob` functionality without actually implementing a `Paint` class.

#### Returning Colors

Imagine we want to test a `paint_colors` method that returns an array of colors as strings.

Also imagine our future `Paint` class will be initialized with a parameter of `color` that will be returned to us by a `color` method on it.

A test for this functionality might look something like this:

```ruby
def test_it_can_return_colors
  bob = Bob.new
  paint_1 = Paint.new("Alizarin Crimson")
  paint_2 = Paint.new("Van Dyke Brown")
  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  assert_equal ["Alizarin Crimson", "Van Dyke Brown"], bob.paint_colors
end
```

Run this test to see what happens.

Again, we're focusing on tests for `Bob`, so we shouldn't get sidetracked by the `Paint` class requirements.

Try to implement a mock as we did above. You should be able to start building out the method `paint_colors`. What happens?

#### A First Stub

Here we need something slightly smarter than our original mock. We need some sort of object that can respond to a method call. We're going to start with a stub.

Replace your test of `paint_colors` with the following.

```ruby
def test_it_can_return_colors
  bob = Bob.new
  paint_1 = stub(color: "Alizarin Crimson")
  paint_2 = stub(color: "Van Dyke Brown")

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  assert_equal ["Alizarin Crimson", "Van Dyke Brown"], bob.paint_colors
end
```

Now, run your test. If you haven't yet made a `paint_colors` method that works, go ahead and finish it now.

#### Doing Terrible Things

That's great. We can test our Bob class without creating a Paint class, and we can even have imagined methods on Paint. But what if we implemented some code that didn't actually do what we wanted?

Replace your existin `paint_colors` method with the following:

```ruby
def paint_colors
  ["Alizarin Crimson", "Van Dyke Brown"]
end
```

Run your test. What happens?

#### Adding Expectations to Our Mocks

We want to make sure that our implementation of `paint_colors` actually uses our Paint object. How can we do this? By adding expectations to our Mock.

When you look at the mocha documentation you'll find that a mock has methods we can call on it.

* `.expects` defines a method that can be called on the mock
* `.returns` defines the value that the expected method should return

Putting that together we can do the following within `BobTest`:

```ruby
def test_it_can_return_colors
  bob = Bob.new
  paint_1 = mock(color: "Alizarin Crimson")
  paint_1.expects(:color).returns("Alizarin Crimson")
  paint_2 = mock("paint")
  paint_2.expects(:color).returns("Van Dyke Brown")
  require 'pry'; binding.pry

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  assert_equal ["Alizarin Crimson", "Van Dyke Brown"], bob.paint_colors
end

```

Once you're in pry, try calling the `color` method on `paint_1`. Does it work? Call it again? Does it work?

Run your test again. What happens? A failure? Great!

Read the error. What is happening? Why is this test failing?

Now change your existing method back so that it uses the `color` method that we expect to be implemented on Paint.

Run the test again. What happens? A pass? Great!

That's how mocks work. You create a mock to stand in for other objects and can add some simple capabilities to get you the functionality you need.

#### A Second Stub

You can also create stubs on existing mock objects.

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

* Can you think of a Black Thursday test you've already written that could use mocks and stubs instead?
* When would you use a stub over a mock with expectations and returns?

## Further Reading

- Martin Fowler - Test Double: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
- Gerard Meszaros - Test Double: link [here](http://xunitpatterns.com/Test%20Double.html)
