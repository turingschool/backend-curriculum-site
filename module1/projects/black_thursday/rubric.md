---
layout: page
title: Black Thursday - Evaluation Rubric
---


<br> | **1: Well Below Expectations**  | **2: Below Expectations** | **3: Meets Expectations** | **4: Well Above Expectations**
-- | --- | --- | --- | ---
**Functionality** | iteration 3 not complete. | iterations 0 - 3 complete. | iterations 0 through 4 complete. | All iterations complete.
**Mechanics** |  Less than 25% of enumerables are the best choice. Class methods are not defined correctly. Frequently passes data using instance variables when return values would suffice. | Half of enumerables are best choice. Class methods are defined but not implemented properly. Passes data using instance variables when return values would suffice. | 75% of enumerables are best choice. Class methods are implemented correctly. Does not pass data using instance variables over return values. | Incorporates significant improvements not covered in class in a way that is appropriate and not simply for the sake of adding new things.
**Design** | Methods are often longer than 7 lines, do not have single responsibilities, and the code is generally difficult to read. | More than 2 methods are longer than 7 lines, do not have a single responsibility, or are named in a way that makes it difficult to understand what the method does. No module or superclass is used to help reduce repeated code across repository classes. | Methods are less than 7 lines, have a single responsibility, and have names that clearly communicate that single responsibility. At least one module or superclass helps reuse code across the repository classes. | Implements classes/modules not described in the spec that help ensure all classes are less than 100 lines of code, clearly have a single responsibility, and do not repeat any code. Implements are least 1 module and at least 1 superclass. Implements benchmarking for each `SalesAnalyst` method described in the spec.
**Testing** | Less than half of the methods in any given class are untested or have tests that don't verify expected behavior.| Every method is not tested. git history does not demonstrate students are writing tests before implementation code. | Every method is tested at both the unit and integration level. git history demonstrates students are writing tests before implementation code. | Mocks and stubs are used to ensure that classes can be tested without relying on functionality from other classes

## Version Control

A failing project will have few commits, will not use a PR workflow, students with non equal contributions to the codebase, large commits, poor PR messages.

A successful and passing project must have: Students contributed roughly equally to the project in terms of number of commits and lines of code. Commits are made in small chunks of functionality. Students used pull requests as a collaboration tool by reviewing each other's PRs, making comments, and never merging their own PRs

An exceptional project will have: Students implement a code review process for their pull request in which each partner makes suggestions for improvements, and those improvements are then integrated into the PR before it is merged. Students integrated HoundCI into git workflow.

## Functionality

* **4** Students complete all iterations.
* **3** Students complete iterations 0 through 4.
* **2** Students complete all functionality in iterations 0 through 3.
* **1** Students do not complete all functionality in iteration 3.

## Mechanics

* **4** Incorporates significant improvements not covered in class in a way that is appropriate and not simply for the sake of adding new things.

* **3** 75% of enumerables are best choice. Class methods are implemented correctly. Does not pass data using instance variables over return values.

* **2** Half of enumerables are best choice. Class methods are defined but not implemented properly. Passes data using instance variables when return values would suffice.

* **1** Less than 25% of enumerables are the best choice. Class methods are not defined correctly. Frequently passes data using instance variables when return values would suffice.


## Design

* **4** Implements classes/modules not described in the spec that help ensure all classes are less than 100 lines of code, clearly have a single responsibility, and do not repeat any code. Implements are least 1 module and at least 1 superclass. Implements benchmarking for each `SalesAnalyst` method described in the spec.

* **3** Methods are less than 7 lines, have a single responsibility, and have names that clearly communicate that single responsibility. The Law of Demeter is followed. Modules or inheritance is used to eliminate code repetition.

* **2** More than 2 methods are longer than 7 lines, do not have a single responsibility, or are named in a way that makes it difficult to understand what the method does. No module or superclass is used to help reduce repeated code across repository classes. Code breaks the Law of Demeter.

* **1** Methods are often longer than 7 lines, do not have single responsibilities, and the code is generally difficult to read.

## Testing

* **4** Mocks and stubs are used to ensure that classes can be tested without relying on functionality from other classes

* **3** Every method is tested at both the unit and integration level. git history demonstrates students are writing tests before implementation code.

* **2** Every method is not tested. git history does not demonstrate students are writing tests before implementation code.

* **1** Less than half of the methods in any given class are untested or have tests that don't verify expected behavior.

