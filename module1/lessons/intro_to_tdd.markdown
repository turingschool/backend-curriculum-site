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

* What are some things we need for the setup of tests?
* Name a few assertion methods.
* Where should we run our tests from?
* What do error messages tell us?

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

## TDD Cycle: Red, Green, Refactor

Red-green-refactor is a process for writing code that involves three steps.

1. Write a failing test (red)
2. Write implementation code to make the test pass (green)
3. Clean up your code if necessary (refactor)

## Write Tests First

- Shapes design
- Helps break problem into small pieces
- Removes fear of programming
- Communicates what your code _should_ do
- Tells you basically exactly what to do

## TDD Code-Along with `minitest`

### Scenario Specifications

* Products have a name
* Products have a description
* Products have a price
* Products start with a total stock number available
* You can calculate the cost of the total inventory

```ruby
# product_test.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class ProductTest < Minitest::Test
  def test_it_exists
    doomproof_vest = Product.new('Doomproof platinum vest', 'A radiation-absorbing tunic that allows the wearer to survive exposure to doom radiation.', 1200.00, 20)
    
    assert_instance_of Product, doomproof_vest
  end
  # test it has a name
  # test it has a description
  # test it has a price
  # test it has an initial stock number
  # test you can calculate the cost of the total inventory
end
```

### Learn to Love the Error, Learn to Love the Failure

They're your friends, seriously. Take time to understand each error and failure you encounter. You'll be seeing those same error messages over and over again, so the sooner you connect what they mean to what you need to fix, the smoother you'll be sailing.

* Errors usually indicate your code is broken somewhere
* Failures usually indicate that your code isn't functioning the way you expect it to

### Solving an Error or a Failure

1. Run the test
2. Read the error/failure message, including stack trace
  * stacks are LIFO (last-in, first-out like a stack of dishes)
  * call stack is a stack that stores information about the active subroutines of a computer program (often referred to as 'the stack')
  * stack trace is a report of the active stack frames at a certain point in time during the execution of a program
  * fun-fact: queues are FIFO (first-in, first-out, like a European line-up)
3. Write implementation code to make the test pass

* Lets write some implementation code to solve our errors, one step at a time.

```
E

Error:
ProductTest#test_it_exists:
NameError: uninitialized constant ProductTest::Product
Did you mean?  ProductTest
    product_test.rb:8:in `test_it_exists'
```

```ruby
# product_test.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/product'

class ProductTest < Minitest::Test
  def test_it_exists
    doomproof_vest = Product.new('Doomproof platinum vest', 'A radiation-absorbing tunic that allows the wearer to survive exposure to doom radiation.', 1200.00, 20)
    
    assert_instance_of Product, doomproof_vest
  end
  # test it has a name
  # test it has a description
  # test it has a price
  # test it has an initial stock number
  # test you can calculate the cost of the total inventory
end

class Product
  
end
```

```
Error:
ProductTest#test_it_exists:
ArgumentError: wrong number of arguments (given 4, expected 0)
    product_test.rb:9:in `initialize'
    product_test.rb:9:in `new'
    product_test.rb:9:in `test_it_exists'
```

```ruby
class Product
  
  def initialize(l, l, l, l)
    #code
  end
  
end
```

* Refactor

```ruby
class Product
  
  def initialize(name, description, unit_price, amount_available)
    #code
  end
  
end
```
```
.
```

```ruby
def test_it_has_a_name_product_price_and_amount_available
  doomproof_vest = Product.new('Doomproof platinum vest', 'A radiation-absorbing tunic that allows the wearer to survive exposure to doom radiation.', 1200.00, 20)
  
  assert_equal 'Doomproof platinum vest', doomproof_vest.name
  assert_equal 'A radiation-absorbing tunic that allows the wearer to survive exposure to doom radiation.', doomproof_vest.description
  assert_equal 1200.00, doomproof_vest.unit_price
  assert_equal 20, doomproof_vest.amount_available
end
```

```
.E

Error:
ProductTest#test_it_has_a_name_product_price_and_amount_available:
NoMethodError: undefined method `name' for #<Product:0x007fd15901b698>
    product_test.rb:17:in `test_it_has_a_name_product_price_and_amount_available'
```

```ruby
class Product
  
  attr_reader :name
  
  def initialize(name, description, unit_price, amount_available)
    @name = name
  end
  
end
```

* Continue the TDD cycle to make the current test pass

```ruby
class Product
  
  attr_reader :name, :description, :unit_price, :amount_available
  
  def initialize(name, description, unit_price, amount_available)
    @name = name
    @description = description
    @unit_price = unit_price
    @amount_available = amount_available
  end
  
end
```

* Then dream up how you want your total inventory cost calculation to behave

```ruby
def test_total_inventory_cost_calculates_total_cost
  doomproof_vest = Product.new('Doomproof platinum vest', 'A radiation-absorbing tunic that allows the wearer to survive exposure to doom radiation.', 1200.00, 20)
  
  assert_equal 24_000.00, doomproof_vest.total_inventory_cost
end
```

```
..E

Error:
ProductTest#test_total_inventory_cost_calculates_total_cost:
NoMethodError: undefined method `total_inventory_cost' for #<Product:0x007fc93f143308>
    product_test.rb:26:in `test_total_inventory_cost_calculates_total_cost'
```

```ruby
class Product
  ...
  
  def total_inventory_cost
    #code
  end

end
```

```
..F

Failure:
ProductTest#test_total_inventory_cost_calculates_total_cost [product_test.rb:26]:
Expected: 24000.0
  Actual: nil
```

* Draw the %$&@ing owl 

```ruby
class Product
  ...
  
  def total_inventory_cost
    unit_price * amount_available
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
* What are some reasons for writing tests before implementation code?
* What's the main difference between an error and a failure?
* What are 3 things an error message tells us?
* How do you read a stack trace?

## Resources
* Blog post: [Why Test Driven Development?](http://derekbarber.ca/blog/2012/03/27/why-test-driven-development/)
