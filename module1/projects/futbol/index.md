---
layout: page
title: Futbol
---

Let's build a system to do some analysis on futbol team performance.

## Learning Goals

* Build classes with single responsibilities.
* Write organized readable code.
* Use TDD as a design strategy
* Design an Object Oriented Solution to a problem
* Practice algorithmic thinking
* Work in a group
* Use Pull Requests to collaborate among multiple partners

## Project Description

We will be using data from a fictional soccer league to analyze team performance for specific seasons and across seasons. We want to see who the best and worst performers are, as well as be able to pull statistics for individual teams. To that end we will create a `StatTracker` class that will provide us with the information we need.

The first half of the project will focus on building the base statistics functionality through our `StatTracker`.  As you build out this class, you will quickly realize that there is waaaay too much going on in one class; so, for the second half of the project we will switch our focus to reorganizing our code to practice good SRP!

## Organization

A key goal of this project is to write readable, organized, object-oriented code. Each of the methods we will implement should be defined as instance methods on `StatTracker`. However, all of the code for your project should not be contained in the `StatTracker` class. You should break your code into logical, organized components.

We recommend taking a "red, green, refactor" approach. First, write tests, write code that makes the tests pass, and then focus on refactoring and organizing after you have working tests and code. It will be easier to make decisions about new classes, modules, methods, etc. when you have seen working code.

We also encourage you to track your progress by utilizing a project management tool such as GitHub Projects; we will not be requiring a project management tool for the project, but it is a good habit to get into!

See [the evaluation rubric](./rubric) for more details and what exactly you should accomplish in this project.

## Testing

Another key goal of this project is to utilize Test Driven Development. Because the data set is so large, it will be inefficient to use the actual dataset as your test data. Instead, you should make up your own test data. You can do this either by creating dummy CSV files, known as fixture files, or you can create dummy data within your test files. Either is a valid approach.

Earlier in the mod, we introduced [Mocks and Stubs](../../lessons/mocks_stubs), which is another testing strategy that may come in handy during this project. We recommend starting with fixture files or dummy data in the test setup, and refactoring to using mocks and stubs if you feel comfortable with those tools.

### Spec Harness

In addition to your own tests, instructors will use [This Spec Harness](https://github.com/turingschool-examples/futbol_spec_harness) to assess the completion of your project. Prior to your evaluation, follow the direction in the README to set up the spec harness and verify that your code passes the tests. **NOTE: the spec harness is not a replacement for writing your own tests**.

## Iterations

We have separated the methods required for this project into sections below.

* **Iteration 1:** [Setup and File I/O](./iterations/file_io)
* **Iteration 2:** [Statistics](./iterations/statistics)
* **Iteration 3:** [Re-Organization](./iterations/reorganization)
* **Iteration 4:** [Build a Website](./iterations/website)

## Evaluation Rubric

Your project will be assessed using [this rubric](./rubric)
