---
title: Unit Testing Client-Side Code
subheading: A Workshop
---

## Intro (5 minutes)

As you learned to build more complex applications, we gave you Rails. As a framework, one of Rails' jobs is to help you organize your code. Logic that is related to a resource belongs in that resource's model. Logic related to a view belongs in a helper.

This doesn't just help you organize your files -- it helps you organize divide responsibilities in your code. You don't really have to think about what's unit testable. If it's in a model, it's unit testable.

JavaScript is not just a new language, but a new environment and we've taken away any opinionated framework from you. Now, the responsibility division and code organization is completely your responsibility.

## Learning Goals

By the end of this workshop, you should be able to:

- Add unit tests to your front-end application
- Understand how to approach refactoring client-side code for unit testing
- Understand and be able to speak to why unit testing client-side code is complicated

## How Should We Think About Unit Testing? (20 minutes)

Reading: [Writing Testable JavaScript](https://alistapart.com/article/writing-testable-javascript)

After 15 minutes, turn to the person next to you and compare/discuss interesting parts of the reading.

### Murphy's Four Areas of Responsibility

- Presentation and interaction
- Data management and persistence
- Overall application state
- Setup and glue code to make the pieces work together

## Activity (25 minutes)

- [QS Snippet](https://gist.github.com/neight-allen/6b7f05c01023682d41ad5625febf2655)

Using the four areas of responsibility from Murphy's article, go through this partial Quantified Self implementation and take a first pass at highlighting the pieces you think belong to those certain sections.

After about 15 minutes, turn to the person next to you and compare/discuss your results.

## Application (25 minutes)

Get together with your project partner. Find a function within your codebase that would be a good candidate for refactoring based on what we've just learned.

1. Make a copy of the function you're about to refactor, so you can compare when you're done.
1. Pick apart the different logical steps that are taken in this function
1. Determine one or more functions that could be extracted out from your main function
1. Try to write unit tests for those functions before refactoring them
1. TDD your refactor

Spend about 10 minutes doing this for one function. We'll close by seeing some of your solutions.
