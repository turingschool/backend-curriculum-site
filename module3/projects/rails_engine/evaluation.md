---
layout: page
title: Rails Engine Evaluation
length: 1 week
type: project
---

For the project eval, you should prepare a 10 minute presentation that clearly demonstrates each category of the below rubric. 

In the past, we had students record their presentation. This is not a requirement anymore. But, if you'd like to get an idea for what a good presentation might entail, you can take a look at these recorded presentations (these students have given their permission for these to be shared): 
1. [Example 1](https://www.loom.com/share/44b0adf2a5b54be5bd4d02405e43c98b)
2. [Example 2](https://www.loom.com/share/765f2cfbf4af49268cdee564e5d995db)


The technical presentation portion is outlined below with what points should be covered. If you have questions about the presentation, please let an instructor know before the time it's due.

You should review each section of the rubric and strive to have a 3 in each section before attempting any 4s.



## Presentation points:

[ ] Demonstration of functional completeness 
 * Run postman suite

[ ] Technical quality and organization of the code
 * Talk through one endpoint from section 1 and one endpoint from section 2 (routing, controllers, serializers, error handeling, etc.)
 * Is there a design decision that you made that you're particularly proud of? 

[ ] Identifying code that should be refactored and how it would be refactored
 * Identify a piece of code that you'd like to refactor. How would you update that code?
 * Are there any parts of your code that you're unsure/hesitant about? Why?

[ ] Discussion of test coverage 
 * Show examples of happy and sad path and edge cases
 * Run your test suite and open coverage report 

[ ] Approach to their ActiveRecord queries
 * Talk through 1-2 queries from section 3. 
 * Did you create any queries that used ruby, when they could have used ActiveRecord?



## Rubric

### Technical Presentation

* 4: The student has a well organized presentation that addresses each point directly and uses technical vocabulary correctly throughout the presentation.
* 3: Student presents their code and is able to talk about all the presentation points.
* 2: Student presents their code and is able to talk about 3-4 of the presentation points.
* 1: Student is unprepared for the presentation and requires prompts from the instructor to talk about the code.

### Feature Delivery

* 4: Project completes all requirements and at least one extension.
* 3: Project completes all requirements
* 2: Project fails to complete 1 - 3 required endpoints
* 1: Project fails to complete more than 3 endpoints

### Test Driven Development

* 4: Project achieves 100% test coverage at the unit and integration levels. The tests include sad path and edge case testing.
* 3: Project achieves greater than 90% test coverage
* 2: Project achieves greater than 80% test coverage
* 1: Project does not have 80% test coverage.

### Technical Quality

* 4: Project demonstrates exceptionally well factored code.
* 3: Project demonstrates solid code quality and MVC principles.
* 2: Project demonstrates some gaps in code quality and/or application of MVC principles.
* 1: Project demonstrates poor factoring and/or understanding of MVC.

### ActiveRecord

* 4: Project makes good use of an advanced ActiveRecord concept not taught in class
* 3: Project demonstrates good use of ActiveRecord using no ruby to process data that could otherwise be done by the database
* 2: Project makes good use of `ActiveRecord`, but drops to ruby enumerables for some query methods.
* 1: Project frequently uses Ruby where ActiveRecord could be used, or fails to use ActiveRecord effectively
