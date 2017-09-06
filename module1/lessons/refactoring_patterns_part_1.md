---
layout: page
title: Refactoring Patterns
length: 60
tags: ruby, refactoring, tdd
---

## Learning Goals

*   Explain how refactoring fits into the RED-GREEN-REFACTOR cycle
*   Identify the difference between refactoring and "changing stuff"
*   Define and apply the Move Method refactoring pattern
*   Define and apply the Extract Class refactoring pattern
*   Define and apply the Hide Delegate refactoring pattern

## Warmup
1.  Why do we refactor?
2.  What's the difference between "refactoring" and "changing stuff"?
3.  Does refactoring always make code better?

## Key Points
"What if we move it over here... will that fix it?"  

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
        * Where should it live? 
        * What is the role of the class, does this functionality belong?  
        * Which class/object does this method reference?  
    2.  [Extract Class](refactoring_patterns_2)
        * Can you make chunks of methods?  
        * Can they be grouped to feel like an object?  
        * Would they have attributes? 
        * Sandi Metz rules: Class should be less than 100 lines
    3.  [Hide Delegate](refactoring_patterns_3)
        * What does the interface look like? Can we simplify it?  
        * Law of Demeter
        * Protect from change 

### Live Refactoring  
Let's apply these refactoring patterns to this [Chisel](https://github.com/turingschool/curriculum/blob/master/source/projects/chisel.markdown) [project](https://github.com/AliSchlereth/chisel) together.   

* Extract Class: Format  
* Move Method: body, emphasis, strong & underlying methods  
* Extract Class: FormatStrong  
* Move Method: strong & underlying methods (on Chisel: Format.new.strong_formatting.strong(chunk)  
* Extract Class: FormatEmphasis  
* Move Method: emphasis & underlying methods (on Chisel: Format.new.emphasis_formatting.emphasis(chunk)  
* Hide Delegate: on Chisel Format.new.strong(chunk) & on Format FormatStrong.strong(chunk)   
* Hide Delegate: on Chisel Format.new.emphasis(chunk) & on Format FormatEmphasis.emphasis(chunk)  

* If time & sequence works, also would be appropriate to change Format, FormatStrong, and FormatEmphasis to modules  

## WrapUp  
Describe the three common refactoring patterns (move method, extract class, hide delegate) and in what scenarios they should be used. Post your answers to Slack.  

## Homework 
Read the Motivation sections for the Move Method, Extract Class, and Hide Delegate sections from [Chapter 7](https://dl.dropboxusercontent.com/u/69001/Refactoring/Refactoring%20-%20Chapter%207.pdf) of Jay Fields' revised version of Fowlers'
[Refactoring: Ruby Edition](http://www.amazon.com/Refactoring-Edition-Addison-Wesley-Professional-Series/dp/0321984137)
