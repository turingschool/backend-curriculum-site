---
layout: page
title: Refactoring Patterns
length: 120
tags: ruby, refactoring, tdd
---

## Learning Goals

*   explain how refactoring fits into the RED-GREEN-REFACTOR cycle
*   identify the difference between refactoring and "changing shit"
*   define and apply the Move Method refactoring pattern
*   define and apply the Extract Class refactoring pattern
*   define and apply the Hide Delegate refactoring pattern

## Warmup

Attempt to answer these five questions:

1.  Why do we refactor?
2.  What's the difference between "refactoring" and "changing shit"?
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
*   Refactoring patterns are common *transformations*  , not *improvements*  .
*   Jay Fields revised Fowler's book for Ruby:
[Refactoring: Ruby Edition](http://www.amazon.com/Refactoring-Edition-Addison-Wesley-Professional-Series/dp/0321984137)
*   Three common refactoring patterns

    1.  Move Method
    2.  Extract Class
    3.  Hide Delegate

### Check for Understanding
Describe the three common refactoring patterns (move method, extract class, hide delegate) and in what scenarios they should be used. Post your answers to Slack.

## Choosing the Appropriate Refactoring Tactic

### Individual Work
Identify 1 scenario suited to each type of refactor (3 total). Use [past M1 projects](https://github.com/turingschool/ruby-submissions/tree/master/1610-b) for inspiration. Post responses on the Google sheet posted in Slack.

### Group Work
In groups of 3, assign one tactic to each person in your group and one-by-one have each member teach-back their tactic and the matching scenario they picked. Each member should explain to the group:
  1. What the tactic is,
  2. When to use the tactic, and
  3. Why the scenario you picked is a good match for the tactic.  

## Refactoring Pattern Stations
For the remaining time students will disburse and work through three separate station exercises in small groups of three.

For the **first 10 minutes of each station**, work through the exercise independently. For the **last 5 minutes of each station**, review your refactored code together and address any discrepancies between your answers -- are they a matter of personal style or deviations from convention?

*   [Station 1](refactoring_patterns_station_1)
*   [Station 2](refactoring_patterns_station_2)
*   [Station 3](refactoring_patterns_station_3)

## Follow Up: Enigma Refactoring Exercises

Students should join a pair to work on applying these techniques to a sample Enigma project using [these exercises](https://github.com/turingschool-examples/enigma_refactoring_exercises).

## Follow Up

*   Tonight you should watch [Katrina's Therapeutic Refactoring talk](http://confreaks.tv/videos/cascadiaruby2012-therapeutic-refactoring).
*   The readings we used today can be [found here](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf).
