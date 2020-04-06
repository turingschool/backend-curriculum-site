---
layout: page
title: Reorganization
---

_[Back to Futbol Home](../index)_

Now that we have some statistics methods done, its time to do some refactoring!  There are a few things to consider when deciding what methods and classes can be refactored and reorganized:

* Classes should be compact - no longer than 150 lines!
* Classes should have a single responsibility - you should be able to describe what a class is responsible for in one sentence.
* Use the tools we have learned recently when thinking about reorganization - Modules, Inheritance, and Plain Old Ruby Objects (POROs).

As you refactor, you must maintain the integrity of your existing tests by adding tests for any new methods as you go.  **Every** method should have at least one test!  During this refactor, remember Mocks and Stubs - these can be considered part of a refactor; for example, to better test methods that rely on large datasets, or many helper methods.

As a **deliverable** for your refactoring and reorganization, include a README in your GitHub repo that describes your design strategy.  This could be a narrative description of your design, or a graphic representation.
