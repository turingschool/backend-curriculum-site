---
layout: page
title: Methods and Return Values
length: 90
tags: ruby, methods, return, argument
---

## Learning Goals

* Define the terms Method, Argument, and Return Value
* Explain why we use methods
* Define methods in Ruby
* Explain where Ruby looks for methods
* Understand how abstraction helps us program

## Vocabulary

* Method
* Return
* Argument (Parameter)
* Parse
* Execute
* Abstraction

## Warmup

With your partner define the following terms in your own words:

* Method
* Argument
* Return Value
* Object

Then, for each of the terms above, identify examples of the previous terms in the pry snippets below:

```ruby
pry(main)> "Hello World".upcase
=> "HELLO WORLD"
```

``` ruby
pry(main)> "Hello World".include?("Hello")
=> true
```

## Define and Identify

During this first section of the lesson, you have a worksheet to follow along with. Feel free to take notes as we go on that or in your notebook. At the end, you'll be given a minute or so to make sure you have notes on the worksheet.

## Methods

A **Method** is a group of related instructions that achieves some purpose. If you open up pry and type:

```ruby
pry(main)> "Hello World".upcase
=> "HELLO WORLD"
```

You are calling the `upcase` method. It's job is to create a version of the String with all capital letters.

<br>
<br>
<br>
<br>

**Turn and Talk**: Imagine the `upcase` method didn't exist. How might you recreate this method in Ruby?

<br>
<br>
<br>
<br>

One of the most important reasons we need methods is to **reuse code**. Instead of rewriting all those lines of code for creating an upcased string, we simply call the `upcase` method.

The example illustrates another key point: **methods run on objects**. In the example above, the `upcase` method is running on `"Hello World"`, which is a String object. You can think of methods like they are messages to an object. The above code is like saying, "Hey string, give me an upcased version of yourself."

To recap the Key Points from this section:
- We use methods so we can reuse code
- Methods run on objects


## Return Values

A **Return Value** is the output of a **Method**.

Every **Method** has *exactly one* **Return Value**.

A **Return Value** can be any type, for example `4`, `"Hello World"`, `true`, `[1,2,3]`, `nil`.

If you open a pry session and type

```ruby
pry(main)> "Hello World".upcase
=> "HELLO WORLD"
```

You are calling the `upcase` **Method** on the string`"Hello World"`. The **Return Value**, denoted by the `=>`, is `"HELLO WORLD"`.


## Arguments

**Arguments** are the input to a method. They are also known as **Parameters**.

If you open a pry session and type

```ruby
pry(main)> "Hello World".include? "Hello"
=> true
```

You are calling the `include?` method on the string `"Hello World"`. You are passing the **Argument** `"Hello"` to the `include?` method. The **Return Value** is `true`.

**Note**: Parenthesis are optional when passing arguments. The previous code snippet could also be written as:

```ruby
pry(main)> "Hello World".include?("Hello")
=> true
```

Some methods take multiple **Arguments**. For example:

```ruby
pry(main)> "Hello World".gsub("World", "Turing")
=> "Hello Turing"
```

This is the same as:

```ruby
pry(main)> "Hello World".gsub "World", "Turing"
=> "Hello Turing"
```

<br>
<br>
<br>
<br>

**Partner Practice Time**: On your worksheet.


## Defining our own Methods

`.upcase`, `.include?`, and `.gsub` are all **Methods** built in to the string class. What if we want to create our own class with its own methods?

Let's make a class that converts temperatures from Fahrenheit to Celsius. In a new file called `converter.rb`, we'll add the following lines of code and run this file from the command line using `ruby converter.rb`.

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end
end
```

**Turn and Talk**: What will happen when this code runs?

<br>
<br>
<br>
<br>

We didn't we see `Welcome` printed to the screen because the `class` and `def` keywords *define* the class and method, but our code does not *call* the method. Remember, methods run on objects, so the first thing we need to do is create an object using our class. Then we can call the method on it:


```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end
end

converter = Converter.new
converter.print_welcome
```

## Defining methods that take Arguments

Let's now add a method that can convert a Fahrenheit temperature to Celsius.

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius

  end
end
```

We need to give this method the Fahrenheit temperature as an input. Therefore, we define an **Argument** called `fahrenheit`. Let's also call this method at the bottom of the file:

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)

  end
end

converter = Converter.new
converter.convert_to_celsius
```

**Turn and Talk**: What will happen when we run this code?

<br>
<br>
<br>
<br>

The error we get is `ArgumentError: wrong number of arguments (given 0, expected 1)`. We defined our method to take 1 argument, but when we called it we didn't provide an argument. This is what it means by "given 0, expected 1".

Let's pass our method an argument:

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)

  end
end

converter = Converter.new
converter.convert_to_celsius(32)
```

When we provide an argument to a method, we can reference it inside the method using the name we provided. For now, let's just print it:

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)
    puts fahrenheit
  end
end

