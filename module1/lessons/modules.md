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
* Mixin
* Module
* Instantiate
* State
* Behavior

## Sides

Available [here](../slides/mixins)

## Warm Up

Jot down your thoughts for the following questions. Be ready to share.

* What do you know about modules already? If little, what would you guess modules are all about based on the name?
* Football players and soccer players both have unique attributes. What behaviors might they share?
* What behaviors/abilities might be shared between an instructor and a student?

## Introduction

We're going to learn about Modules, a simple tool that will do a few completely different things in Ruby. Today we are going to talk about using them as Mixins. 

### Mixins

* Mixins allow us to share behavior between objects
* Ruby implements mixins with Modules

### Modules

* Modules may look like classes, but they only hold methods
* Modules only store behavior
* Modules *do not* store state
* Modules cannot be instantiated. This means that you cannot type somethinglike `MyModule.new`

Let's look at two separate classes to start exploring the idea of modules. Clone down [this repo](https://github.com/turingschool-examples/ruby-module-example).

First, we'll experiment with the `StatusUpdate` class. 

`pry`

```ruby
require "./status_update.rb"
=> true

status = StatusUpdate.new("I'm learning about modules in Ruby #nbd")

status.display

status.add_comment("Oh cool!")
status.add_comment("Just wait until you learn about inheritance.")
status.add_comment("What is a module?")
status.add_comment("I'm so proud of you! Love, mom.")

status.display

status.remove_comment(3)

status.display
```

Now, let's experiment with the `Photo` class.


```ruby
require "./photo.rb"
=> true

photo = Photo.new("https://images.pexels.com/photos/2280545/pexels-photo-2280545.jpeg", "This is what I ate for breakfast #yum #hashtag")

photo.display

photo.add_comment("That looks delicious!")
photo.add_comment("Ooooh, will you cook for me?")
photo.add_comment("Brunch next Sunday?")

photo.display

photo.remove_comment(1)

photo.display
```

**Turn & Talk:**

- What is similar/different between the two classes (StatusUpdate and Photo)?
- What design principle(s) are we breaking with these two classes? Explain.

### Modules

We can extract this duplication into a **module** which we'll include within each class. Oftentimes, you'll see modules named with the convention "-able", like [Comparable](https://docs.ruby-lang.org/en/2.5.0/Comparable.html) or [Enumerable](https://docs.ruby-lang.org/en/2.5.0/Enumerable.html). 

`touch commentable.rb`

```ruby
module Commentable
  # what extracted code goes here? 
end
```

To get access to the methods defined in the module, you will include the module at the beginning of the class. Using include allows you to call the module methods on an instance of the class where it is included.

In `status_update.rb`

```ruby
require "./commentable"

class StatusUpdate
  include Commentable

  # ... other code
end
```

In `photo.rb`

```ruby
require "./commentable"

class Photo
  include Commentable

  # ... other code
end
```

Get back into Pry and try out the interaction pattern below:


```ruby
require "./status_update.rb"
require "./photo.rb"

status = StatusUpdate.new("I'm learning about modules in Ruby #nbd")

status.display

status.add_comment("Oh cool!")
status.add_comment("Whoa...")

status.display

status.remove_comment(1)

status.display


photo = Photo.new("https://images.pexels.com/photos/2280545/pexels-photo-2280545.jpeg", "This is what I ate for breakfast #yum #hashtag")

photo.display

photo.add_comment("That looks delicious!")
photo.add_comment("Pancakes!")

photo.display

photo.remove_comment(2)

photo.display
```

**Turn & Talk:**

- What just happened there?
- What would be the benefit of a module? 
- Where else might you be able to reuse `Commentable`? 

### Key Points

- Once a module is included in a class, any object created from that class can call the method in the module (we just treat it as if the `add_comment` and `remove_comment` methods were part of our other classes, where you call the methods on an instance of an class.)
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

* Create an `Engine` module to extract the `start` and `stop` methods. (Yes, we know this isn't following the "-able" naming conventions, but this is not a rule).
* Create an `Airconditionable` module that is mixed into both classes. Instances of either class should be able to turn the AC on (`Chilly air coming your way!`) or off (`Temp is fine in here.`). It's up to you what you want to name these methods.
* Now that stop and start are extracted to the module, add back in a start or stop method in one of your class. Have it return the string "WAIIIIIIIT". What happens when you run this method? Why?

## Summary
* In the exercise above, why didn't we just tell you to have a 'Vehicle' module that could hold engine and AC? What might the benefit of those being separated be?
* What is a module? How is it different than a class?
* How do you allow a class to have access to module methods? 

## Additional Reading

Module Resources:
* [Include vs Extend in Ruby](http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/) from John Nunemaker
* [Modules](http://ruby-doc.com/docs/ProgrammingRuby/html/tut_modules.html) in Programming Ruby / RubyDoc
* [Ruby Class, Module, and Mixin](http://matt.aimonetti.net/posts/2012/07/30/ruby-class-module-mixins/) by Matt Aimonetti
