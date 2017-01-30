---
title: Translating Code to Classes
length: 60
tags: ruby
---

## Learning Goal

*   Take existing code and turn it into a class with methods.

## SuperFizz

*   Lets create a new file in our `classwork` folder, called `translating_code_to_classes.rb`

*   Last week we worked with `superfizz.rb`. Now we are going to take that code and turn it into a class with methods.
*   We will be working with this code:

```ruby
1000.times do |num|
  if num % 3 == 0 && num % 5 == 0 && num % 7 == 0
    puts "SuperFizzBuzz"
  elsif num % 3 == 0 && num % 7 == 0
    puts  "SuperFizz"
  elsif num % 5 == 0 && num % 7 == 0
    puts "SuperBuzz"
  elsif num % 3 == 0 && num % 5 == 0
    puts "FizzBuzz"
  elsif num % 3 == 0
    puts "Fizz"
  elsif num % 5 == 0
    puts "Buzz"
  elsif num % 7 == 0
    puts "Super"
  else
    puts num
  end
end
```

## Creating a class

*  The first thing that we can do is create a class called `SuperFizz`

```ruby
class SuperFizz
  1000.times do |num|
    if num % 3 == 0 && num % 5 == 0 && num % 7 == 0
      puts "SuperFizzBuzz"
    elsif num % 3 == 0 && num % 7 == 0
      puts  "SuperFizz"
    elsif num % 5 == 0 && num % 7 == 0
      puts "SuperBuzz"
    elsif num % 3 == 0 && num % 5 == 0
      puts "FizzBuzz"
    elsif num % 3 == 0
      puts "Fizz"
    elsif num % 5 == 0
      puts "Buzz"
    elsif num % 7 == 0
      puts "Super"
    else
      puts num
    end
  end
end

SuperFizz.new
```

*   Now when we run this file, it still outputs what we want but it is encompassed in a class that we can now create multiple instances of.

*   In our example, we ran through numbers 0-1000. When we create a class, we give ourselves the ability to create an instance for each number we pass through.

*   Let's remove the ```1000.times do``` so we can control our number.

```ruby
class SuperFizz
  if num % 3 == 0 && num % 5 == 0 && num % 7 == 0
    puts "SuperFizzBuzz"
  elsif num % 3 == 0 && num % 7 == 0
    puts  "SuperFizz"
  elsif num % 5 == 0 && num % 7 == 0
    puts "SuperBuzz"
  elsif num % 3 == 0 && num % 5 == 0
    puts "FizzBuzz"
  elsif num % 3 == 0
    puts "Fizz"
  elsif num % 5 == 0
    puts "Buzz"
  elsif num % 7 == 0
    puts "Super"
  else
    puts num
  end
end

SuperFizz.new(100)
```

*   If we run our file now, it doesn't like that. Why? Because now it is expecting SuperFizz to define a variable named `num` but we have not. We are now passing in `num` so how do we deal with that?

*   By initializing our class, we have created a place that is looked to first for default information.

```ruby
class SuperFizz

  def initialize(num)
    if num % 3 == 0 && num % 5 == 0 && num % 7 == 0
      puts "SuperFizzBuzz"
    elsif num % 3 == 0 && num % 7 == 0
      puts  "SuperFizz"
    elsif num % 5 == 0 && num % 7 == 0
      puts "SuperBuzz"
    elsif num % 3 == 0 && num % 5 == 0
      puts "FizzBuzz"
    elsif num % 3 == 0
      puts "Fizz"
    elsif num % 5 == 0
      puts "Buzz"
    elsif num % 7 == 0
      puts "Super"
    else
      puts num
    end
  end
end

SuperFizz.new(87687687)
```

*   Now we can pass in any number and get back the result.

*   Maybe there are other things that will eventually happen in the `class SuperFizz` so we should only check the digits when we specifically want to.

```ruby
class SuperFizz
attr_reader :num
  def initialize(num)
    @num = num
  end

  def check_number
    if num % 3 == 0 && num % 5 == 0 && num % 7 == 0
      puts "SuperFizzBuzz"
    elsif num % 3 == 0 && num % 7 == 0
      puts  "SuperFizz"
    elsif num % 5 == 0 && num % 7 == 0
      puts "SuperBuzz"
    elsif num % 3 == 0 && num % 5 == 0
      puts "FizzBuzz"
    elsif num % 3 == 0
      puts "Fizz"
    elsif num % 5 == 0
      puts "Buzz"
    elsif num % 7 == 0
      puts "Super"
    else
      puts num
    end
  end
end

superfizz = SuperFizz.new(87687687)
superfizz.check_number
```

*   By creating an `attr_reader`, we have allowed ourselves access to a method named `num` that holds the number we passed in when we created a new instance of `SuperFizz.new`

```ruby
def num
  @num #=> 87687687
end
```

*   There is quite a bit of repetition in here, let's clean some of that up. Maybe we can check each number to see if it is divisible by 3, 5, or 7 and then create a string based on the results.

*   Because the longest word that we would like to make is "SuperFizzBuzz", it seems we should first start by checking if our number is divisible by 7. This would allow "Super" to be the first word in our string.

*   We also want to start our class with an empty string.

```ruby
class SuperFizz
attr_reader :num, :output
  def initialize(num)
    @num = num
    @output = ""
  end

  def check_number
    divisible_by_7
  end
```

*   We have created an empty string to hold our output and now we are going to carry that empty string with us into the `divisible_by_7` method.

```ruby
def divisible_by_7
  if num % 7 == 0
    output << "Super"
  end
  divisible_by_3
end
```

*   We have now started to create a chain of methods that will check each other. Since in the word "SuperFizzBuzz", "Fizz" is next, we are going to check if the number is divisible by 3. We want to carry our output with us as well, which will have the word "Super" in it if the number is divisible by 7.

```ruby
def divisible_by_3
  if num % 3 == 0
    output << "Fizz"
  end
  divisible_by_5
end
```

*   We also check if our number is divisible by 5 so that "Buzz" will be the last word in the string.

```ruby
def divisible_by_5
  if num % 5 == 0
     output << "Buzz"
  end

  if output.empty?
    puts num
  else
    puts output
  end
end
```

*   Lastly, we can refactor a little bit and pull out the second if statement.

```ruby
def divisible_by_5
  if num % 5 == 0
     output << "Buzz"
  end
  check_the_output
end

def check_the_output
  if output.empty?
    puts num
  else
    puts output
  end
end
```

*   Our file should now look like this:

```ruby
class SuperFizz
attr_reader :num, :output
  def initialize(num)
    @num = num
    @output = ""
  end

  def check_number
    divisible_by_7
  end

  def divisible_by_7
    if num % 7 == 0
      output << "Super"
    end
    divisible_by_3
  end

  def divisible_by_3
    if num % 3 == 0
      output << "Fizz"
    end
    divisible_by_5
  end

  def divisible_by_5
    if num % 5 == 0
       output << "Buzz"
    end
    check_the_output
  end

  def check_the_output
    if output.empty?
      puts num
    else
      puts output
    end
  end
end

superfizz = SuperFizz.new(87687687)
superfizz.check_number
```

*   We have now created a dynamic object that can do more than one thing. If we wanted to create more methods for superfizz, that is also possible.
