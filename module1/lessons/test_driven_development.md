---
layout: page
title: Test Driven Development
tags: basics, testing, encapsulation
length: 60
---

## Learning Goals

* Understand that TDD is about asking questions and making decisions
* Understand the role of TDD in streamlining the problem-solving and design process
* Be able to name and explain the differences between unit and integration tests

## Vocabulary

* Unit Tests
* Integration Tests
* Feature Tests
* Acceptance Tests

## Warm Up

With your partner, look over the test file you have printed out, and answer the following questions:
- For each test (between `def` and `end`), what is the name of the test? 
- For each test (between `def` and `end`), what piece of functionality does that tell you this class has? The first two are answered/annotated for you, it's your job to jot down notes for the remaining tests.
- Now, look back at your notes and the name of each test. Does the naming appropriately explain what the test tests?
- How would you explain, in 1-2 sentences, what the House class does?
- Why do you think you were you able to say so much about this House class without even looking at the actual code?


### Overview

It can be especially difficult to get started on a new project or even a new iteration of a project. The essence of testing is asking questions and coming up with difficult answers.

* Testing compels you to make hard decisions early, and up front.
* This is scary because you are making decisions in a context you don't understand.
* Testing (especially in the context of TDD) is a discipline tool -- forces you to a) be **specific** about what you are trying to do and b) stay **focused** on that objective

### Why do we write tests?

Having a robust test suite is a way for us to be good to our future selves; and provides us with several advantages:

* *Refactor with Confidence:* When we decide we want to make a change to how we've implemented our code, we can make that change making sure that we know that the code as a whole still works.
* *Add new features with confidence:* This also allows us to add new features with confidence. Sometimes it's difficult to know how code we add may impact functionality that we've already provided. A test suite tells us when something new we've done has broken something else we did before.
* *Roadmap to future collaborators:* It's very rare that someone will work on code alone - and if they do, they may be doing it over time. Your test suite serves as a roadmap of the codebase; another developer or future-you should be able to skim through the code base and get a feel for what the code does, and where to find certain things in it.

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

## Implementation

### Example

Given the following interaction pattern, I'll write a test file for this (not yet existent) class, Car.

```ruby
> car = Car.new("Toyota", "Camry")
=> #<Car:0x007fa2e9acd738>
car.make
=> "Toyota"
car.model
=> "Camry"

car.drive
=> "The Camry is driving"
```

### Partner Practice

Given the following interaction pattern, write a test file for this (not yet existent) class, Car.

```ruby
> car = Car.new("Toyota", "Camry")
=> #<Car:0x007fa2e9acd738>
car.make
=> "Toyota"
car.model
=> "Camry"
car.color
=> "white"

car.drive
=> "The Camry is driving"

car.stop
=> "The Camry has stopped"
```

## Command vs. Query Methods

Methods either do one of two things for us:
- Give us information about an object
- Change something about an object

When testing, it's really important to keep in mind what a method should be doing, to ensure we test it well. Stepping out of TDD just for a minute so we can illustrate this, let's look at this example:

```ruby
class Car
  attr_reader :make, :model, :engine_on

  def initialize(make, model)
    @make = make
    @model = model
    @engine_on = false
  end

  def start
    @engine_on = true
  end

end
```

Discuss with your partner:
- What are all the methods we have on an instance of this class?
- Which methods give us information about a car object?
- Which methods change something about a car object?
- How would you go about testing that the `start` method does what it is supposed to?

To make sure we're all the same page, let's write this test together.

### Partner Practice

Given the following interaction pattern, build on your test file for this (not yet existent) class, Car.

```ruby
car = Car.new("Toyota", "Camry")
#=> #<Car:0x007fa2e9acd738>

car.color
#=> "white"
car.paint("blue")
car.color
#=> "blue"
car.odometer
#=> 0
car.drive(10)
car.drive(7)
car.odometer
# => 17
```

Be ready to share your code with the rest of class!

### With a Partner

You will not always have interaction patterns to guide your testing. In these cases, you'll need to decide for yourself what you'll name the methods and how you'll decide to implement its functionality.

You are planning to create a `Mechanic` class. The mechanic has a name and a shop they work at. The primary responsibility of a mechanic is to take a list of cars and determine which of those cars is due for an oil change (greater than 3,000 miles).

Write a series of tests and THEN create a Mechanic class.

Share out with the class!

### Wrap Up

* Why is a thorough test suite important to have?
* How does letting tests drive your development lead you to stronger code?
* What tradeoffs do you face when working with unit vs integration tests?
