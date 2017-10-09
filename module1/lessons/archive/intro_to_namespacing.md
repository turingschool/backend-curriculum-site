---
layout: page
title: Introduction to Namespacing
length: 60
tags: ruby, modules, oop
---

### Learning Goals

* Understand that modules fill various roles in Ruby.
* Understand what a namespace is and how to create one with a module.

### Vocabulary 

* Namespacing
* Scope Resolution Operator

### Slides

Available [here](../slides/intro_to_namespacing)

### Warm Up

Spend the first five minutes writing answers to the following questions:

* What are some defining characteristics of modules?
* Name one type of module we've already discussed.

### Namespacing

* Namespacers act as containers for our classes; they allow us to organize our code & implement different types of classes with the same name 
* Namespacers can be either classes or modules. We'll be implementing namespacing with modules today.

Let's look at some code.
Slytherin Type 1

`touch slytherin1.rb`

```ruby
class Slytherin

  def initialize(name)
    @name = name
    @teachers = []
  end

end
```

Slytherin Type 2

`touch slytherin2.rb`

```ruby
class Slytherin
  def initialize
    @teachers = []
    @students = []
  end

  def add_student(student)
    @students << student
  end

  def add_teacher(teacher)
    @teachers << teacher
  end

end
```
Turn & Talk:
What is the same/different about these two classes?


Create a runner:

`touch slytherin_runner.rb`

```ruby
require "./slytherin1.rb"
require "./slytherin2.rb"

house = Slytherin.new
student = Slytherin.new("Malfoy")

house.add_student(student)
```

Agree/Disagree:
If I run my runner, what will I get? Why?

`ruby slytherin_runner.rb`

We can use namespacing, where we wrap each Student in a module like so:
A Slytherin Student:

`slytherin1.rb`

```ruby
module Student
  class Slytherin
    
    def initialize(name)
      @name = name
      @teachers = []
    end

  end
end
```
A Slytherin house:

`slytherin2.rb`

```ruby
module House
  class Slytherin
    
    attr_reader :students

    def initialize
      @teachers = []
      @students = []
    end

    def add_student(student)
      @students << student
    end

    def add_teacher(teacher)
      @teachers << teacher
    end

  end
end
```

This is how we would instantiate with modules and then call the appropriate method:
Back in our runner:

```ruby
student = Student::Slytherin.new("Malfoy")
house = House::Slytherin.new
```

Agree/Disagree:
When I run the runner file what will I get? Why?

I might also nest them in folders to fix out file naming problem.

` mkdir house student`
` mv slytherin1.rb student/slytherin.rb`
` mv slytherin2.rb house/slytherin.rb`

Turn & Talk:
Have we seen a double colon like that before? What have you seen it do?

The double colon is a **scope resolution operator**. It allows you to change/direct your scope. It allows access to items in modules or class-level items in classes.

### Exercise: Namespacing

So now you try.
Make a Car Class:

`touch car_1.rb`

```ruby
class Car
  def start
    puts "Engine on!"
  end

  def drive
    puts "All wheels go!"
  end
end
```

Make a second Car Class:

`touch car_2.rb`

```ruby
class Car
  def start
    puts "Engine on!"
  end

  def drive
    puts "Rear wheels go!"
  end
end
```

* Start with the code above
* Wrap the first `Car` with a module to create a `AWD::Car`
* Wrap the second `Car` with a module to create a `RWD::Car`
* Create an instance of `RWD::Car` and prove that you can access both
  the expected methods
* Create an instance of `AWD::Car` and prove that you can access both
  the expected methods

### WrapUp
* How do you namespace a class?
* What is the syntax of calling a namespaced class?
* What are some scenarios where you have seen namespacing? Where might you use it?

### Additional Resources
* Launch School's OOP "book" [Inheritance "chapter"](https://launchschool.com/books/oo_ruby/read/inheritance#moremodules)
