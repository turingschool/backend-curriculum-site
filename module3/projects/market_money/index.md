---
layout: page
title: Market Money
length: 1 week
tags:
type: project
---

## Project Description

You are working for a company developing an interface to help people find sustainable and local alternatives for their lifestyle in their area. One of their features to encourage supporting local growers/crafters/etc., is a Farmers Market lookup. Your company uses a Micro Service Architecture, and needs you to build out the service that is responsible for providing functionality for Farmers Market & Vendors. 

Your job is to expose the data that powers this part of the site through an API that the front end would consume. You won't be building an actual front end for this project.

## Learning Goals

Below are technical goals that you should be applying in this project.<br>
The priority of these goals are demonstrated using a star grading system.<br>
By the end of this project: <br>
  Student should have a functional understanding of the concept ⭐ ⭐ ⭐ <br>
  Student should have a familiar understanding, but may still have questions ⭐ ⭐ <br>
  Student should know of the concept, but need further resources to implement ⭐

* Expose an API ⭐ ⭐ ⭐
* Use serializers to format JSON responses ⭐ ⭐ ⭐
* Test API exposure ⭐ ⭐ ⭐
* Error Handling ⭐ ⭐
* Use SQL and AR to gather data ⭐ 
* Consume an API ⭐


_Note: See [Learning Goals](../../misc/learning_goals) to see at what level these skills need to be by the final._


### Implicit
Below are skills that are more general/necessary on the job that are practiced by completing the goals above.

* Reading Documentation
* Time Management
* Prioritizing Work
* Breaking down large project into small pieces
* Breaking down a problem into small steps
* Practice individual research (articles, videos, mentors)

## Postman

We have created a fully functional test suite right within Postman. By importing the JSON files noted below, you can open the Postman "Runner" and execute a large suite of tests.

**Note: The Postman tests are NOT a replacement for writing your own tests.**
#### Importing the Test Suite

Download the test suite for Postman:
* [Market Money Test Suite](./market_money.postman_collection.json)

Click on the link to load it in your browser, then hit Cmd-S to save it to your system.

In Postman, in the top left corner, click on the "Import" button, and use the file selector to locate the two files on your operating system.

Next, you'll "confirm" the import. The test suite should display as a "Postman Collection v2.1" and import as a "Collection". Click the "Import" button to continue.

Within your collections in Postman, you should see one collection-- "Market Money".

### Running the Tests

There are two ways to run the test suite: one endpoint at a time, or the whole suite.

#### Running one endpoint at a time

As you develop your endpoints, run `rails s` and find the appropriate endpoint within the Postman collection you imported. For example, "Get All Markets". When you select "Get All Markets" from the list, you should see a Postman tab open, pre-populated with everything you need to connect to the endpoint in your code and see if it works correctly.

Click the "Send" button in the top right corner. **Note: Due to the large sum of Markets in the database, this request will take some time, and it will be the most time consuming request you have.**

In the lower portion of the Postman interface, you should see "Body", "Cookies", "Headers" and a spot that says something like "Test Results (3/3)". This would indicate that 3 tests passed out of 3. If you see, for example, 1/3 then 1 test passed and 3 did not.

You can click on the "Test Results (3/3)" to see which tests passed.

The error messages aren't that great, but we're here to help you diagnose the problems.

#### Running the full test suite

When you hover over the `Market Money` Collection on the left hand side of your Postman interface, you'll see three dots pop up. Click those three dots, and select `Run Collection`. This will show you a check list of all the requests that are in that collection. 

From there, you can select any requests you wish to run at once. If you want to run the entire test suite, simply check all the boxes, and press the blue `Run Market Money` button. 

As it runs, it will show you which tests are passing or failing. Remember, that first request to `Get all Markets` will take a good chunk of time. I've noticed that if I pull up my terminal where my local server is running, the request seems to go faster. 


## Technical Requirements

The Technical Requirements for this project can be found [here](./requirements).

## Extensions

After you've completed ALL 11 endpoints, you can find some extra practice ideas [here](./extensions).

## Evaluation

Evaluation details can be found [here](./evaluation).