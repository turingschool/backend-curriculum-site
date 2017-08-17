---
layout: page
title: How Testing Works
length: 60
tags: ruby, testing, tdd
---

## Learning Goals

* Define and demonstrate a testing cycle
* Write a test using MiniTest
* Use error messages to drive development

### Write Tests First

Why write the tests first?
  - Helps break problem into small pieces
  - Removes fear of programming
  - Communicates what your code _should_ do
  - Shapes design
  - Tells you basically exactly what to do

Let's say I'm building a model to represent a house. What testing assertions could I define that would prove to me, once they're all true, that I've in fact built the house I expect?

- Does it have a roof?
- Does it have a foundation?
- Does it have windows?
- Does it have walls?
- Do the walls create rooms?
- Does it have a kitchen? a bedroom? a bathroom? a living room?

Where do our tests live?
- Tests will all live in their own `test` directory
- Source code all lives in a sibling `lib` directory
- Test files should reflect the class it's testing with `_test` appended to the file name

#### Practice

Work with a partner. What testing questions could you ask to verify that the following models have been created appropriately?

- An office
- A movie set
- A frozen banana stand
- A staircar

### Minitest

[Minitest](http://docs.seattlerb.org/minitest/) is a framework used for automated testing. It is the testing framework used on many of the homework exercises you've been assigned.

#### Turn and Talk

Discuss with a partner. What are some things you've noticed about the setup of tests? What effect do these statements have?
- `assert`
- `assert_equal`
- `refute`
- `refute_equal`
- `assert_nil`
- `assert_instance_of`

#### Test Etiquette

- Run your individual test file by running `ruby test/name_of_file_test.rb`
- Two directories: `lib` and `test`
- Filenames: `test/name_of_class_test.rb`
- `require 'minitest/autorun'`
- `require "./lib/name_of_class.rb"`
- Test Class Name: `class NameOfClassTest < Minitest::Test`
- `def test_something` for names of methods in test file -- **MUST** start with `test`
- Don't depend on tests to run in the order they were written


#### Practice

Let's pick one of the models from the previous exercise (an office, a movie set, a staircar) and use Minitest to turn your assertions into real Ruby tests.

If we have extra time, let's explore how your code breaks when you don't follow the Test Etiquette rules from above.

### Testing Cycle: Red, Green, Refactor

Red-green-refactor is a process for writing code that involves three steps.
  - Write a failing test (red)
  - Write implementation code to make the test pass (green)
  - Clean up your code if necessary (refactor)

#### Learn to Love the Error, Learn to Love the Failure

They're your friends, seriously. Take time to understand each error and failure you encounter. You'll be seeing those same error messages over and over again, so the sooner you connect what they mean to what you need to fix, they smoother you'll be sailing.

#### Practice

Now that you have a failing test from the exercise above, finish the red-green-refactor loop by writing code to pass the test and refactoring.

## Bring It All Together

### Exercise: TDD Calculator

- Build a calculator class from scratch using TDD
- Start with whiteboarding and pseudocode
- Write pseudocode in the test file first for a few methods
- Your calculator should be able to handle the following methods:
  - .new
  - #total
  - #add
  - #clear
  - #subtract

## Resources

* Blog post: [Why Test Driven Development?](http://derekbarber.ca/blog/2012/03/27/why-test-driven-development/)
* Want a written-out tutorial on TDD with Minitest? [Check here](http://tutorials.jumpstartlab.com/topics/testing/intro-to-tdd.html).
* If you'd like additional practice with testing, take a look at this [calculator challenge](https://github.com/JoshCheek/how-to-test)
