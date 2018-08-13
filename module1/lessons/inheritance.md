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

* Where do objects get methods you don't write like `.inspect`?
* What have you done up to this point when you noticed duplication in your code?
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

In the snippet above, `< Minitest::Test` means `inherit from the Test module of Minitest` (we'll talk about modules later).

A couple rules of inheritance in Ruby:

* When a class inherits from another class, it receives all of the methods from that other class
* The inheriting class is called the **child** or **subclass**
* The class being inherited from is called the **parent** or **superclass**
* A class can only inherit from one parent
* Any number of classes can inherit from a single superclass

Since inheritance is one of a few ways we can share code across classes, it's convention to use it when there is a **is-a** relationship between two things. For example, a dog **is a** mammal, a CEO **is an** employee.

One note: a class can only inherit from one other class. Be sure that when you use inheritance the class you are choosing to inherit from has the strongest relationship with the child classes.

## Creating a Subclass

If we have a file `employee.rb` that contains this class:

```ruby
#employee.rb
class Employee
  def initialize(base_salary, bonus)
    @base_salary = base_salary
    @bonus = bonus
  end

  def total_compensation
    @base_salary + @bonus
  end
end
```

We can inherit from it using the `<` character. Let's try this in a file called `ceo.rb`:

```ruby
#ceo.rb
require './employee'

class Ceo < Employee
end
```

Let's test this in a separate file called `runner.rb`:

```ruby
#runner.rb
require './employee'
require './ceo'

employee = Employee.new(50000, 5000)
puts "employee compensation is #{employee.total_compensation}"
ceo = Ceo.new(100000, 1000)
puts "ceo compensation is #{ceo.total_compensation}"
```

You can see that even though we didn't define `initialize` and `total_compensation` in our `Ceo` class, the `Ceo` object still responded to those methods because it inherited them from `Employee`. In this example, `Ceo` is the **subclass** or **child**, and `Employee` is the **superclass** or **parent**.

Let's also add a method to our `Ceo` class:

```ruby
#ceo.rb
require './employee'

class Ceo < Employee
  def title
    "Chief Executive Officer"
  end
end
```

And update our runner:

```ruby
#runner.rb
require './employee'
require './ceo'

employee = Employee.new(50000, 5000)
puts "employee compensation is #{employee.total_compensation}"
ceo = Ceo.new(100000, 1000)
puts "ceo compensation is #{ceo.total_compensation}"
puts "ceo title is #{ceo.title}"
```

So we can still define methods in our `Ceo` class just like with any other class.

**Try it**: With your partner, create a `SalesManager` class that inherits from `Employee`. Add a method `title` that prints its title. Test it in your runner file.

## Super

When called inside a method, the keyword `super` calls the method from the superclass with the same name. For instance if you call super in the `initialize` method, it will call the superclass's `initialize` method.

Let's say we don't want every `Ceo` to have the same title, so we will pass it in to the initialize as an argument:

```ruby
#ceo.rb
require './employee'

class Ceo < Employee
  attr_reader :title

  def initialize(base_salary, bonus, title)
    @title = title
    super(base_salary, bonus)
  end
end
```

The call to `super` calls the `Employee` class's initialize, which sets up the `base_salary` and `bonus` instance variables.

Here, we specified the arguments to `super`. There are actually three forms of the keyword `super`:

* `super(argument1, argument2)` calls the superclass method with argument1 and argument2 specifically
* `super` calls the superclass method with all of the arguments in the current method
* `super()` calls the superclass method with no arguments

**Try It**: With your partner, add an argument `total_sales` to your `SalesManager`'s initialize, and call the superclass initialize.

## Overriding

In Ruby we can override a method from our parent class by re-defining it in our child class. Doing this implies that there is some exception to a general rule. A `Mammal` class might have a method `lays_eggs?` that returns false that would work on most child classes, but we would then need to override that method on `Platypus` to return true.

If we want to change our Ceo's annual salary:

```ruby
#ceo.rb
require './employee'

class Ceo < Employee
  attr_reader :title

  def initialize(base_salary, bonus, title)
    @title = title
    super(base_salary, bonus)
  end

  def total_compensation
    (@base_salary + @bonus) * 2
  end
end
```

**Try it**: With your partner, override your `SalesManager`'s `total compensation` to be the annual_salary plus the bonus plus 10 percent of the total_sales.

## Summary

* Why might we decide to use inheritance?
* What is the syntax for creating a class that inherits from another class? How many classes can you inherit from and how do you decide which should inherit from which?  
* What does `super`, do and what are the differences between the three different ways you can call it?
* What does it mean to override a method in Ruby?
