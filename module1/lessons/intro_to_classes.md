---
layout: page
title: Intro to Classes
length: 60
tags: ruby, classes, objects
---

## Learning Goals

* Define classes with instance methods in Ruby
* Define classes with instance variables in Ruby
* Identify the application of Abstraction and Encapsulation principles

## Schedule
* 5min - WarmUp
* 15min - Organizing Methods with Classes
* 5min - Break
* 15min - Behavior & State 
* 10min - Independent Practice
* 5min - WrapUp

## Vocabulary
* Class
* Instance
* Instance Method
* Object
* Abstract/Abstraction
* Instance Variable
* Encapsulation

## Slides

Linked [here](../slides/intro_to_classes)

## Warmup

* Define a method `hello` that returns the string "Hello, and welcome!"
* Define a method `sum` that takes two numbers as arguments and returns their sum
* Wrap these methods in a `Calculator` class
* Create a new instance of our `Calculator` class and call the methods you defined

## Lesson  

### Basic Classes

Using our Converter from yesterday, we have a nice small set of methods that hang together to provide some functionality. Let's do just a little bit more work to wrap these methods together. We'll do that by creating a class to wrap these methods.

The general pattern for creating a class is as follows:

```ruby
class NameOfClass
  # stuff
end
```

When we wrap these methods in a class we need to create a new **instance** of the class on which to call these methods. We sometimes say that the instance is the **receiver**, that we're sending messages to it, and that it is responding to those messages.

### Organizing Methods with Classes

```ruby
# converter.rb

class Converter
  def convert(first, second, third)
    print_welcome
    print_converted(first)
    print_converted(second)
    print_converted(third)
  end

  def print_welcome
    puts 'Welcome to Converter!'
  end

  def convert_to_celsius(temperature)
    ((temperature - 32) * 5.0 / 9.0).round(2)
  end

  def print_converted(temperature)
    converted = convert_to_celsius(temperature)
    puts "#{temperature} degrees Fahrenheit is equal to #{converted} degrees Celsius"
  end
end
```

Wrapping these methods in a class changes the way we will interact with them and provides some organization. We've provided an indication to our future selves and to others who might work with this code that these methods are related.

One of the primary functions of a class is to create new instances of that class. Putting these methods inside of this class means that we will now need to call them on an instance of that class. They are now **instance methods**.

Add the following to a new file called `converter_runner.rb`.

```ruby
# converter_runner.rb
require './converter'

converter = Converter.new
converter.convert(23, 27, 73)
puts "This is our converter: #{converter}"

converter = Converter.new
converter.convert(32, 35, 100)
puts "This is our converter: #{converter}"

converter = Converter.new
converter.convert(34, 22, 83)
puts "This is our converter: #{converter}"
```

Run that file by typing `ruby converter_runner.rb` into your terminal and see what happens.

First we get our expected output from running the `.convert` method on our `Converter` class.

What's after that?

The output from `puts "This is our converter: #{converter}"` is the way that Ruby represents an instance of an object to use in print. Notice there's an `object_id` that is unique to each instance we've created. Even though they generally look the same, our computer is now tracking three separate instances of our Converter object.  

An *object* is an abstract representation of a real world thing. Remember, Abstraction is the practice of creating classes/objects and building out an interface with logical behaviors and characteristics.

Here we see Abstraction coming in to play where the user can interface with a Converter. It has specific details about it that we interact with such as `.convert` but other details that we do not interact with such as .`convert_to_celcius`.

### Behavior & State

Thus far we've only used classes as a place to collect **instance methods** (methods that we call on a specific instance of the class). Sometimes we say that these methods define the **behavior** of these instances. But why bother creating multiple instances if they all have exactly the same behavior? That's where **state** comes in. State refers to the specific attributes of an instance of a class. Applying this to a `Classroom` example, a specific classroom might have a width **attribute**. It's width would be considered to be part of its **state**.

#### Adding State to Our Classes

We generally store state with **instance variables**, and frequently define them using an `initialize` method that is invoked in the background when we call `.new`.

Imagine we are creating a program that tells a general contractor how to plan out rooms. Let's create a new `Room` class that holds information about a classroom:

