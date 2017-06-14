---
layout: page
title: Intro to Classes
length: 60
tags: ruby, classes, objects
---

## Learning Goals

* Define classes with instance methods in Ruby
* Articulate advantages of using classes/objects over writing procedural code

## Warmup

* Define a method `sum` that takes two numbers as arguments and returns their sum
* Define a method `hello` that returns the string "Hello, and welcome!"
* Define a method `print_hello` that prints the string "Hello, and welcome!" to the screen

## Lesson

### Creating Classes and Instances in Ruby

The general pattern for creating a class is as follows:

```ruby
class NameOfClass
end
```

If we create a `Chair` class, we can then create multiple instances of that class using the `.new` method that is built into all classes in Ruby by default.

```ruby
# chair.rb

class Chair
end

chair_1  = Chair.new
puts "Number 1: #{chair_1}"

chair_2   = Chair.new
puts "Number 2: #{chair_2}"

chair_3 = Chair.new
puts "Number 3: #{chair_3}"
```

Run the code above from your command line using `ruby chair.rb`. What happens?

What prints to our terminal is the way that Ruby represents an instance of an object to use in print. Notice there's an `object_id` that is unique to each instance we've created. Even though they generally look the same, our computer is now tracking three separate instances of our Chair object.

### Organizing Methods with Classes

One of the powerful things about classes is that they allow us to organize methods that are related to one another.

Let's create a new class `Converter` that builds off of the methods that we created yesterday.

Start with a basic class definition:

```ruby
class Converter
end
```

And add in the methods from yesterday's class.

```ruby
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

What's the advantage of this over the collection of methods that we created yesterday? From the perspective of a user, maybe not much. Ultimately the functionality will be the same. What have we changed? We've changed the way we will interact with these methods and provided some organization to them. We've provided an indication to our future selves and to others who might work with this code that these methods are related.

Remember that one of the primary functions of a class is to create new instances of that class. Putting these methods inside of this class means that we will now need to call them on an instance of that class. They are now **instance methods**.

Add the following to a new file called `converter_runner.rb`.

Add the following to the bottom of your `converter.rb` file.

```ruby
require './converter'

converter = Converter.new
converter.convert(32, 35, 100)
```

Run that file by typing `ruby converter_runner.rb` into your terminal and see what happens.

### Practice

Create a `Calculator` class that has the methods `#double`, `#add`, `#subtract`, and `#square`. Implement the functionality of each of these methods and create a runner file that runs each of these methods.

## Summary

* How would you define a `Validator` class in Ruby?
* What are two advantages to using classes/objects over writing procedural code in Ruby?
