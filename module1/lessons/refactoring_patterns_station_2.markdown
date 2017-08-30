---
layout: page
title: Refactoring Patterns - Extract Class
length: 15
tags: ruby, refactoring, tdd
---

# Refactoring Pattern 2: Extract Class

## Learning Goals

* Explain Extract Class & how it promotes abstraction & single responsibility principle 
* Identify scenarios for which Extract Class is the appropriate refactoring pattern to use
* Implement Extract Class

## Supplies

* You should have a copy of
[this extraction of Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf).

## First 12 minutes:

* Discuss the Extract Class section from 175 to 179
* *Carefully* re-read the code sections on 177 and 178
* Try refactoring [this](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_2_extract_class_test.rb) example scenario (you should already have this cloned) using Extract Class. As you create new classes and move things around, make sure the linked test still passes
* If you finish early, apply this refactoring pattern to the Enigma examples found under `Additional Resources` in the main lesson for today
* If you still have more time, apply this refactoring pattern to your current project

## Final 3 minutes:

* Compare solutions with others in your small group 
* Discuss these **key ideas** of Extract Class:
  * One object is doing the work of two (or more)
    * This is one of the most common weaknesses in object-oriented systems
  * Really is a "Step 1" before applying Move Method
  * Allows for easier testing, reuse, and abstraction
