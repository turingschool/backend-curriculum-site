---
layout: page
title: Mocks and Stubs
---

## Learning Goals

* Understand what mocking and stubbing is and why we would use it.

## Slides 

Find slides [here](https://docs.google.com/presentation/d/1TcJhktMttcVNhq9Z53MsM14b_skLTRs00FvKjqN8wj0/edit?usp=sharing)

## Vocabulary

* Mock
* Stub

## Warmup

With your partner, take 3 minutes to answer the following questions: 
  - In the regular world, outside of coding, what does it mean to "mock" something?
  - What do you already know about mocks and/or stubs? (What are they? Where are they implemented? Why are they useful?)

## Paired Exercise

### Step 1: Setup

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


**Pair Work:**

Work with your partner to make the first two tests pass. **You should not create a Paint class at any point during this lesson**.

### Step 2: Mocks

The next test that we have tests `Bob`'s `paints` method to see that it returns a collection of `Paint` instances. 

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

What would we have to do to make this test pass?

In this particular example, we could go work to make the Paint class to move this test forward. That wouldn't be too bad because this example is pretty short. Imagine if the Paint class needed to hit an API in order to retrieve its color. Then we would have to implement all of that functionality before we could move forward with the Bob class. We might have a case where our teammate is already working on the Paint class and we don't want to duplicate work. We may also want to isolate this test from that particular interaction so that if a test breaks it is easier to identify what exactly has broken.

**Mocks are objects that stand in for other objects.** The other object might be one that's not implemented yet, doesn't yet have the functionality we need, or maybe we just want to work with a simpler situation. You can think of a mock as fake or a dummy object.

In the test above, we would have to create a Paint class in order to make this test pass. Instead, we are going to use a Mock object to stand in for a Paint object.

```ruby
paint_1 = mock("paint")
```

The argument to the `mock` method is an identifier. You can leave it out:

```ruby
paint_2 = mock
```

Remember, a mock is a simple object that stands in for another object. At the base level, a mock is just a "thing" -- a blank canvas that we can use for just about anything.


Let's update this test so that it uses Mocks instead of Paints.

### Step 3: Stubs

In our next test, we want to test that we can get an array of the paint colors (not just paint objects).

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

### Step 4: Mock Expectations

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

With that last test, update it to use mocks and stubs so that you can make it pass without creating the Paint class. Then make the test pass:

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

1. Clone down the [museum_mocks_stubs repo](https://github.com/turingschool/museum_mocks_stubs). 
2. cd museum_mocks_stubs
3. gem install mocha
4. require 'mocha/minitest' (at the top of your test file)

**Directions:** 

The museum_test.rb has 8 skipped tests in it. One by one, unskip the tests, and use mocks and stubs to make your tests pass. 

- For tests 1-5, use mocks. 
- For tests 6-8, use mocks and stubs. 


### Interview Question

What are mocks and stubs? When have you used them?

## The Ultimate CFU

* Can you think of a Cross Check test you've already written that could use mocks and stubs instead?
* When would you use a stub over a mock with expectations and returns?

## Further Reading

- Martin Fowler - Test Double: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
- Gerard Meszaros - Test Double: link [here](http://xunitpatterns.com/Test%20Double.html)
