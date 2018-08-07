---
title: Ruby Data Types
length: 90 min
tags: ruby, data types, strings, integers, floats, arrays, hashes
---

## Learning Goals

* Explain the key points of each of the important basic Ruby data types.
* Speak to a few common methods for each data type.
* Be able to reference Ruby Docs in order to determine what an object's method does.

## Slides

Available [here](../slides/ruby_data_types)


## Agenda

- 5 min - Warm up
- 10 min - Ruby Docs Overview / Task overview / Move to Groups
- 15 min - Work in First Group
- 15 min - Work in Second Group
- 5 min - Break
- 5 min - Presentations
- 5 min - Presentations
- 15 min - Instructor Recap, Notecards
- 10 min - CFU

## Integers & Floats
* Integers are numbers without decimals, both positive and negative
* Floats are numbers with decimals, both positive and negative
* All mathematical operations can be used on integers and floats in Ruby
  - 4 + 3 ==> 7
  - 7 * 2 ==> 14
  - 45 % 10 ==> 5 (the modulo find the remainder)
* Comparison operators can be used to compare integers or floats
  - 4 == 4 ==> true
  - 12 <= 8 ==> false
  - 3 != 6 ==> true
* Variables can store integers or floats, then use them to compare, compute, etc.
  - my_age = 30
  - your_age = 29
  - my_age == your_age ==> false
* Methods to change a data type:
  - `.to_f` - change an integer to a float
  - `.to_i` - change a float to an integer
  - `.to_s` - change an integer or float to a "string"


## Strings
* A series of characters between quotation marks
* Double quotes or single quotes so long as they match
* Some key methods to get information about strings:
  - length - returns the number of characters in string, including spaces
  - chars - returns an array, where each character from the string is it's own element in the array
  - Use bracket notation to access a character from a string. Example: "hello"[1] ==> "e"
* Some key methods to manipulate strings:
  - upcase/downcase - convert all letter to upper/lower case respectively
  - capitalize - convert the _first_ letter to uppercase
* Interpolation - combining multiple strings or string(s) with variable(s)
  - Example: name = "Kim Kardashain" "Hello, my name is #{name}!" ==> "Hello, my name is Kim Kardashian!"
  - To use the #{} syntax, the entire string must be wrapped in double quotes


## Arrays
* Ordered list that is comma-separated and enclosed in square brackets
* Count always starts at 0
* Can hold many pieces of data (we call each piece an `element`); or be empty!
* Can hold any data type - integer, string, hash, array
* Elements can be accessed by their index - array[0] will return the element in the first/0 position of the array
* Some key methods to get information about arrays:
  - Length, count, size
* Some key methods to manipulate arrays:
  - push, pop, shift, unshift, delete_at, insert
* Enumerables - many times we will want to do the same thing to every element in an array. The Ruby language provides a lot of methods that allow us to do that efficiently
  - each, map, find, select


## Hashes
* Also known as a dictionary, can hold many pieces of information
* It has a key and value setup, example:
  - user = { "first" => "Kylie", "last" => "Jenner" }
* Information (value) is accessed with bracket notation, example:
  - user["first"] ==> "Kylie"
* Key methods - .values, .keys
* Enumerables - many times we will want to do the same thing to every key, value, or key/value pair in a hash. The Ruby language provides a lot of methods that allow us to do that efficiently

## CFU
Please complete [this](https://goo.gl/forms/CPhMUhOkjwc0Prs93) form to help the instructors know where you are with data types. If this is anything you are unfamiliar on in this lesson or in the CFU, brush up on it _tonight_ so you are not behind the rest of the week.

## Additional Resources

* [Intro to Hashes](https://vimeo.com/238162528)
* [Strings and Integers](https://vimeo.com/235827172)
* [Arrays](https://www.youtube.com/watch?v=c2UnIQ3LRnM&list=PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5&t=0s&index=4)
