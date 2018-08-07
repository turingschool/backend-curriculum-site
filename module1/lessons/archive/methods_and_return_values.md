---
layout: page
title: Methods and Return Values
length: 60
tags: ruby, methods, return, argument
---

## Learning Goals

* Understand Return Values
* Understand Arguments
* Define methods in Ruby
* Explain why we use methods
* Understand different types of methods
* Understand how abstraction helps us program

## Slides

Available [here](../slides/methods_and_return_values)

## Vocabulary
* Return
* Method
* Argument
* Parse
* Execute
* Abstraction

## Warmup

* Write out a list of steps to describe how these lines of code work:

  ```ruby
    pi = 3.14159265359.round(2)
    puts pi
  ```

* What methods are being called?
* What are those methods being called on?

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

**Note**: Parenthesis are optional when passing parameters. The previous code snippet could also be written as:

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

## Defining our own Methods

`.upcase`, `.include?`, and `.gsub` are all **Methods** built in to the string class. What if we want to define our own methods? We do that with the `def` keyword.

Let's make a new file called `converter.rb` to convert Fahrenheit to Celsius. We'll add the following lines of code and run this file from the command using `ruby converter.rb`.

```ruby
def print_welcome
  puts "Welcome!"
end
```

Why didn't we see `Welcome` printed to the screen? Because the `def` keyword *defines* the **Method** `print_welcome`, but it does not *call* the **Method**. In order to call the **Method**, we could do something like this:

```ruby
def print_welcome
  puts "Welcome!"
end

print_welcome
```

And we could see `Welcome` printed to the screen.

## Defining methods that take Arguments

Let's now add a method that can convert a Fahrenheit temperature to Celsius.

```ruby
def convert_to_celsius

end
```

We need to give this method the Fahrenheit temperature as an input. Therefore, we define a **Parameter** called `fahrenheit`:

```ruby
def convert_to_celsius(fahrenheit)

end
```

## Defining Return Values

We want this method to output, or **Return** the Celsius temperature. How does Ruby know what value to return?

A return value is either:

1. defined *explicitly* using the `return` keyword OR
1. is the last line of code run, if no `return` keyword was used.

Let's create an **Explicit Return** like so:

```ruby
def convert_to_celsius(fahrenheit)
  celsius = ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  return celsius
end
```

We could write the same method using an **Implicit Return**:

```ruby
def convert_to_celsius(fahrenheit)
  ((fahrenheit - 32) * 5.0 / 9.0).round(2)
end
```

We could add lines above the last line if we wanted and the method would still return the same value:

```ruby
def convert_to_celsius(fahrenheit)
  1+1
  ["piglet", "kitten", "baby gorilla"]
  99
  ((fahrenheit - 32) * 5.0 / 9.0).round(2)
end
```

And we could add lines below and use the `return` keyword:

```ruby
def convert_to_celsius(fahrenheit)
  return ((fahrenheit - 32) * 5.0 / 9.0).round(2)
  1+1
  ["piglet", "kitten", "baby gorilla"]
  99
end
```

As soon as Ruby sees the `return` keyword, the method stops and outputs the specified value.

**IMPORTANT: each of the previous versions of convert_to_celsius return the same value**

## Calling our Methods

Let's update the `converter.rb` file:

```ruby
# converter.rb

def print_welcome
  puts 'Welcome to Converter!'
end

def convert_to_celsius(fahrenheit)
  ((fahrenheit - 32) * 5.0 / 9.0).round(2)
end

print_welcome
convert_to_celsius(32)
convert_to_celsius(35)
convert_to_celsius(100)
```

Once you have saved the code above, run it using the command `ruby converter.rb` in your terminal. Be sure you are in the same directory as the `converter.rb` file.

What happens? Is it what you expected? Why or why not?

It may look like nothing happened, but in the background this program ran and did everything we told it to. We didn't see anything because we never explicitly told it to print values to the screen.

Let's change the program so that we can see some output.

```ruby
# converter.rb

def print_welcome
  puts 'Welcome to Converter!'
end

def convert_to_celsius(fahrenheit)
  ((fahrenheit - 32) * 5.0 / 9.0).round(2)
end

celsius_1 = convert_to_celsius(32)
celsius_2 = convert_to_celsius(35)
celsius_3 = convert_to_celsius(100)

print_welcome
puts celsius_1
puts celsius_2
puts celsius_3
```

### Calling Methods from Other Methods

We can also call methods from within other methods that are in the same scope. Let's add a function that takes a number and then prints a more robust message.

```ruby
# converter.rb

def print_welcome
  puts 'Welcome to Converter!'
end

def convert_to_celsius(fahrenheit)
  ((fahrenheit - 32) * 5.0 / 9.0).round(2)
end

def print_converted(temperature)
  converted = convert_to_celsius(temperature)
  puts "#{temperature} degrees Fahrenheit is equal to #{converted} degrees Celsius"
end

print_welcome
print_converted(32)
print_converted(35)
print_converted(100)
```

### Layers of Abstraction

One of the advantages of using methods is that we can build methods that operate at higher levels of abstraction than other methods. Abstraction is a practice where less complex functionality is exposed in an interface and more complex functionality is suppressed. In some ways, this is like a pyramid where higher level methods rely on lower level methods to take care of the details.

![](https://camo.githubusercontent.com/07f5ef4748c194ee893c18089a2b6513d473ac37/687474703a2f2f6d696e6573662e636f6d2f7265736f75726365732f6363612f77702d636f6e74656e742f75706c6f6164732f323031302f30312f61627374726163742d6f2d6d65746572312e6a7067)

If we look at our `converter.rb` file, what we really want to do is take three numbers, print a welcome, and then print a message for each of those numbers. We can create a method that does exactly that. Bundling these more detailed methods into more abstract methods can help us to create more complex programs.

```ruby
# converter.rb

def convert(first, second, third)
  print_welcome
  print_converted(first)
  print_converted(second)
  print_converted(third)
end

def print_welcome
  puts 'Welcome to Converter!'
end

def convert_to_celsius(fahrenheit)
  ((fahrenheit - 32) * 5.0 / 9.0).round(2)
end

def print_converted(temperature)
  converted = convert_to_celsius(temperature)
  puts "#{temperature} degrees Fahrenheit is equal to #{converted} degrees Celsius"
end
convert(32, 35, 100)
convert(12, 45, 65)
```

**Turng & Talk**
Talk with your partner about the flow of this program. Where does it start, how does each method get called?  


With a partner, create a method that provides similar functionality for `doubler.rb`. If you finish that, see if you can change your method so that it accepts an array as an argument and prints a message for each element of the array.

## WrapUp

* How do we define methods in Ruby?
* What is the difference in how we define a method that takes arguments from one that does not?
* How do you call one method from within another method?
* Why do we use methods?
