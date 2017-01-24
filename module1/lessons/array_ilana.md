---
title: Arrays
length: 60
tags: ruby, arrays, data structures
---

# Introduction to Arrays

## Learning Goals

*   Understand the basic idea of a collection type
*   Develop a mental model to understand arrays
*   Gain some familiarity with common array methods

### What is a data structure?

-   A data structure is a particular way of organizing data in a computer so that it can be used efficiently

### What is an array?

-   Arrays are the most fundamental collection type in programming. Just about every language has them. Arrays are collections of data where each element is addressed by an arbitrary number called the *index* or *position*.

We'll step through using some of the fundamental Array methods, including:

*   `[]`
*   `count`
*   `<<` / `push`
*   `unshift`
*   `insert`
*   `pop`
*   `shift`
*   `shuffle`

As we go, we'll work with an IRB/Pry session.

1.  Create a new file in your module 1 folder called ```intro_to_arrays.rb```. In this file, you can take notes and recreate what we have used in our pry session to refer to.
2.  In our pry session let's create some data:
```ruby
name_1 = "Ilana"
name_2 = "Beth"
name_3 = "Lauren"
```
3. Now that we have more than one name, we need a way to collection this data. Let's set a variable name "data" to an empty array.
```ruby
data = []
```
