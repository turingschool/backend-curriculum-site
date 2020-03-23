---
layout: page
title: Rails Engine Evaluation
length: 1 week
tags:
type: project
---

### Feature Delivery

* 4: Project completes all requirements and at least one extension.
* 3: Project completes all requirements
* 2: Project fails to complete 1 - 3 required endpoints
* 1: Project fails to complete more than 3 endpoints

### Test Driven Development

* 4: Project achieves 100% test coverage at the unit and integration levels
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

## Peer Review

Complete the following sections independently.

### Setup

First,

* Clone down your partner's project
* Set up your partner's project

Then, answer the following questions:

* Was your partner's project easy to set up? Why or why not?
* Do they have a clear README? What sort of things should be included to make the set up more clear?

### Rake Task

Run your partner's rake task. Open up the rake task and look it over.

Then, answer the following questions:

* Does the rake task work? How do you know?
* Is the rake task readable? Is it DRY? What are some improvements you could make to the rake task?

### Endpoints

Run the spec harness in Rails Driver against your partner's app. Look through their code as well.

Then, answer the following questions:

* How many endpoints failed the spec harness? Why did they fail?
