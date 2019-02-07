---
layout: page
title: Modules
length: 60
tags: ruby, mixins
---

## Learning Goals
* understand the role the Modules play in Ruby
* use a module to create a mixin to make our code DRYer (Don't Repeat Yourself)

## Vocabulary  
* Module
* Mixin
* Instantiate
* State
* Behavior

## Sides

Available [here](../slides/mixins)

## Warm Up

Spend the first five minutes writing answers to the following questions:

* What do you know about modules already? If little, what would you guess modules are all about based on the name?
* Football players and soccer players both have unique attributes. What behaviors might they share?

## Introduction

We're going to learn about Modules, a simple tool that will does a few completely different things in Ruby. Today we are going to talk about using them as Mixins. They are pretty awesome.

### Mixins

* Mixins allow us to share behavior between classes
* Ruby implements mixins with Modules

### Modules

* Modules may look like classes, but they only hold methods
* Modules only store behavior
* Modules *do not* store state

Let's make some online orders - **Take 1**.

`touch grubhub_order.rb`

```ruby
class GrubhubOrder
  def confirmation(item)
    puts "You got #{item}."
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
  def confirmation(item)
    puts "You got #{item}."
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

amazon.confirmation('chocolate')
grub.confirmation('chocolate')

amazon.review
grub.review

amazon.delivery
grub.delivery
```

**Turn & Talk:**

- What is similar/different between the two classes (GrubHub v Amazon)?
- What design principle(s) are we breaking with these two classes? Explain.

Let's extract the duplication using Modules - online orders **Take 2**.

`touch online_order.rb`

```ruby
module OnlineOrder
  def confirmation(item)
    puts "You got #{item}."
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

amazon.confirmation('chocolate')
grub.confirmation('chocolate')

amazon.review
grub.review

amazon.delivery
grub.delivery
```

**Turn & Talk:**

What just happened there?


### Key Points

- Once a module is included in a class, any object created from that class can call the method in the module (we just treat it as if the `confirmation` and `review` methods were part of our other classes, where you call the methods on an instance of an class.)
- Many classes can include the same module
- Each class can include many modules


## Exercise: Modules

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

* Create an `Engine` module to extract the `start` and `stop` methods.
* Take the code from the discussion and implement a `AirConditioning` module that is mixed into both classes.
* Instances of either class should be able to turn the AC on (`Chilly air coming your way!`) or off (`Temp is fine in here.`).

DISCUSS: Why didn't I just tell you to have a 'Vehicle' module that could hold engine and AC? What might the benefit of those being separated be?

BONUS:
* Now that stop and start are extracted to the module, add back in a start or stop method in one of your class. Have it return the string "WAIIIIIIIT". What happens when you run this method? Why?

## Summary
* What is a module? How is it different than a class?
* How do you use a module?

## Additional Reading

Module Resources:
* [Include vs Extend in Ruby](http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/) from John Nunemaker
* [Modules](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_modules.html) in Programming Ruby / RubyDoc
* [Ruby Class, Module, and Mixin](http://matt.aimonetti.net/posts/2012/07/30/ruby-class-module-mixins/) by Matt Aimonetti
