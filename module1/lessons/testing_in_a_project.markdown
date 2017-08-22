---
title: Testing in a Project
length: 60 minutes
tags: ruby, testing, tdd
---

# Testing in a Project

## Learning Goals  

* Recall what our debugging tools are
* Recall advantages of TDD
* Discuss & share testing from your current project
* Identify further ways to implement TDD in your project

## Structure  

5 min - Warm Up  
15 min - TDD Patterns
5 min - Break  
25 min - Implement Testing in a Project
5 min - Wrap Up

## Vocabulary  

* TDD

## Warm Up

* Name 2 debugging tools we use heavily in collaboration with TDD
* Recall 3 necessary components of a test file
* Name 4 assertion methods
* Why is the TDD workflow (Red-Green-Refactor) helpful/important?

## TDD Patterns

### Breaking down the big idea
How do you decide what to assert?

Let's say I'm building a model to represent a house. What testing assertions could I define that would prove to me, once they're all true, that I've in fact built the house I expect?

- Does it have a roof?
- Does it have a foundation?
- Does it have windows?
- Does it have walls?
- Do the walls create rooms?
- Does it have a kitchen? a bedroom? a bathroom? a living room?

#### Turn & Talk
What testing questions could you ask to verify that the following models have been created appropriately?

- An office
- A movie set
- A frozen banana stand
- A staircar

### Input/Output thought process 
For each test, consider:
What object(s) do we need to access?
What is the actual method we're testing? (What is the input for the assertion method?)
What do we expect to see? (What output do we expect the method to return?)

### Practice

1. Let's pick one of the models from the previous exercise (an office, a movie set, a staircar) and use Minitest to turn assertions into a Ruby tests.

2. We'll finish the red-green-refactor loop by writing code to pass the test and refactoring. 

** break **

## Identifying Ways to Improve Testing in a Project

Remember that TDD helps:

* Shape design
* Break code into small pieces
* Communicate what your code _should_ do

#### Turn & Talk  
Break down a test that you've written with the person sitting next to you; ask your partner:

Does the test make sense?
How could I improve this test?
What are some tests I could add to build on this test and make the method more robust?

## Recap
* 
* 
* 