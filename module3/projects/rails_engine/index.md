---
layout: page
title: Rails Engine
length: 1 week
tags:
type: project
---

## Project Description

You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

## Learning Goals

### Explicit

Below are technical goals that you should be applying in this project.<br>
The priority of these goals are demonstrated using a star grading system.<br>
By the end of this project: <br>
  Student should have a functional understanding of the concept ⭐ ⭐ ⭐ <br>
  Student should have a familiar understanding, but may still have questions ⭐ ⭐ <br>
  Student should know of the concept, but need further resources to implement ⭐

* Expose an API ⭐ ⭐ ⭐
* Use serializers to format JSON responses ⭐ ⭐ ⭐
* Test API exposure ⭐ ⭐ ⭐
* Compose advanced ActiveRecord queries to analyze information stored in SQL databases ⭐ ⭐
* Write basic SQL statements without the assistance of an ORM ⭐

_Note: See [Learning Goals](../../misc/learning_goals) to see at what level these skills need to be by the final._

### Implicit
Below are skills that are more general/necessary on the job that are practiced by completing the goals above.

* Reading Documentation
* Time Management
* Prioritizing Work
* Breaking down large project into small pieces
* Breaking down a problem into small steps
* Practice individual research (articles, videos, mentors)

## Project Management

The organization of this project spec is by feature type. However, it is encouraged that you work through a little of each feature type rather than trying to complete an entire feature type before moving to the next. We encourage you to use an Agile approach as much as possible to complete this assignment, and to review the work and develop estimated milestones before you begin. **Any good set of milestones will allow for some slippage before the project is due.**

## Postman

We have adapted this project from previous cohorts and have rewritten a fully functional test suite right within Postman. By importing the JSON files noted below, you can open the Postman "Runner" and execute a large suite of tests.

**Note: not ALL of the Postman tests will be passing in order to pass the project**. You will need to examine the tests you NEED to run, since we're giving students some choice in how to build the application.

#### Importing the Test Suite

Download the test suites for Postman:
* [Rails Engine, Section 1](./RailsEngineSection1.postman_collection.json)
* [Rails Engine, Section 2](./RailsEngineSection2.postman_collection.json)
* [Rails Engine, Section 3](./RailsEngineSection3.postman_collection.json)

Click on each link to load it in your browser, then hit Cmd-S to save it to your system.

In Postman, in the top left corner, click on the "Import" button, and drag the downloaded JSON file over the interface or use the file selector to locate the file on your operating system.

Next, you'll "confirm" the import. The test suite should display as a "Postman Collection v2.1" and import as a "Collection". Click the "Import" button to continue.

On the left side of your Postman interface, you should see a "Rails Engine" entry with "19 requests".

#### Running the Tests

There are two ways to run the test suite: one endpoint at a time, or the whole suite.

#### Running one endpoint at a time

As you develop your endpoints, run "rails s" and find the appropriate endpoint within the Postman collection you imported. For example, "Get All Merchants". When you select "Get All Merchants" from the list, you should see a Postman tab open, pre-populated with everything you need to connect to the endpoint in your code and see if it works correctly.

Click the "Send" button in the top right corner.

In the lower portion of the Postman interface, you should see "Body", "Cookies", "Headers" and a spot that says something like "Test Results (7/7)". This would indicate that 7 tests passed out of 7. If you see, for example, 3/7 then 7 tests passed and 4 did not.

You can click on the "Test Results (7/7)" to see which tests passed.

The error messages aren't that great, but we're here to help you diagnose the problems.

**IMPORTANT** some of the endpoints include EDGE CASE testing, which should be saved as "extension" work.

#### Running the full test suite

In the bottom right corner of the Postman interface, you'll see a "Runner" button. Click that and a new panel will appear. From here, you can drag one of the three "Rails Engine" collections to the right side of the screen.

Next, you can select/deselect which tests you'd like to run. Finally, click the "Run Rails Engine" button.

As it runs, it will show you which tests are passing or failing.


## Technical Requirements

The Technical Requirements for this project can be found [here](./requirements)


## Extensions

Review the evaluation details to ensure you have completed each section of it before tackling any extensions. If all requirements have been met, then please work on the extensions found [here](./extensions)


## Evaluation

Evaluation details can be found [here](./evaluation)


## Peer Code Review

Instructions for the peer review can be found [here](./peer_code_review)
