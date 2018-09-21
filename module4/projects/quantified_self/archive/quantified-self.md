---
layout: page
title: Quantified Self
subheading: A calorie tracker project for the fourth module
---

## Introduction

Pearson's Law:

> "That which is measured improves. That which is measured and reported improves exponentially." - Karl Pearson

Technology has enabled us to measure more, and shorten the period between measurement and reporting. Sensors are cheaper and smaller, computers are everywhere, and we can access data from anywhere. People who have recognized this, and applied it to themselves are part of a movement called "Quantified Self."

You are going to build a simple calorie tracker.

## Learning Goals

* Students apply knowledge of Ruby collections to JavaScript arrays
* Students create and use functions with parameters
* Students apply good coding conventions to JavaScript functions
* Students organize functions into classes and objects
* Students make effective use of `this` in multiple contexts
* Students unit test JavaScript
* Students use event listeners to attach code to event-element combinations including document-ready and element-click
* Students write precise CSS-style selectors in multiple contexts like DOM manipulation and integration testing
* Students read form content and manipulate DOM via JavaScript
* Students integrate outside data sources in the browser (Fetch, local storage)
* Students use integration testing to verify JavaScript functionality
* Students implement a stand-alone web service with Node and Express
* Students interact with SQL databases by writing raw SQL
* Students use pull requests to organize discussion about features
* Students implement feedback from a code review to improve quality
* Students use an agile process to turn acceptance requirements into deployed software

### Requirements Overview

Your requirements for the application are detailed in the cards **you're going to import to Pivotal Tracker** (you can also find them [here](./quantified-self-tracker-stories.csv)), but here's an visual of what you're doing:

#### Layouts

You'll be building two main layouts for this project. A "foods" index page and a "diary" index page (as seen below).

### **Manage Foods**

![quantifed-self-resource-management.png](quantified-self-resource-management.png)

### **Main Diary**

![quantified-self-diary.png](quantified-self-diary.png)

#### Broad Front End features

- CRUD foods
- Add a food to a meal
- Compare calories to goals (meal and total)
- View calorie calculations in diary
- The page must not refresh while users are interacting with it
- Data persists across refreshes
- EXTENSION: Build an admin panel to manage data
- EXTENSION: Add offline functionality

#### Broad Back End features

During the two weeks of this project, you'll get the opportunity to build this API
for three interations. First, you'll build it in Rails. Second, you'll build it using
Node, Express, and Knex. Lastly, you'll use a wild card programming language to stretch
skills a little more.

### Getting your project started

