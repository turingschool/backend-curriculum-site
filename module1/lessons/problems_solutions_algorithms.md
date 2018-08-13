---
title: Problems, Solutions, and Algorithms
length: 90
tags: ruby, pseudocode, algorithms
---

## Learning Goals

* Be able to define the terms algorithm, pseudocode, and iteration
* Be able to use pseudocode to describe the flow of an algorithm's implementation
* Be familiar with using iterative processes to design increasingly robust solutions

## Structure

* 10 - Warmup
* 15 - Lecture
* 5 - Break
* 15 - Lecture Cont.
* 10 - Challenge 1
* 5 - Break
* 15 - Challenge 2
* 10 - Challenge 3
* 5 - Closeout

## Vocabulary

* Pseudocode
* Algorithm
* Iteration

## Slides

Available [here](../slides/problems_solutions_algorithms)

## Warmup

### Part 1 - Writing

First, spend 5 minutes writing an "algorithm" that explains how to tie your shoes.
Try to be as explicit and specific as possible. Assume your reader is a human, but a
very literal one.

### Part 2 - Doing

Now, pair up with your neighbor. The person whose name is alphabetically first will
read their algorithm step-by-step to the person whose name is alphabetically last.
The person whose name is alphabetically last will attempt to tie their shoes according
only to the instructions from their partner.

You can repeat instructions if needed, but don't add any instructions beyond what
you had originally written down.

## Lecture - Big-Picture Strategy

* What is an Algorithm
    `a process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer.`
* Incremental solutions (linear)
* Iterative solutions (spirals)
* Building a full "slice"
* "Half a product not a half-assed product"

### An Iterative Process

1. *Identify the big picture goal:* What do you want your program to do? How will you know when you've succeeded?
1. *Identify the interface:* How do you want to interact with your program? What are its inputs and outputs?
1. *Identify a small picture goal:* What is the simplest case of this problem? Is there a sub-problem of even that case?
1. *Plan to solve that small goal:* Sketch ideas out in a notebook.
1. *Write a small goal test:* Identify expected inputs and outputs. Decide on a method name.
1. *Implement:* Write pseudocode and turn that into code.
1. *Repeat:* Is the whole problem solved? If not, go back to step 3.

### Exercise 1 -- Common Words

With a pair, answer the questions from steps 1 through 4 for the following problem.
When you get to steps 3 and 4, repeat them at least 3 times for increasing levels of complexity.

**Problem:**

I have a text document and want to know "What are the three most common words in the text?"

*Extension*: Let's exclude the following: I, you, he, she, it, we, they, they, a, an.

### Software Processes / Techniques -- why do we care

* Programming -- what makes it hard? (Translating ideas into code? Or coming up with ideas?)
* **Perception** - A good programmer is someone who solves technical problems *easily*
* **Reality** - A good programmer is someone equipped with the tools and processes to confront challenging problems and still emerge successful
* Problem solving challenges: What to do vs. How to do it
* "Dumping out the toolbox" - controlling nerves and pacing yourself
* Software development techniques are designed to *manage* these difficulties
* TDD
* Pseudocode
* Agile Development

## Remaining Exercises

### Small Groups - Algorithm Challenges

We'll then break into small groups to work through this process for a few different problems.

### Odds & Evens

I have a file with 100 numbers. I want to create two new files: one with all the odds and one with all the evens.

*Extension*: Don't allow duplicates in the output

### Palindromes

A palindrome is a word or phrase that reads the same when you reverse all of the letters.

* mom
* kayak
* noon
* Never odd or even

A palindromic number is the same concept applied to numbers:

* 101
* 11
* 1221
* 45654

Create a program to find the largest palindromic number that you can create by multiplying two three digit numbers together.

### Lats & Longs

I have a file with 100 latitude/longitude pairs. Find the point that's closest to the north pole.

*Extension*: Find the one closest to the **magnetic** north pole.


## WrapUp
* What is an algorithm? What is algorithmic thinking? Why is it necessary when working with computers?
* How does iterative problem solving work? Why is it beneficial to us as developers?
* What is pseudocode? How does it make programming easier? Why should we do it even if we think we've got a pretty sweet plan?

