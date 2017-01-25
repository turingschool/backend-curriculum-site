---
layout: page
title: Primer on .each
length: 90
tags: enumerable, ruby, collections, arrays, each
---

# Primer on .each

### Goals

* Learn how to use a debugger to pause and interact with running code
* Understand how to use single-line and multi-line each

#### Debuggers

As programmers we often make assumptions about what our code is doing. We are often wrong. One of the most important and effective debugging techniques is to validate your assumptions.

Have you ever found yourself working on a programming problem and as you attempt to solve it, you are forced to run the entire file over and over again until you get the correct result? Wouldn't it be awesome if you could pause your code at a specific line and interact with it? Enter debuggers.

Debuggers are great to see what your code is actually doing. The most common debuggers in ruby are `byebug` and `pry`. You can pick whichever you prefer. For this exercise we will use `pry`.

First, install it from the command line.
`gem install pry`

Then, let's create an `exploring_each.rb` file within your classwork directory.

You need to require it at the top of your Ruby file.

```ruby
require "pry"
```

Now you can use it like this...

```ruby
favorite_things = ["Trapper Keeper", "Netscape Navigator", "Troll Doll"]
binding.pry
""
```

> Note:  Notice that empty string following `binding.pry`? Pry bindings can never be the last line of code in a script. They are meant to pause your code while it's running. This empty string is a way of making pry think you're not at the end of your script.

We're going to use your debugger to explore `.each` and on the challenges below.

<!-- Let's use [this gist](https://gist.github.com/jmejia/04924190362f64fc49ab) as a guide. -->

#### What are enumerable methods?

Enumerables are methods that can be used on collections (arrays and hashes) to iterate over each element.
These can be used to make something based on the original collection, change the original collection, or search for elements or an element within that collection.

#### What is .each?

* `.each` is the base for enumerable methods
* it allows you to traverse a collection and access each of its elements
* it **returns the original collection**

#### What is the syntax for writing enumerable methods?

##### Multi-Line

```ruby
array.each do |item|
  item.do_something
end
```

##### Single-Line

```ruby
array.each { |item| item.do_something }
```

#### Basic use of .each

Let's say we have an array of words, and we want to print out to the screen
each word in the array, but in all capitalized letters.

```ruby
array = ["alice", "bob", "eva"]

array.each do |name|
  puts name.capitalize
end
```

This can also be written:

```ruby
array = ["alice", "bob", "eva"]

array.each { |name| puts name.capitalize }
```

What do you think each of these returns?

Remember that there is a difference between what gets output to a screen
and what a bit of code returns.

#### Exercises

Use your debugger to work through the following.

We'll start with the first two together.

* If you had an array of numbers, `[1,2,3,4,5,6]`, how do you print out the
doubles of each number? Triples?
* If you had the same array, how would you only print out the even numbers?
What about the odd numbers?
* If you had the same array, how could you create a new array which contains each number multipled by 2?
* Given an array of first and last names, e.g. `["Ilana Corson", "Lauren Fazah", "Beth Sebian"]`, how would you print out only first names?
* How would you print out only last names?
* How could you print out only the initials?
* How can you print out the last name and how many characters are in it?
* How can you create an integer which represents the total number of characters in all the names?
* Say you had an array of nested arrays: `[['Ilana', 'Corson'], ['Lauren', 'Fazah'], ['Beth', 'Sebian']]`. Each nested array has two elements, a first name and a last name. How would you print out each nested array's full name?
