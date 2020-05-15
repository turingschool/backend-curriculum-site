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
*   Integrate 3rd Party APIs
*   Write tests for the added features
*   Expose API endpoints

## Preparation

We'll be working off of [`Destination Planner`](https://github.com/turingschool-examples/destination-planner)

```
git clone git@github.com:turingschool-examples/destination-planner.git
cd destination-planner
bundle install
bundle exec rake db:{create,migrate,seed}
bundle exec rails server
```

## Practice Challenges

### 1. Current Weather

For this story, we will be using the [OpenWeatherMap API](https://openweathermap.org/api). Sign up for an api key and familiarize yourself with the documentation. Please note that it may take a while for your api key to be activated.

```
As a user
When I visit "/"
And I click on a destination
Then I should be on page "/destinations/:id"
Then I should see the destination's name, zipcode, description, and current weather
The weather forecast is specific to the destination whose page I'm on
The forecast should include date (weekday, month and day), current, high and low temps in Fahrenheit, and a summary (for example "light rain", "clear sky", etc.)
```

### 2. Weather Image

For this story, we will using the [Giphy API](https://developers.giphy.com/).

```
As a user
When I visit "/"
And I click on a destination
Then I should be on page "/destinations/:id"
Then I should see an image related to the current weather at the destination
```

**Note**: you have some flexibility here to determine what a "related" image might be.

### 3. Create an External API for the `Destination` resource

-   RESTful routes should be created to `index`, `show`, `create`, `update`, and `destroy` destinations.
-   Routes should render JSON or an HTTP status code depending on their purpose.
-   These routes should be namespaced under `/api/v1/`.
-   Request specs should be driving the creation of these routes.
-   Make sure `create`, `update`, and `destroy` work through Postman

### 4. Create External API endpoints for Destination Weather

-   Expose the information from challenges 1 and 2 in an api endpoint, including destination weather and a related image
-   Routes should render JSON or an HTTP status code depending on their purpose.
-   You have some freedom to determine what the JSON response looks like.
-   These routes should be namespaced under `/api/v1/`.
-   Request specs should be driving the creation of these routes.
