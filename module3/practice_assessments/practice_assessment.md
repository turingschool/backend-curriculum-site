---
layout: page
title: Module 3
subheading: Practice Assessment
length: 90
tags: json, javascript, rails, ruby, api
---

In this assessment you will:

*   Demonstrate mastery of all parts of the Rails stack
*   Demonstrate mastery of Ruby throughout the process
*   Integrate a 3rd Party API
*   Write tests for the added features

## Preparation

We'll be working off of [`Destination Planner`](https://github.com/turingschool-examples/destination-planner)

```
git clone git@github.com:turingschool-examples/destination-planner.git
cd destination-planner
bundle install
bundle exec rake db:{create,migrate,seed}
bundle exec rails server
```

We will be using the [OpenWeatherMap API](https://openweathermap.org/api). Sign up for an api key and familiarize yourself with the documentation.


## Assessment Challenges

Work through the following challenges and get as far as you can in the allotted time.

### 1. Search 10 Day Weather Forecasts for cities

```
As a user
When I visit "/"
And I click on a destination
Then I should be on page "/destinations/:id"
Then I should see the destination's name, zipcode, description, and 10 day weather forecast
The weather forecast is specific to the destination whose page I'm on
The forecast should include date (weekday, month and day), high and low temps (F), and weather conditions
```

### 2. Create an External API for the `Destination` resource

-   RESTful routes should be created to `get`, `show`, `create`, `update`, and `destroy` destinations.
-   Routes should render JSON or an HTTP status code depending on their purpose.
-   These routes should be namespaced under `/api/v1/`.
-   Request specs should be driving the creation of these routes.
- Make sure `create`, `update`, and `destroy` work through Postman

## Evaluation Criteria

As a refresher, evaluation criteria is located [here](./practice_assessments/assessment_info).
