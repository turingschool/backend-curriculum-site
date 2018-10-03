---
layout: page
title: Quantified Self - Rails
subheading: A calorie tracker project for the fourth module
---

## Introduction

Pearson's Law:

> "That which is measured improves. That which is measured and reported improves exponentially." - Karl Pearson

Technology has enabled us to measure more, and shorten the period between measurement and reporting. Sensors are cheaper and smaller, computers are everywhere, and we can access data from anywhere. People who have recognized this, and applied it to themselves are part of a movement called "Quantified Self."

You are going to build a simple calorie tracker.

## Learning Goals

* Create a Rails API given specified endpoints and response formats.
* Use a CI tool to check on build successes early and ofter.
* Follow the agile process, using a Pivotal Tracker board.
* Review and refactor code so that it:
    * is well organized
    * clearly communicates intent
    * utilizes abstraction to hide complexity
    * breaks problems down into small methods/functions with a single responsibility

### Requirements Overview

You will be creating a fully-tested API that supports a front-end that users will utilize to track calories in meals that they eat.

Your requirements for the application are detailed in the cards **you're going to create on Pivotal Tracker**.

### Background: The Front End

The application that consumes your API will have two main layouts. A "foods" index page and a "diary" index page (as seen below).

##### **Manage Foods**

![quantifed-self-resource-management.png](quantified-self-resource-management.png)

##### **Main Diary**

![quantified-self-diary.png](quantified-self-diary.png)

At a high level, users will be able to:

- CRUD foods
- Add a food to a meal
- Compare calories to goals (meal and total)
- View calorie calculations in diary
- Data persists across refreshes

### Back End Features

You will be building an API only for this iteration of Quantified Self. In the second iteration, you and a partner will build an Express server and build-out the front-end in JavaScript and jQuery. For now, let's focus on this Rails back-end:

- You'll start the repository from scratch.
- Create a Pivotal Tracker board and write stories for each of your endpoints.
- Add your assigned Technical Lead to your Pivotal Tracker and your repository.

You will need to build ten endpoints. All endpoints will return the data as JSON.

#### Food Endpoints:

**GET /api/v1/foods**

Returns all foods currently in the database

Each individual food will be returned in the following format:

```js
{
    "id": 1,
    "name": "Banana",
    "calories": 150
},
```

**GET /api/v1/foods/:id**

Returns the food object with the specific `:id` you've passed in or 404 if the food is not found

**POST /api/v1/foods**

Allows creating a new food with the parameters:

```js
{ "food": { "name": "Name of food here", "calories": "Calories here"} }
```

If food is successfully created, the food item will be returned. If the food is not successfully created, a 400 status code will be returned. Both name and calories are required fields.

**PATCH /api/v1/foods/:id**

Allows one to update an existing food with the parameters:

```js
{ "food": { "name": "Mint", "calories": "14"} }
```

If food is successfully updated (name and calories are required fields), the food item will be returned. If the food is not successfully updated, a 400 status code will be returned.

**DELETE /api/v1/foods/:id**

Will delete the food with the id passed in and return a 204 status code. If the food can't be found, a 404 will be returned.

##### Meal Endpoints:

**GET /api/v1/meals**

Returns all the meals in the database along with their associated foods

If successful, this request will return a response in the following format:

```js
[
    {
        "id": 1,
        "name": "Breakfast",
        "foods": [
            {
                "id": 1,
                "name": "Banana",
                "calories": 150
            },
            {
                "id": 6,
                "name": "Yogurt",
                "calories": 550
            },
            {
                "id": 12,
                "name": "Apple",
                "calories": 220
            }
        ]
    },
    {
        "id": 2,
        "name": "Snack",
        "foods": [
            {
                "id": 1,
                "name": "Banana",
                "calories": 150
            },
            {
                "id": 9,
                "name": "Gum",
                "calories": 50
            },
            {
                "id": 10,
                "name": "Cheese",
                "calories": 400
            }
        ]
    },
    {
        "id": 3,
        "name": "Lunch",
        "foods": [
            {
                "id": 2,
                "name": "Bagel Bites - Four Cheese",
                "calories": 650
            },
            {
                "id": 3,
                "name": "Chicken Burrito",
                "calories": 800
            },
            {
                "id": 12,
                "name": "Apple",
                "calories": 220
            }
        ]
    },
    {
        "id": 4,
        "name": "Dinner",
        "foods": [
            {
                "id": 1,
                "name": "Banana",
                "calories": 150
            },
            {
                "id": 2,
                "name": "Bagel Bites - Four Cheese",
                "calories": 650
            },
            {
                "id": 3,
                "name": "Chicken Burrito",
                "calories": 800
            }
        ]
    }
]
```

