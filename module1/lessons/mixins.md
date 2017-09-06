---
layout: page
title: Mixins
length: 60
tags: ruby, mixins
---

## Learning Goals

* understand that modules fill various roles in Ruby.
* use a module to create a mixin to be DRY (Don't Repeat Yourself)

## Vocabulary  
* Module
* Mixin
* Instantiate
* State
* Behavior

## Sides

Available [here](../slides/mixins)

## Introduction

We're going to learn about Modules, a simple tool that will teach us to do two completely different things in Ruby - namespacing and mixins. They are pretty awesome.

## Warm Up

Spend the first five minutes writing answers to the following questions:

* What do you know about modules already? If little, what would you guess modules are all about?
* Football and soccer both use a ball, but each has its own attributes. What behaviors might they share?

## Mixins

A little bit about mixins.

* Mixins allow us to share behavior between classes
* Ruby implements mixins with Modules
* Modules are like classes except you can't instantiate them
* Modules only store behavior
* Modules *do not* store state

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

Turn & Talk: How can we use modules to make this code better?

Well there's repetition in there, and one of the hallmarks of good programming is DRY, which stands for **don't repeat yourself**.

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
To get access to the methods defined in the module, you will include the module at the beginning of the class. Using include allows you to call the module methods on an instance. 

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

Turn & Talk: What just happened there?

And now we just treat it as if the `confirmation` and `review` methods were part of our other classes, where you call the methods on an instance of an class. 

## Exercise: Module Mixins

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

## Further Practice

Take the code from the discussion and implement a `AirConditioning` module that is mixed into both classes.

Instances of either class should be able to turn the AC on (`Chilly air coming your way!`) or off (`Temp is fine in here.`).

## Summary
* What is a module? How is it different than a class? 
* How do you use a module? 
* Why would you use a module vs class inheritance? 

## Additional Reading

Module Resources:
* [Include vs Extend in Ruby](http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/) from John Nunemaker
* [Modules](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_modules.html) in Programming Ruby / RubyDoc
* [Ruby Class, Module, and Mixin](http://matt.aimonetti.net/posts/2012/07/30/ruby-class-module-mixins/) by Matt Aimonetti

Intro to Functional Programming(FP) Resources:
* [Clojure for the Brave and True](http://www.braveclojure.com/)
* [The Rise and Fall of Functional Programming](https://medium.com/javascript-scene/the-rise-and-fall-and-rise-of-functional-   programming-composable-software-c2d91b424c8c)

Deep Dive into Functional Programming (FP):
  * [SICP](https://github.com/sarabander/sicp-pdf)
