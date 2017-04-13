---
layout: page
title: Module 3 Assessment
---

# Module 3 Assessment

In this assessment you will:

* Demonstrate mastery of all parts of the Rails stack
* Demonstrate mastery of Ruby throughout the process
* Write tests for the added features

## Areas of Knowledge

Areas to be tested is explained in the [Areas of Knowledge](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/assessment.md#areas-of-knowledge) section of the Assessment doc.

## Expectations

Criteria is explained in the [Expectations section](http://backend.turing.io/module3/lessons/assessment#expectations) of the Assessment doc.

## Preparation

You should have worked through the [Setup](http://backend.turing.io/module3/lessons/assessment#setup) in the Assessment doc.

## Assessment Challenges

Work through the following challenges and get as far as you can in the allotted time. The first section is easier so it should not take half the time if you plan on finishing both.

### 1. Create an API

For this challenge clone [Storedom](https://github.com/turingschool-examples/storedom).

We need an API for the application that can both read and write data. Start by focusing on functionality for items. All of this should happen in a dedicated, versioned controller.

When I send a GET request to `/api/v1/items`
I receive a 200 JSON response containing all items
And each item has an id, name, description, and image_url but not the created_at or updated_at

When I send a GET request to `/api/v1/items/1`
I receive a 200 JSON response containing the id, name, description, and image_url but not the created_at or updated_at

When I send a DELETE request to `/api/v1/items/1`
I receive a 204 JSON response if the record is successfully deleted

When I send a POST request to `/api/v1/items` with a name, description, and image_url
I receive a 201 JSON  response if the record is successfully created
And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at

* Verify that your non-GET requests work using Postman or curl. (Hint: `ActionController::API`). Why doesn't the default `ApplicationController` support POST and PUT requests?

### 2. Consume 3rd party API

For this challenge you'll implement a lookup feature for storedom. We want to be able to search and return Best Buy locations in our area.

We need to consume data from the BestBuy Api. Start by checking out the [BestBuy developer documentation](https://developer.bestbuy.com/). You should have received a Best Buy API key from an instructor.

Once you're done getting your key, use the [Stores documentation](http://bestbuyapis.github.io/api-documentation/#stores-api) to meet the requirements below.

* It's not necessary, or even advised, that you store anything in a database from the Best Buy API.
* Display the returned stores and their attributes returned from the API query in a logical and intuitive HTML layout. (This does not need to be styled).

```
As a user
When I visit "/"
And I fill in a search box with "80202" and click "search"
Then my current path should be "/search" (ignoring params)
And I should see stores within 25 miles of 80202
And I should see a message that says "16 Total Stores"
And I should see exactly 10 results
And I should see the long name, city, distance, phone number and store type for each of the 10 results
```

#### Bonus

If you finish the other stories, things are refactored, and want an extra challenge, try this out.

```
(This is a continuation of the story above)

And I should see pagination links below the search results for the number of pages (2 in this case)
And `1` is my current page but isn't a clickable link
And `2` is a clickable link
When I click `2`
Then I should be taken to the next page of search results
Then my current path should be "/search" (ignoring params)
And in the params I should see `page=2`
And I should see stores within 25 miles
And I should see a message that says "16 Total Stores"
And I should see the next 6 results
And I should see the long name, city, distance, phone number and store type for each of the next 6 results
```

## Evaluation Criteria

The criteria is located in the [Assessment](http://backend.turing.io/module3/lessons/assessment) file.

