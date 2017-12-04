---
title: Intro to Variables and Data Types
tags: basics, strings, Ruby in 100 Minutes
length: 60 - 90
---

## Learning Goals

* define "string"
* define "integer"
* define "float"
* assign values to variables using proper naming conventions
* use string concatenation with literal strings and variables
* use string interpolation with variables
* call key methods on strings
* call key methods on integers and floats
* read Ruby documentation    

## Vocabulary  
*  objects
*  strings  
*  integers  
*  floats  
*  variables    

## Structure  
5min  - WarmUp  
15min - Variables  
15min - Strings  
15min - Integers  
5min  - WrapUp

## Warm Up  
Create a T-Chart on the white board for string, integer & float  

* Students add to T-Chart one thing they know about each data type

## Intro

There are several different data types in Ruby. Today, we'll focus on Strings and Integers. We'll also talk about variables (structures used to store references to data, not data types themselves).  

## Variables  

Programming is all about creating abstractions; in order to create an abstraction, we must be able to assign names to things. Variables are a way of creating a name for a piece of data.

Some languages are Statically Typed, meaning you need to specify what type of data (like a number, word, etc) can go in a certain variable. Ruby is Dynamically Typed, meaning you do not need to declare the data type of a variable, any variable can hold any type of data and any variable *can* be reassigned to a different data type (constant variables shouldn't be changed). Some languages also require you to "declare" a variable before you assign a value to it, however, Ruby variables are automatically created when you assign a value to them. Let’s try an example:

```ruby
number = 10
number
```

The line `num = 10` creates the variable named `number` and stores the value 10 into it.

In English we read left-to-right, so it’s natural to read code left to right. But when evaluating an assignment using the single equals sign (=), Ruby actually evaluates the right side first. Take the following example:

```ruby
sum = 10 + 5
```

The 10 + 5 is evaluated first, and the result is given the name sum.

*Try it*: What is c at the end of this? Why?

```ruby
$ irb
$ c = 15
$ c = "hello"
$ c
```

### Naming Variables

Ruby variables have a few **requirements**. Local variables ...

* have no spaces
* do not contain most special characters like $, @, and &
* can contain underscores & numbers, but CANNOT start with a number

A few examples of invalid Ruby variable names include:

* `student names` - variables cannot include a space
* `account_$` - variables cannot include most special characters
* `1st_lesson` – variables can’t start with a number, should just be first_lesson

In addition to those requirements, Rubyists have a few common style **conventions** for variable names:

* always start with a lowercase letter (underscore is permitted, though uncommon)
* use snake case where each word in the name is lowercase and connected by underscores ( _ )
* are named after the meaning of their contents, not the type of their contents
* are NEVER abbreviated, especially **NO SINGLE LETTER VARIABLES**

Good variable names might be count, students_in_class, or first_lesson.

A few examples of Ruby variable names with poor convention include:

* `studentsInClass` – uses camel-case rather than snake-case, should be students_in_class
* `student_name_string` – includes the type of the data in the name, should just be students
* `msg` or `v` – abbreviates rather than just using message  


*Try it:* Use IRB to store values with each of the following variable names. Which names are good, which are actually invalid Ruby, and which are valid but go against Ruby style?

* `time_machine`
* `student_count_integer`
* `homeworkAssignment`
* `Team`
* `3_sections`
* `top_ppl`  

## Strings

In Ruby, strings are objects.

Programming strings are used to store collections of letters and numbers. That could be a single letter like "a", a word like "hi", or a sentence like "Hello my friends."

A Ruby string is defined as a quote (") followed by zero or more letters, numbers, or symbols and followed by a closing quote of the same type ("). Quotes can either be single (') or double (").

The shortest possible string is called the empty string: "". It’s not uncommon for a single string to contain paragraphs or even pages of text.

### Practice
**Turn & Talk**  
Which of the following are valid strings? Why/why not?  

1. `''`
2. `"123"`
3. `123`
4. `"@\*#%&"`
5. `hello, world!`
6. `'welcome to Turing'`
7. `'987654321."`
8. `"hot chocolate is the best"`

### Substrings

*Try it*: Type the following examples in IRB and determine what they do:  

```ruby
$ irb
$ "hello, world"[0]
$ "Turing"[0]
$ "ruby"[2]
$ "lunch"[-1]
$ "hello, world"[0..4]
$ "Turing"[0..1]
$ "ruby"[1..-1]
$ "lunch"[0..-2]
$ "lunch"[0...-2]
```

We can pull out specific parts of a string. For example, I may want to know only the first letter of a string. In programming, we start with the position 0 and count up from there.

I can access the first letter of a string using this notation:

```
$ "hello, world"[0]
=> "h"
```

If we type this into IRB, we'll get back the letter "h".


We use [0..2] notation to pull out substrings. For example, I may want to get back the substring "hello" from "hello, world". To do that, I can use this notation:

```ruby
$ "hello, world"[0..4]
```

In Ruby, `..` indicates an inclusive range. The above example means give me back all of the characters at positions 0, 1, 2, 3, and 4. An exclusive range is defined by `...` and excludes the last element; `"hello, world"[0..4]` would return `"hell"`.

Ruby interprets negative positions to count back from the end of the string. So in "Hi", the "i" is in position -1 and the "H" is in position -2.

So if a letter has both a positive and negative position number, which should you use? If you can use the positive numbers do it, they’re easier to reason about. But, if you’re looking for something based on it being at the end of the string (like "What’s the last character of this string?"), then use the negative positions.

### Introduction to String Methods

A Ruby `method` can be thought of as a message or command that's being sent to an object. The message is received, and something is returned where it was called. Here's a simple example:

```ruby
$ "hello, world".upcase
```

The method is `.upcase`    
The object it's being called on is "hello, world"  
The return value is "HELLO, WORLD".  
Like the above example, most methods you'll see use what we call "dot notation" where there is a dot between the object and the method.

Let's open up some Ruby documentation: [String](http://ruby-doc.org/core-2.4.1/String.html). Take a look on the left-hand side underneath "Methods".   

You can also look at all of the possible string methods by calling the method `methods`:

```ruby
$ "here is a string".methods  
```

Another helpful method is `.class`, which tells you what kind of data (object) type you're working with:

```ruby
$ "here is a string".class  
=> String
```

We'll walk through the two below to start:

```
capitalize
center
```

*Try it*: Find the following methods and their documentation, then experiment with them in IRB and jot down your own definition of what the method does. *You may need/want to Google other definitions or examples for some*.

```
delete
downcase
empty?
gsub
include?
index
length
reverse
split
start_with?
upcase
==
```

### String Concatenation

First, we'll assign the string "Tyrese" to the variable `student`:

```ruby
$ irb  
$ student = "Tyrese"
=> "Tyrese  
```

Let's say that we want to create a string that says "Welcome to class, Mary." There are two ways to do this. We'll start with concatenation first, which joins strings together with the plus sign:

```ruby
$ "Welcome to class, " + student + "."
=> "Welcome to class, Tyrese."
```

Try it out in IRB.

*Try it*: Create two more of your own examples of string concatenation using a variable.

Note that the `+` is also a string method. It does not use dot notation.

### String Interpolation

The second approach is to use string interpolation where we stick data into the middle of a string.

String interpolation only works on a double-quoted string. Within the string we use the interpolation marker #{}. Inside those brackets we can put any variables or Ruby code which will be evaluated, converted to a string, and output in that spot of the outer string. Our previous example could be rewritten like this:

```ruby
$ "Welcome to class, #{student}."  
=>  "Welcome to class, Tyrese."
```

If you compare the output you’ll see that they give the exact same results. The interpolation style tends to be fewer characters to type and fewer open/close quotes and plus signs to forget. String interpolation is preferred and more common. You should take note of the fact that string interpolation **will only work inside of double-quoted strings**. This would not work: `'Welcome to class, #{student}.'`

*Try it*: Create two more examples of your own using string interpolation and a variable.

## Integers

Numeric data comes in two types: Integers and Floats. Integers are whole numbers (no decimals) and in older versions of Ruby are either of the class Fixnum or Bignum. Floats are numbers that have decimal places.

```ruby
$ irb
$ 123456789.class
$ 1_000_000_000_000_000_000_000.class
$ 5.6.class
$ 1.239.class
$ 43e+3.class
```

*Try it*: Predict the return value before trying these in IRB. Which of these work? Which of these do something you didn't expect?

```ruby
$ 3 + 4
$ 2 * 4
$ 2 ** 5
$ 6 - 2
$ 4 / 2
$ 3 / 4
$ 3.0 / 4.0
$ 3 / 4.0
$ 3.0 / 4
$ 1.5.to_s
$ 5.5.to_i
$ 1 + "2"
$ 1 + "2".to_i
$ (1 + 2) * 3
$ 1 + (2 * 3)
```

We can also (somewhat) combine strings and integers. Try these:

```ruby
$ "hi" * 5
$ 5 * "hi"
```

### Introducing Number Methods

All of the arithmetic operations that you tried above are actually methods. Let's look at the documentation for [Integer](https://ruby-doc.org/core-2.4.0/Integer.html) and [Float](https://ruby-doc.org/core-2.4.0/Float.html).

```
round
to_f
to_i
to_s
floor
ceil
abs
%
==
>
>=
even?
odd?
next
```

Spicier methods:

```
upto
times
```

## Recap

Today, you accomplished the following:
* What are the naming requirements for Ruby local variables? What are the conventions?
* How do you assign a value to a variable?
* Define "string"
* What is the syntax for string concatenation (aka How do you concatenate strings?)
* What is the syntax for interpolation? (aka How do you interpolate variables into strings?)
* Name a String method
* Define "integer"
* Define "float"
* Name an Integer method
* Name a Float method
* How do you get to the Ruby Docs?

## Homework  
*  Work through Core-Types for String and Ints_and_Floats  

```bash  
$ cd 1module  
$ git clone https://github.com/turingschool/ruby-exercises.git  
$ cd ruby-exercises/core-types  
$ gem install bundler  
$ bundle  
$ ruby string_test.rb  
```  
   Make the tests pass, exploring a variety of ways to interact with strings and fixnums. Jot down your own definition of what each method does.  


*  Complete the [Working with Strings and Integers](https://github.com/turingschool/challenges/blob/master/working_with_strings_and_integers.markdown) challenge.
