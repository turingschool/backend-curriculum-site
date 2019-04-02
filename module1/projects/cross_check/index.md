---
layout: page
title: Cross-Check
---

Let's build a system to do some analysis on NHL team performance.

## Learning Goals

* Build classes with single responsibilities.
* Write organized readable code.
* Use TDD as a design strategy
* Design an Object Oriented Solution to a problem
* Practice algorithmic thinking
* Work in a group
* Use Pull Requests to collaborate among multiple partners

## Project Description

We will be using data from the National Hockey League to analyze team performance for specific seasons and across seasons. We want to see who the best and worst performers are, as well as be able to pull statistics for individual teams. To that end we will create a `StatTracker` class that will provide us with the information we need.

## Organization

A key goal of this project is to write readable, organized, object-oriented code. Each of the methods we will implement should be defined as instance methods on `StatTracker`. However, all of the code for your project should not be contained in the `StatTracker` class. You should break your code into logical, organized components.

We recommend taking a "red, green, refactor" approach. First, write tests, write code that makes the tests pass, and then focus on refactoring and organizing after you have working tests and code. It will be easier to make decisions about new classes, modules, methods, etc. when you have seen working code.

See [the evaluation rubric](./rubric) for more details and what exactly you should accomplish in this project.

## Testing

Another key goal of this project is to utilize Test Driven Development. Because the data set is so large, you will not be able to use the actual dataset as your test data. Instead, you should make up your own test data. You can do this either by creating dummy CSV files, known as fixture files, or you can create dummy data within your test files. Either is a valid approach.

### Spec Harness

In addition to your own tests, instructors will use [This Spec Harness](https://github.com/turingschool-examples/cross_check_spec_harness) to assess the completion of your project. Prior to your evaluation, follow the direction in the README to set up the spec harness and verify that your code passes the tests. **NOTE: the spec harness is not a replacement for writing your own tests**.

## Iterations

We have separated the methods required for this project into sections below.

For each of the iterations below, where a method requires you to perform a calculation with *goals*, use the goal count included in the Games CSV *except for iteration 5*.

* **Iteration 1:** [Setup and File I/O](./iterations/file_io)
* **Iteration 2:** [Game Statistics](./iterations/game_statistics)
* **Iteration 3:** [League Statistics](./iterations/league_statistics)
* **Iteration 4:** [Team Statistics](./iterations/team_statistics)
* **Iteration 5:** [Season Statistics](./iterations/season_statistics)
* **Iteration 6:** [Create a Website](./iterations/website)

## Evaluation Rubric

Your project will be assessed using [this rubric](./rubric)
