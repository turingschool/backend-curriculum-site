---
layout: page
title: Mocks and Stubs
---

## Learning Goals

*   Understand what stubbing is, how to stub in Ruby with Minitest, when to use it
*   Understand what mocking is, how to mock in Ruby with Minitest, and when to use it
*   What’s the difference between behavior and state testing


## Warmup

- In Black Thursday, how many tests are loading CSV data?
- Are there methods that you could test without actually loading the CSVs? How would you do it?

## Discussion

Talk to your partner to come up with answers to these questions

- What is "test value"?
- How can you determine the "value" of any individual test?
- How does the Single Responsibility Principle apply to unit testing?

## Mocks and Stubs

To get access to methods that create mocks and stubs, we'll need to install and require `mocha`.

```bash
gem install mocha
```

Once that's set, require `mocha/mini_test` in your test_helper.rb.

### Mocks

Mocks are objects that stand in for other objects. The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation.

Let's imagine we wanted to test `Bob`'s `paints` method to see that it returns a collection of `Paint` instances.

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

This is our first test. We don't have any other code. What are the things we need to do to make this pass?

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

```ruby
paint_1 = stub(:color => "Alizarin Crimson")
paint_2 = stub(:color => "Van Dyke Brown")
binding.pry
```

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

* Can you think of a Black Thursday test you've already written that could use mocks and stubs instead?
* When would you use a stub over a mock with expectations and returns?

## Further Reading

- Martin Fowler - Test Double: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
- Gerard Meszaros - Test Double: link [here](http://xunitpatterns.com/Test%20Double.html)
