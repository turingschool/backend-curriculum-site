---
layout: page
title: Quantified Self - Server-side Javascript
subheading: A calorie tracker project for the fourth module
---

## Introduction

You are going to build a calorie tracker using Javascript. You'll primarily be using NodeJS and Express to complete this project. This also includes you abstracting out additional APIs into their own respective microservices.

## Learning Goals

* Create an Express API given specified endpoints and response formats.
* Create a microservice that interfaces with the Yummly API.
* Integrate both apps together and complete the quantified self experience

## Requirements Overview

You will be creating a fully-tested Express API that users will utilize to track calories in meals that they eat. You can use [this](https://github.com/turingschool-examples/qs-fe-starter-kit) as a starter kit.

You may also use [this Webpack starter kit](https://github.com/wbkd/webpack-starter). This one may be a bit more robust than the one we have provided above. It includes more configuration for transpiling, linting, and environment-specific configuration.  

* All applications should be deployed with Heroku. For more information on how to do this, look [here](https://codeburst.io/deploy-your-webpack-apps-to-heroku-in-3-simple-steps-4ae072af93a8)

## Back End Features

For your Express back end:

- You'll use the given Webpack starter pack to get started. Run through the setup instructions and fire up the application.
- Create an agile board and write stories for each of your endpoints. Choose between Github Projects, Waffle, or Trello. Use [this as a reference point](https://www.pivotaltracker.com/blog/principles-of-effective-story-writing-the-pivotal-labs-way) on how to write effective stories. We'll go into more detail on this.  
- Send your agile board, repo, and production links to your instructors.

You will need to build the following foods and meals endpoints for your application (listed below). Based on the extensions below you may need to modify and add the endpoints listed in project spec - do so as needed. You will definitely need to add some.

There may be different architectural decisions you make with your server because of this addition; take you time to plan this out thoughtfully.

### Food Endpoints (week 1):

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

### Meal Endpoints (week 1):

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

Returns all the foods associated with the meal with an id specified by `:meal_id` or a 404 if the meal is not found

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

Adds the food with :id to the meal with `:meal_id`

This creates a new record in the MealFoods table to establish the relationship between this food and meal. If the meal/food cannot be found, a 404 will be returned.

If successful, this request will return a status code of 201 with the following body:

```js
{
    "message": "Successfully added FOODNAME to MEALNAME"
}
```

**DELETE /api/v1/meals/:meal_id/foods/:id**

Removes the food with `:id` from the meal with `:meal_id`

This deletes the existing record in the MealFoods table that creates the relationship between this food and meal. If the meal/food cannot be found, a 404 will be returned.

If successful, this request will return a 204 status code.

## Required extension (week 2):

### Recipes with Yummly - Microservice

This extension will be your first experience in creating and using an independent microservice that you've built yourself. This means that you'll need to pull down the Webpack starter pack as you did above, and create a brand new API. This new microservice will be created and deployed, just as your first one above.

So let's break this down. You'll need to do a few things to get everything set up.

* Look over the Yummly documentation on how to search for recipes.
* Use the Yummly API to search for a particular kind of food (for example, soup or sandwiches).
* Build a recipes table in your new microservice. Look below to see what an example recipes response would look like. This may show you what your database should look like. 

Name STRING (name is also the ID of the recipe)
Rating FLOAT
totalTimeInSeconds INT
Ingredient Count INT
Cuisine: STRING (take first one)

RecipeFlavors Table:
Salty: FLOAT
Sour: FLOAT
Sweet: FLOAT
Bitter: FLOAT
Meaty: FLOAT
Piquant: FLOAT
Recipe_id: FK

**GET /api/v1/recipes/search?=food_type**

### Your turn. Be creative and create three new endpoints 
**GET /api/v1/recipes/your_choice**
**GET /api/v1/recipes/your_choice**
**GET /api/v1/recipes/your_choice**

Once you have seeded your database with recipe information from the Yummly API,

## Optional extension:

### Calendar - Additional endpoints

What's the point of this app if one can't look back in time and see what eating habits they have? You'll need to build out additional endpoints that lists all dates a user has recorded meals, and what they ate for each meal. Please note that this extension will require you to create additional endpoints that include the creation of users.

## Expectations

- Reach out to instructors on Slack wherever you'd like feedback.
- Reach out for extra support if you feel like your team is falling behind.
- If there's any question about functionality, ASK.

## Rubric

You will be graded by an instructor on the criteria in [this rubric](./rubric).
