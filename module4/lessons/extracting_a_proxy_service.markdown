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

* Clone it from https://github.com/turingschool-examples/store_demo
* Read the README for setup instructions

## Work Plan

* Explore the Ratings functionality
* Review the existing test coverage
* Write at least one acceptance test
* Review the Ratings schema
* Create a second Rails application
* Implement a similar model schema
* Implement a barebones API controller
* Experiment from the Monsterporium console
* Experiment from the Monsterporium `Rating` model
* Implement lookups in the `Rating` model
* Revise the `Product` model to match your new `Rating`
* Remove the old rating artifacts
* Prove that the Monsterporium still works correctly with your acceptance tests
* Extension: pull the `Rating` model out to a gem that your Monsterporium relies upon
