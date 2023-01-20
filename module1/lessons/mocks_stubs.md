---
layout: page
title: Mocks and Stubs
---

## Learning Goals

* Understand what mocking and stubbing is and why we would use it.
  * Understand the difference between a mock and a stub.
* Learn the syntax for mocks and stubs with rspec.
* Practice creating stubs to help with integration tests.

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

* Navigate to the [Bob Ross directory](https://github.com/turingschool-examples/mod-1-be-exercises/tree/main/lessons/mocks_stubs/bob_ross) in the Mocks and Stubs folder in the mod-1-be-exercises repo on your local computer.


### Mocks

In the test below, we are testing `Bob`'s `paints` method to see that it returns a collection of `Paint` instances.

inside `spec/bob_spec.rb`:
```ruby
it 'can add paint' do
  bob = Bob.new
  paint_1 = Paint.new("Alizarin Crimson")
  paint_2 = Paint.new("Van Dyke Brown")

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  expect(bob.paints).to eq([paint_1, paint_2])
end
```

**Turn and Talk:**

Run the test - why is it so slow?

In this particular example, we are relying on creating an object that takes a loooong time to create.  In this example, we have forced the issue by putting a `sleep` in the Paint class; but in the real world, this kind of slow down could be caused by a lengthy API call, or perhaps another team is working on the Paint class, and we don't have the class yet (and it is not our task to create the class).  In order to focus our test more distinctly on the Bob class, we can use a Mock.

**Mocks are objects that stand in for other objects.** The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation. You can think of a mock as fake or a dummy object. Since some programming languages call these "doubles", I like to think of Mocks as "stunt doubles" -- they look the same as the original, but act a little different.

In the test above, we are going to use the rspec method `double` to create a mock object to stand in for a Paint object.

```ruby
paint_1 = double("paint")
```

The string provided is just a placeholder, it's not actually used, but it can be helpful to differentiate these objects later if you need to.

Remember, a mock is a simple object that stands in for another object. At the base level, a mock is just a "thing" -- a blank canvas that we can use for just about anything. (no pun intended to Bob Ross and the painting theme!)

Let's update this test so that it uses mock objects instead of full Paint objects.


### Stubs

In our next test, we are testing that we can get an array of the paint colors (not just paint objects).

```ruby
def test_it_can_return_colors
  bob = Bob.new
  paint_1 = double("my first paint")
  paint_2 = double("my second paint")
  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  expect(bob.paint_colors).to eq(["Alizarin Crimson", "Van Dyke Brown"])
end
```

**A stub is a fake method.** It can be added to an object that doesn't have that method yet, or it can override an existing method on an existing object. We can add a stub to a mock so our fake object will now have a fake method:

```ruby
paint_1 = double("paint")
allow(paint_1).to receive(:color).and_return('Van Dyke Brown')
```
Now, whenever we call `paint_1.color` it will return `"Van Dyke Brown"`.

Let's update this test so that it stubs out the color method for the Mock objects.


> **It's important to note:**
> You don't HAVE to have a mock object to use stubs. You can stub a method response on a real object too:
>
> ```ruby
> paint_1 = Paint.new('bad color name')
> allow(paint_1).to receive(:color).and_return('a better color name!')
> ```


### **Pair Work:**

With that last test, update it to use mocks and stubs so that you can make it pass without invoking the Paint class. (Your tests should run in under 1 second)

```ruby
it 'can calculate total paint amount' do
  bob = Bob.new
  paint_1 = Paint.new("Alizarin Crimson", 42)
  paint_2 = Paint.new("Van Dyke Brown", 25)

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  expect(bob.total_paint_amount).to eq(67)
end
```

## Unit Tests and Integration Tests

A "unit" test will test one small "unit" of your code. Most typically, this is a single method, and you test that when you call that method, something happens or something changes or something gets returned. If that method takes parameters, you will usually write a few tests for different kinds of input, and expect different kinds of output.

An "integration" test is usually a bigger test, sometimes called a "feature" test, that checks that multiple "units" are working together as expected. Like unit tests, these can also take various inputs and have much larger impacts of change that we should test for to make sure that all of the pieces we expect to work together are each doing their part to build a successful outcome.

An example in the Bob Ross repo:
- We have a Paint class with tests. These are unit tests. They take different setups and produce different expectations.
- We have a Bob class with tests, and some of these are unit tests (can we make a new Bob object, add paints) and some of these are integration tests which rely on the Paint methods working correctly (if we call `bob.paint_colors` we expect that `paint_1.color` works properly.

---

### Individual Practice:

**Setup:**

* Navigate to the [User Image Generator directory](https://github.com/turingschool-examples/mod-1-be-exercises/tree/main/lessons/mocks_stubs/user_image_generator) in the Mocks and Stubs lesson of the mod-1-be-exercises repo.

**Directions:**

* Review the Image Generator class and corresponding spec file to familiarize yourself with the functionality
* Leveraging stubs, write tests for `#generate_images` and `#change_max_size`
* Move on to the `user_spec.rb`
* Run the tests, and read through the comments carefully
* Using stubs and/or mocks, write the tests to confirm the rest of the functionality that exists in `./lib/user.rb`

### Interview Question

What are mocks and stubs? When would you use them?

## Further Reading

- Martin Fowler - Test Double: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
- Gerard Meszaros - Test Double: link [here](http://xunitpatterns.com/Test%20Double.html)
