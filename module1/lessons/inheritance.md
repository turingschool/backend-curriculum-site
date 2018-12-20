---
layout: page
title: Inheritance
length: 120
tags: ruby, inheritance
---

## Learning Goals

* identify inheritance as an essential principle of OOP
* explain what is inheritance and why we use it
* identify that you can over-write a method locally (polymorphism?)

## Vocabulary
* Inheritance
* Parent/Superclass
* Child/Subclass

## Slides

Available [here](../slides/inheritance)

## Warmup

* What do you think of when you hear the word inheritance?
* Create a new test file for a `Node` class with a single test to see if the class `Node` exists.
* Where do you think we get the ability to call the method `assert_equal` or `assert_instance_of`, etc?

## Inheritance

In Ruby, inheritance is one way that we can use code defined in one class in multiple classes. One of the benefits of inheritance is the reduction in duplication that comes from defining methods on a **Parent** class that can then be used across many child classes. You've already seen inheritance in your testing suite.

```ruby
require 'minitest'

class NodeTest < Minitest::Test

end
```

In the snippet above, `< Minitest::Test` means `inherit from the Test class of the Minitest module`. It is important to note that this is not the same as mixing in a Module. This is a completely different use of Modules called **namespacing**.

A couple rules of inheritance in Ruby:

* When a class inherits from another class, it receives all of the methods from that other class
* The inheriting class is called the **child** or **subclass**
* The class being inherited from is called the **parent** or **superclass**
* A class can only inherit from one parent
* Any number of classes can inherit from a single superclass

Since inheritance is one of a few ways we can share code across classes, it's convention to use it when there is a **is-a** relationship between two things. For example, a dog **is a** mammal, a CEO **is an** employee.

One note: a class can only inherit from one other class. Be sure that when you use inheritance the class you are choosing to inherit from has the strongest relationship with the child classes.

## Creating a Subclass

### Syntax

If we have a file `employee.rb` that contains this class:

```ruby
# employee.rb
class Employee
  def total_compensation
    base_salary + bonus
  end
end
```

We can inherit from it using the `<` character. Let's try this in a file called `ceo.rb`:

```ruby
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

```

Let's test this in a separate file called `runner.rb`:

```ruby
#runner.rb
require './ceo'

ali = Ceo.new(15, 20)

puts ali.total_compensation
```

You can see that even though we didn't define `total_compensation` in our `Ceo` class, the `Ceo` object still responded to this methods because it inherited them from `Employee`. In this example, `Ceo` is the **subclass** or **child**, and `Employee` is the **superclass** or **parent**.

Note, we can still define methods in our `Ceo` class just like with any other class.

### Try It!

With a partner:

* Create a `SalesManager` class that inherits from `Employee`, and takes `base_salary`, and `estimated_annual_sales` as arguments when you initialize.
* Create a `bonus` method on `SalesManager` that returns 10% of `estimated_annual_sales`
* Create a new `SalesManager` in your runner file and print their total compensation to the terminal

## Super

### Overview

When called inside a method, the keyword `super` calls the method from the superclass with the same name. For instance if you call super in the `initialize` method, it will call the superclass's `initialize` method.

Let's say we want every `Employee` to have a name and an id.  First, we need to update our `Employee` superclass to take name and id on instantiation:

```ruby
#employee.rb
class Employee
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end

  def total_compensation
    base_salary + bonus
  end
end  
```

Now, we can update our `Ceo` to take name and id as well. Rather than recreating the instance variable setup in the `Ceo`'s initialize, we can use `super` to fetch the additional setup we want from the `Employee` superclass:

```ruby
#ceo.rb
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
```

The call to `super` calls the `Employee` class's initialize, which set the `name` and `id` instance variables.

Here, we specified the arguments to `super`. There are actually three forms of the keyword `super`:

* `super(argument1, argument2)` calls the superclass method with argument1 and argument2 specifically
* `super` calls the superclass method with all of the arguments in the current method
* `super()` calls the superclass method with no arguments

## Overriding

In Ruby we can also override a method from our parent class by re-defining it in our child class. Doing this implies that there is some exception to a general rule. A `Mammal` class might have a method `lays_eggs?` that returns false that would work on most child classes, but we would then need to override that method on `Platypus` to return true.

Let's take a look at an Intern class. Let's assume that at this company interns are paid an hourly wage, but are not paid a bonus. Their compensation would no longer be calculated as `base_salary + bonus`. Instead, we can redefine that method on `Intern`, and override the method of the same name on `Employee`.

```ruby
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

### Try It

Using either `super` or overriding a method, make it so that when you call `#total_compensation` on `Ceo` it adds a dollar to their `base_salary` before returning the total compensation

## Summary

* Why might we decide to use inheritance?
* What is the syntax for creating a class that inherits from another class? How many classes can you inherit from and how do you decide which should inherit from which?
* What does `super`, do and what are the differences between the three different ways you can call it?
* What does it mean to override a method in Ruby?
