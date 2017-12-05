---
layout: page
title: Exploring .each and Debugging with Pry
length: 60
tags: enumerable, ruby, collections, arrays, each, pry, debugging
---

# Exploring `.each` & Debugging with Pry

***

## Learning Goals

* Recognize & demonstrate use of inline and multi-line `each`
* Name various debuggers for Ruby
* Employ pry to pause & interact with running code

<!-- * Learn how to use a debugger to pause and interact with running code
* Understand how to use single-line and multi-line each -->

<!-- [slides](../slides/debugging_with_pry) -->
***

## Vocabulary 
* Enumerable
* Block
* Debugger
* Pry

***

## Enumerable Methods

Enumerables are methods that can be used on collections (arrays and hashes) to iterate over each element.
These can be used to: 

* create something based on the original collection
* search for elements or an element within that collection
* change the original collection

### What is `.each`?

* `.each` allows you to traverse a collection and access each of its elements
* `.each` **returns the original collection**
* `.each` is the base for all enumerable methods

### What is the syntax for writing enumerable methods?

* A **block** exists between `do...end` or between `{...}`
* A **block parameter** goes between the pipes `||` & is the variable you use within the block itself

#### Multi-Line Block

```ruby
array.each do |element|
  element.do_something
end
```

#### Inline (Single-Line) Block

```ruby
array.each { |element| element.do_something }
```

### Basic use of .each

Let's say we have an array of names `names = ["alice", "bob", "eva"]` and we want to print out to the screen
each word in the array, but in all capitalized letters.

```ruby
names.each do |name|
  puts name.capitalize
end
```

This can also be written:

```ruby
names.each { |name| puts name.capitalize }
```
### Turn & Talk

What do you think these should return?

Remember that there is a difference between what gets *output to a screen* and what a bit of *code returns*.

***

## Debuggers

### Turn & Talk

Discuss one instance (during your prework or homework) where you faced a problem and had to run the entire file over and over again until you got the correct result.


### Shorten the Development Feedback Loop!

Consider the feedback loop in programming: we assume our code should do something, we're wrong, we change it until we get working code. Shortening the loop will make us faster & more efficient developers. **Debuggers** provide effective tools for evaluating our assumptions.

* Debugger: a computer program that assists in the detection and correction of errors (bugs) in other programs.

Debuggers help you see what your code is actually doing. The most common debuggers in Ruby are `Byebug` and `Pry`. You can pick whichever you prefer. For this exercise we will use `Pry`.

### Pry

Language shells, like IRB (interactive Ruby), are REPLs (Read-Eval-Print-Loop) that take user input, evaluate it & return the result.

"Pry is a powerful alternative to the standard IRB (interactive ruby) shell for Ruby. It features syntax highlighting, a flexible plugin architecture, runtime invocation and source and documentation browsing." (Straight from the horse's mouth: [http://pryrepl.org/](http://pryrepl.org/))

The **syntax highlighting** & **runtime invocation** are most useful & relevant to us.

### Using Pry

Install Pry from the command line:
```
gem install pry
```

You can enter a Pry session from your CLI by simply typing `pry`

`binding.pry` is the standard way to invoke Pry at runtime

* You can think of a binding like a “snapshot” of everything available at the moment of instantiation: current value of “self”, local variables, methods, instance variables and more. 
* It also causes the whereami command to be invoked automatically - and so the surounding context of the session (a few lines either side of the invocation line) are displayed for the user.

### Pry Playground

Then, let's create a `debugging_with_pry.rb` file within your classwork directory.

You need to require Pry at the top of your Ruby file. Then you can use it wherever you'd like your program to pause.

```ruby
require "pry"

def favorite_things(things)
  things.each do |thing|
    binding.pry
    puts thing.capitalize
    thing.upcase
  end
  binding.pry
end

a_few_of_my_favorites = ["crisp apple strudels", "schnitzel with noodles", "wild geese that fly with the moon on their wings"]
favorite_things(a_few_of_my_favorites)
```

We're going to use our new debugger to explore `.each` with the challenges below.

<!-- Let's use [this gist](https://gist.github.com/jmejia/04924190362f64fc49ab) as a guide. -->

***

### Important Commands for Pry Sessions 

* To fully exit any pry session, enter `!!!`, `exit!`, or type `ctrl-\`
* During runtime invocation:
  * To proceed to the next pry (within your loop or not), enter `exit` (this will exit your pry session if you were on the last pry)
  * If your pry session is too large for your CLI (e.g. it will show `:` on the bottom instead of `[1] pry(#<ClassName>)>`), type `q`

## Exercises

Work through the following using `Pry`. We'll start with the first two together.

* Given an array of numbers, `[1,2,3,4,5,6]`, how do you print out the
doubles of each number? Triples?
  * Given the same array, how would you only print out the even numbers?
  What about the odd numbers?
  * Given the same array, how could you create a new array which contains each number multipled by 2?
* Given an array of first and last names, e.g. `["Victoria Vasys", "Ali Schlereth", "Nate Allen"]`, how would you print out only first names?
  * How would you print out only last names?
  * How could you print out only the initials?
  * How can you print out the last name and how many characters are in it?
  * How can you create an integer which represents the total number of characters in all the names?
* Say you had an array of nested arrays: `[['Victoria', 'Vasys'], ['Ali', 'Schlereth'], ['Mike', 'Dao']]`. Each nested array has two elements, a first name and a last name. How would you print out each nested array's full name?

## Recap

* What do enumerable methods do? Give an example.
* What is the syntax for an inline `each`? Multi-line `each`?
* List 3 debugging tools/techniques for Ruby
* What is the syntax for adding `Pry` to your code? Where do you add these?
<!-- * What can you access in a runtime-invoked pry session? -->
* How do you proceed to the next `binding.pry` (could be the next iteration of a loop)?
* How do you exit a pry session completely?

***

## Further Learning

Explore [http://pryrepl.org/](http://pryrepl.org/)

Check out this video for a more in-depth intro to Pry: [Pry Screencast](https://vimeo.com/26391171)

Fun fact- you can invoke “pry” on almost any Ruby object. That's possible because it is defined on Object, the ancestor of every Ruby class.

Finally, we are not limited to remaining in the scope where the binding.pry call was invoked - using Pry's state navigation abilities we can navigate to any part of the program we wish and examine the state there (see [Pry at runtime demonstration](https://vimeo.com/23634437))
