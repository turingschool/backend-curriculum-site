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

## Vocabulary
* Testing
* Assertion
* Expected
* Actual
* TDD

## Warm Up

In our CreditCheck project, how do we verify that our code works? What are the disadvantages to this approach?

# Automated Testing

Automated Testing is a very important part of programming. It allows us to verify that our code works the way we expect, and saves us time by doing it automatically. It is also less error prone since we don't have to rely on our eyes to spot mistakes. Whenever we make a change to our code, we can simply run our test to make sure everything still works.

## Minitest

Let's take a look at how we can use testing to verify an implementation of the `CreditCard` class from the [Credit Check Project](../projects/credit_check):

```ruby
class CreditCard
  attr_reader :card_number, :limit

  def initialize(card_number, limit)
    @card_number = card_number
    @limit = limit
  end

  def last_four
    @card_number[-4..-1]
  end

  def is_valid?
    digits = get_digits(@card_number)
    doubled_every_other = double_every_other(digits)
    summed = sum_over_ten(doubled_every_other)
    sum = sum_digits(summed)
    check_validity(sum)
  end

  def get_digits(card_number)
    digit_array = []
    characters = card_number.chars
    characters.each do |character|
      digit_array << character.to_i
    end
    digit_array
  end

  def double_every_other(array_of_digits)
    doubled = []
    array_of_digits.each.with_index do |digit, index|
      if index.even?
        doubled << digit * 2
      else
        doubled << digit
      end
    end
    doubled
  end

  def sum_over_ten(digits)
    summed_over_ten = []
    digits.each do |digit|
      if digit > 9
        summed_over_ten << digit - 9
      else
        summed_over_ten << digit
      end
    end
    summed_over_ten
  end

  def sum_digits(digits)
    sum = 0
    digits.each do |digit|
      sum += digit
    end
    sum
  end

  def check_validity(sum)
    if sum % 10 == 0
      true
    else
      false
    end
  end
end
```

This code lives in a file called `credit_card.rb` in the `lib` directory of our project. Every class file in your `lib` directory should have a corresponding test file in the `test` directory. The test file name is the same as the class name with `_test` added to the name. In this case, we need to make a `credit_card_test.rb` file in the `test` directory with this code:

```ruby
require 'minitest/autorun'
require 'minitest/pride'
```

`minitest` is the Automated Testing Framework we will use in Module 1. `minitest/autorun` is what gives us access to Minitest. `minitest/pride` makes our output colorful and fun! Yay testing!

In general, `require` statements pull code into the current file. In this case, we are using a tool that someone else built, Minitest, to enhance our code. Throughout your coding career, you will follow this pattern more and more as many solutions exist for the problem you are trying to solve.

Next, add this code to your test file:

```ruby
require 'minitest/autorun'
require 'minitest/pride'

class CreditCardTest < Minitest::Test

end
```

In order to use Minitest, we need to create a class that inherits from `Minitest::Test`. We read that line of code as, "Class CreditCardTest inherits from Minitest Test." We'll learn more about inheritance later. For now, just get used to reading the `<` symbol as "inherits from".

This is the standard setup for any test file. While you can technically name the class whatever you want, the convention is to name it the same as the class you are testing with `Test` appended to the name. So for the `CreditCard` class, our test class should be named `CreditCardTest`.

From the root directory of the project, run `ruby test/credit_card_test.rb`, and you should see output like this:

```
Run options: --seed 30000

# Running:



Finished in 0.000603s, 0.0000 runs/s, 0.0000 assertions/s.
0 runs, 0 assertions, 0 failures, 0 errors, 0 skips
```

If you instead get an error that Ruby can't find Minitest, from your terminal run `gem install minitest` and try again.

Now we're ready to start testing!

## test_it_exists

The first test we'll write will be called `test_it_exists`. This will verify that we can create an instance of the class we are testing. Update your test file to this:

```ruby
require 'minitest/autorun'
require 'minitest/pride'

class CreditCardTest < Minitest::Test
  def test_it_exists
  end
end
```

We have just defined our first test. Notice that it starts with `test_`. All of our tests **must** start with `test_`.

Next, we need to create an instance of the `CreditCard` class. In order to gain access to the `CreditCard` class in this file, we need to require it:

```ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit_card'

class CreditCardTest < Minitest::Test
  def test_it_exists
    credit_card = CreditCard.new("5541808923795240", 15000)
    assert_instance_of CreditCard, credit_card
  end
end
```

Run the test with `ruby test/credit_card_test.rb` and you should see some output. We really only care about the last line of this output. It should read:

