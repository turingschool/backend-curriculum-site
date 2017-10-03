---
layout: page
title: Intro to Methods
length: 60
tags: ruby, methods
---

## Learning Goals

* Define methods in Ruby
* Explain why we use methods
* Define methods that take arguments
* Define methods that do not take arguments

## Vocabulary
* Method
* Argument
* Parameter
* Return
* Abstraction

## Slides

Available [here](../slides/intro_to_methods)

## Warmup

* What do you know about methods from your prework?
* How have you organized your code up to this point?
* What tools have you used if you wanted to perform the same action multiple times?

## Lesson

### Defining Methods without Parameters

Assume that we want to create a simple program to convert Fahrenheit to Celsius. One way that we could do this would be to create a file called `converter.rb`, include the following line of code, and then run `ruby converter.rb` from the command line.

```ruby
# converter.rb
puts 'Welcome to Converter!'
```

A method allows us to reuse that same snippet of code. We define a method using the keyword `def`, followed by the name of the method, some set of instructions, followed by the keyword `end`.  
Now assume that we want to make it so that we can reuse this code. We could define a method `print_welcome` that would allow us to print this statement many times.

```ruby
# converter.rb
def print_welcome
  puts 'Welcome to Converter!'
end

print_welcome
print_welcome
print_welcome
```

**Try it!**  
With a partner, create a method `print_welcome` in a new file `doubler.rb` that prints the message `Welcome to Doubler!`

### Defining Methods with Parameters

Frequently, methods take an input and return some output.

Continuing with our example that will convert a temperature in Fahrenheit and convert it to Celsius. In this case, our inputs/outputs are as follows:

* Input: temperature in Fahrenheit
* Output: temperature in Celsius

The formula for converting F to C is this:

(F - 32) * 5/9

We can define a `convert_to_celsius` method that will take the temperature in Fahrenheit as a **parameter** and **returns** the temperature in Celsius.

```ruby
def convert_to_celsius(temperature)
  ((temperature - 32) * 5.0 / 9.0).round(2)
end
```

In the above method, we define a **parameter** temperature and **return** a float rounded to two decimal places. How do we know what is being returned in the method above? Ruby always returns the last line run in a method.

We could add lines above the last line if we wanted, and, as long as they didn't change the `temperature` variable, the method would still return the same value:

```ruby
def convert_to_celsius(temperature)
  1+1
  ["piglet", "kitten", "baby gorilla"]
  99
  ((temperature - 32) * 5.0 / 9.0).round(2)
end
```

If we save this method in a file, we can then call it multiple times with different **arguments**.

```ruby
# converter.rb

def print_welcome
  puts 'Welcome to Converter!'
end

def convert_to_celsius(temperature)
  ((temperature - 32) * 5.0 / 9.0).round(2)
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

def convert_to_celsius(temperature)
  ((temperature - 32) * 5.0 / 9.0).round(2)
end

celsius_1 = convert_to_celsius(32)
celsius_2 = convert_to_celsius(35)
celsius_3 = convert_to_celsius(100)

print_welcome
puts celsius_1
puts celsius_2
puts celsius_3
```
**Turn & Talk**  
How is this program working? Talk with your partner about what each line is in charge of. Try to point out where the following are taking place: parameter, argument, return, assign to a variable.

In the code snippet above we define a method `convert_to_celsius` that uses the **parameter** `temperature` to calculate the equivalent temperature in Celsius. We then call the method three times and pass it 32, 35, and 100 as **arguments**. Each time we call it, we **assign** the value that the method **returns** to a variable `celsius_1`, `celsius_2`, and `celsius_3`. We then print the values stored in those three variables to the screen.

**TRY IT**: With your pair, define a method `doubler` that takes a single argument, doubles it (multiply by two) and returns it. Similar to what we've done above, call that method three times and save the return values to variables. Then print those values to the screen.

### Calling Methods from Other Methods

We can also call methods from within other methods that are in the same scope. Let's add a function that takes a number and then prints a more robust message.

```ruby
# converter.rb

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

print_welcome
print_converted(32)
print_converted(35)
print_converted(100)
```

With a partner, add another method to your `doubler.rb` file `print_double` which accepts an argument and prints a phrase in the form `3 doubled is 6`

Once you've completed that, see if you can determine what the `print_converted` or your `print_double` method **returns**. Why might that be?

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

def convert_to_celsius(temperature)
  ((temperature - 32) * 5.0 / 9.0).round(2)
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
