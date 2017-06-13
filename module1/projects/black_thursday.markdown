---
layout: page
title: Black Thursday
---

Black Thursday
===============

A business is only as smart as its data. Let's build a system able to load, parse, search, and execute business intelligence queries against the data from a typical e-commerce business.

Project Overview
-----------------

### Learning Goals

*   Use tests to drive both the design and implementation of code
*   Decompose a large application into components
*   Use test fixtures instead of actual data when testing
*   Connect related objects together through references
*   Learn an agile approach to building software

### Getting Started

1.  One team member forks the repository [here](https://github.com/turingschool-examples/black_thursday) and adds the other(s) as collaborators.
2.  Everyone on the team clones the repository
3.  Create a [Waffle.io](http://waffle.io) account for project management.
4.  Setup [SimpleCov](https://github.com/colszowka/simplecov) to monitor test coverage along the way

### Spec Harness

This project will be assessed with the help of a [spec harness](https://github.com/turingschool/black_thursday_spec_harness). The `README.md` file includes instructions for setup and usage. Note that the spec harness **is not** a replacement for your own test suite.

### Key Concepts

From a technical perspective, this project will emphasize:

*   File I/O
*   Relationships between objects
*   Encapsulating Responsibilities
*   Light data / analytics

### Project Iterations and Base Expectations

Because the requirements for this project are lengthy and complex, we've broken
them into Iterations in their own files. Your project *must* implement iterations 0 through 3 and either 4 or 5.

*   [Iteration 0](black_thursday_iterations/iteration_0) - Merchants & Items
*   [Iteration 1](black_thursday_iterations/iteration_1) - Beginning Relationships and Business Intelligence
*   [Iteration 2](black_thursday_iterations/iteration_2) - Basic Invoices
*   [Iteration 3](black_thursday_iterations/iteration_3) - Item Sales
*   [Iteration 4](black_thursday_iterations/iteration_4) - Merchant Analytics
*   [Iteration 5](black_thursday_iterations/iteration_5) - Customer Analytics

Evaluation Rubric
------------------

The project will be assessed with the following guidelines:

### 1. Ruby Syntax & Style

*   4:  Application demonstrates excellent knowledge of Ruby syntax, style, and refactoring
*   3:  Application shows strong effort towards organization, content, and refactoring
*   2:  Application runs but the code has long methods, unnecessary or poorly named variables, and needs significant refactoring
*   1:  Application generates syntax error or crashes during execution

### 2. Breaking Logic into Components

*   4: Application is expertly divided into logical components each with a clear, single responsibility
*   3: Application effectively breaks logical components apart but breaks the principle of SRP
*   2: Application shows some effort to break logic into components, but the divisions are inconsistent or unclear
*   1: Application logic shows poor decomposition with too much logic mashed together

### 3. Test-Driven Development

*   4: Application is broken into components which are well tested in both isolation and integration using appropriate data
*   3: Application is well tested but does not balance isolation and integration tests, using only the data necessary to test the functionality
*   2: Application makes some use of tests, but the coverage is insufficient
*   1: Application does not demonstrate strong use of TDD

### 4. Functional Expectations

*   4: Application implements iterations 0, 1, 2, 3, (4 or 5), and features of your own design
*   3: Application implements iterations 0, 1, 2, 3, and either 4 or 5
*   2: Application implements iterations 0, 1, 2, and 3
*   1: Application does not fully implement iterations 0, 1, 2, and 3

### 5. Code Sanitation

The output from `rake sanitation:all` shows...

*   4: Zero complaints
*   3: Five or fewer complaints
*   2: Six to ten complaints
*   1: More than ten complaints  

### 5. Version Control  
<!--  (doesn't apply to all projects, but a good spot for project-specific rubric requirements) -->  
* 4: Student demonstrates strong git workflow, commits frequently to document progress, uses commits to identify added functionality, and utilizes pull requests for communication and feedback  
* 3: Student utilizes git workflow essentials, committing frequently to document progress
* 2: Student adds and commits infrequently and pushes project to GitHub  
* 1: Student makes an initial commit and pushes project to GitHub  

