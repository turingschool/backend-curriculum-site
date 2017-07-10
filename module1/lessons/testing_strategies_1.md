---
layout: page
title: Testing Strategies 1
tags: basics, testing, encapsulation
length: 60
---

# Testing Strategies, or: How to help testing help us

## Learning Goals

* Understand that TDD is about asking questions and making decisions
* Understand the role of TDD in streamlining the problem-solving and design process.
* Be able to explain and apply the "two-mindset approach" to TDD
* Be able to name and explain the four key types of tests


### Vocabulary  
* Unit Tests  
* Integration Tests  
* Feature Tests
* Acceptance Tests

### Structure  
* 5min - WarmUp  
* Testing Patterns  
* Hierarchy of Tests  
* 5min - WrapUp  

### WarmUp  
* What is your current workflow in regards to testing and writing code?  
* What are some benefits of writing tests before your code?  
* What are some different types and purposes of your tests?  

### Testing Patterns  

It can be especially difficult to get started on a new project or even a new iteration of a project. The essence of testing is asking questions

### Hierarchy of Tests

[TestPyramid](http://martinfowler.com/bliki/TestPyramid.html)

![TestPyramid](http://martinfowler.com/bliki/images/testPyramid/test-pyramid.png)

* Unit
* Integration
* Feature
* Acceptance

*Unit Test* - tests one component in isolation.
*Integration Test* - tests multiple interdependencies or coordinating components.
*Feature Test* - a single feature as experienced by a user.
*Acceptance Test* - a collection of user functionalities that delivers business value.

Feature and Acceptance Tests are customer-centric while Unit and Integration Tests are programmer-centric.
Especially when you move into web development projects in later modules you'll rely more heavily on Acceptance and
Feature tests to verify the behavior of your application as it will eventually be experienced by a user.

In Module 1, on the other hand, we will rely much more heavily on **Unit** and **Integration** tests -- and it's very
important to have a good mix of both!

### WrapUp  
* How does letting tests drive your development lead you to stronger code?  
* What are the four types of tests?  What is the role of each type of test?  
