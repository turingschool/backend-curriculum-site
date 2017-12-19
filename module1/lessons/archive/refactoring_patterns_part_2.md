---
layout: page
title: Refactoring Patterns
length: 60 min
tags: ruby, refactoring, tdd
---

## Learning Goals
* Explain, identify motivation for, and implement the Move Method refactoring pattern
* Explain, identify motivation for, and implement the Extract Class refactoring pattern
* Explain, identify motivation for, and implement the Hide Delegate refactoring pattern

## Structure

5min - WarmUp
5min - Review
15min - Station Session 1
15min - Station Session 2
15min - Station Session 3
5min - WrapUp

## Vocabulary

* Refactoring
* Move Method
* Extract Class
* Hide Delegate

## WarmUp

* How have you already implemented refactoring strategies in your code?
* What's a key distinction between changing code and refactoring?
* Recall yesterday's red-green-refactor example. What are some strategies to get your code back to green again after you refactor and your tests run red?  (a.k.a. how do you refactor without breaking everything?)
* What are three reasons for refactoring your code?

## Refactoring Strategies

Three highlighted refactoring patterns from Jay Fields revised Fowler's book for Ruby:
[Refactoring: Ruby Edition](http://www.amazon.com/Refactoring-Edition-Addison-Wesley-Professional-Series/dp/0321984137)
1.  Move Method
2.  Extract Class
3.  Hide Delegate

**Turn & Talk**
What is the gist of each of these refactoring patterns? What are the pros/cons of each?

## Stations

You will spend 15 min at each station focusing on one of the strategies.
For each station you will apply the refactoring pattern to the code from [this](https://github.com/turingschool-examples/refactoring_patterns) repo. Make sure to clone it down before you start.
1.  [Move Method](./refactoring_patterns_station_1.markdown)
2.  [Extract Class](./refactoring_patterns_station_2.markdown)
3.  [Hide Delegate](./refactoring_patterns_station_3.markdown)

## WrapUp

* What was challenging about refactoring the above exercises?
* Which refactoring pattern might you reach for first?
* Explain each refactoring pattern and the key motivation for using it.

## Homework

*   Tonight you should watch [Katrina's Therapeutic Refactoring talk](http://confreaks.tv/videos/cascadiaruby2012-therapeutic-refactoring).

## Additional Resources

*   The readings we used today can be [found here](https://drive.google.com/file/d/0B4C6lfVKu-E7ZlFDTnhyTklXdm8/view?usp=sharing). Read through the refactoring patterns not covered in this lesson.
* Apply the techniques practiced today to a sample Enigma project; work through [these exercises](https://github.com/turingschool-examples/enigma_refactoring_exercises). The first should be tackled alone & if possible, the second exercise should be done with a partner.
