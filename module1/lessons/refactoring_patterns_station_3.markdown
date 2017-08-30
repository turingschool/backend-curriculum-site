---
layout: page
title: Refactoring Patterns - Hide Delegate
length: 15
tags: ruby, refactoring, tdd
---

## Refactoring Pattern 3: Hide Delegate

## Learning Goals

* Explain Hide Delegate & how it promotes encapsulation
* Identify scenarios for which Hide Delegate is the appropriate refactoring pattern to use
* Implement Hide Delegate

## Supplies

* You should have a copy of
[this extraction of Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf).

## First 12 minutes:

* Discuss the Hide Delegate section from 181 to 184
* *Carefully* re-read the code sections on 183 and 184
* Try refactoring [this](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_3_hide_delegate_test.rb) example scenario (you should already have this cloned) using Hide Delegate. As you encapsulate
the use of the delegated object, make sure the linked test still passes
* If you finish early, apply this refactoring pattern to the Enigma examples found under `Additional Resources` in the main lesson for today
* If you still have more time, apply this refactoring pattern to your current project

## Final 3 minutes:

* Compare solutions with others in your small group 
* Discuss these **key ideas** of Hide Delegate:
  *  Encapsulation => objects need to know less about other parts of the system
    * You can talk to your friends, but don't talk to your friends' friends
    * Rather than talking through, talk to
  * The [Law of Demeter](http://en.wikipedia.org/wiki/Law_of_Demeter) is not a law and is not about agriculture
  * Chains of method calls with different levels of abstraction are a red flag
    * Instead, pass the messages like a bucket brigade


* Read/discuss the Key Ideas below
* Try refactoring the Example Scenario below using Hide Delegate
* You're encouraged to discuss / compare solutions with others
* If you finish early, apply this pattern to the Engima repo linked in today's lesson plan 
* If you still have extra time, apply this pattern to your current project 

## Key Ideas



## Example Scenario
Apply this Refactoring Pattern to the linked repository which you should have already cloned down. As you move methods around, make sure the linked test still passes. 

[Hide Delegate]()
