---
layout: page
title: SortingCards - Evaluation Rubric
---

## Functionality

* **4** Student completes all functionality in iterations 1 through 4.
* **3** Student completes all functionality in iterations 1 through 3.
* **2** Student completes all functionality in iterations 1 and 2.
* **1** Student does not complete all functionality in iteration 2.

If a student does not complete a significant portion of iteration 3, then it is likely that other rubric categories will not score greater than a 2. If a student has not completed a significant portion of the project, an instructor may also decide not to assign grades for the remainder of the rubric.

## Mechanics

* **4** A project at this level meets all of the requirements of a 3, but also likely incorporates significant improvements not covered in class in a way that is appropriate and not simply for the sake of adding new things.

* **3** A project at this level meets the following criteria:

    * Generally uses Ruby's built-in data types and their methods appropriately.
    * The student uses alternatives to `each` in order to streamline their code, or uses each to iterate through collections in a way that demonstrates a strong understanding of enumeration.
    * Students use conditional statements to manage the flow of information through the program.
    * The student also uses instance variables to store state, and not in places where return values would be a better option to transfer data that will only be used temporarily.

* **2** A project at this level:

    * May use a limited number of enumerables, or may use them inappropriately (e.g. failing to use return values for enumerables designed to return a new collection or value).
    * The student uses classes, but may define their own methods to access instance variables instead of utilizing `attr_reader`s.
    * Flow control structures may be unnecessarily complicated.
    * A project at this level may also create unnecessary instance variables.

* **1** A project at this level likely has limited functionality. The student has been unable to use Ruby to accomplish the task assigned.

## Design

* **4** A project at this level meets all of the requirements of a 3 level project. In addition:

    * The student has implemented strategies not yet covered in class to further clean up their code.
    * They can speak to the way the tools they used have reduced duplication, or complexity, or otherwise improved their code and why they consider these approaches an improvement.
    * They can also speak to the benefits and potential drawbacks of the approach they've taken.
    * A project at this level may have also implemented a linter, static code analysis tool, or benchmarking.

* **3** While there may be occassional lapses, a project at this level generally:

    * Separates functionality between classes in a way that allows people unfamiliar with the project to quickly understand the main responsibility of each class,
    * Includes methods that are well named and clearly have a single responsibility that can be described concisely,
    * Implements methods at different levels of abstraction allowing students to separate high level logic from low level implementation details.
    * Additionally, methods are easy to read and a person unfamiliar with the project can determine what they do fairly quickly. In order to facilitate this, methods are generally less than 7 lines long and lines of code are generally no longer than 80 characters.
    * A project at this level includes a `lib` and a `test` directory and the files that a student has included in both places adhere to convention in both their name and content.

* **2** Projects at this level

    * May suffer from frequent use of long, or poorly named methods.
    * Students may struggle to describe the single responsibility of a particular method or class.
    * Methods may be difficult to understand due to poorly named variables, complex logic, or an under-use of helper methods.
    * File and class names may consistently not follow convention.

* **1** A project at this level does not demonstrate an attempt by the student to create code that can be understood by others following the conventions of object oriented programming in Ruby. It is possible for a project at this level to `work`, but it may be difficult to see exactly how it is working. Code may be stored in unexpected places, or the code itself may be difficult to decipher.

## Testing

* **4** A project at this level meets all the requirements of a level 3 project. In addition, a student has implemented additional strategies to simplify, speed up, or organize their test suite. A project at this level implements strategies not specifically taught in class, and the student can speak to the advantages of using the strategies they have implemented. A project at this level always uses the most specific assertion available to a student (e.g. the student does not `assert_instance_of` when they have access to the actual object expected to be returned and could instead assert equality).
* **3** A project at this level:

    * Includes tests that verify the functionality of the majority of methods in the project.
    * Students have included tests at both the unit and integration level.
    * The student demonstrates that they are proficient in using Minitest to make assertions about their code.

* **2** A project at this level:

    * Includes a test suite, but students may not be able to point to a method that tests at either an integration or unit level.
    * Students may have difficulty describing what a test has verified, and assertions may frequently not be testing what a student or the test name indicates.

* **1** A project at this level likely either has either few or no tests, or the tests that are included do not work. In either case, the test suite does not sufficiently test the application.

## Version Control

* **4** The student has met all the requirements described below to achieve a 3, and:

    * Has also used a branching workflow with well named branches that are each based on specific pieces of functionality,
    * Has included descriptive messages for each of their pull requests on GitHub.
    * The student may have used GitHub as a tool to discuss code by requesting reviews from mentors on pull requests.

* **3** The student hosts their code on GitHub on their master branch, and their commit history demonstrates that they have made commits in small chunks of functionality.
* **2** A project at this level may not clearly demonstrate that the student has made commits in small chunks of functionality, or the code that a student wants reviewed might not be on the master branch.
* **1** A project at this level likely either has 3 or fewer commits, or the code is not hosted on GitHub.
