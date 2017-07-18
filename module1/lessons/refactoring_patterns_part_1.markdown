---
layout: page
title: Refactoring Patterns
length: 60
tags: ruby, refactoring, tdd
---

## Learning Goals

*   explain how refactoring fits into the RED-GREEN-REFACTOR cycle
*   identify the difference between refactoring and "changing shit"
*   define and apply the Move Method refactoring pattern
*   define and apply the Extract Class refactoring pattern
*   define and apply the Hide Delegate refactoring pattern

## Warmup

Attempt to answer these questions:

1.  Why do we refactor?
2.  What's the difference between "refactoring" and "changing stuff"?
3.  Does refactoring always make code better?

## Key Points

Let's start by discussing Refactoring at a high level:

*   The "Red-Green-Refactor" loop

    1.  Red - Create a unit test that fails.
    2.  Green - Write code to make the unit test pass.
    3.  Refactor - Clean up the messiness.


*   Changing the internals of code without changing the external behavior
*   The concept of technical debt and awkward analogies to personal debt
*   Software patterns are common solutions to common problems
*   Refactoring patterns are common *transformations*, not *improvements* .
*   Three common refactoring patterns

    1.  [Move Method](refactoring_patterns_1)
    2.  [Extract Class](refactoring_patterns_2)
    3.  [Hide Delegate](refactoring_patterns_3)

### Live Refactoring  
Let's apply these refactoring patterns to this [Chisel](https://github.com/turingschool/curriculum/blob/master/source/projects/chisel.markdown) [project](https://github.com/AliSchlereth/chisel) altogether. 

## WrapUp  
Describe the three common refactoring patterns (move method, extract class, hide delegate) and in what scenarios they should be used. Post your answers to Slack.  

## Homework 
Read the Motivation section for the Move Method, Extract Class, and Hide Delegate sections from [Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf)) of Jay Fields' revised version of Fowlers'
[Refactoring: Ruby Edition](http://www.amazon.com/Refactoring-Edition-Addison-Wesley-Professional-Series/dp/0321984137)
