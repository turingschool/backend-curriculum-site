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
[this extraction of Chapter 7](https://drive.google.com/file/d/0B4C6lfVKu-E7ZlFDTnhyTklXdm8/view?usp=sharing).

## First 12 minutes individually:

* Briefly read Move Method section from 167 to 172
* *Carefully* re-read the code sections on 170, 171, and 172
* Reflect on these **key ideas** of Move Method:
  * Move Method is useful when you have two objects (e.g. Class A & Class B) that are too tightly coupled
    * One indication you should use it is when you have several methods in Class A that have the name of Class B
    * You move the method from Class A to Class B and update any references
  * Remember to consider the context of Class B when choosing a name for the moved method
* Try refactoring [this](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_1_move_method_test.rb) example scenario (you should already have this cloned) using Move Method. As you move methods around, make sure the linked test still passes
* If you finish early, apply this refactoring pattern to the Enigma examples found under `Additional Resources` in the main lesson for today
* If you still have more time, apply this refactoring pattern to your current project

## Final 3 minutes in your small group:

* Answer the following questions:
  * Why would you move a method from one class to another?
  * How can you identify methods that should be moved?
  * How can you implement red, green, refactor to successfully move the method?
  * Should you rename the moved method? If so, how?
* Compare solutions

