---
layout: page
title: Extracting a Proxy Service
---

In this workshop we're going to implement the "proxy" model of a service.

* We'll start with a single "monolithic" application.
* We'll identify a chunk of functionality to extract
* We'll ensure/improve the test coverage
* We'll build a service application
* We'll proxy the work from the primary app to the service

This work should be completed in pairs and will likely take 4-6 hours.

## Setup

We'll use a project called the Monsterporium:

* Clone it from <https://github.com/turingschool-examples/store_demo>
* Read the README for setup instructions

## Work Plan

### Getting Started

* Explore the Ratings functionality in Monsterporium (M)
* M: Review the existing test coverage
* M: Write at least one acceptance test
* M: Review the Ratings schema

### A Second Application

* Create a second Rails application for our Service (S)
* S: Implement a similar model schema
* S: Implement a barebones API controller to SHOW ratings for a product
* S: Create a rating manually from the console

### Stitching Them Together

* M: Manually fetch the rating from the console
* M: Experiment from the `Rating` model to dynamically read ratings
* M: Revise the `Product` model to match your new `Rating`
* M: Prove that the Monsterporium still works correctly with your acceptance tests

### Challenges from the Front-End

With the basic read in place, you can consider the following challenge or move on directly to the next section.

* Move the API read so it happens from the front-end JavaScript and not the Monsterporium backend app

### Writing Ratings Remotely

* S: Write a controller test to demonstrate the creation of ratings via the API
* S: Implement the controller functionality to make it work
* M: Send the API create request directly from the controller (along with continuing to store it locally)
* M: When it works, push the API request down to the model

### Big Finish

* M: Remove any functionality from the `RatingsController` that isn't used
* M: Remove the `ActiveRecord::Base` inheritance from `Rating`
* M: Remove anything unnecessary from `Rating`
* M: What functionality have we lost? Do we need it? If so, how would/should we bring it back?

### Finishing Touches

* M: If you haven't implemented it already, fetch the ratings via JavaScript when displaying a product
* M: Instead of POSTing the ratings from the Model, send them directly from the form via JavaScript
* M: Can you wrap the `Rating` model into a gem?
