---
title: Arrays
length: 60 - 90
tags: ruby, arrays, data structures
---

## Learning Goals

* Understand the basic idea of a collection type
* Develop a mental model to understand arrays
* Gain some familiarity with common array methods

## Structure

* 5 - WarmUp
* 20 - Together - Data Structures, Collections, and Programming
* 20 - Group Exercise
* 5 - WrapUp
* 5 - Independent Practice & Homework  

## Vocabulary  
* Data Structure 
* Array  
* Index 

## SetUp  
In the pry session you'll be using, build a Bead class. Use instances of these beads through the demonstration.

```ruby 
class Bead 
  attr_reader :color
  
  def initialize(color)
     @color = color
  end 

end 
```

## Supplies

Before we begin, collect the following Arts & Crafts supplies:

* 1 piece of paper
* 5 paper cups
* 6 wooden beads
* A pen or marker  
* 5 tags, one of each color ("blue", "red", "green", "purple", "orange")

Then take your five paper cups and use a marker to number them "0" through "4".  
Attach each tag to a bead.

## Warm Up
* What is a "Data Structure"?  
* Why are Arrays so ubiquitous?
* What does an Array model conceptually?  
* What are some of the properties of an array? How do they behave?  

## Data Structures, Collections, and Programming  
In pairs, post answers to Slack thread:
* What is a "Data Structure"?  
  A data structure is a particular way of organizing information so that it can be used efficiently
* Why are Arrays so ubiquitous?
  Arrays are the most fundamental collection type in programming — just about every language has them. They are the most efficient data structure for **storing & accessing a sequence of objects** and can be easily sorted and searched.
* What does an Array model conceptually?  
* What are some of the properties of an array?  
   Arrays are collections of data; each element in an array is addressed by a number called the index or position, starting with 0 (zero-indexed). All arrays have a size (length/count). Array elements are stored in subsequent memory locations. Ruby arrays can hold elements that have different data types. 

### Arrays - Group Exercise

Let's model some of the core concepts. In this section, we'll step through using some of the fundamental Array methods, including:

* `[]`
* `count`
* `<<` / `push`
* `pop`
* `shift`
* `unshift`
* `insert`
* `shuffle`

As we go, we'll work side-by-side with our physical Array model and with an IRB/Pry session.  
<!-- Have a student help by demonstrating interaction with manipulatives or on the board.  -->

1. Lay down your large piece of paper and write `colors` in large letters. This is the name of your variable holding your collection. How many elements are in your collection so far?
2. Put the empty `0` cup on the paper. If you now access the value inside `colors[0]`, what would you get back?
3. Store a "blue" bead into the zero cup, the equivalent of maybe `colors[0] = "blue"`. What would you expect the answer of `colors.count` to be? What does `colors.first` return? What about `colors.last`?
4. We can explicitly assign the value of another cup. Add `colors[1] = "red"`. That does not change the answer to `colors.first`, but does change `colors.last`. Why?
5. The "shovel" operator (`<<`) adds an element to the end of an existing array. Pretend you ran `colors << "green"`. How many beads are in the array in total?
6. It turns out that "shovel" is just syntactic sugar for the method named `push`. Pretend you ran `colors.push(nil)`. How does that affect your array? What is the value of `colors.count` now?  
9. You can remove the last element of an array by running `colors.pop`. Do that now.  
9. You can remove the first element of an array by running `colors.shift`. Do that now.
7. Sometimes you want to add an element to the *beginning* of an array. You do that with `colors.unshift("purple")`. But wait a minute. You can't add the cup with marker `4` to the beginning of `colors`. What do you do?
8. You can also insert data into a specific location. Say you ran `colors.insert(3, "orange")`. How does that change things?
9. If you run `.shuffle` on an array it creates a copy of the array with the values shuffled in random order. But you only have enough cups for one array. How about you run `colors = colors.shuffle`?
10. There's a ton you can do with *enumerable* methods. But the fundamental enumerator is the method `each`. On the side of your paper, write the output for this code: `colors.each {|b| puts b }`.

Got it? Here are the important concepts you've seen:

* You can directly assign a value to a location in an array using `[]`
* You can access the value stored at a position by using `[]`
* You can add an element to the end of an array with `<<` or `.push`
* You can remove an element from the end of an array with `.pop`
* You can add an element to the front of an array with `.unshift`.
* The `insert` method takes two arguments: first is the position where you want to insert the data, the second is the data to be inserted
* `shuffle` returns a copy of your array with the elements randomly jumbled up
* `each` is an *enumerable* method which takes a block parameter and runs that block once for *each* element in the collection.

## Group Exercise

For this exercise you'll work in threes.

* Person `A` is in charge of reading the instructions
* Person `B` is in charge of the physical model
* Person `C` is in charge of working in IRB (in such a way that the others can see!)

Start with an empty `colors` array in both the physical space and IRB.

#### Steps

1. Insert a "blue" bead to index 1 `colors[1] = "blue"`
2. Check the value of index 0 `colors[0]`
3. Check the value of index 1 `colors[1]`
4. Check the count of the array `colors.count`
5. Push a green and a red bead onto the array `colors.push("green")` then `colors.push("red")`
6. Pop the last bead off of the array `colors.pop`
7. Remove the first element from the array `colors.shift` -- what value will this return to you?
8. Check the count of the array `colors.count`
9. Insert a red bead at index 1 `colors.insert(1, "red")`
10. Insert an orange bead at index 1 `colors.insert(1, "orange")`  
11. Prepend a purple bead to the front of the array `colors.unshift("purple")`
12. Overwrite the value at index 1 by assigning a yellow bead there `colors[1] = "yellow"`

## Independent Work

### From the Top

Start over with the [arrays section of Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#7.-arrays). Make sure to run the code snippets.  


## WrapUp

* We say that arrays are "zero-indexed". Why does that make counting and positions somewhat confusing?
* Why would `array << 7` be useful as opposed to setting a specific index (ie `numbers[12] = 7`) ?
* It's easy to mix up `push` and `pop` or `shift` and `unshift`. Can you come up with a way to keep them straight?
* Which methods that you've seen here can grow the size of the array? Which
shrink it?
* What happens if you try to access a position outside the length of the array
(like `numbers[100000]`)?
* What happens when you call `pop` on an empty array?


## Homework  

[Core-Types](https://github.com/turingschool/ruby-exercises/tree/master/core-types): Arrays  