```
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

In order to verify that our instance of the `CreditCard` class, we used the `assert_instance_of` assertion.

## Assertions

Assertions are what actually verify that our code is doing what we expect. Assertions compare an **Expected** vs. an **Actual** value.

The **Expected** value is what we expect our code to produce. This value is hardcoded.

The **Actual** value is what our code produces. Typically, this is the output of a method called on the class we are testing.

In Minitest, the expected value goes first, and the actual value goes second.

The assertions you should know in Minitest are:

* `assert_instance of <expected Class>, <instance of Class>` - verifies that an object is an instance of a particular Class

* `assert_equal <expected value>, <actual value>` - verifies that two values are equal

* `assert_nil <value>` - verifies that something is nil

* `assert <value>` - verifies that something is truthy

* `refute <value>` - verifies that something is falsey

* `refute_equal <expected value>, <actual value>` - verifies that two values are not equal

## Testing the Attributes

Let's use these assertions to verify the rest of our `CreditCard` behavior. After `test_it_exists`, the next test we usually write are the tests for attributes:

```ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit_card'

class CreditCardTest < Minitest::Test
  def test_it_exists
    credit_card = CreditCard.new("5541808923795240", 15000)
    assert_instance_of CreditCard, credit_card
  end

  def test_it_has_attributes
    credit_card = CreditCard.new("5541808923795240", 15000)
    assert_equal "5541808923795240", credit_card.card_number
    assert_equal 15000, credit_card.limit
  end
end
```

Let's break down the line `assert_equal "5541808923795240", credit_card.card_number`. The first thing that Ruby does is it evaluates the method call `credit_card.card_number`. That method call **returns** the card number we passed in. Ruby then compares that to the card number we are expecting, and determines if they are equal or not.

Run the test with `ruby test/credit_card_test.rb` and you'll see that the tests pass.

A very important note here is that each of the tests **runs independently**. In this case, we have two tests, `test_it_exists` and `test_it_has_attributes`. What happens in one does not affect the other. This is illustrated by the fact that in both tests we have the line `credit_card = CreditCard.new("5541808923795240", 15000)`. Each test needs to create its own instance of `CreditCard`.

## Testing Helper Methods

Our method `is_valid?` utilizes many helper methods. When testing, it is NOT okay to only test the high level method without testing its helper methods. *EVERY* method should have a corresponding test. Let's test one of those helper methods, `get_digits`.

The test would look like this:

```ruby
def test_it_can_get_digits
  credit_card = CreditCard.new("5541808923795240", 15000)
  actual = credit_card.get_digits("5541808923795240")
  expected = [5,5,4,1,8,0,8,9,2,3,7,9,5,2,4,0]
  assert_equal expected, actual
end
```

In this case we are creating two variables, `actual` and `expected`, to store the values we want to compare. This is functionally the same as the single line assertions we've been using, but can be more readable especially if you have long expected or actual values. In this case, both expected and actual values are quite long, so this is looking pretty readable.

Run the tests and you should see:

```
3 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

## Failures and Errors

Just for fun, let's see what happens when our test fails. We'll change our expected value to something else:

```ruby
def test_it_can_get_digits
  credit_card = CreditCard.new("5541808923795240", 15000)
  actual = credit_card.get_digits("5541808923795240")
  expected = "Cheese Cake"
  assert_equal expected, actual
end
```

Run this file and you'll see this output:

```
3 runs, 4 assertions, 1 failures, 0 errors, 0 skips
```

Scroll up and you'll see output describing the failure:

```
Failure:
CreditCardTest#test_it_can_get_digits [test/credit_card_test.rb:21]:
--- expected
+++ actual
@@ -1 +1 @@
-"Cheese Cake"
+[5, 5, 4, 1, 8, 0, 8, 9, 2, 3, 7, 9, 5, 2, 4, 0]
```

This tells us what test failed and on what line the failure happened. The last two lines in particular show us the difference between the expected and actual values.

Now let's change the code to produce an error:

```ruby
def test_it_can_get_digits
  credit_card = CreditCard.new("5541808923795240", 15000)
  actual = credit_card.get_numbers("5541808923795240")
  expected = [5,5,4,1,8,0,8,9,2,3,7,9,5,2,4,0]
  assert_equal expected, actual
end
```

We've changed the method call from `credit_card.get_digits` to `credit_card.get_numbers`. Because we don't have a `get_numbers` method in our `CreditCard` class, we would expect to get an error. Ruby this code and you'll now see this output:

```
3 runs, 3 assertions, 0 failures, 1 errors, 0 skips
```

Scroll up and you will see details on the error.

This illustrates the difference between a failure and an error:

* a **Failure** is a mismatch between the expected and actual values in your Minitest assertions
* an **Error** is a bug in your code that prevents Ruby from running your code.

## Skips and Test Naming

You can use the skip keyword to tell Minitest to ignore a test:


