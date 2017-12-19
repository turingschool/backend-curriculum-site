---
layout: page
title: Refactoring Patterns
length: 60
tags: ruby, refactoring, tdd
---

## Learning Goals

* Explain how refactoring fits into the RED-GREEN-REFACTOR cycle
* Identify the difference between refactoring and "changing stuff"
* Define and apply the Move Method refactoring pattern
* Define and apply the Extract Class refactoring pattern
* Define and apply the Hide Delegate refactoring pattern

## Slides

Available [here](../slides/refactoring_patterns)

## Warmup

1.  Why do we refactor?
2.  What's the difference between "refactoring" and "changing stuff"?
3.  Does refactoring always make code better?

## Key Points

"What if we move it over here... will that fix it?"

Let's start by discussing Refactoring at a high level:

* The "Red-Green-Refactor" loop

    1. Red - Create a unit test that fails.
    2. Green - Write code to make the unit test pass.
    3. Refactor - Clean up the messiness.

* Changing the internals of code without changing the external behavior
* The concept of technical debt and awkward analogies to personal debt
* Software patterns are common solutions to common problems
* Refactoring patterns are common *transformations*, not *improvements* .
* Three common refactoring patterns

    1. [Move Method](refactoring_patterns_station_1)
        * Where should it live?
        * What is the role of the class, does this functionality belong?
        * Which class/object does this method reference?
    2. [Extract Class](refactoring_patterns_station_2)
        * Can you make chunks of methods?
        * Can they be grouped to feel like an object?
        * Would they have attributes?
        * Sandi Metz rules: Class should be less than 100 lines
    3. [Hide Delegate](refactoring_patterns_station_3)
        * What does the interface look like? Can we simplify it?
        * Law of Demeter
        * Protect from change

### Live Refactoring

For the next two hours you will apply the three refactoring patterns outlined above to [this](https://github.com/turingschool-examples/refactoring_patterns) repository. Spend forty minutes on each.

## WrapUp

* What was challenging about refactoring the above exercises?
* Which refactoring pattern might you reach for first?
* Explain each refactoring pattern and the key motivation for using it.

## Homework

* Tonight you should watch [Katrina's Therapeutic Refactoring talk](http://confreaks.tv/videos/cascadiaruby2012-therapeutic-refactoring).

## Additional Resources

* The readings we used today can be [found here](https://drive.google.com/file/d/0B4C6lfVKu-E7ZlFDTnhyTklXdm8/view?usp=sharing). Read through the refactoring patterns not covered in this lesson.