converter = Converter.new
converter.convert_to_celsius(32)
```

You can think of an argument as a variable that is created right at the start of the method.


## Defining Return Values

We want this method to output, or **Return** the Celsius temperature. How does Ruby know what value to return?

A return value is either:

1. defined *explicitly* using the `return` keyword OR
2. is the last line of code run, if no `return` keyword was used.

Let's create an **Explicit Return** like so:

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)
    celsius = ((fahrenheit - 32) * 5.0 / 9.0).round(2)
    return celsius
  end
end

converter = Converter.new
converter.convert_to_celsius(32)
```

We could write the same method using an **Implicit Return**:

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)
    ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  end
end

converter = Converter.new
converter.convert_to_celsius(32)
```

Run either of these versions, and you won't see anything printed to the screen. We did everything else: we defined our class and method, we called it, and it returned the value we were looking for, but we didn't see it because we never told Ruby to print it. **THIS IS VERY IMPORTANT:** returning and printing are NOT the same!

If we want to see the return value, we can save it to a variable and then print it:

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)
    ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  end
end

converter = Converter.new
celsius = converter.convert_to_celsius(32)
puts celsius
```

Or we can skip saving to a variable and print the return value directly:

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)
    ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  end
end

converter = Converter.new
puts converter.convert_to_celsius(32)
```

## Practice

Following the directions in [this gist](https://gist.github.com/ameseee/c311860e9f6bc023036351f298907ccb), work with your partner through the activities.

You focus should be exploring to build a deep understanding of these concepts, NOT to race through the activity for the sake of finishing it. Whether you know this stuff or not, there should be plenty for you and your partner to talk about/dig into during this time.

## Method Lookup

Imagine you open a classmate's project and you stumble upon this code:

```ruby
thing = Thing.new
thing.some_random_method
```

**Turn and Talk**:

Where would you go to find out what the `some_random_method` method does?

<br>
<br>
<br>
<br>

Remember, methods run on objects. In order to find where a method is defined, we need to first ask ourselves what type of object it is being called on. Look in the class file for that object's class type, and you might find it there. We say *might* because there's actually a long list of places that Ruby can look for a method. For right now, what you need to know is that when looking for a method, the first thing Ruby will do is look in the class of the object it is being called on.

**Turn and Talk**:

Where would you look to figure out how the slice method works?
```ruby
nums = [1, 2, 3, 4]
nums.slice(1, 1)
```

## Calling Methods from Other Methods

We can also call methods from within other methods that are in the same class. Let's add a function that takes a number and then prints a more robust message.

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)
    ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  end

  def print_celsius_converted(temperature)
    converted = convert_to_celsius(temperature)
    puts "#{temperature} degrees Fahrenheit is equal to #{converted} degrees Celsius"
  end
end

converter = Converter.new
converter.print_welcome
converter.print_celsius_converted(32)
converter.print_celsius_converted(35)
converter.print_celsius_converted(100)
```

## Layers of Abstraction


One of the advantages of using methods is that we can build methods that operate at higher levels of abstraction than other methods. Abstraction is a practice where less complex functionality is exposed in an interface and more complex functionality is suppressed. In some ways, this is like a pyramid where higher level methods rely on lower level methods to take care of the details.

Think about how you drive a car. You don't need to know how a combustion engine works in order to drive it. All you need to know is that when you put your foot down on the gas pedal, the car moves. The details of how the engine work are *abstracted* away from you. You only need to know how the gas pedal works, the *interface*.

![](https://camo.githubusercontent.com/07f5ef4748c194ee893c18089a2b6513d473ac37/687474703a2f2f6d696e6573662e636f6d2f7265736f75726365732f6363612f77702d636f6e74656e742f75706c6f6164732f323031302f30312f61627374726163742d6f2d6d65746572312e6a7067)

If we look at our `converter.rb` file, what we really want to do is take three numbers, print a welcome, and then print a message for each of those numbers. We can create a method that does exactly that. Bundling these more detailed methods into more abstract methods can help us to create more complex programs.

```ruby
class Converter
  def print_welcome
    puts "Welcome to Converter!"
  end

  def convert_to_celsius(fahrenheit)
    ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  end

  def print_celsius_converted(temperature)
    converted = convert_to_celsius(temperature)
    puts "#{temperature} degrees Fahrenheit is equal to #{converted} degrees Celsius"
  end

  def convert(first, second, third)
    print_welcome
    print_celsius_converted(first)
    print_celsius_converted(second)
    print_celsius_converted(third)
  end
end

converter = Converter.new
converter.convert(32, 35, 100)
converter.convert(12, 45, 65)
```

A note on order: The order of your _methods_ does not matter.  Ruby will **parse** each method in the class and then when a method is **called** Ruby will **execute** the parsed methods accordingly.

## Check for Understanding

1. What is a method? An argument? A return value?
2. What keywords do we use to create methods?
3. How does Ruby know what to return from a method?
4. How do you call one method from within another method?
5. Why do we use methods?
6. What is abstraction?