```ruby
# Room.rb
class Room
  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end
end
```

Those variables beginning with `@` are **instance variables** they can have a unique value for each **instance** that we create. That's great. That means that we can now create multiple room instances that have different lengths/widths/heights.

How do we use this new Room class? Let's create a runner file!

```ruby
# room_runner.rb
require './room'

room = Room.new(10, 5, 20)
puts room
```

Run that and what do we get? Sure enough, it's an instance of Room!

That's great. We can set the attributes of the classroom instance when we create it. What if I want to access those attributes? Basically, what happens if I forget the length of the this particular room? How do I ask it?
We could put a pry to dig around.

```ruby
#room_runner.rb
require 'pry'
require './room'

room = Room.new(10, 5, 20)
binding.pry
```

When we call `room_a` in our pry session, we get something like this `#<Room:0x007fe119e926c0>`, we still can't see the length. This is due in part to the principle of Encapsulation, where information is only exposed when intentionally built to do so. Right now, we want to expose that information, so let's do that.

Let's add a line to our runner file.

```ruby
# room_runner.rb
require './room'

room = Room.new(10, 5, 20)
puts "Length: #{room.length}"
```

Run that, and we get a no method error. This is a little bit tricky. It's true we could create a method to access these instance variables, but Ruby gives us a shortcut. Update your `room.rb` file as follows:

```ruby
# room.rb
class Room
  attr_reader :length,
              :width,
              :height

  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end
end
```

This will allow us to access all of the instance variables by sending messages to our instance (e.g. calling `room.width` or `room.length`, etc.).

#### Combining State and Behavior

That's great! What about methods? Yesterday we used methods in our classes, and we can still do that. Now, we can use our instance variables to create instance methods that return different values based on the state of our instance.

Let's update our runner:

```ruby
# room_runner.rb
require './room'

room = Room.new(10, 5, 20)
puts "Length: #{room.length}"
puts "Width: #{room.width}"
puts "Area: #{room.area}"
```
Run that, and we get a no method error for `area`. Let's build that method:

```ruby
# room.rb
class Room
  attr_reader :length,
              :width,
              :height

  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end

  def area
    length * width
  end
end
```

#### Changing State

What if we want to change the values of our instance? Imagine mid way through construction, the client wants to change the dimensions to a room they had planned. We need the program to accomodate changing values. 

Our runner:

```ruby
# room_runner.rb
require './room'

room = Room.new(10, 5, 20)
puts "Length: #{room.length}"
puts "Width: #{room.width}"
puts "Area: #{room.area}"

puts "Make length 1."
room.add_length(4)

puts "New Length: #{room.length}"
puts "New Area: #{room.area}"

puts "Add four to length"
room.width = 1

puts "New Length: #{room.length}"
puts "New Width: #{room.width}"
puts "New Area: #{room.area}"
```
We have two ways that we could potentially change these values. Update our files based on the code below:
We get a no method error for add_length. As well as an error for `room.width = 1`.

```ruby
# room.rb
class Room

  attr_reader :length,
              :width, 
	      
  attr_accessor :height

  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end

  def area
    length * width
  end

  def add_length(feet)
    @length += feet
  end
end
```



Changing an `attr_reader` to an `attr_accessor` makes it so that we can change the room's value from outside the class to **anything** we want. Note, we are changing, and reducing this object's Encapsulation. We are placing some trust in people using the class that they will use it responsibly. We use an `attr_accessor` **only** when we need to change something from outside the class and **only** when we are sure we can trust what they change it to - since they can change it to **ANYTHING**.

Meanwhile, the method `add_length` is a little more specific in what it allows us to do; specifically, using this method we can make the classroom longer. No other change is allowed. We do this by accessing the **instance variable** from within the method. Note, we could also do this with an `attr_accessor` but may not want to.

### Practice

Create a `Lunchbox` class that has theme, height, width, and length attributes. Allow users to access the theme, and create a method `capacity` that returns the total volume the lunchbox can hold.

## Summary

* Explain Abstraction in your own words.
* Explain Encapsulation in your own words.
* How would you define a `Cubby` class in Ruby?
	* What might be some of its attributes?
	* What might be some of its methods?
