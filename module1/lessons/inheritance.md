---
layout: page
title: Inheritance
length: 120
tags: ruby, inheritance
---

## Learning Goals

* identify inheritance as an essential principle of OOP
* explain what is inheritance and why we use it
* identify that you can over-write a method locally
* write code that demonstrates the single inheritance principle

## Vocabulary

* Inheritance
* Parent/Superclass
* Child/Subclass

## Warmup

In your notebook, jot down your thoughts for the following questions. Be ready to share.

* What do you think of when you hear the word inheritance?
* Where do you think we get the ability to call the method `attr_reader` or `assert_equal`, etc? Where are they defined?

## Inheritance

In Ruby, inheritance is one way that we can use code defined in one class in multiple classes. One of the benefits of inheritance is the reduction in duplication that comes from defining methods on a **Parent** class that can then be used across many child classes.

From [Sandi Metz's Practical Object Oriented Programming in Ruby](https://www.poodr.com/), here is a more techincal definition of inheritance:

> Inheritance is, at its core, a mechanism for automatic message delegation. It defines a forwarding path for not-understood messages.

A couple rules of inheritance in Ruby:

* The objects modeled using inheritance must demonstrate a "generalization–specialization" relationship
* When a class inherits from another class, it receives access to all of the methods and instance variables from that other class
* The inheriting class is called the **child** or **subclass**
* The class being inherited from is called the **parent** or **superclass**
* A class can only inherit from **one** parent
* The chain of a parent's parents (and parent's parent's parents, etc.) is called **ancestors**
* Any number of classes can inherit from a single superclass

Since inheritance is one of a few ways we can share code across classes, it's convention to use it when there is a **is-a** relationship between two things. For example, a dog **is a** mammal, a CEO **is an** employee.

Again from Metz, here is a practical application of inheritance:

> Some of [a] bicycle’s behavior applies to all bicycles, some only to road bikes, and some only to mountain bikes. This single class contains several different, but related, types. This is the exact problem that inheritance solves; that of highly related types that share common behavior but differ along some dimension.

With a partner, brainstorm what Metz might be talking about when she refers to some behavior applying to all bikes, and some behavior only applying to certain types of bikes. Feel free to check out [this site](https://lemonbin.com/types-of-bicycles/) for photos that might help you brainstorm.

## Creating a Subclass

### Demo

Take notes while we discuss, diagram, and demonstrate these concepts:

* the `superclass` method
* the missing method lookup chain
* difference between number of methods on instance and number of methods on instance's parent

### Group Practice

In a new directory, let's create a file `employee.rb` that contains this class:

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

We'll try this out in a separate file called `runner.rb`:

```ruby
#runner.rb
require './ceo'

ali = Ceo.new(15, 20)

puts ali.total_compensation
```

You can see that even though we didn't define `total_compensation` in our `Ceo` class, the `Ceo` object still responded to this methods because it inherited them from `Employee`. In this example, `Ceo` is the **subclass** or **child**, and `Employee` is the **superclass** or **parent**.

We can still define methods in our `Ceo` class just like with any other class.

**NOTE**: It's tempting to think of inheritance as methods getting "passed down" to a child (as you would when thinking about genetics in living creatures); however, technically, the method calls on the child object are "passed up" to the parent class. When a method is called on the child that only exists in the parent class, that message is automatically delegated to the parent class.

### Try It!

With a partner:

* Create a `SalesManager` class that inherits from `Employee`, and takes `base_salary`, and `estimated_annual_sales` as arguments when you initialize.
* Create a `bonus` method on `SalesManager` that returns 10% of `estimated_annual_sales`
* Create a new `SalesManager` in your runner file and print their total compensation to the terminal

## Super

### Overview

When called inside a method, the keyword `super` calls the method from the superclass with the same name. For instance if you call super in the `initialize` method, it will call the superclass's `initialize` method.

`super` is kind of a confusing word for this behavior. It might help to think of it as "call parent's method".

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

We'll diagram this concept before moving on.

Look at an Intern class below. Let's assume that at this company interns are paid an hourly wage, but are not paid a bonus. Their compensation would no longer be calculated as `base_salary + bonus`. Instead, we can redefine that method on `Intern`, and override the method of the same name on `Employee`.

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

We can also combine `super` and overriding. Imagine that you wanted to use a method from the superclass, but you needed to modify something about the return value. Take a look at the `benefits` method in both this parent class and the child class:

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

  def benefits
    [:sick_leave]
  end
end  
```

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

  def benefits
    super.push(:health_insurance)
  end
end
```

### Try It

Override a method and/or use `super` so that when you call `#total_compensation` on `Ceo` it adds a dollar to their `base_salary` before returning the total compensation.

## Words of Caution

In the examples we did today, we created just two subclasses for a `Employee` superclass.

* While it may be tempting to immediately create a parent class for 1-2 subclasses (for example: `Animal` as the parent class and `Dog` and `Cat` as child classes), creating this hierarchy adds overhead. It *may* end up being less technically expensive to duplicate some functionality initially until you have a better sense of what the potential superclass of *many* subclasses (`Mouse`, `Lizard`, `Coral`, etc.) should do. Sometimes it is easier to promote the more abstract parts of the code UP to a superclass than it is to move concrete parts of a superclass down to a subclass.

* While subclasses can and should rely on functionality from the parent class, a parent class should not use methods that are not defined within the parent class. For example, our `Employee` class relies on `base_salary` and `bonus`. In the event that later on, another child class `Manager` is created, the parent class imposes that `base_salary` and `bonus` *must* be defined within the subclass since the parent class uses those to calculate `total_compensation`. In order to provide documentation for future developers using your parent class template, you can follow this pattern, as recommended in Metz's OOP book:

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

  def base_salary
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  def bonus
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end  
```

## Discussion

* Why might we decide to use inheritance?
* Can you think of times that inheritance might not be the right choice?
* What is the syntax for creating a class that inherits from another class? How many classes can you inherit from and how do you decide which should inherit from which?
* What does `super` do, and what are the differences between the three different ways you can call it?
* What does it mean to override a method in Ruby?

## Optional Next Steps

* Check out Chapter 6 (pages 105 - 139) of [Sandi Metz's Practical Object Oriented Design in Ruby](http://www.r-5.org/files/books/computers/dev-teams/diagrams/Sandi_Metz-Practical_Object-Oriented_Design_in_Ruby-EN.pdf). Toward the end of the chapter, Metz talks about an alternative design pattern to using `super` which is beyond the scope of today's lesson but that you may find interesting.
* Google "Composition vs. Inheritance in Ruby" for some more perspectives on when to use inheritance and when to include a module.
