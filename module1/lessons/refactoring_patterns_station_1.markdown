---
layout: page
title: Refactoring Patterns - Move Method
length: 10 - 25
tags: ruby, refactoring, tdd
---

# Pattern 1: Move Method

## Supplies

* You should have a copy of
[this extraction of Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf).

## Instructions

* Discuss the Move Method section from 167 to 172
* *Carefully* re-read the code sections on 170, 171, and 172
* Read/discuss the Key Ideas below
* Try refactoring the Example Scenario below using Move Method
* You're encouraged to discuss / compare solutions with others
* If you finish early, apply this refactoring pattern to the Enigma examples found on the main lesson page for today 
* If you still have more time, apply this refactoring pattern to your current project

## Key Ideas

* Move Method comes about when you have two objects that are too tightly coupled
* One sign is when you have several methods in Class A that have the name of Class B
* You move the method from Class A to Class B and update any references
* Remember to consider the context of Class B when choosing a name for the moved method

## Example Scenario  
Apply this Refactoring Pattern to the linked repository which you should have already cloned down. As you move methods around, make sure the linked test still passes. 

[Move Method](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_1_move_method_test.rb)
