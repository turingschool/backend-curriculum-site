---
layout: page
title: Testing Strategies
tags: basics, testing, encapsulation
length: 60
---

## Learning Goals

* Understand that TDD is about asking questions and making decisions
* Understand the role of TDD in streamlining the problem-solving and design process.
* Be able to name and explain the four key types of tests

## Vocabulary

* Encapsulation
* Unit Tests
* Integration Tests
* Feature Tests
* Acceptance Tests

## Structure

* 5min - WarmUp
* Testing Patterns
* Hierarchy of Tests
* 5min - WrapUp

## Slides

Available [here](../slides/testing_strategies_4)

## WarmUp

* Why do we write tests?
* What are the benefits of having a test suite?
* How do you decide what to test?
* What is your process for writing test?
* What has been the most difficult part of testing so far?

## Lecture

### Overview

It can be especially difficult to get started on a new project or even a new iteration of a project. The essence of testing is asking questions and coming up with difficult answers.

* Testing compels you to make hard decisions early, and up front.
* This is scary because you are making decisions in a context you don't understand.
* Testing (especially in the context of TDD) is a discipline tool -- forces you to a) be **specific** about what you are trying to do and b) stay **focused** on that objective

### Why do we write tests?

Having tests a robust test suite is a way for us to be good to our future selves. Having a robust test suite provides us with two advantages:

* *Refactor with Confidence:* When we decide we want to make a change to how we've implemented our code, we can make that change making sure that we know that the code as a whole still works.
* *Add new features with confidence:* This also allows us to add new features with confidence. Sometimes it's difficult to know how code we add may impact functionality that we've already provided. A test suite tells us when something new we've done has broken something else we did before.

### Okay, sure, but why do we write tests first?

Sometimes it can feel a little bit difficult to come up with a test for something before we've decided exactly how it's going to work. That's fine. However, writing our tests first provides some additional advantages:

* *Integrates writing tests into our process for creating new code:* This means we don't have to go back and fill-in our test suite later. Testing becomes an integral part of writing code and note a chore to be completed at some later date.
* *Forces us to think about what it is we actually want:* Part of the reason testing is so hard is that we have to make decisions early. Programming is hard. It can be helpful to separate the process of determining *what* we want the program to do from how we're actually going to accomplish it. In some ways, this also allows us to ask the question: 'in my dream world, how would this work?' It gives us permission to really think about what we *want* rather than what we think will be easiest to implement.
* *Breaking down problems:* Similar to the point above, making decisions about our code will help us to break our problem down into smaller problems. If we think first of the inputs and outputs for one method, we can then also think about the inputs and outputs for some of our helper methods.
* *Only write the code you need:* It's surprisingly easy to get distracted when you're programming. We can start writing code that we think will help us at some point in the future without really knowing how. We can't completely ignore this possibility when we have a test, but it can help to tell us when we've actually solved a problem. This also let's us know that we don't need to write any more code.

### Types of Tests

When writing a program, you will likely have smaller methods that support each other to create greater functionality. Often these might be wrapped in some kind of runner method, or chained together for a grand result. We saw this in the discussion above regarding both Top-Down and Bottom-Up strategies. The tests for these methods are actually different kinds of tests. There are four commonly referred to types of tests which build upon each other:

* Programmer-centric:
  * **Unit Test** - tests one component in isolation.
  * **Integration Test** - tests multiple interdependencies or coordinating components.
* Customer-centric:
  * **Feature Test** - a single feature as experienced by a user.
  * **Acceptance Test** - a collection of user functionalities that delivers business value.

Especially when you move into web development projects in later modules you'll rely more heavily on Acceptance and Feature tests to verify the behavior of your application as it will eventually be experienced by a user.

In Module 1, on the other hand, we will rely much more heavily on **Unit** and **Integration** tests -- and it's very
important to have a good mix of both!

### Hierarchy of Tests

A Turing Version of [Martin Fowler's test pyramid](http://martinfowler.com/bliki/TestPyramid.html):

![TestPyramid](https://goo.gl/NYQcSd)

### Sad Path Testing

When you test your application, especially when you have some sort of user interaction, be sure that you include tests to see what will happen when a user does not behave as you would expect them to. We sometimes refer to this as sad-path testing. What happens when things go wrong? Do our applications completely error out or do they give our users feedback that they can use to determine what to do next?

## Practice

### Observe

Given the following interaction pattern, what tests would I write?

```
> car = Car.new("Toyota", "Camry")
=> #<Node:0x007fa2e9acd738>
car.make
=> "Toyota"
car.model
=> "Camry"
car.color
=> "white"
```

As I read through this I see a Car class that implements four methods that I will need to test: `new`, `make`, `model`, and `color`.

My test file would likely end up looking like this, though I would write each one of these tests and make them pass one at a time.

```ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/car'

class CarTest < Minitest::Test
  def test_it_exists
    car = Car.new("Toyota", "Camry")

    assert_instance_of Car, car
  end

  def test_it_has_attributes
    car = Car.new("Toyota", "Camry")

    assert_equal "Toyota", car.make
    assert_equal "Camry", car.model
  end

  def test_it_is_white_by_default
    car = Car.new("Toyota", "Camry")

    assert_equal "white", car.color
  end
end
```

### With a Partner

See if you can write a test suite for the interaction pattern below.

```
car = Car.new("Toyota", "Camry")
car.color
#=> "white"
car.paint("blue")
car.color
#=> "blue"
car.odometer
#=> 0
car.odometer.class
#=> Integer
```

Share out with the class!

### Detour: Interaction Patterns in Pry

The interaction patterns you've seen up to this point have been intended to offer you snippets of code that you could run in pry if you wanted. You'll need to remember to require the class that you're using, but after that each of the lines should run pretty much as described. Go ahead and try it! Open up a pry session and run the following lines. See if they return what you would expect.

```
require './lib/car'
#=> true
car = Car.new("Toyota", "Camry")
car.color
#=> "white"
car.paint("blue")
car.color
#=> "blue"
car.odometer
#=> 0
car.odometer.class
#=> Integer
```

Note that there are some lines where we don't provide a return value. Pry will always show you what the return value of a method is. If we haven't included a return value, it means that we are not concerned with what the method returns. That's a pretty good indicator that it's a `command` method, designed to change some aspect of a class's state.

### With a Partner

You will not always have interaction patterns to guide your testing. In these cases, you'll need to decide for yourself what you'll name the methods and how you'll decide to implement its functionality.

* When you start a car it returns a string that says "Starting up!"
* If you try to start the car when it's already running it returns the string "BZZZT!"
* If you stop a car that's running it returns the string "Stopping."

Share out with the class!

### WrapUp

* How does letting tests drive your development lead you to stronger code?
* What tradeoffs do you face when working with unit vs integration tests?
