---
layout: page
title: Pseudocoding 101
length: 30
tags: ruby, pseudocode
---

## Learning Goals

* Be able to define the term pseudocode and algorithm
* Be able to use pseudocode to describe the flow of an algorithm's implementation

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

## Big-Picture

### What is an algorithm?
- A programming algorithm is a computer procedure that is a lot like a recipe (called a procedure) and tells your computer precisely what steps to take to solve a problem or reach a goal. The ingredients are called inputs, while the results are called the outputs.

### What is pseudocode?
- Pseudocode is an informal high-level description of the operating principle of a computer program or other algorithm.
-  Programming -- what makes it hard? (Translating ideas into code? Or coming up with ideas?)

### An Iterative Process

A generalized process for solving technical problems:

1. How will you know when the problem is solved? (Identify the big-picture goal)
2. How do you want to use the software? (Identify the "interface")
3. What's the (next-)most trivial possible case? (Identify the next small-picture goal)
4. *How* do we achieve this goal? (Sketch an algorithm using pseudocode)
5. Implement it (do programming)
6. Is the whole problem (from step 1) solved? If not, return to 3.

### Additional Exercises
Answer the questions from steps 1 through 4 for the following problem.
When you get to steps 3 and 4, repeat them at least 3 times for increasing levels of complexity.

#### Common Words


**Problem:**

I have a text document and want to know "What are the three most common words in the text?"

*Extension*: Let's exclude the following: I, you, he, she, it, we, they, they, a, an.

#### Odds & Evens

**Problem:**

I have a file with 100 numbers. I want to create two new files: one with
all the odds and one with all the evens.

*Extension*: Don't allow duplicates in the output

### Lats & Longs

**Problem:**

I have a file with 100 latitude/longitude pairs. Find the point that's closest to the north pole.

*Extension*: Find the one closest to the **magnetic** north pole.
