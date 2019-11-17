---
layout: page
title: Jungle Beat
---

# Jungle Beat
### Learning Goals

* Practice breaking a program into logical components
* Distinguishing between classes and instances of those classes
* Understanding how linked lists work to store and find data
* Testing components in isolation and in combination
* Use and implement iteration or recursion techniques

## Basics

In this project we're going to do some silly things with sound. Specifically, we're going to make a very basic drum machine program.

However to add some additional depth, let's also use this project as a chance to explore one of the fundamental data structures in computer science -- the Linked List.

### Drum Machine 101 -- Making Sounds

Go into your Terminal and try this:

```
$ say -r 500 "ding, dah, oom, oom, ding, oom, oom, oom, ding, dah, oom, oom, ding, dah, oom, oom, ding, dah, oom, oom "
```

Yeah. That's what we're looking for. Now try it from Ruby:

```
$ pry
> `say -r 500 "ding, dah, oom, oom"`
```

Note that the backticks allow you to run terminal commands from within Ruby.

The exact command that you need to run may differ based on what version of OS X
you have installed on your computer. The commands above will work on 10.13.

### Linked Lists

Linked Lists are one of the most fundamental Computer Science data structures. A Linked List models a collection of data as a series of "nodes" which link to one another in a chain.

In a singly-linked list (the type we will be building) you have a __head__, which is a node representing the "start" of the list, and subsequent nodes which make up the remainder of the list.

The __list__ itself can hold a reference to one thing -- the head node.

Each node can hold a single element of data and a link to the next node in the list.

The last node of the list is often called its __tail__.

Using sweet ASCII art, it might look like this:

```
List -- (head) --> ["hello" | -]-- (link) --> ["world" | -]-- (link) --> ["!" | ]
```

The three nodes here hold the data "hello", "world", and "!". The first two nodes have links which point to other nodes. The last node, holding the data "!", has no reference in the link spot. This signifies that it is the end of the list.

In other lower level languages, something called a pointer is what is used to ensure that a single link knows about the next link. In Ruby, we don't use pointers, so the link is literally its node. When we get to a node which is the last node, we call it the tail, and its link is nil.

A linked list should be able to do the following:


* Insert elements
* Pop an element from the end
* Push an element onto the beginning
* Remove the (first occurance | all occurances) of an element by data content
* Remove an element by position
* Add an element at an arbitrary position
* Add an element after a known node
* Find whether a data element is or is not in the list
* Find the distance between two nodes

## Iterative Development

As we work through this project, we'll be following an _iterative_ development process. This means we'll aim to build the system out of small but complete chunks which could reasonably stand on their own to perform some required function. The iterations are outlined below. It may be worth reading through them all at first to get a sense of the scope of the entire project, but we encourage you to then forget about later iterations until you get to them.

The point of this process is to help us focus on small pieces at a time without getting overwhelmed by the scope of the entire project.

### Iteration Base Expectations

* [Iteration 0](jungle_beat_iterations/iteration_0) - Node Basics
* [Iteration 1](jungle_beat_iterations/iteration_1) - Append, All and Count (Single Node)
* [Iteration 2](jungle_beat_iterations/iteration_2) - Append, All and Count (Multiple Nodes)
* [Iteration 3](jungle_beat_iterations/iteration_3) - Insert and Prepend
* [Iteration 4](jungle_beat_iterations/iteration_4) - Find, Pop, and Includes?
* [Iteration 5](jungle_beat_iterations/iteration_5) - Creating a Linked List Wrapper
* [Iteration 6](jungle_beat_iterations/iteration_6) - Playing Beats
* [Extensions](jungle_beat_iterations/extensions) - Validating Beats, Speed & Voice

## Tips

* A linked list it not an array. While it may perform many of the same functions as an array, its structure is conceptually very different.
* There are only 3 types of "state" that need to be tracked for a linked list -- the head of the list, the data of each node, and the "next node" of each node.
* In object-oriented programming, "state" is generally modeled with instance variables
* There are two main ways to implement Linked Lists: __iteration__ and __recursion__. Iterative solutions use looping structures (`while`, `for`) to walk through the nodes in the list. Recursive solutions use methods which call themselves to walk through nodes. It would be ideal to solve it each way.
* Most of your methods will be defined on the `List` itself, but you will need to manipulate one or more `Node`s to implement them.
* __TDD__ will be your friend in implementing the list. Remember to start small, work iteratively, and test all of your methods.
* An __empty__ list has `nil` as its head.
* The __tail__ of a list is the node that has `nil` as its next node.

## Constraints

* Make sure that your code is well tested for both *expected cases* and *edge cases*. Try popping more elements than there are in the list. Try seeing if an empty list includes anything. Try inserting elements at a position beyond the length of the list.
* Avoid using other ruby collections (Arrays, Hashes, etc) for the storage of your beats. That's where you're supposed to use the linked list. But having Arrays elsewhere in your code, or using methods that return arrays (like `.split`) are totally ok.

## Resources

Need some help on Linked Lists? You can check out some of the following resources:

* https://www.youtube.com/watch?v=oiW79L8VYXk
* http://www.eternallyconfuzzled.com/tuts/datastructures/jsw_tut_linklist.aspx
* http://www.cs.cmu.edu/~adamchik/15-121/lectures/Linked%20Lists/linked%20lists.html
* http://www.sitepoint.com/rubys-missing-data-structure/

## Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

**Expectations:**

### 1. Ruby Syntax & Style

* Applies appropriate attribute encapsulation  
* Developer creates instance and local variables appropriately
* Naming follows convention (is idiomatic)
* Ruby methods used are logical and readable
* Code is indented properly
* Code does not exceed 80 characters per line
* Each class has correctly-named files and corresponding test files in the proper directories

### 2. Breaking Logic into Components

* Code is effectively broken into methods & classes
* Developer writes methods less than 10 lines
* No more than 3 methods break the principle of SRP


### 3. Test-Driven Development

* Each method is tested  
* Tests implement Ruby syntax & style  

### 4. Version Control

Expectations:

* Developer commits at a pace of at least 1 commit per hour
* Developer implements branching and PRs
* The final submitted version is merged into master

### 5. Functionality

* Application meets all requirements (extension not req'd)
