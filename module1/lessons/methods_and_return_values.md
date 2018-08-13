---
layout: page
title: Methods and Return Values
length: 90
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

**IMPORTANT: each of the previous versions of `convert_to_celsius` return the same value**

## Practice

Using our Credit Check project from yesterday, let's practice creating some of our own methods.

First, let's wrap our whole algorithm into one giant method, called `validate`:

```ruby
#lib/credit_check.rb

def validate(card_number)
  digits = card_number.chars
  double_every_other = []
  digits.each.with_index do |digit, index|
    if index.even?
      double_every_other << digit.to_i * 2
    else
      double_every_other << digit.to_i
    end
  end

  summed_over_ten = []
  double_every_other.each do |digit|
    if digit > 9
      summed_over_ten << digit - 9
    else
      summed_over_ten << digit
    end
  end

  sum = 0
  summed_over_ten.each do |digit|
    sum += digit
  end

  if sum % 10 == 0
    puts "The number #{card_number} is valid"
  else
    puts "The number #{card_number} is invalid"
  end
end

card_number = "5541801923795240"
validate(card_number)
```

Once you have saved the code above, run it using the command `ruby lib/credit_check.rb` in your terminal. Be sure you are in the root directory of your credit check project.

What happens? Is it what you expected? Why or why not?

Let's try something else. In the last `if` statement, remove the two `puts` so that the `if` statement looks like this:

```ruby
if sum % 10 == 0
    "The number #{card_number} is valid"
  else
    "The number #{card_number} is invalid"
  end
```

Now, run the file again.  What happens? Discuss with a partner.

In this new version of our credit_check, we can see the result by printing the result of the method call, like this:

```ruby
def validate(card_number)
  digits = card_number.chars
  double_every_other = []
  digits.each.with_index do |digit, index|
    if index.even?
      double_every_other << digit.to_i * 2
    else
      double_every_other << digit.to_i
    end
  end

  summed_over_ten = []
  double_every_other.each do |digit|
    if digit > 9
      summed_over_ten << digit - 9
    else
      summed_over_ten << digit
    end
  end

  sum = 0
  summed_over_ten.each do |digit|
    sum += digit
  end

  if sum % 10 == 0
    "The number #{card_number} is valid"
  else
    "The number #{card_number} is invalid"
  end
end

card_number = "5541801923795240"
puts validate(card_number)
```

### Refactoring
Right now, our credit_check file has one giant method - this is not a good sign! When creating methods, we want each method to have one responsibility, or one job. With a partner, discuss what each of the 'responsibilities' of this method are - how many can you pick out?

The first job of our `validate` method is to convert the `card_number` string into an array of integers.  Let's pull that responsibility out into its own method:

```ruby
def get_digits(card_number)
  digit_array = []
  characters = card_number.chars
  characters.each do |character|
    digit_array << character.to_i
  end
  digit_array
end

def validate(array_of_digits, card_number)
  doubled = []
  array_of_digits.each.with_index do |digit, index|
    if index.even?
      doubled << digit * 2
    else
      doubled << digit
    end
  end

  summed_over_ten = []
  doubled.each do |digit|
    if digit > 9
      summed_over_ten << digit - 9
    else
      summed_over_ten << digit
    end
  end

  sum = 0
  summed_over_ten.each do |digit|
    sum += digit
  end

  if sum % 10 == 0
    "The number #{card_number} is valid"
  else
    "The number #{card_number} is invalid"
  end
end

card_number = "5541801923795240"
array_of_digits = get_digits(card_number)
puts validate(array_of_digits, card_number)
```

Great! Now, we have a nice `get_digits` method that is responsible for only one job: converting a string into an array of integers. Let's use this same principle to refactor the rest of our `validate` method.

