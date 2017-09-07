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
[this extraction of Chapter 7](https://drive.google.com/file/d/0B4C6lfVKu-E7ZlFDTnhyTklXdm8/view?usp=sharing).

## First 12 minutes individually:

* Briefly read the Hide Delegate section from 181 to 184
* *Carefully* re-read the code sections on 183 and 184
* Reflect on these **key ideas** of Hide Delegate:
  *  Encapsulation means objects need to know less about other parts of the system
    * Rather than talking through, talk to
    * You can talk to your friends, but don't talk to your friends' friends
  * Chains of method calls with different levels of abstraction are a red flag
    * Instead, pass the messages like a bucket brigade
  * The [Law of Demeter](http://en.wikipedia.org/wiki/Law_of_Demeter) is not a law and is not about agriculture
* Try refactoring [this](https://github.com/turingschool-examples/refactoring_patterns/blob/master/test/station_3_hide_delegate_test.rb) example scenario (you should already have this cloned) using Hide Delegate. As you encapsulate the use of the delegated object, make sure the linked test still passes
* If you finish early, apply this refactoring pattern to the Enigma examples found under `Additional Resources` in the main lesson for today
* If you still have more time, apply this refactoring pattern to your current project

## Final 3 minutes in your small group:

* Answer the following questions:
  * What is encapsulation?
  * Why would we want to hide delegates?
  * What's one clear indication that you should implement Hide Delegate?
* Compare solutions

