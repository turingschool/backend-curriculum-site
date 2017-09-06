---
layout: page
title: Inheritance
length: 60
tags: ruby, inheritance
---

## Learning Goals

* identify inheritance as an essential principle of OOP
* explain what is inheritance and why we use it 
* identify that you can over-write a method locally (polymorphism?)

## Vocabulary 
* Inheritance 
* Parent
* Child 

## Slides

Available [here](../slides/inheritance)

## Warmup

* What have you done up to this point when you noticed duplication in your code?
* What do you think of when you hear the word inheritance?
* Create a new test file for a `Node` class with a single test to see if the class `Node` exists.
* Where do you think we get the ability to call the method `assert_equal` or `assert_instance_of`, etc?

## Lesson

### Introduction

In Ruby, inheritance is one way that we can use code defined in one class in multiple classes. One of the benefits of inheritance is the reduction in duplication that comes from defining methods on a parent class that can then be used across many child classes. You've already seen inheritance in your testing suite.

```ruby
require 'minitest'

class NodeTest < Minitest::Test

end
```

In the snippet above, `< Minitest::Test` means `inherit from the Test module of Minitest` (we'll talk about modules later).

Since inheritance is one of a few ways we can share code across classes, it's convention to use it when there is a **is-a** relationship between two things. For example, a dog **is a** mammal, a CEO **is an** employee.

One note: a class can only inherit from one other class. Be sure that when you use inheritance the class you are choosing to inherit from has the strongest relationship with the child classes.

### Syntax

The `<` character tells us that our class is inheriting from another class when used in a class definition.

```ruby
# employee.rb
class Employee
end

# ceo.rb
require './employee'

class Ceo < Employee
end
```

Setting up this relationship allows us to define methods on the parent class that we can then use on the child.

#### Example

```ruby 
# runner.rb
require './ceo'

ali = Ceo.new(15, 20)

puts "CEO Base Salary: #{ali.base_salary}"
puts "CEO Total Comp: #{ali.total_compensation}"


# ceo.rb
require './employee'

class Ceo < Employee
  attr_reader :base_salary,
              :bonus

  def initialize(base_salary, bonus)
    @base_salary = base_salary
    @bonus       = bonus
  end
end

# employee.rb
class Employee
  def total_compensation
    base_salary + bonus
  end
end
```

#### Independent Practice 
With a partner: 

* Create a `SalesManager` class that inherits from `Employee`, and takes `base_salary`, and `estimated_annual_sales` as arguments when you initialize.
* Create a `bonus` method on `SalesManager` that returns 10% of `estimated_annual_sales`
* Create a new `SalesManager` in your runner file and print their total compensation to the terminal  
* Which class is the parent and which is the child? Why did we define the relationship in this way?  

### Super

`super` allows us to execute methods from our child class that have the same name in our parent class.

* `super` passes all of the arguments in the current method
* `super()` passes no arguments, but still completes any actions 
* `super(argument1, argument2)` passes argument1 and argument2 specifically

#### Example

```ruby 
# runner.rb
require './ceo'
require './sales_manager'

ali = Ceo.new(15, 20, "Ali", 1)
sal = SalesManager.new(15, 400)

"CEO Base Salary: #{ali.base_salary}"
puts "CEO Total Comp: #{ali.total_compensation}"
puts "CEO Name: #{ali.name}"
puts "CEO ID: #{ali.id}"
puts "\n"
puts "Sales Manager Bonus: #{sal.bonus}"
puts "SalesManager Total Comp: #{sal.total_compensation}"

# ceo.rb
require './employee'

class Ceo < Employee
  attr_reader :base_salary,
              :bonus

  def initialize(base_salary, bonus, name, id)
    @base_salary = base_salary
    @bonus       = bonus
    super(name, id)
  end
end

# employee.rb
class Employee
  attr_reader :name,
              :id

  def initialize(name, id)
    @name = name
    @id   = id
  end 
  
  def total_compensation
    base_salary + bonus
  end
end
```
#### Independent Practice  
With a partner:

* add name and id to SalesManager using super

### Overriding Methods

In Ruby we can override a method from our parent class by re-defining it in our child class. Doing this implies that there is some exception to a general rule. A `Mammal` class might have a method `lays_eggs?` that returns false that would work on most child classes, but we would then need to override that method on `Platypus` to return true.

#### Example

```ruby
# runner.rb
require './ceo'
require './sales_manager'
require './intern'

ali = Ceo.new(15, 20, "Ali", 1783)
sal = SalesManager.new(15, 400, "Sal", 8736)
jeff = Intern.new(5, "Jeff", 3298)

puts "CEO Base Salary: #{ali.base_salary}"
puts "CEO Total Comp: #{ali.total_compensation}"
puts "CEO Name: #{ali.name}"
puts "CEO ID: #{ali.id}"
puts "\n"
puts "Sales Manager Bonus: #{sal.bonus}"
puts "SalesManager Total Comp: #{sal.total_compensation}"
puts "\n"
puts "Intern Total Comp: #{jeff.total_compensation}"


# intern.rb
require './employee'

class Intern < Employee
  attr_reader :hourly_rate

  def initialize(hourly_rate, name, id)
    @hourly_rate = hourly_rate
    super(name, id)
  end

  def total_compensation
    hourly_rate * 2000
  end
end
```


#### Independent Practice 
With a partner:

* Using either `super` or overriding a method, make it so that when you call `#total_compensation` on `Ceo` it adds a dollar to their `base_salary` before returning the total compensation
* Explain in what ways does total_compensation work differently on Ceo, SalesManager, and Intern? 

## Summary

* Why might we decide to use inheritance?
* What is the syntax for creating a class that inherits from another class? How many classes can you inherit from and how do you decide which should inherit from which?  
* What does `super`, do and what are the differences between the three different ways you can call it?
* What does it mean to override a method in Ruby?
