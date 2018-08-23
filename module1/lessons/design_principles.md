---
layout: page
title: Design Principles
length: 120
---

## Learning Goals

Students will

* Research and describe different programming principles
* Create diagrams of classes that outline their state and behavior
* Review code and form opinions on that code

## Slides

Available [here](../slides/design_principles)

## Warmup

Number off and research the following topics:

* Code Smells
* SOLID OOP
* Four Pillars of OOP
* OOP Design Patterns
* Law of Demeter
* DRY/YAGNI

In a group, create a poster with short descriptions of each one of the above topics.

## Lesson

We're going to practice diagramming classes, and then use those diagrams as a way to better understand and make plans for our code.

### Diagramming Classes

A class diagram is a visual way to represent a class. It includes:

* Class Name
* Instance Variables
* Methods

![Class Diagram](./assets/class_diagram.jpg)

Let's practice together by creating a class diagram for a Dog class.

The name of the class would likely be Dog.

It might hold state like its name, age, breed, etc.

It might also have methods like `roll_over`, `sit`, `fetch`, `bark`, `eat`, `sleep`, etc.

What would the primary responsibility of this class be? To describe and hold the behaviors associated with a Dog.

### Practice with a Partner

Take a look at the project spec for Sorting Cards.

* What classes are included?
* What state do they each hold?
* What methods do they implement?
* What is the primary responsibility for each class?

### Practicing Without a Spec

Assume we wanted to create a program to play the game mastermind from our command line.

* What classes would you create to tackle this problem?
* What would be each class's primary responsibility?
* What methods would each class have?
* What state would they hold as insstance variables?

### Code Review

Look at the three different versions of the Mastermind project linked [here](https://github.com/s-espinosa/master_minds). Students are asked to create a version of the classic game that you can play in your terminal.

![Mastermind](./assets/Mastermind.jpg)

Review the three different versions, and answer the following questions.

* What do you like about each one?
* What don't you like?
* Are there specific aspects of the code that are making it easy or difficult to read?