**GET /api/v1/meals/:meal_id/foods**

Returns all the foods associated with the meal with an id specified by :meal_id or a 404 if the meal is not found

If successful, this request will return a response in the following format:

```js
{
    "id": 1,
    "name": "Breakfast",
    "foods": [
        {
            "id": 1,
            "name": "Banana",
            "calories": 150
        },
        {
            "id": 6,
            "name": "Yogurt",
            "calories": 550
        },
        {
            "id": 12,
            "name": "Apple",
            "calories": 220
        }
    ]
}
```

**POST /api/v1/meals/:meal_id/foods/:id**

Adds the food with :id to the meal with :meal_id

This creates a new record in the MealFoods table to establish the relationship between this food and meal. If the meal/food cannot be found, a 404 will be returned.

If successful, this request will return a status code of 201 with the following body:

```js
{
    "message": "Successfully added FOODNAME to MEALNAME"
}
```

**DELETE /api/v1/meals/:meal_id/foods/:id**

Removes the food with :id from the meal with :meal_id

This deletes the existing record in the MealFoods table that creates the relationship between this food and meal. If the meal/food cannot be found, a 404 will be returned.

If successful, this request will return:

```js
{
    "message": "Successfully removed FOODNAME to MEALNAME"
}
```

##### Favorites Endpoints:

**GET /api/v1/favorite_foods**

Retrieves data on the foods which were eaten most frequently. This should return an array of objects with a timesEaten property representing the number of times the food was eaten, then a foods property whose value is an array of foods that were eaten the given number of times, calories, and the meals it was eaten for.

This response should include the 3 highest `timesEaten` values (if applicable; foods only eaten once should not appear). If there are not 3 `timesEaten` values greater than 1, only list the `timesEaten` values greater than 1.

If successful, this request will return the following:

```js
[
  {
    "timesEaten": 4,
    "foods":
      [
        {
          "name": "Banana",
          "calories": 200,
          // since Bananas were eaten 4 times but only two meals
          // are in this array, this would mean that Banana was eaten
          // more than once in at least each meal
          "mealsWhenEaten": ["Breakfast", "Dinner"]
        },
  },
  "timesEaten": 3,
  "foods":
    [
      {
        "name": "Strawberries",
        "calories": 200,
        "mealsWhenEaten": ["Breakfast", "Lunch", "Dinner"]
      },
      {
        "name": "Almonds"
        "calories": 800,
        // Since almonds were eaten three times but snacks is the
        // only meal in this array, this would mean that almonds were
        // only eaten as snacks, but three times.
        "mealsWhenEaten": ["Snacks"]
      }
    ]
    ]
  }
  // `"timesEaten": 2` is not listed here because in this example,
  // no snack was eaten exactly two times.
]
```


### Expectations

- Tag instructors in PRs on Github wherever you'd like feedback.
- Reach out for extra support if you feel like you are falling behind.
- If there's any question about functionality, ASK.
- Be prepared for your check-in - tag your instructor in a PR using [this template](https://gist.github.com/ameseee/bcad94e879ff60e8649820c8e321d58a) by 8am on Thursday, October 4.
- To submit, tag your instructor in a PR using [this template](https://gist.github.com/ameseee/c4f0b2e1bb3f41661a7de8574ba3992c).

## Rubric

You will be graded by an instructor on the criteria in [this rubric](./rubric).
