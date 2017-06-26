---
layout: page
title: Intro to Classes
length: 60
tags: ruby, classes, objects
---

## Learning Goals

* Define classes with instance methods in Ruby
* Define classes with instance variables in Ruby

## Warmup

* Define a method `sum` that takes two numbers as arguments and returns their sum
* Define a method `hello` that returns the string "Hello, and welcome!"
* Define a method `print_hello` that prints the string "Hello, and welcome!" to the screen
* Wrap these methods in a `Calculator` class
* Create a new instance of our `Calculator` class and call the methods you defined

## Lesson

### Organizing Methods with Classes

Let's start with the `Converter` class from yesterday's lesson.

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

Wrapping these methods in a class changed the way we will interact with them and provided some organization. We've provided an indication to our future selves and to others who might work with this code that these methods are related.

One of the primary functions of a class is to create new instances of that class. Putting these methods inside of this class means that we will now need to call them on an instance of that class. They are now **instance methods**.

Add the following to a new file called `converter_runner.rb`.

```ruby
# converter_runner.rb
require './converter'

converter = Converter.new
converter.convert(32, 35, 100)
puts "This is our converter: " + converter
```

Run that file by typing `ruby converter_runner.rb` into your terminal and see what happens.

First we get our expected output from running the `.convert` method on our `Converter` class.

What's after that?

The output from `puts "This is our converter: " + converter` is the way that Ruby represents an instance of an object to use in print. Notice there's an `object_id` that is unique to each instance we've created. Even though they generally look the same, our computer is now tracking three separate instances of our Converter object.

### Behavior & State

Thus far we've only used classes as a place to collect instance methods (methods that we call on a specific instance of the class). Sometimes we say that these methods define the *behavior* of these instances. But why bother creating multiple instances if they all have exactly the same behavior? That's where *state* comes in. State refers to the specific attributes of an instance of a class. Applying this to a `Classroom` example, a specific classroom might have a width *attribute*. It's width would be considered to be part of its *state*.

#### Adding State to Our Classes

We generally store state with **instance variables**, and frequently define them using an `initialize` method that is invoked in the background when we call `.new`.

Let's create a new `Classroom` class that holds information about a classroom:

```ruby
# classroom.rb
class Classroom
  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end
end
```

Those variables beginning with `@` are **instance variables** they can have a unique value for each **instance** that we create. That's great. That means that we can now create multiple classroom instances that have different lengths/widths/heights.

How do we use this new Classroom class? Let's create a runner file!

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts classroom_a
```

Run that and what do we get? Sure enough, it's an instance of classroom!

That's great. We can set the attributes of the classroom instance when I create it. What if I want to access those attributes? Basically, what happens if I forget the length of the classroom? How do I ask it?

Let's add a line to our runner file.

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts "Length: " + classroom_a.length
```

Run that, and we get a no method error. This is a little bit tricky. It's true we could create a method to access these instance variables, but Ruby gives us a shortcut. Update your `classroom.rb` file as follows:

```ruby
# classroom.rb
class Classroom
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

This will allow us to access all of the instance variables by sending messages to our instance (e.g. calling `classroom_a.width` or `classroom_a.length`, etc.).

#### Combining State and Behavior

That's great! What about methods? Yesterday we used methods in our classes, and we can still do that. Now, we can use our instance variables to create instance methods that return different values based on the state of our instance.

```ruby
# classroom.rb
class Classroom
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

Let's update our runner as well:

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts "Length: " + classroom_a.length
puts "Width: " + classroom_a.width
puts "Area: " + classroom_a.area
```

#### Changing State

What if we want to change the values of our instance? Assume Turing hires a contractor to renovate our classrooms.

We have two ways that we could potentially change these values. Update our files based on the code below:

```ruby
# classroom.rb
class Classroom
  attr_accessor :length,
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

  def add_length(feet)
    @length += feet
  end
end
```

And our runner:

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts "Length: " + classroom_a.length
puts "Width: " + classroom_a.width
puts "Area: " + classroom_a.area

puts "Make length 1."
classroom_a.length = 1

puts "New Length: " + classroom_a.length
puts "New Area: " + classroom_a.area

puts "Add four to length"
classroom_a.add_length(4)

puts "New Length: " + classroom_a.length
puts "New Area: " + classroom_a.area
```

Changing our `attr_reader`s to `attr_accessor`s makes it so that we can change the classroom's value from outside the class to **anything** we want. We are placing some trust in people using the class that they will use it responsibly.

Meanwhile, the method `add_length` is a little more specific in what it allows us to do; specifically, using this method we can make the classroom longer. No other change is allowed. We do this by accessing the **instance variable** from within the method. Note, we could do this without an `attr_accessor`.

### Practice

Create a `Lunchbox` class that has theme, height, width, and length attributes. Allow users to access the theme, and create a method `capacity` that returns the total volume the lunchbox can hold.

## Summary

* How would you define a `Cubby` class in Ruby?
* What might be some of its attributes?
* What might be some of its methods?
