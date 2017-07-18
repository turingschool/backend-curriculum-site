---
layout: page
title: Refactoring Patterns - Extract Class
length: 10 - 25
tags: ruby, refactoring, tdd
---

# Pattern 2: Extract Class

## Supplies

* You should have a copy of
[this extraction of Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf).

## Instructions

* Discuss the Extract Class section from 175 to 179
* *Carefully* re-read the code sections on 177 and 178
* Read/discuss the Key Ideas below
* Try refactoring the Example Scenario below using Extract Class
* You're encouraged to discuss / compare solutions with others
* If you finish early, apply this method to the Enigma repo linked today's lesson plan  
* If you still have extra time, apply this strategy to your current project 

## Key Ideas

* One of the most common weaknesses in object-oriented systems
* One object is doing the work of two (or more)
* Really is a "Step 1" before applying Move Method
* Extraction allows for easier testing, reuse, and abstraction

## Example Scenario
Apply this Refactoring Pattern to the linked repository which you should have already cloned down. As you make classes around move things around, make sure the linked test still passes. 

[Extract Class](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_2_extract_class_test.rb)
