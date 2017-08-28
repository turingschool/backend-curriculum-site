---
title: Translating Code to Classes
length: 60
tags: ruby, refactoring, DRY 
---

## Learning Goals
*   apply a Class to a chunk of functionality
*   untilize code written within a Class
*   break apart a chunk of functionality in to individual methods 
*   analyze code snippet for opportunities to make DRY

## Warm-up

**Turn-and-Talk:** Let's talk about newspapers (yes, they still exist). Newspapers and other print media are forms of communication. When it comes to good communication for a newspaper, it's not good enough to simply print the news. Imagine a newspaper where all of the text is the same size and there are no pictures. The information contained is roughly the same but most people wouldn't be drawn to reading it. With a partner sitting next to you discuss the following questions:

* Assuming you don't read every word of a newspaper, how do you decide what to read?
* Our code is also a form of communication. It's communication with future developers and future you (at some point you will get frustrated about some code and ask "who wrote this?" only to find it was you). How can we apply the techniques of newspapers to make our code better?

## SuperFizz

*   Lets create a new file in our `classroom_exercises` folder, called `translating_code_to_classes.rb`

*   Last week we worked with `superfizz.rb`. Now we are going to take that code and turn it into a class with methods.

* Tying into our warm-up, which of these implementations would you rather work with? (they do the same thing)

```ruby
1000.times{|n|if(n%3==0)&&(n%5==0)&&(n%7==0);puts"SuperFizzBuzz";elsif(n%3==0)&&(n%7==0);puts"SuperFizz";elsif(n%5==0)&&(n%7==0);puts"SuperBuzz";elsif(n%3==0)&&(n%5==0);puts"FizzBuzz";elsif(n%3==0);puts"Fizz";elsif(n%5==0);puts"Buzz";elsif(n%7==0);puts"Super";else;puts(n);end}
```

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

We'll use the second implementation.

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

* Before looking at the solution below, how would you make it dynamic?

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

*   If we run our file now, it doesn't like that. Why? Because now it is expecting SuperFizz to define a variable named `num` but we have not defined one. We are now passing in `num` so how do we deal with that?

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

  def run
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

super_fizz_buzz = SuperFizz.new(105).run
super_fizz      = SuperFizz.new(21).run
super_buzz      = SuperFizz.new(35).run
fizz_buzz       = SuperFizz.new(15).run
fizz            = SuperFizz.new(3).run
buzz            = SuperFizz.new(5).run
supper          = SuperFizz.new(7).run # bad variable name but super is taken in Ruby ;)
flat            = SuperFizz.new(8).run
```

(**Note:** We added several checks at the end of the file above so we can make sure that our changes don't break functionality.)

*   By creating an `attr_reader`, we have allowed ourselves access to a method named `num` that holds the number we passed in when we created a new instance of `SuperFizz.new`

```ruby
def num
  @num #=> 87687687
end
```

**Food for thought:** What is the return value of the `run` method above? Another way to ask the same question: If we assigned the run method to a local variable (`return_value = superfizz.run`) what would `return_value` return?

We should change the method so it returns an actual value. If we want to see output, we will need to move the `puts` statement to the bottom of the file.

```ruby
class SuperFizz
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def run
    if num % 3 == 0 && num % 5 == 0 && num % 7 == 0
      "SuperFizzBuzz"
    elsif num % 3 == 0 && num % 7 == 0
       "SuperFizz"
    elsif num % 5 == 0 && num % 7 == 0
      "SuperBuzz"
    elsif num % 3 == 0 && num % 5 == 0
      "FizzBuzz"
    elsif num % 3 == 0
      "Fizz"
    elsif num % 5 == 0
      "Buzz"
    elsif num % 7 == 0
      "Super"
    else
      num
    end
  end
end

super_fizz_buzz = SuperFizz.new(105).run
super_fizz      = SuperFizz.new(21).run
super_buzz      = SuperFizz.new(35).run
fizz_buzz       = SuperFizz.new(15).run
fizz            = SuperFizz.new(3).run
buzz            = SuperFizz.new(5).run
supper          = SuperFizz.new(7).run
flat            = SuperFizz.new(8).run

