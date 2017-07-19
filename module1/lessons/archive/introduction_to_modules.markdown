---
layout: page
title: Introduction to Modules
length: 90
tags: ruby, modules, oop
---

### Learning Goals

* understand that modules fill various roles in Ruby.
* understand what a namespace is and how to create one with a module.
* use a module to create a mixin to be DRY (Don't Repeat Yourself)

### Introduction

We're going to learn about Modules, a simple tool that will teach us to do two completely different things in Ruby - namespacing and mixins. They are pretty awesome.

### Warm Up

Spend the first five minutes writing answers to the following questions:

1. What do you know about modules already? If little, what would you guess modules are all about?
2. Golf and basketball both use a ball. But if you're on a basketball court and ask for "the ball", no one is going to
  throw you a golf ball. Why? If you were as dumb as a computer, why would a golf ball be an acceptable response? If you asked   what color is the ball? How do you know what the answer is vs the computer?  

### Namespacing

Namespacing works for both classes and modules. We'll be implementing it with modules today.

Let's look at some code.  
Student Type 1  
`touch student_1.rb`  
```ruby
class Student
  def cast_spell
    puts "Exepelliarmus!"
  end

  def speak
    puts "I'm a Slytherin! I'm ambitious and awesome!"
  end
end
```
Student Type 2  
`touch student_2.rb`
```ruby
class Student
  def cast_spell
    puts "Expelliarmus!"
  end

  def speak
    puts "I'm a Hufflepuff! Potato."
  end
end
```
Hop into `pry` and play around a bit.
```ruby
require "./student_1.rb"
=> true
require "./student_2.rb"  
=> true  
slyth = Student.new  
huff = Student.new  
```
Turn & Talk:  
What is the same/different about these two students?  We have 2 Student classes.

Agree/Disagree:  
If I make them speak, what will I get? Why?
```ruby
slyth.speak
??  
huff.speak  
??  
```

We can use namespacing, where we wrap each Student in a module like so:  
A Slytherin Student:    
`student_1.rb`
```ruby
module Student
  class Slytherin
    def cast_spell
      puts "Expelliarmus!"
    end

    def speak
      puts "I'm a Slytherin, and am AWESOME."
    end
  end
end 
```  
A Hufflepuff student:  
`student_2.rb`    
```ruby
module Student
  class Hufflepuff
    def cast_spell
      puts "Expelliarmus!"
    end

    def speak
      puts "Potato."
    end
  end
end
```

This is how we would instantiate with modules and then call the appropriate
method:  
`pry`  

```ruby
require "./student_1.rb"
=> true
require "./student_2.rb"  
=> true  
slyth = Student::Slytherin.new  
huff = Student::Hufflepuff.new  
```
Agree/Disagree:  
When I call slyth.speak what will I get vs huff.speak? Why?   
```ruby 
slyth.speak  
??  
huff.speak  
??  
```

Turn & Talk:  
Have we seen a double colon like that before? What have you seen it do?  

The double colon is a scope resolution operator. It allows you to access items
in modules, or class level items in classes.

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
* Wrap the first `Car` with a module to create a `Car::AWD`
* Wrap the second `Car` with a module to create a `Car::RWD`
* Create an instance of `Car::RWD` and prove that you can access both
  the expected methods
* Create an instance of `Car::AWD` and prove that you can access both
  the expected methods

### Functional Programming

Next we are going to talk about Functional Programming(FP). So what's the
difference between that and Object Oriented Programming(OOP)? It's a
complicated answer.

If we're trying to keep things simple, and we are, what we've been doing
so far has been object oriented programming. Here, what we do is we
model various concepts and apply them.

We create objects, that can also contain objects, and there are methods
which we create that do things, and of course, each object can hold
information.

This is stuff we know.

So the mystery lies in Functional Programming. The good thing about OOP
is that it lets us make these concrete mental models in our head. Let's go
back to Mythical Creatures. In that exercise we had a Centaur Class.
That centaur had a name and a breed, and it had methods like run and
shoot.

Functional Programming is different. It looks at things as a chain of
equations or functions, and you hook them together like Voltron, and this
leads you to a solution. It's very mathematical in nature.

The main difference is that in both paradigms, infomration is being sent
back and forth. OOP sends it in variables and objects. Functional
Programming passes functions back and forth and lets the recipient add to
it.
 
Turn & Talk:  
How might you use a Functional Approach to programming? Have you come across/written any methods that work this way?  

<!-- That's enough theory, let's look at some code.

```ruby
module Pythagorean
  def self.find_c(a, b)
    Math.sqrt((a ** 2) + (b ** 2))
  end
end
```

* How do we use this?

Start with the snippet above and add `find_a` and `find_b` methods. As you might remember from geometry:

`c^2 = a^2 + b^2`

An easy triangle to use for testing purposes is `a = 3`, `b = 4`, `c = 5`.

If you find this approach to programming interesting, you might check out [Gary Bernhart's "Boundaries" Talk](https://www.destroyallsoftware.com/talks/boundaries).

What are some other possible uses for this? How might you have used this in a previous project?
 -->

### Mixins

A little bit about mixins.

* Ruby, like other OOP languages, uses inheritance.  
Agree/Disagree:  
What do you think inheritance is in Ruby?  

* Module mixins are inheritance by a different name.
* How it works is that they(modules) are added to the lookup chain.  
Agree/Disagree:  
What is "the lookup" chain? What happens?  
* You can share them across classes.  
Agree/Disagree:  
Why might this be helpful? When would you use it?    
* Or you can use them with a single class to organize better.
  * Doing that may be a terrible idea.

Let's look at an example.  
`touch grubhub_order.rb`  
```ruby
class GrubhubOrder
  def confirmation(thing)
    puts "You got #{thing}."
  end

  def review
    puts "Please rate your order within 30 days."
  end

  def delivery
    puts "Your food will arrive in 45-60 minutes."
  end
end
```
`touch amazon_order.rb`  
```ruby
class AmazonOrder
  def confirmation(thing)
    puts "You got #{thing}."
  end

  def review
    puts "Please rate your order within 30 days."
  end

  def delivery
    puts "Your order will arrive in 2 business days."
  end
end
```
`pry`  
```ruby
require "./amazon_order.rb"
=> true  
require "./grubhub_order.rb"  
=> true  
amazon = AmazonOrder.new  
grub   = GrubHubOrder.new  
amazon.delivery  
grub.delivery  
amazon.review  
grub.review  
```    
Turn & Talk:   
How can we use modules to make this code better?    

Well there's repetition in there, and one of the hallmarks of
good programming is DRY, which stands for **don't repeat yourself**.

Let's extract the duplication.  
`touch online_order.rb`   
```ruby
module OnlineOrder
  def confirmation(thing)
    puts "You got #{thing}."
  end

  def review
    puts "Please rate your order within 30 days."
  end
end  
```  
In `amazon_order.rb`  
```ruby
require "./online_order"
class Amazon
  include OnlineOrder

  def delivery
    puts "Your order will arrive in 2 business days."
  end
end 
```  
In `grubhub_order.rb`  
```ruby
require "./online_order"
class Grubhub
  include OnlineOrder

  def delivery
    puts "Your food will arrive in 45-60 minutes."
  end
end
```    
Agree/Disagree:  
What will happen when we hop into Pry?  
`pry`  
```ruby
require "./amazon_order.rb"
=> true  
require "./grubhub_order.rb"
=> true  
amazon = AmazonOrder.new  
grub = GrubhubOrder.new  
amazon.delivery
grub.delivery  
amazon.review  
amazon.review  
```  
Turn & Talk:  
What just happend there?  

And now we just treat it as if the `confirmation` and `review` methods were included in our other classes.

#### Exercise: Module Mixins

Now it's your turn.

Consider the following code:
```ruby
class Camry
  def start
    puts "Engine on!"
  end

  def stop
    puts "Engine off!"
  end

  def drive
    puts "Back wheels go!"
  end
end
```

```ruby
class Jeep
  def start
    puts "Engine on!"
  end

  def stop
    puts "Engine off!"
  end

  def drive
    puts "All wheels go!"
  end
end
```

Together with a partner create an `Engine` module to extract the `start` and `stop` methods.   

### Further Practice

Take the code from the discussion and implement a `AirConditioning` module that is mixed into both classes.

Instances of either class should be able to turn the AC on (`Chilly air coming your way!`) or off (`Temp is fine in here.`).

### WrapUp  
* What are two types of Ruby Modules?  
* For each type, what are some use cases?   
* What would be pros/cons of each type?  

### Additional Reading
Module Resources:  
* [Include vs Extend in Ruby](http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/) from John Nunemaker
* [Modules](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_modules.html) in Programming Ruby / RubyDoc
* [Ruby Class, Module, and Mixin](http://matt.aimonetti.net/posts/2012/07/30/ruby-class-module-mixins/) by Matt Aimonetti

Intro to Functional Programming(FP) Resources:  
* [Clojure for the Brave and True](http://www.braveclojure.com/)  
* [The Rise and Fall of Functional Programming](https://medium.com/javascript-scene/the-rise-and-fall-and-rise-of-functional-   programming-composable-software-c2d91b424c8c)  
* Deep Dive into Functional Programming (FP):   
* [SICP](https://github.com/sarabander/sicp-pdf)  
