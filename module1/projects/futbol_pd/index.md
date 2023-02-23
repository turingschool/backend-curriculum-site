---
layout: page
title: Futbol - PD
---

Let's build a system to do some analysis on futbol team performance.
And let's also build a system to do some analysis on YOUR team performance, too!

## Learning Goals

* Building software in teams
  * Use Pull Requests to collaborate among multiple partners
  * Practice giving and receiving feedback with teammates
  * Establish a project organization process
* Design an Object Oriented Solution to a problem with multiple people
* Use TDD and write clean Ruby following SRP and DRY principles

## Project Description

We will be using data from a fictional soccer league to analyze team performance for specific seasons and across seasons. We want to see who the best and worst performers are, as well as be able to pull statistics for individual teams. To that end we will create a `StatTracker` class that will provide us with the information we need.

The first step of the project will focus on establishing norms for your group. This should include the following: project organization process, git workflow expectations, and DTR *at a minimum*.

Next you, will plan and design your solution with your group. This probably doesn't actually involve writing any code yet. Remember, the primary purpose of this project is to practice building software in a team setting. You need a good design and plan before folks can break off and do their own thing.

Finally, once you have strong processes and a plan in place, the project can begin focusing on building the base statistics functionality through our `StatTracker`.

## Code Organization

Each of the methods we will implement should be defined as instance methods on `StatTracker`. However, all of the code for your project should not be contained in the `StatTracker` class. You should break your code into logical, organized components.

We recommend taking a "red, green, refactor" approach. First, write tests, write code that makes the tests pass, and then focus on refactoring and organizing after you have working tests and code. It will be easier to make decisions about new classes, modules, methods, etc. when you have seen working code.

A key goal of this project is to work effectively in teams of 3-5 people. We **STRONGLY** encourage you to track your progress by utilizing a project management tool such as GitHub Projects or Trello; we will not be requiring a project management tool for the project, but it is a good habit to get into! If you choose not to use a project management tool, your group should still decide how tasks are being assigned to group members and how the status of those tasks should be communicated to the group.

See [the evaluation rubric](./rubric) for more details and what exactly you should accomplish in this project.

## Testing

As with all projects, you should utilize Test Driven Development. Because the data set is so large, it will be inefficient to use the actual dataset as your test data. Instead, you should consider making up your own test data. You can do this either by creating dummy CSV files, known as fixture files, or you can create dummy data within your test files. Either is a valid approach.

A lesson available in Mod 1 is [Mocks and Stubs](../../lessons/mocks_stubs), which is another testing strategy that may come in handy during this project. We recommend starting with fixture files or dummy data in the test setup, and refactoring to using mocks and stubs if you feel comfortable with those tools.

### Spec Harness

In addition to your own tests, you can use [this Spec Harness](https://github.com/turingschool-examples/futbol_spec_harness) to assess the accuracy of your project calculations. The spec harness contains a small number of tests to verify that the methods you wrote work as intended according to the project technical requirements. **NOTE: the spec harness is not a replacement for writing your own tests**.

## Iterations

We have separated the methods required for this project into sections below.

* **Iteration 1:** [Group Norms and Project Design](./iterations/group_norms)
* **Iteration 2:** [Setup, File I/O, and Statistics](./iterations/file_io_stats)
* **Iteration 3:** [Retro](./iterations/retro)
* **Iteration 4:** [Process Change](./iterations/team_statistics)

## Evaluation Rubric

Your project will be assessed using [this rubric](./rubric).

### Evaluation Presentation
Please reference [these instructions](./evaluation) to prepare for your live project evaluation.