```ruby
def get_digits(card_number)
  digit_array = []
  characters = card_number.chars
  characters.each do |character|
    digit_array << character.to_i
  end
  digit_array
end

def double_every_other(array_of_digits)
  doubled = []
  array_of_digits.each.with_index do |digit, index|
    if index.even?
      doubled << digit * 2
    else
      doubled << digit
    end
  end
  doubled
end

def sum_over_ten(digits)
  summed_over_ten = []
  digits.each do |digit|
    if digit > 9
      summed_over_ten << digit - 9
    else
      summed_over_ten << digit
    end
  end
  summed_over_ten
end

def sum_digits(digits)
  sum = 0
  digits.each do |digit|
    sum += digit
  end
  sum
end

def divisible_by_ten?(sum)
  if sum % 10 == 0
    true
  else
    false
  end
end

def output(validity, card_number)
  if validity
    "The number #{card_number} is valid"
  else
    "The number #{card_number} is invalid"
  end
end

card_number = "5541801923795240"
array_of_digits = get_digits(card_number)
doubled = double_every_other(array_of_digits)
summed_over_ten = sum_over_ten(doubled)
sum = sum_digits(summed_over_ten)
validity = divisible_by_ten?(sum)
puts output(validity, card_number)
```

Now, all of our methods are carrying just one responsibility!  There is just one more thing that we can do to help refactor this program. As it stands, we are calling a bunch of methods to achieve the goal of verifying a credit card number.  Wouldn't it be nice to only have to call one method whose responsibility would be to call the other methods?  Let's go ahead and make that refactor in the next section.


### Calling Methods from Other Methods

We can call methods from within other methods that are in the same scope. Let's add a function that takes a credit card number and calls out to the other methods to check it's validity.

```ruby
def is_valid?(card_number)
  array_of_digits = get_digits(card_number)
  doubled = double_every_other(array_of_digits)
  summed_over_ten = sum_over_ten(doubled)
  sum = sum_digits(summed_over_ten)
  validity = divisible_by_ten?(sum)
  output(validity, card_number)
end

def get_digits(card_number)
  digit_array = []
  characters = card_number.chars
  characters.each do |character|
    digit_array << character.to_i
  end
  digit_array
end

def double_every_other(array_of_digits)
  doubled = []
  array_of_digits.each.with_index do |digit, index|
    if index.even?
      doubled << digit * 2
    else
      doubled << digit
    end
  end
  doubled
end

def sum_over_ten(digits)
  summed_over_ten = []
  digits.each do |digit|
    if digit > 9
      summed_over_ten << digit - 9
    else
      summed_over_ten << digit
    end
  end
  summed_over_ten
end

def sum_digits(digits)
  sum = 0
  digits.each do |digit|
    sum += digit
  end
  sum
end

def divisible_by_ten?(sum)
  if sum % 10 == 0
    true
  else
    false
  end
end

def output(validity, card_number)
  if validity
    "The number #{card_number} is valid"
  else
    "The number #{card_number} is invalid"
  end
end

card_number = "5541801923795240"
puts is_valid?(card_number)
```

A note on order: The order of your _methods_ does not matter.  Ruby will **parse** each method as the file is read and then when a method is **called** Ruby will **execute** the parsed methods accordingly.

### Layers of Abstraction

One of the advantages of using methods is that we can build methods that operate at higher levels of abstraction than other methods. Abstraction is a practice where less complex functionality is exposed in an interface and more complex functionality is suppressed. In some ways, this is like a pyramid where higher level methods rely on lower level methods to take care of the details.

![](https://camo.githubusercontent.com/07f5ef4748c194ee893c18089a2b6513d473ac37/687474703a2f2f6d696e6573662e636f6d2f7265736f75726365732f6363612f77702d636f6e74656e742f75706c6f6164732f323031302f30312f61627374726163742d6f2d6d65746572312e6a7067)

If we look at our `credit_check.rb` file, what we really want to do is take a credit card number, check that it is valid, and print an outcome for that number. We _can_ create a method that does exactly that, but bundling these more detailed methods into more abstract methods can help us to create more complex programs.


## WrapUp

* How do we define methods in Ruby?
* What is the difference in how we define a method that takes arguments from one that does not?
* How do you call one method from within another method?
* Why do we use methods?
