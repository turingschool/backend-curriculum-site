---
layout: page
title: Black Thursday - Evaluation Rubric
---

## Functionality

* **4** Students complete all iterations.
* **3** Students completes all functionality in iterations 0 through 3 and either iteration 4 or 5.
* **2** Students complete all functionality in iterations 0 through 3.
* **1** Students do not complete all functionality in iteration 3.

If a student does not complete a significant portion of iteration 3, then it is likely that other rubric categories will not score greater than a 2. If a student has not completed a significant portion of the project, an instructor may also decide not to assign grades for the remainder of the rubric.

## Mechanics

* **4** A project at this level meets all of the requirements of a 3, but also incorporates significant improvements not covered in class in a way that is appropriate and not simply for the sake of adding new things.

* **3** A project at this level accomplishes all of the following:

    * Mostly uses best choice enumerables for iterating over collections
    * Has both `SalesEngine::from_csv` and `SalesEngine::new` factory methods that allow the user to create a `SalesEngine` object with and without CSV files
    * Uses instance variables to store state, and not in places where return values would be a better option to transfer data that will only be used temporarily

* **2** A project at this level has one or more of the following characteristics:

    * Frequently uses enumerables that are not the best choice
    * Does not include both `SalesEngine::from_csv` and `SalesEngine::new` factory methods, or fails to implement one correctly
    * Creates unnecessary instance variables

* **1** A project at this level has one or more of the following characteristics:

    * The spec harness produces errors from iterations 0 - 3

## Design

* **4** A project at this level meets all of the requirements of a level 3 project and also accomplishes all of the following:

    * Implements at least 1 superclass and at least 1 module
    * Implements classes/modules not described in the project spec that ensure all classes are less than 100 lines of code, clearly have a single responsibility, and do not repeat any code
    * Implements benchmarking for each `SalesAnalyst` method described in the spec

* **3** A project at this level accomplishes all of the following:

    * While there may be occasional lapses, methods are mostly well named, less than 7 lines, and clearly have a single responsibility that can be described concisely
    * Utilizes at least one module or superclass to reuse code that is shared across the repository classes

* **2** Projects at this level has one or more of the following characteristics:

    * Many methods are long or poorly named
    * Students struggle to describe the single responsibility of a particular method
    * Does not utilize a module or superclass resulting in repeated code across the repository classes

* **1** A project at this level does not demonstrate an attempt by the student to create code that can be understood by others following the conventions of object oriented programming in Ruby. It is possible for a project at this level to `work`, but it may be difficult to see exactly how it is working. Code may be stored in unexpected places, or the code itself may be difficult to decipher.

## Testing

* **4** A project at this level meets all the requirements of a level 3 project and also:

    * Utilizes mocks and stubs to ensure that classes can be tested without relying on functionality from other classes

* **3** A project at this level accomplishes all of the following:

    * Includes tests for every method at both the unit and integration level.
    * Has a git history that clearly shows students are writing tests before implementation code

* **2** A project at this level does one or more of the following:

    * Includes a test suite that does not test every method
    * Has a git history that does not demonstrate students are writing tests before implementation code

* **1** A project at this level does one or more of the following:

    * Less than half of the methods in any given class are untested
    * Less than half of the methods have tests that do not accurately test the method's functionality


## Version Control

* **4** A project at this level meets the requirements of a level 3 project and its git history also shows all of the following:

    * Students integrate HoundCI into their workflow
    * Students implement a code review process for their pull request in which each partner makes suggestions for improvements, and those improvements are then integrated into the PR before it is merged

* **3** The git history of a project at this level shows all of the following:

    * Students contributed roughly equally to the project in terms of number of commits and lines of code
    * Students made commits in small chunks of functionality
    * Students used pull requests as a collaboration tool by reviewing each other's PRs, making comments, and never merging their own PRs

* **2** The git history of a project at this level shows one or more of the following:

    * Students did not contribute equally to the project in terms of number of commits or lines of code
    * Students did not make commits in small chunks of functionality
    * Students did not comment on their teammate's PRs
    * Students merged their own PRs

* **1** The git history of a project at this level shows one or more of the following:

    * Students made less than 10 commits
    * Students did not use pull requests
    * Students code is not hosted on the master branch of a Github repository