```ruby
def test_it_can_get_digits
  credit_card = CreditCard.new("5541808923795240", 15000)
  actual = credit_card.get_digits("5541808923795240")
  expected = [5,5,4,1,8,0,8,9,2,3,7,9,5,2,4,0]
  assert_equal expected, actual
end
```

Run this code and you'll see instead of 4 assertions and 0 skips, we now have 3 assertions and 1 skip. Skipping is particularly useful when you have a lot of tests that aren't passing and you want to just focus on one test.

We said before that tests have to start with `test_`. Let's see what happens when we don't follow this rule:

```ruby
def check_it_can_get_digits
  credit_card = CreditCard.new("5541808923795240", 15000)
  actual = credit_card.get_digits("5541808923795240")
  expected = [5,5,4,1,8,0,8,9,2,3,7,9,5,2,4,0]
  assert_equal expected, actual
end
```

This code will output:

```
2 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```

We went from `3 runs, 4 assertions` to `2 runs, 3 assertions`. So our test just simply didn't run. Minitest will only treat methods defined as `test_` as tests, and all others are treated as normal methods. This is very dangerous because Minitest did not give us any warning that our test was named incorrectly. It can be very easy to assume that your tests are working fine when there are no failures or errors, even when your tests aren't actually running. Moral of the story: always name your tests `test_` and always check the number of runs/assertions.

## Writing Tests that read like documentation

The main purpose of testing is to verify that your code works the way you expect.

Another very important purpose of testing is that other developers can read your test file and know what your code does. Ideally, your test files are so good that you don't need any additional documentation to describe what your code does.

One way to achieve this is to name your tests well. Normally when we write methods, we don't want the names to be very long because we are going to need to call these methods a lot. This rule doesn't apply to test names since we never actually call the methods (Minitest does that for us). Therefore, don't worry about brevity when writing test names and instead focus on being descriptive.

For example, when testing the `is_valid?` method, we could just write a test called `test_is_valid`, however this test name doesn't really describe what the method is supposed to do. Instead, it would be better to write two tests: `test_is_valid_returns_false_when_card_number_is_invalid` and `test_it_returns_true_when_card_number_is_valid`.

Another way to write a test file that reads like documentation is to order your tests well. There aren't exact rules for this, but generally we want simpler tests, like `test_it_exists` and `test_it_has_attributes` at the top of our test file. Also, it is good practice to put the methods your Users will care about towards the top of the test file. For instance, our `CreditCard` class's most important method is `is_valid?`, so the test for that method would be towards the top of the test file, and the helper methods would be towards the bottom of the file.

# Practice

Fill out the rest of the test file to completely test the `CreditCard` class. If helpful, here are the names of the tests that should be in your test file:

```
test_it_exists
test_it_has_attributes
test_is_valid_returns_false_when_card_number_is_invalid
test_is_valid_returns_true_when_card_number_is_valid
test_it_can_get_last_four_digits_of_card_number
test_it_can_get_digits
test_it_can_double_every_other_digit
test_it_can_sum_digits_over_ten
test_it_can_sum_digits
test_check_validity_returns_true_when_sum_is_divisible_by_ten
test_check_validity_returns_false_when_sum_is_not_divisible_by_ten
```

# Summary

### File Structure
- Test files live in their own `test` directory
- Implementation code files live in a sibling `lib` directory
- Test files should reflect the class they're testing with `_test` appended to the file name, e.g. `test/name_of_class_test.rb`
- In your test, you'll now `require "./lib/name_of_class.rb"`
- Run your test files from the root of the project directory, e.g. `ruby test/name_of_class_test.rb`; running the test will invoke your program

```
.
├── lib
|   └── name_of_class.rb
└── test
    └── name_of_class_test.rb
```

### Minitest Setup
* Require `minitest/autorun` - the easy and explicit way to run all your tests
* Require `minitest/pride` - vivid color explosion
* Test Class Name: `class NameOfClassTest`
* Test class inherits from `Minitest::Test`, e.g. `class NameOfClassTest < Minitest::Test`

### Writing Tests
* `def test_something` for names of methods in test file -- **MUST start with `test_`**
* Tests will overwrite previous tests with the same name; **give each test a new name**
* Each test is independent of the next; **don't depend on tests to run in order** of how they're written
* Assertions verify the expected behavior of our code
  * `assert_equal <expected value>, <actual value>`
  * `assert_instance of <expected Class>, <instance of Class>`
  * `assert <value>`
* Errors: Code isn't running
* Failures: Assertions did not pass
* Skips tests to ignore them

### Testing Best Practices
* Write descriptive test names. It is good to reference your method in the test name: `test_method_name_does_what_I_want_it_to`
* Order tests by complexity
* Put User facing methods near top and helper methods near bottom of test file
