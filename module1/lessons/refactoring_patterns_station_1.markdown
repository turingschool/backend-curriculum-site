---
layout: page
title: Refactoring Patterns - Move Method
length: 15
tags: ruby, refactoring, tdd
---

# Refactoring Pattern 1: Move Method

## Learning Goals 

* Explain Move Method and how it promotes abstraction and single responsibility principle
* Identify scenarios for which Move Method is the appropriate refactoring pattern to use
* Implement Move Method

## Supplies

* You should have a copy of
[this extraction of Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf).

## First 12 minutes:

* Discuss the Move Method section from 167 to 172
* *Carefully* re-read the code sections on 170, 171, and 172
* Try refactoring [this](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_1_move_method_test.rb) example scenario (you should already have this cloned) using Move Method. As you move methods around, make sure the linked test still passes
* If you finish early, apply this refactoring pattern to the Enigma examples found under `Additional Resources` in the main lesson for today
* If you still have more time, apply this refactoring pattern to your current project

## Final 3 minutes:

* Compare solutions with others in your small group 
* Discuss these **key ideas** of Move Method:
  * Move Method is useful when you have two objects (e.g. Class A & Class B) that are too tightly coupled
    * One indication you should use it is when you have several methods in Class A that have the name of Class B
    * You move the method from Class A to Class B and update any references
  * Remember to consider the context of Class B when choosing a name for the moved method

