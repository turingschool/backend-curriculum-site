---
layout: page
title: Intro to TDD
length: 60
tags: ruby, testing, tdd
---

# Intro to Test-Driven Development (TDD)

## Learning Objectives

* Explain and demonstrate the TDD workflow
* Create and run a `minitest` test suite (including assertions)
* Interpret error messages & stack trace; adjust implementation code to fix error messages
* Interpret test failures & fix implementation accordingly

## Vocabulary

* TDD
* Test Error/Failure
* Stack Trace
* minitest assertion

## Warm-up

Assume that you have a `Person` and a `Dog` class.
Assume all dogs have owners.

* How might you represent the idea of a dog having an owner in code?
* Write an `initialize` method for `Dog`
* What do you need to put in a runner file to access both classes?
* How did you confirm your last projects were working correctly? What are the downsides to this approach? 

## Test-Driven Development (TDD) Overview

As we write increasingly complex applications, we'll need more sophisticated testing approaches to secure the same level of confidence.

### Advantages

TDD is a process for writing code that helps:

* Drive your development! (Intentional coding)
* Ensure your code works the way you intend
* Create code that is understandable to others
* Create code that is cheap and easy to change

### Difficulties 

* Learning a Domain Specific Language (DSL; a computer language specialized to a particular application domain)
* Planning what we want to happen
* Taking bite sized chunks

### Using TDD

* Write tests before you write code (radical, we know)
* Use a testing framework such as `minitest` to structure your testing suite
* **Red-Green-Refactor** process to implement complexity to your application

## TDD Code-Along with `minitest`

### File Structure

* One project directory
* One file for test code
* One file for implementation code

### Scenario Specifications

* Students have names
* Students have laptops. The laptop is usually an Apple, but it can be any brand
* Students can bring various flavors of cookies to their instructors, but double-chocolate brownie chunk flavor can never be wrong

### minitest Setup

[Minitest](http://docs.seattlerb.org/minitest/) is a framework used for automated testing. It is the testing framework used on many of the homework exercises you've been assigned.

```
gem install minitest
```

* Require `minitest/autorun` - the easy and explicit way to run all your tests
* Require `minitest/pride` - vivid color explosion
* Test class inherits from Minitest::Test 
  * `test` is a `minitest` module; `::` is a scope resolution operator
  * minitest/test is a small and incredibly fast unit testing framework. It provides a rich set of assertions to make your tests clean and readable.

```ruby
# student_test.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class StudentTest < Minitest::Test
  # test it exists
  # test it has a name
  # test it has a laptop
  # test it has cookies
end
```

## TDD Cycle: Red, Green, Refactor

Red-green-refactor is a process for writing code that involves three steps.

1. Write a failing test (red)
2. Write implementation code to make the test pass (green)
3. Clean up your code if necessary (refactor)

### `minitest` Testing

* Tests in `minitest` start with `def test_something`
* Assertions (or refutations) start with the **assertion method**, followed by the **expected** value, followed by the **actual** value

```ruby
assert_equal 'expected', 'actual'
```

Let's build on our Student Test!

```ruby
def test_it_exists
  student = Student.new
  assert_instance_of Student, student
end

def test_student_has_a_name
  student = Student.new("Penelope")
  assert_equal "Penelope", student.name
end
```

### Learn to Love the Error, Learn to Love the Failure

They're your friends, seriously. Take time to understand each error and failure you encounter. You'll be seeing those same error messages over and over again, so the sooner you connect what they mean to what you need to fix, the smoother you'll be sailing.

### Solving an Error or a Failure

1. Run the test
2. Read the error/failure message, including stack trace
  * stacks are LIFO (last-in, first-out like a stack of dishes)
  * call stack is a stack that stores information about the active subroutines of a computer program (often referred to as 'the stack')
  * stack trace is a report of the active stack frames at a certain point in time during the execution of a program
  * fun-fact: queues are FIFO (first-in, first-out, like a European line-up)
3. Write implementation code to make the test pass

```ruby
class Student
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end
```

### Turn & Talk 

* What made sense? What was easy? 
* What do you need more practice with?

## TDD Practice

* Repeat TDD process for remaining `Student` specifications
OR
* Practice TDD with this UNICORN [tutorial](http://tutorials.jumpstartlab.com/topics/testing/intro-to-tdd.html)

## Recap

* What is the color-related catchphrase for TDD workflow?
* `minitest` setup 
  * What do you have to require in a test file?
  * What does your test class inherit from?
  * What is the syntax for a minitest test? Assertion?
* What's the main difference between an error and a failure?
* How do you read a stack trace?

## Further Learning
* Explore the gem! [https://github.com/seattlerb/minitest](https://github.com/seattlerb/minitest)
