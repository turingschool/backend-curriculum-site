---
layout: page
title: Introduction to Namespacing
length: 60
tags: ruby, modules, oop
---

### Learning Goals

* understand that modules fill various roles in Ruby.
* understand what a namespace is and how to create one with a module.

### Introduction

You've already learned about Mixins, a use of modules. Another use of Modules is Namespacing.

### Warm Up

Spend the first five minutes writing answers to the following questions:

1. What do you know about modules already?
2. Golf and basketball both use a ball. But if you're on a basketball court and ask for "the ball", no one is going to
  throw you a golf ball. Why? If you were as dumb as a computer, why would a golf ball be an acceptable response? If you asked what color is the ball? How do you know what the answer is vs the computer?  

### Namespacing

Namespacing works for both classes and modules. We'll be implementing it with modules today.

Let's look at some code.  
Slytherin Type 1  

`touch slytherin.rb`  

```ruby
class Slytherin  

  def initialize(name)
  	 @name = name
  	 @teachers = []
  end 

end
```

Slytherin Type 2  

`touch slytherin.rb`

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
What is the same/different about these two students?  We have 2 Student classes.


Create a runner:

`touch slytherin_runner.rb` 

```ruby
require "./slytherin.rb"
require "./slytherin.rb"

house = Slytherin.new
student = Slytherin.new("Malfoy")  

house.add_student(student)
```
Agree/Disagree:  
If I run my runner, what will I get? Why?

`ruby slytherin_runner.rb`

We can use namespacing, where we wrap each Student in a module like so:  
A Slytherin Student:  
  
`slytherin_1.rb`

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

`slytherin_2.rb`    

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
house = House::Hufflepuff.new  
```
Agree/Disagree:  
When I run the runner file what will I get? Why?   

I might also nest them in folders to fix out file naming problem. 

` mkdir house student`    
` mv slytherin_1.rb student/slytherin.rb`  
` mv slytherin_2.rb house/slytherin.rb`

Turn & Talk:  
Have we seen a double colon like that before? What have you seen it do?  

The double colon is a scope resolution operator. It allows you to change/direct your scope. It allows access to items in modules or class level items in classes.

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
* What is the syntax of namespacing? How do you define it? How do you call it?  
* What are some scenarios where you have seen it? Where might you use it? 
