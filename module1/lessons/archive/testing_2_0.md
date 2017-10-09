---
layout: page
title: Testing 2.0
length: 60min 
tags: ruby, tdd, testing 
---

## Learning Goals

*   Understand what a fixture is and how to create one
*   Understand what stubbing is, how to stub in Ruby with Minitest, when to use it
*   Understand what mocking is, how to mock in Ruby with Minitest, and when to use it
*   What’s the difference between behavior and state testing

## Background Concepts

*   Test Doubles(dummy, fake, stub, spies, mocks). Further reading:
  - Basic: Martin Fowler: link [here](http://www.martinfowler.com/bliki/TestDouble.html)
  - Advanced: Gerard Meszaros link [here](http://xunitpatterns.com/Test%20Double.html)
*   Four-phase testing
  1.  Setup - sometimes in test, sometimes separate method
  2.  Exercise
	3.  Verify
	4.  Teardown
*   System Under Test (SUT) or Object Under Test

## Fixtures

### Basics

*   Create smaller copies of files you'll use in production
*   How many lines of data should your fixture include? No hard number. Include the **bare minimum** data you need to test functionality.
* Save to `fixtures` folder in your `test` folder

## Mocking versus Stubbing

### What’s the problem we’re trying to correct?

  * Order/Warehouse example
  * Always asking the question: What’s the system under test (SUT)?

### Test Doubles to the Rescue

*  **Stubs** provide canned answers to calls made during the test.

```ruby
object = mock()
object.stubs(:stubbed_method).returns(1, 2)
object.stubbed_method # => 1
object.stubbed_method # => 2
```

* **Stubs** Especially helpful to fake state of secondary objects that are auxilary to our test.

* **Stubs** allow you to imitate _state_.

* **Mocks** allow you to define what calls a method you're testing should make. Mocking libraries include extensive list of expectations to verify what you expect to happens happens. Allows you to imitate _behavior_.

```ruby
object = mock()
object.expects(:expected_method).at_least_once

object = mock()
object.expects(:expected_method).never

object = mock()
object.expects(:expected_method).at_most_once
object.expected_method #=> passes

object = mock()
object.expects(:expected_method).at_most_once
2.times { object.expected_method } #=> fails
```

* **Mocks** especially helpful to test whether SUT is behaving on secondary objects as you expect.
* **Mocks** allows you to verify _behavior_.
* More examples: http://www.rubydoc.info/github/floehopper/mocha/Mocha/Expectation

### Check for Understanding

With your partners, teach back the difference between stubs and mocks. Check the [mocha docs](https://github.com/freerange/mocha) for more details/

### Setup: Mocking and Stubbing Libraries

We'll be using mocha for these exercises.
  * Run `gem install mocha` from command line
  * Require in your file or test_helper

```ruby
require 'rubygems'
gem 'mocha'
require 'mocha/mini_test'
```

* Another common library is [flexmock](https://github.com/jimweirich/flexmock)

### Stubs

* Instead of creating a new instance, we just stub it and dictate what state and behavior we want that secondary object to hold.
* It allows us to imitate the _state_ and _state-dependent behavior_ of an actual object.
* Use cases
  1.  Testing across classes
  2.  Isolating a method within a class (example: Order Shipping Costs)
* State, state, state

### Check for Understanding: Stubs

Working independently, find an opportunity to use stubbing in your last project. Get the test passing.

### Mocks

* Mocks allow us to test whether the SUT exercises the behavior (especially on other objects) we want it to exercise.

```ruby
class DelegatorOfThings
	def delegate_the_things(doer_of_things)
		doer_of_things.do_thing_1
		doer_of_things.do_thing_2
	end
end

class DelegatorOfThingTest < Minitest::Test
	def test_it_does_the_thing
		doer_of_things = mock()
		doer_of_things.expects(:do_thing_1).once #<= This is the verification/expectation. It will _pass_ or _fail_
		doer_of_things.expects(:do_thing_2).once #<= This is the verification/expectation. It will _pass_ or _fail_

		delegator = DelegatorOfThings.new
		delegator.delegate_the_things(doer_of_things)
	end
end
```

*   Example: `mock_example` ("enterprise")

### Check for Understanding: Mocks

Create an alternate version of the zap test using mocking.

## The Ultimate CFU

* How will you know you're writing a test that might be appropriate for stubbing or mocking?
* What's the difference between testing doubles that rely on state versus behavior?
* How many lines of data should you include in your fixture files?