- You'll have two separate code bases to complete this project. You'll have a code base for your front end and a separate code base for your back end. You may run into some errors when trying to communicate between the two code bases (most likely CORS problems), but we'll address this in class when we discuss Fetch.
- We'll be starting with the front end so you'll want to follow the instructions on the [Quantified Self Starter Kit](https://github.com/turingschool-examples/quantified-self-starter-kit) to get your codebase going.
- When you start to re-build the backend with Node, you'll start your new backend repository from scratch.
- You'll need to accept your email invitation from Pivotal Tracker and use this as your Project Management tool.
- Import [this CSV](./quantified-self-tracker-stories.csv) to your project to get all the cards in there. Import is found under settings. Note - these user stories are for the functionality dealing with the front end only. When you get to the backend, you'll need to write your own stories.
- Add your assigned Technical Lead to your Pivotal Tracker and your repository.

### Expectations

- Use whatever you've used in the past for schema, documentation and user stories. Or something new you've been wanting to try out. These things are graded on completion. Probably want to agree on a format in your DTR.
- Allowed libraries are jQuery, lodash/underscore, and moment.
- Logic like sorting, filtering, and validation should be done without using another library (except those listed in the previous point). These are great opportunities to abstract logic for unit tests.
- All elements from the mockup should be represented in your app, even if the styling or layout is different.  Unless it is mentioned specifically in the user stories, colors and other styling are up to you. You'll be just fine if it looks exactly like the mockup though.
- **Details, Details, Details!!!** If it's in the user stories, we're looking for it in your app. Please ask before you add any additional functionality. The job is to build what is asked for, and get any improvements approved first.
- This is a 2 week project without any scheduled instructor check ins. We expect that you'll be tagging instructors in PRs on Github wherever you'd like feedback. We also expect that if you feel like your team is falling behind, that you'll reach out for extra support.

### Tips for success

- Use HTML/CSS classes when changing styling, instead of changing the styling of an element directly.
- Experiment with ES6, but try to be consistent in each file whether you're using ES6 or ES5. Probably the most useful thing in ES6 is string interpolation and multi-line strings, neither of which are supported in ES5.
- There is similar functionality across elements in the app. Make your code DRY, but don't over do it. Sometimes the functionality differs slightly.
- Plan, diagram and break down the problem, but don't try to get it right the first time. Don't write too much code without refactoring. Maybe stop and refactor every so many minutes, or so many cards.
- A lot of this is new, and you'll probably have to be pairing more often, or at least be available to each other remotely.
- Materialize is just a headache, but we can't stop you from using it. Use whatever tool you'd like for styling.
- Research `content-editable`. It will save you a lot of time for the editing foods functionality.
- There's a lot in this document. Refer back frequently.
- If there's any question about functionality, ask. There's a [#qs-questions](slack://channel?team=T029P2S9M&id=C3VFECP60) channel specifically for this.

## Challenges

- Create a full-stack JS application across two codebases
- Be able to organize your JS across different files
- Make Fetch calls to connect your front-end with your back-end
- Handle events
- Handle events fired on DOM elements that didn't exist at load
- Manage state via jQuery
- Handle multiple DOM and data changes on single event
- Write unit and integration tests in Javascript
- Start to understand how full-stack JS applications work in practice, without a whole lot of explicit explanation

## Rubric

You will be subjectively (Friday of Week Three via Github) graded by an instructor on the criteria below. You'll need to self assess on this rubric when submitting your final project [here](https://github.com/turingschool/ruby-submissions/tree/master/1710-b/4module/quantified_self).

### Specification Adherence

Application implements **all** functionality as defined, but some bugs or strange behavior where features intersect.

- Above Expectations
- Meets Expectations
- Below Expectations

### Documentation

Developer provides easy to navigate documentation showing how to setup and contribute to the application (for _both_ front-end and back-end repos).

- Above Expectations
- Meets Expectations
- Below Expectations

### HTML/UI

The team put some effort into styling, and the application is not confusing to use (including, but not limited to, user should **not** have to type anything into the URL to go between pages). HTML classes and IDs are kebab case.

- Above Expectations
- Meets Expectations
- Below Expectations

### Accessibility

Developer implements code to increase accessibility (your app should have 0 violations according to aXe).

- Meets Expectations
- Below Expectations

### JS syntax and Style

JavaScript code is logically divided into files. Developers can show examples of good coding practices and demonstrate OOP concepts, like DRY and separation of concerns. Developers pay attention to indentation and naming conventions. They also _consistently_ utilize ES5 or ES6 syntax and jQuery when working with events.

- Above Expectations
- Meets Expectations
- Below Expectations

### Git Workflow

The team uses master for production, uses feature branches for small groups of cards, and has a pull request for each feature with good context and conversation, following the template. Commit messages are in the present tense, and start with a capital letter. Developers that aren't on the team have commented on PRs.

- Above Expectations
- Meets Expectations
- Below Expectations

### Project Management

The team is using Pivotal Tracker to keep their project organized and to track progress. Team is documenting conclusions and timelines on relevant cards.

- Above Expectations
- Meets Expectations
- Below Expectations

### Communication

The team consistently reaches out to their Technical Lead for feedback on code quality and technical issues. The team responds to their Technical Lead in a timely manner. The team implements feedback from Technical Lead around pacing, refactors, workflow, etc.

- Above Expectations
- Meets Expectations
- Below Expectations

### Extensions: Risk Taking

Adhering to any of these additional specifications will allow you to increase one score above:

#### All functionality is part of a class, written using ES6

You'll learn about classes and ES6 during the course of this project. If you can fit all of your JS into classes, using ES6 syntax, you'll get one extra point to add to a rubric score.

#### No Libraries (except for testing).

A big part of this project is writing JS functionality that you could have borrowed from a library. We've listed a few allowed libraries above. jQuery is still used in most legacy codebases, and JS is sorely missing most time manipulation. Accepting this challenge will require you to write more code, but it will give you a better handle one what is built into JS.

The exception is testing. There's not any reasonable way you'll be able to test without mocha and selenium.

#### Multiple Sources of Truth

Local Storage is often used for "offline" functionality. When the user is having trouble connecting to the internet, the application will continue to function. When a connection is re-established, the local changes are uploaded to the server. Likewise, if changes are made on one client, they should be downloaded to another client

Use Local Storage and Fetch to meet the following requirements:

1. If I'm disconnected from the internet, I can continue to use the application.
1. When I make a change while disconnected from the internet, that change will be uploaded to the server when I reconnect
2. If I make a change on one computer, those changes should propagate to any other clients through the server. You do not need realtime functionality. These changes can occur after a refresh.

You will probably need to use a concept called `service workers`

#### Mircroservices

Instead of building a single service, build a series of microservices. Each microservice is a separate codebase and application that represents a single table in your schema. These applications communicate with each other via HTTP. Since they all live in the same datacenter, this is not much of a performance problem.

The architecture would look something like this:

![microservices-challenge](./microservices-challenge.png)

If you attempt this challenge, your planning and design should include your microservices architecture.

As to why you might want to do this, watch [Chad Fowler's Rocky Mountain Ruby 2015 talk](https://www.youtube.com/watch?v=-UKEPd2ipEk)
