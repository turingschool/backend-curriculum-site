---
layout: page
title: Introduction to Modules
length: 60
tags: ruby, modules, oop
---

### Goals

* understand that modules fill various roles in Ruby.
* understand what a namespace is and how to create one with a module.
* use a module to create a mixin to be DRY. (Don't Repeat Yourself)

### Structure

* 5 - Warmup
* 25 - Namespacing
* 25 - Mixins

### Introduction

We're going to learn about Modules, a simple tool that will teach us to do two completely different things in Ruby - namespacing and mixins. They are pretty awesome.

### Warm Up

Spend the first five minutes writing answers to the following questions:

1. What do you know about modules already? If little, what would you guess modules are all about?
2. Golf and basketball both use a ball. But if you're on a basketball court and ask for "the ball", no one is going to
throw you a golf ball. Why? If you were as dumb as a computer, why would a golf ball be an acceptable response?

### Namespacing

Namespacing works for both classes and modules. We'll be implementing it with modules today.

Let's look at some code.

```ruby
class Student
  def cast_spell
    puts "Exepelliarmus!"
  end

  def speak
    puts "I'm a Slytherin! I'm ambitious and awesome!"
  end
end

class Student
  def cast_spell
    puts "Expelliarmus!"
  end

  def speak
    puts "I'm a Hufflepuff! Potato."
  end
end
```

If we have this in our file, and we instantiate a new Student and
we try to call the speak method, what happens?

Well it will always, unfortunately, be a Hufflepuff.

But what if we want a Slytherin student?

We have to use namespacing, and so we wrap each in a module like so:

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

```ruby
student = Student::Slytherin.new
student.speak
```

Have we seen a double colon like that before?

The double colon is a scope resolution operator. It allows you to access items
in modules, or class level items in classes.

And that should let us make a Slytherin student that can speak.

### Exercise: Namespacing

So now you try.

```ruby
class Car
  def start
    puts "Engine on!"
  end

  def drive
    puts "All wheels go!"
  end
end

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

Next we are going to talk about functional programming. So what's the
difference between that and object oriented programming? It's a
complicated answer.

If we're trying to keep things simple, and we are, what we've been doing
so far has been object oriented programming. Here, what we do is we
model various concepts and apply them.

We create objects, that can also contain objects, and there are methods
which we create that do things, and of course, each object can hold
information.

This is stuff we know.

So the mystery lies in functional programming. The good thing about OOP
is that it lets us make these concrete mental models in our head. Let's go
back to Mythical Creatures. In that exercise we had a centaur class.
That centaur had a name and a breed, and it had methods like run and
shoot.

Functional programming is different. It looks at things as a chain of
equations or functions, and you hook them together like Voltron, and this
leads you to a solution. It's very mathematical in nature.

The main difference is that in both paradigms, infomration is being sent
back and forth. OOP sends it in variables and objects. Functional
programming passes functions back and forth and lets the recipient add to
it.

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
* Module mixins are inheritance by a different name.
* How it works is that theyre added to the lookup chain.
* You can share them across classes.
* Or you can use them with a single class to organize better.
* Doing that may be a terrible idea.

Let's look at an example.

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

What's wrong with this code?

Well there's repetition in there, and one of the hallmarks of
good programming is DRY, which stands for **don't repeat yourself**.

So let's pull that out.


```ruby
module OnlineOrder
  def confirmation(thing)
    puts "You got #{thing}."
  end

  def review
    puts "Please rate your order within 30 days."
  end
end

class Amazon
  include OnlineOrder

  def delivery
    puts "Your order will arrive in 2 business days."
  end
end

class Grubhub
  include OnlineOrder

  def delivery
    puts "Your food will arrive in 45-60 minutes."
  end
end
```

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

Together let's create a `HasEngine` module to extract the `start` and `stop` methods.

### Further Practice

Take the code from the discussion and implement a `HasAirConditioning` module that is mixed into both classes.

Instances of either class should be able to turn the AC on (`Chilly air coming your way!`) or off (`Temp is fine in here.`).

### Additional Reading

* [Include vs Extend in Ruby](http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/) from John Nunemaker
* [Modules](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_modules.html) in Programming Ruby / RubyDoc
* [Ruby Class, Module, and Mixin](http://matt.aimonetti.net/posts/2012/07/30/ruby-class-module-mixins/) by Matt Aimonetti