puts super_fizz_buzz
puts super_fizz
puts super_buzz
puts fizz_buzz
puts fizz
puts buzz
puts supper
puts flat
```

*   There is quite a bit of repetition in here, let's clean some of that up. Maybe we can check each number to see if it is divisible by 3, 5, or 7 and then create a string based on the results.

*   Let's start our class with an empty string named `result` to store our generated word.

*   Because the longest word that we would like to make is "SuperFizzBuzz", it seems we should first start by checking if our number is divisible by 7. This would allow "Super" to be the first word in our string.

* We can use the same logic for determining which number to check against next... since numbers evenly divisible by 3 should return "Fizz", we should do that second.

* Now we can check against the number 5 and return "Buzz" if `num` is evenly divisible.

```ruby
class SuperFizz
  attr_reader :num, :result

  def initialize(num)
    @num = num
    @result = ""
  end

  def run
    if num % 7 == 0
      result << "Super"
    end

    if num % 3 == 0
      result << "Fizz"
    end

    if num % 5 == 0
      result << "Buzz"
    end

    if result.empty?
      result << num.to_s
    end

    result
  end
end

# (Additional code omitted)
```

Great. Things are moving in the right direction but there's still room for improvement. Do you see the pattern emerging in our conditionals (`if` statements)?

Try this out:

```ruby
class SuperFizz
  attr_reader :num, :result

  def initialize(num)
    @num = num
    @result = ""
  end

  def run
    if divisible_by?(7)
      result << "Super"
    end

    if divisible_by?(3)
      result << "Fizz"
    end

    if divisible_by?(5)
      result << "Buzz"
    end

    if result.empty?
      result << num.to_s
    end

    result
  end

  def divisible_by?(amount)
    num % amount == 0
  end
end
```

This makes our code more clear and removes repetition. A guideline set out by Sandy Metz in Practical Object Oriented Design in Ruby is to try to limit methods to 5 lines. Let's see if we can do that.

**Rabbit Hole (not essential):** We could also use `+=` to add to our strings to the variable. What's the difference between `+=` and `<<` for strings in Ruby?

Let's break out the checks against each number into separate methods.

```ruby
class SuperFizz
  attr_reader :num, :result

  def initialize(num)
    @num = num
    @result = ""
  end

  def run
    divide_by_7
    divide_by_3
    divide_by_5
    validate_result
    result
  end

  def divide_by_7
    if divisible_by?(7)
      result << "Super"
    end
  end

  def divide_by_3
    if divisible_by?(3)
      result << "Fizz"
    end
  end

  def divide_by_5
    if divisible_by?(5)
      result << "Buzz"
    end
  end

  def validate_result
    if result.empty?
      result << num.to_s
    end
  end

  def divisible_by?(amount)
    num % amount == 0
  end
end
```

**Rabbit Hole (not essential):** This [styleguide on Github](https://github.com/bbatsov/ruby-style-guide#visibility) says not to leave all methods public. Which of these methods should be `private`?

One last change... The `if` statements here are now quite simple. We can write these to be one line like so:

```ruby
class SuperFizz
  attr_reader :num, :result

  def initialize(num)
    @num = num
    @result = ""
  end

  def run
    divide_by_7
    divide_by_3
    divide_by_5
    validate_result
    result
  end

  def divide_by_7
    result << "Super" if divisible_by?(7)
  end

  def divide_by_3
    result << "Fizz" if divisible_by?(3)
  end

  def divide_by_5
    result << "Buzz" if divisible_by?(5)
  end

  def validate_result
    result << num.to_s if result.empty?
  end

  def divisible_by?(amount)
    num % amount == 0
  end
end
```

*   We have now created a dynamic object that can do more than one thing. If we wanted to create more methods for SuperFizz, that is also possible and we could likely reuse some of the existing logic.

```ruby
1000.times do |num|
  superfizz = SuperFizz.new(num)
  puts superfizz.run
end
```

### WrapUP 
*  How do you define a class?
*  How do you run code that lives within a Class?
*  Why might you want to wrap your code in a Class? 
*  Why might you want to break functionality into multiple methods? 
*  How do you call a method from within another method? 
