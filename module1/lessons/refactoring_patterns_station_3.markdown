---
layout: page
title: Refactoring Patterns - Hide Delegate
length: 25
tags: ruby, refactoring, tdd
---

## Pattern 3: Hide Delegate

## Supplies

* You should have a copy of
[this extraction of Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf).

## Instructions

* Discuss the Hide Delegate section from 181 to 184
* *Carefully* re-read the code sections on 183 and 184
* Read/discuss the Key Ideas below
* Try refactoring the Example Scenario below using Hide Delegate
* You're encouraged to discuss / compare solutions with others
* If you finish early, apply this pattern to the Engima repo linked in today's lesson plan 
* If you still have extra time, apply this pattern to your current project 

## Key Ideas

* You can talk to your friends, but don't talk to your friends' friends
* The [Law of Demeter](http://en.wikipedia.org/wiki/Law_of_Demeter) is not a law and is not about agriculture
* Rather than talking through, talk to
* Chains of method calls with different levels of abstraction are a red flag
* Instead pass the messages like a bucket brigade

## Example Scenario
Apply this Refactoring Pattern to the linked repository which you should have already cloned down. As you move methods around, make sure the linked test still passes. 

[Hide Delegate](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_3_hide_delegate_test.rb)
