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

### Ensuring Dynamic Functionality

We should make sure that all of our methods can handle different cases, ensuring that our implementation code is dynamic, e.g.:

```ruby
class Round
  def initialize(deck)
    @deck = deck
  end

  def current_card
    @deck.cards.first
  end
end
```

```ruby
# round_spec.rb
require 'rspec'

describe Round do
  describe '#current_card' do
    cards = CardSetup.new
    deck = Deck.new(cards)
    round = Round.new(deck)
    it 'can get back current card' do
      expect(round.current_card), deck.cards.first
    end
  end
end
```

Turn and Talk: what might be the pitfalls in a test like this?  How could we improve the test?

### Testing Edge Cases

* Ensure that your implementation code can handle things we might not expect, e.g.:

```ruby
class Calculator
  def divide(num1, num2)
    num1 / num2
  end
end
```

```ruby
# calculator_spec.rb
require 'rspec'

describe Calculator do
  describe '#divide' do
    calculator = Calculator.new
    it 'can return the quotient' do
      expect(calculator.divide(8,4)).to eq 2
    end
  end
end
```
Turn and Talk: what might be the pitfalls in a test like this?  How could we improve the test (and thus the behavior of our calculator?)

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

Given the following interaction pattern, write a test file for this (not yet existent) class, Student.

```ruby
> student = Student.new("Jesse", 1)
=> #<Student:0x007fa2e9acd738>
student.name
=> "Jesse"
student.mod
=> "1"
student.skills
=> []

student.say_mod
=> "I'm in Mod 1"

```

## Command vs. Query Methods

Methods either do one of two things for us:
- Give us information about an object
- Change something about an object

When testing, it's really important to keep in mind what a method should be doing, to ensure we test it well. Stepping out of TDD just for a minute so we can illustrate this, let's look at this example:

```ruby
class Student
  attr_reader :name, :mod

  def initialize(name_parameter, mod_parameter)
    @name = name_parameter
    @mod = mod_parameter
  end

  def say_mod
    "I'm in Mod 1"
  end
end
```

Discuss with your partner:
- What are all the methods we have on an instance of this class?
- Which methods give us information about a student object?
- Which methods change something about a student object?
- How would you go about testing that the `say mod` method does what it is supposed to?

To make sure we're all the same page, let's write this test together.

### Partner Practice

Given the following interaction pattern, build on your test file for this class.

```ruby
> student = Student.new("Sophocles", 1)
=> #<Student:0x007fa2e9acd738>

student.name
=> "Sophocles"

student.mod
=> "1"

student.skills
=> []

student.say_mod
=> "I'm in Mod 1"

student.learn("testing")

student.skills
=> ["testing"]

student.learn("mocks")

student.skills
=> ["testing", "mocks"]

student.promote

student.say_mod
=> "I'm in Mod 2"

```
Be ready to share your code with the rest of class!

### With a Partner

You will not always have interaction patterns to guide your testing. In these cases, you'll need to decide for yourself what you'll name the methods and how you'll decide to implement its functionality.

You are planning to create an `Instructor` class. The instructor has a name, a mod they teach, and a class of students. The primary responsibility of an instructor is to take a class of students and teach those students a skill.

Write a series of tests and THEN create an Instructor class.

*Extra Challenge:*

- An instructor's class could have students from different mods (why? I don't know, tbh...). An instructor should only be able to teach the students in _their_ mod a skill.

- For an instructor, calculate the percentage of students in their class who know a given skill.

* TESTS FIRST*

Share out with the class!


## Extra Exercise: TDD Calculator

- Build a calculator class from scratch using TDD
- Start with whiteboarding and pseudocode
- Write pseudocode in the test file first for a few methods
- Your calculator should be able to handle the following methods:
  - .new
  - #total
  - #add
  - #clear
  - #subtract

### Wrap Up

* Why is a thorough test suite important to have?
* How does letting tests drive your development lead you to stronger code?
* What tradeoffs do you face when working with unit vs integration tests?
