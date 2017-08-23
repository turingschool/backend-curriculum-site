---
layout: page
title: How Testing Works
length: 60
tags: ruby, testing, tdd
---

## Learning Goals

* Define and demonstrate a testing cycle
* Use error messages to drive development
* Implement new assertion methods
* Identify best testing practices

## Warm Up

* What's the phrase for summing up the TDD cycle?
* What are 3 things an error message tells us?
* What are some reasons for writing tests before implementation code?
* What are some things we need for the setup of tests? 

## More Assertion Methods

### Turn & Talk
What do you think the following assertion methods do?

- `assert_instance_of`
- `assert_equal`
- `assert`
- `assert_nil`
- `refute`
- `refute_equal`

## TDD: Write Tests First

- Shapes design
- Helps break problem into small pieces
- Removes fear of programming
- Communicates what your code _should_ do
- Tells you basically exactly what to do

## Test Etiquette

### File Structure for Multiple Tests
- Test files live in their own `test` directory
- Implementation code files live in a sibling `lib` directory
- Test files should reflect the class they're testing with `_test` appended to the file name, e.g. `test/name_of_class_test.rb`
- In your test, you'll now `require "./lib/name_of_class.rb"`

### Other Convention & Things to Keep in Mind
- Shy away from running your program directly; instead, run your  test files that will invoke your program by running `ruby test/name_of_class_test.rb`
- Test Class Name: `class NameOfClassTest < Minitest::Test`
- `def test_something` for names of methods in test file -- **MUST start with `test_`**
- It's generally good practice to reference your method in the test name `test_method_name_does_what_I_want_it_to`
- Tests will overwrite previous tests with the same name; **give each test a new name**
- Each test is independent of the next; **don't depend on tests to run in order** of how they're written
  - It clarifies your code to other humans to write in order of complexity; aim to start from most basic to most complex functionality and keep tests grouped by method
- You can create a setup method 

```ruby
class LinkedListClass < Minitest::Test
  attr_reader :list
  
  def setup
    @list = LinkedList.new
  end
  ...
end
```

### Practice

Let's explore how our code breaks when we don't follow the Test Etiquette rules from above.


## Exercise: TDD Calculator

- Build a calculator class from scratch using TDD
- Start with whiteboarding and pseudocode
- Write pseudocode in the test file first for a few methods
- Your calculator should be able to handle the following methods:
  - .new
  - #total
  - #add
  - #clear
  - #subtract

## Recap

* What are some reasons for writing tests before implementation code?
* Name 3 new assertion methods you learned about today.
* What 2 directories should we have within our project directory?
* What **must** a test file include? What's the best name for a test?
* Do tests need unique names? Should they be written in a particular order? Do they necessarily run in that order?

## Resources

* Blog post: [Why Test Driven Development?](http://derekbarber.ca/blog/2012/03/27/why-test-driven-development/)
* Want a written-out tutorial on TDD with Minitest? [Check here](http://tutorials.jumpstartlab.com/topics/testing/intro-to-tdd.html).
* If you'd like additional practice with testing, take a look at this [calculator challenge](https://github.com/JoshCheek/how-to-test)
