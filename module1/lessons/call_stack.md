---
layout: page
title: The Call Stack
tags: stacks, queue, flow-control, filo
length: 120
---

## Learning Goals

* Understand the Stack data structure
* Understand how computers use The Call Stack to manage the execution of methods

## Vocabulary

* Data Structure
* Stack
* Push/Pop
* Top
* The Call Stack (The Stack)
* Stack Frame

## Slides

Available [here](../slides/call_stack)


# The Stack Data Structure

## Data Structures

* Abstract model for organizing data
* Models relationships between data
* Models inserting and accessing data
* Can model other things, for example:
  * searching
  * deleting


### Common Data Structures

* Linked List
* Binary Tree
* Graph
* Heap
* Stack

These are all important data structures (read: interview topics). Today we will focus on the Stack.

## Stacks

* Fundamental Data Structure in computer science
* A Stack is the opposite of a Queue
* Follows "first-in-last-out" semantics
* Important point about a stack: Things on top of the stack cover or hide things on the bottom -- you can't see or access lower elements while there is a top element

Terminology

* __Top__ - Most recently added element (sometimes people will say "bottom" if they are envisioning the stack growing from top down)
* __Pushing__ - adding a new element to the top of the stack
* __Popping__ - removing the top element from the stack

![Stack](https://www.w3schools.in/wp-content/uploads/2016/09/Data-Structures-Algorithms-Stack.png)

## Stack Exploration

Complete [this Activity](https://github.com/turingschool-examples/check_it) with a partner. Make sure to answer the CFU questions after you have worked through the examples. If you finish early, work on the bonus activity at the end of the README.

# The Call Stack

## Partner Activity

Clone [this Repository](https://github.com/turingschool-examples/homeward_bound). With a partner, trace through the program line by line when you run `runner.rb`.

Notice that whenever a method finishes running, you have to go back to where it was called from to continue tracing through the program. It can be difficult to follow this sequence between 3 or 4 method calls. How does the computer manage it when there are potentially hundreds of nested method calls?

## The Stack

In order to manage the flow of execution between methods, the Computer keeps track of **The Call Stack**. This stack is so omnipresent we often refer to is as **The Stack**.

Stacks are really good at problems that involve nesting or ordered execution, as we saw in the "check it" example. Keeping track of method calls is a perfect application of stacks because methods also nest inside each other. When a method calls another method, the outer method needs to wait for the inner method call to finish before it can resume.

The Call Stack represents each method call as an element on the stack. This is called a **Stack Frame**.

## Modeling the Stack

Using the Homeward Bound example, we are going to trace through the program and model The Stack as a stack of index cards. We will follow these rules:

* Every time a method is called
  1. Create an index card for that method (if you don't already have one). This is a **Stack Frame**.
  1. Push the new Stack Frame onto the Stack.
* Every time a method is finished
  1. Pop off the top Stack Frame

## Return Values

**Turn and Talk** - Looking at the Homeward Bound code, find examples where we are saving the return value of a method.

We know that methods don't just execute, they also return values. Every method has a return value, but that return value isn't always used.

We are going to use sticky notes to model data being passed between methods via return values. Our updated rules (the new information is bolded):

* Every time a method is called
  1. Create an index card for that method (if you don't already have one). This is a Stack Frame.
  1. **Place a sticky note for the return value on the top Stack Frame**
  1. Push the new Stack Frame onto the Stack **(on top of the sticky note)**
* Every time a method is finished
  1. **Write the return value of the method on the top sticky note**
  1. Pop off the top Stack Frame

## Context

### Local Variables

Stack Frames also keep track of **Context** for the currently executing method. One piece of this context is local variables. We'll add another rule to our stack model:

* Every time a method is called
  1. Create an index card for that method (if you don't already have one). This is a Stack Frame.
  1. Place a sticky note for the return value on the top Stack Frame
  1. Push the new Stack Frame onto the Stack (on top of the sticky note)
  1. **In one of the corners of the Stack Frame, write down any local variables that are created in this method (including arguments)**
* Every time a method is finished
  1. Write the return value of the method on the top sticky note
  1. Pop off the top Stack Frame

Note that we are including any arguments to the method as a local variable since they function like local variables.

Notice that whenever you pop a stack frame, any local variables that were part of it are lost.

### self

Another important piece of context the Stack Frame keeps track of is the value of `self`. Self refers to whatever Object is executing the method. So in the example above, when we call `chance.chase`, because `chance` is a Dog object, inside the `chase` method `self` refers to that Dog object.

We'll add another rule to our stack model:

* Every time a method is called
  1. Create an index card for that method (if you don't already have one). This is a Stack Frame.
  1. Place a sticky note for the return value on the top Stack Frame
  1. Push the new Stack Frame onto the Stack (on top of the sticky note)
  1. In one of the corners of the Stack Frame, write down any local variables that are created in this method (including arguments)
  1. **In another corner, write down the value of `self`**
* Every time a method is finished
  * Write the return value of the method on the top sticky note
  * Pop off the top Stack Frame

## Partnered Activity

Work through [this Example](https://github.com/turingschool-examples/lion_king) using the rules we defined above to model The Call Stack.

One person should be in charge of moving and filling out the sticky notes. The other partner is in charge of the index cards. When you have completed one pass through the example, switch roles.

## Wrap Up

* Most essential challenge in starting programming: Getting over the "Mental Model" hump
* As beginners we tend to view a program in the way that we initially interact with it -- **As Text**
* However the actual operation is much richer -- applying a series of complex but elegant rules to properly evaluate our instructions
* Experiences programmers learn to see behind the text and work with the underlying **Mental Model**
* This is largely what accounts for the perceived gulf between a novice and even an intermediate developer
* Once we get over the hump of modeling how the program works in our mind, the manipulations we can perform become vastly more sophisticated

## Check for Understanding

* What is the Stack data structure? What are the rules of interacting with a Stack?
* What is The Call Stack? How does it work?
* What is a return value, in terms of The Call Stack?
* When an error occurs, how does Ruby create the Stack Trace?
