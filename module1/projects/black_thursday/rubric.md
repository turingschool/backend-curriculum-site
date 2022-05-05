---
layout: page
title: Black Thursday - Evaluation Rubric
---

_[Back to Black Thursday Home](./index)_


<br> | Exceptional  | Meets Expectations | Below Expectations | Well Below Expectations
-- | --- | --- | --- | ---
**Functionality** | All iterations complete. | Iterations 0 through 4 complete. | Iterations 0 through 3 complete. | Iteration 3 not complete.
**Mechanics** |  Incorporates significant improvements not covered in class in a way that is appropriate and not simply for the sake of adding new things. | 75% of enumerables are best choice. Class methods are implemented correctly. Does not pass data using instance variables over return values.  | Half of enumerables are best choice. Class methods are defined but not implemented properly. Passes data using instance variables when return values would suffice. | Less than 25% of enumerables are the best choice. Class methods are not defined correctly. Frequently passes data using instance variables when return values would suffice.
**Design** | Implements classes/modules not described in the spec that help ensure all classes are less than 100 lines of code, clearly have a single responsibility, and do not repeat any code. Implements at least 1 module and at least 1 superclass. Implements benchmarking for each `SalesAnalyst` method described in the spec. | Methods are less than 7 lines, have a single responsibility, and have names that clearly communicate that single responsibility. At least one module or superclass helps reuse code across the repository classes. | More than 2 methods are longer than 7 lines, do not have a single responsibility, or are named in a way that makes it difficult to understand what the method does. No module or superclass is used to help reduce repeated code across repository classes.  |  Methods are often longer than 7 lines, do not have single responsibilities, and the code is generally difficult to read.
**Testing** | Mocks and stubs are used to ensure that classes can be tested without relying on functionality from other classes | Every method is tested at both the unit and integration level. git history demonstrates students are writing tests before implementation code. | Every method is not tested. git history does not demonstrate students are writing tests before implementation code. |  Less than half of the methods in any given class are untested or have tests that don't verify expected behavior.

## Version Control

**Exceptional**:

Students implemented a code review process for their pull requests in which each partner made suggestions for improvements, and those improvements were then integrated into the PR before it was merged. Students integrated [HoundCI](https://houndci.com/) into git workflow.

**Successful / Passing**:

Students contributed roughly equally to the project in terms of number of commits and lines of code. Commits are made in small chunks of functionality. Students used pull requests as a collaboration tool by reviewing each other's PRs, making comments, and never merging their own PRs.

**Below Expectations**:

Project has too few commits, does not use a PR workflow, students did not contribute roughly equally to the codebase, used large commits, poor PR messages.

