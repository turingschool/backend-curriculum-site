---
layout: page
title: Quantified Self - Server-side Javascript
subheading: A calorie tracker project for M4
---

_Project spec updated on 10/15/2019_


## Introduction
You are going to build a simple calorie tracker using Javascript and Express.  You will also have an opportunity to build out a second micro-services that focuses on recipes _or_ a frontend that will interface with your calorie tracker. 

## Learning Goals

* Create an Express API given specified endpoints and response formats.
* Create an optional micro-service that interfaces with the Edamam API.
* Integrate both apps together and complete the quantified self experience

## Requirements Overview

You will be creating a tested Express API that users will utilize to track calories in meals that they eat. 

* All applications should be deployed with Heroku. For more information on how to do this, look [here](https://codeburst.io/deploy-your-webpack-apps-to-heroku-in-3-simple-steps-4ae072af93a8)

## Back End Features

For your Express backend:

- Make sure that you already have the express generator installed on your machine. If you don’t, you can run `npm install express-generator -g`
- Use the express generator and run  `express —no-view <<INSERT APP NAME HERE>>` to get started
- Create an agile board on Github Projects and write stories for each of your endpoints. Use [this as a reference point](https://www.pivotaltracker.com/blog/principles-of-effective-story-writing-the-pivotal-labs-way) on how to write effective stories. We'll go into more detail on this.  
- Send your agile board, repo, and production links to your instructors.

You will need to build the following foods and meals endpoints for your application (listed below). Based on the extensions below you may need to modify and add the endpoints listed in project spec - do so as needed. You will definitely need to add some.

### Week 1 Endpoints

__Foods Endpoints__

_GET /api/v1/foods_

Returns all foods currently in the database

Each individual food will be returned in the following format:

```js
[
    {
        "id": 1,
        "name": "Banana",
        "calories": 150
    },
    {
        "id": 2,
        "name": "Apple",
        "calories": 100
    },
    {
        "id": 1,
        "name": "Meatloaf",
        "calories": 700
    }
]
```
]

_GET /api/v1/foods/:id_

Returns the food object with the specific `:id` you've passed in or 404 if the food is not found

```js
{
    "id": 1,
    "name": "Banana",
    "calories": 150
}
```

_POST /api/v1/foods_

Allows creating a new food with the parameters:

```js
{ "food": { "name": "Pear", "calories": 100} }
```

If food is successfully created, the food item will be returned. 

```js
{
    "id": 1,
    "name": "Banana",
    "calories": 150
}
```

If the food is not successfully created, a 400 status code will be returned. Both name and calories are required fields.

_PUT /api/v1/foods/:id_

Allows one to update an existing food with the parameters:

```js
{ "food": { "name": "Mint", "calories": "14"} }
```

If food is successfully updated (name and calories are required fields), the food item will be returned. 

```js
{
    "id": 2,
    "name": "Mint",
    "calories": 14
}
```

If the food is not successfully updated, a 400 status code will be returned.

_DELETE /api/v1/foods/:id_

Will delete the food with the id passed in and return a 204 status code. No body will be returned after a deletion. If the food can't be found, a 404 will be returned.

__Meals Endpoints__

_GET /api/v1/meals_

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

_GET /api/v1/meals/:meal_id/foods_

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

_POST /api/v1/meals/:meal_id/foods/:id_

Adds the food with :id to the meal with `:meal_id`

This creates a new record in the MealFoods table to establish the relationship between this food and meal. If the meal/food cannot be found, a 404 will be returned.

If successful, this request will return a status code of 201 with the following body:

```js
{
    "message": "Successfully added FOODNAME to MEALNAME"
}
```

_DELETE /api/v1/meals/:meal_id/foods/:id_

Removes the food with `:id` from the meal with `:meal_id`

This deletes the existing record in the MealFoods table that creates the relationship between this food and meal. If the meal/food cannot be found, a 404 will be returned.

If successful, this request will return a 204 status code and no body will be present. 


## Week 2 - Choose your own adventure from the following two options: 

### Option 1 — A Recipe micro-service with the Edamam API

This extension’s focus is to create and use an independent micro-service that you've built yourself. This means that you'll need to use the Express generator as you did above and create a brand new application This new micro-service will be created and deployed, just as you did with your first one. 

So let's break this down. You'll need to do a few things to get everything set up.

* Register for an API key from [Edamam](https://developer.edamam.com/edamam-recipe-api)
* Look over the Edamam documentation on how to search for recipes.
* Use the Edamam API to search for a particular kind of food (for example, bananas).
* Build a recipes table in your new micro-service.
* Look below to see what an example recipes response would look like. You may not need all of the information that the Edamam API gives back to you. Pick out the most important data and _seed your database with at least 10 results per food item_. In other words, you’ll seed your database with 10 recipes that include bananas. Then another 10 recipes that would include chicken. This will go on until you have successfully seeded your database with 100 recipes from 10 unique foods.  

_Example query:_

`curl "https://api.edamam.com/search?q=chicken&app_id=API_ID&app_key=API_KEY&from=0&to=1&calories=591-722&health=alcohol-free"`

_Example result:_

```js

{
  "q" : "chicken",
  "from" : 0,
  "to" : 1,
  "params" : {
    "sane" : [ ],
    "q" : [ "chicken" ],
    "app_key" : [ "99b2a57e1d4286eed868626b3df01d96" ],
    "health" : [ "alcohol-free" ],
    "from" : [ "0" ],
    "to" : [ "1" ],
    "calories" : [ "591-722" ],
    "app_id" : [ "8e41a3ab" ]
  },
  "more" : true,
  "count" : 11882,
  "hits" : [ {
    "recipe" : {
      "uri" : "http://www.edamam.com/ontologies/edamam.owl#recipe_d81795fb677ba4f12ab1a104e10aac98",
      "label" : "Citrus Roasted Chicken",
      "image" : "https://www.edamam.com/web-img/d4b/d4bb1e6c7a6c3738d8e01707eb0ad83d.jpg",
      "source" : "Food52",
      "url" : "https://food52.com/recipes/3403-citrus-roasted-chicken",
      "shareAs" : "http://www.edamam.com/recipe/citrus-roasted-chicken-d81795fb677ba4f12ab1a104e10aac98/chicken/alcohol-free/591-722-cal",
      "yield" : 4.0,
      "dietLabels" : [ "Low-Carb" ],
      "healthLabels" : [ "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free" ],
      "cautions" : [ "Sulfites", "FODMAP" ],
      "ingredientLines" : [ "1 chicken, about 3.5 to 4 pounds", "1 lemon", "1 blood orange", "1 tangerine or clementine", "Kosher salt", "1/2 cup chicken broth" ],
      "ingredients" : [ {
        "text" : "1 chicken, about 3.5 to 4 pounds",
        "weight" : 1700.9713875
      }, {
        "text" : "1 lemon",
        "weight" : 58.0
      }, {
        "text" : "1 blood orange",
        "weight" : 131.0
      }, {
        "text" : "1 tangerine or clementine",
        "weight" : 74.0
      }, {
        "text" : "Kosher salt",
        "weight" : 12.503828324999999
      }, {
        "text" : "1/2 cup chicken broth",
        "weight" : 120.0
      } ],
      "calories" : 2643.1901685250004,
      "totalWeight" : 2093.938546284647,
      "totalTime" : 424.0,
      "totalNutrients" : {
        "ENERC_KCAL" : {
          "label" : "Energy",
          "quantity" : 2643.1901685250004,
          "unit" : "kcal"
        },
        "FAT" : {
          "label" : "Fat",
          "quantity" : 176.07527785109997,
          "unit" : "g"
        },
        "FASAT" : {
          "label" : "Saturated",
          "quantity" : 50.27953942484999,
          "unit" : "g"
        },
        "FATRN" : {
          "label" : "Trans",
          "quantity" : 1.121960727195,
          "unit" : "g"
        },
        "FAMS" : {
          "label" : "Monounsaturated",
          "quantity" : 72.91052791439999,
          "unit" : "g"
        },
        "FAPU" : {
          "label" : "Polyunsaturated",
          "quantity" : 37.70010555505,
          "unit" : "g"
        },
        "CHOCDF" : {
          "label" : "Carbs",
          "quantity" : 33.9289,
          "unit" : "g"
        },
        "FIBTG" : {
          "label" : "Fiber",
          "quantity" : 6.026,
          "unit" : "g"
        },
        "SUGAR" : {
          "label" : "Sugars",
          "quantity" : 22.3877,
          "unit" : "g"
        },
        "PROCNT" : {
          "label" : "Protein",
          "quantity" : 220.661261091,
          "unit" : "g"
        },
        "CHOLE" : {
          "label" : "Cholesterol",
          "quantity" : 871.095407625,
          "unit" : "mg"
        },
        "NA" : {
          "label" : "Sodium",
          "quantity" : 4846.2337822035,
          "unit" : "mg"
        },
        "CA" : {
          "label" : "Calcium",
          "quantity" : 222.90477789331527,
          "unit" : "mg"
        },
        "MG" : {
          "label" : "Magnesium",
          "quantity" : 261.37178028784643,
          "unit" : "mg"
        },
        "K" : {
          "label" : "Potassium",
          "quantity" : 2761.015799917772,
          "unit" : "mg"
        },
        "FE" : {
          "label" : "Iron",
          "quantity" : 11.277436515489338,
          "unit" : "mg"
        },
        "ZN" : {
          "label" : "Zinc",
          "quantity" : 15.501120278634646,
          "unit" : "mg"
        },
        "P" : {
          "label" : "Phosphorus",
          "quantity" : 1775.850998945,
          "unit" : "mg"
        },
        "VITA_RAE" : {
          "label" : "Vitamin A",
          "quantity" : 490.42082283499997,
          "unit" : "µg"
        },
        "VITC" : {
          "label" : "Vitamin C",
          "quantity" : 155.290568696,
          "unit" : "mg"
        },
        "THIA" : {
          "label" : "Thiamin (B1)",
          "quantity" : 0.9368063261,
          "unit" : "mg"
        },
        "RIBF" : {
          "label" : "Riboflavin (B2)",
          "quantity" : 1.5761926522,
          "unit" : "mg"
        },
        "NIA" : {
          "label" : "Niacin (B3)",
          "quantity" : 81.46334356343502,
          "unit" : "mg"
        },
        "VITB6A" : {
          "label" : "Vitamin B6",
          "quantity" : 4.30201190225,
          "unit" : "mg"
        },
        "FOLDFE" : {
          "label" : "Folate equivalent (total)",
          "quantity" : 138.83963261,
          "unit" : "µg"
        },
        "FOLFD" : {
          "label" : "Folate (food)",
          "quantity" : 138.83963261,
          "unit" : "µg"
        },
        "VITB12" : {
          "label" : "Vitamin B12",
          "quantity" : 3.58564768485,
          "unit" : "µg"
        },
        "VITD" : {
          "label" : "Vitamin D",
          "quantity" : 2.313321087,
          "unit" : "µg"
        },
        "TOCPHA" : {
          "label" : "Vitamin E",
          "quantity" : 3.9767816305000006,
          "unit" : "mg"
        },
        "VITK1" : {
          "label" : "Vitamin K",
          "quantity" : 17.589908152499998,
          "unit" : "µg"
        }
      },
      "totalDaily" : {
        "ENERC_KCAL" : {
          "label" : "Energy",
          "quantity" : 132.15950842625003,
          "unit" : "%"
        },
        "FAT" : {
          "label" : "Fat",
          "quantity" : 270.8850428478461,
          "unit" : "%"
        },
        "FASAT" : {
          "label" : "Saturated",
          "quantity" : 251.39769712424996,
          "unit" : "%"
        },
        "CHOCDF" : {
          "label" : "Carbs",
          "quantity" : 11.309633333333332,
          "unit" : "%"
        },
        "FIBTG" : {
          "label" : "Fiber",
          "quantity" : 24.104,
          "unit" : "%"
        },
        "PROCNT" : {
          "label" : "Protein",
          "quantity" : 441.32252218200006,
          "unit" : "%"
        },
        "CHOLE" : {
          "label" : "Cholesterol",
          "quantity" : 290.36513587499996,
          "unit" : "%"
        },
        "NA" : {
          "label" : "Sodium",
          "quantity" : 201.92640759181248,
          "unit" : "%"
        },
        "CA" : {
          "label" : "Calcium",
          "quantity" : 22.290477789331526,
          "unit" : "%"
        },
        "MG" : {
          "label" : "Magnesium",
          "quantity" : 62.23137625901106,
          "unit" : "%"
        },
        "K" : {
          "label" : "Potassium",
          "quantity" : 58.74501701952706,
          "unit" : "%"
        },
        "FE" : {
          "label" : "Iron",
          "quantity" : 62.65242508605187,
          "unit" : "%"
        },
        "ZN" : {
          "label" : "Zinc",
          "quantity" : 140.91927526031498,
          "unit" : "%"
        },
        "P" : {
          "label" : "Phosphorus",
          "quantity" : 253.69299984928568,
          "unit" : "%"
        },
        "VITA_RAE" : {
          "label" : "Vitamin A",
          "quantity" : 54.49120253722222,
          "unit" : "%"
        },
        "VITC" : {
          "label" : "Vitamin C",
          "quantity" : 172.5450763288889,
          "unit" : "%"
        },
        "THIA" : {
          "label" : "Thiamin (B1)",
          "quantity" : 78.06719384166668,
          "unit" : "%"
        },
        "RIBF" : {
          "label" : "Riboflavin (B2)",
          "quantity" : 121.24558863076923,
          "unit" : "%"
        },
        "NIA" : {
          "label" : "Niacin (B3)",
          "quantity" : 509.14589727146887,
          "unit" : "%"
        },
        "VITB6A" : {
          "label" : "Vitamin B6",
          "quantity" : 330.92399248076924,
          "unit" : "%"
        },
        "FOLDFE" : {
          "label" : "Folate equivalent (total)",
          "quantity" : 34.7099081525,
          "unit" : "%"
        },
        "VITB12" : {
          "label" : "Vitamin B12",
          "quantity" : 149.40198686875001,
          "unit" : "%"
        },
        "VITD" : {
          "label" : "Vitamin D",
          "quantity" : 15.422140579999999,
          "unit" : "%"
        },
        "TOCPHA" : {
          "label" : "Vitamin E",
          "quantity" : 26.51187753666667,
          "unit" : "%"
        },
        "VITK1" : {
          "label" : "Vitamin K",
          "quantity" : 14.658256793749997,
          "unit" : "%"
        }
      },
      "digest" : [ {
        "label" : "Fat",
        "tag" : "FAT",
        "schemaOrgTag" : "fatContent",
        "total" : 176.07527785109997,
        "hasRDI" : true,
        "daily" : 270.8850428478461,
        "unit" : "g",
        "sub" : [ {
          "label" : "Saturated",
          "tag" : "FASAT",
          "schemaOrgTag" : "saturatedFatContent",
          "total" : 50.27953942484999,
          "hasRDI" : true,
          "daily" : 251.39769712424996,
          "unit" : "g"
        }, {
          "label" : "Trans",
          "tag" : "FATRN",
          "schemaOrgTag" : "transFatContent",
          "total" : 1.121960727195,
          "hasRDI" : false,
          "daily" : 0.0,
          "unit" : "g"
        }, {
          "label" : "Monounsaturated",
          "tag" : "FAMS",
          "schemaOrgTag" : null,
          "total" : 72.91052791439999,
          "hasRDI" : false,
          "daily" : 0.0,
          "unit" : "g"
        }, {
          "label" : "Polyunsaturated",
          "tag" : "FAPU",
          "schemaOrgTag" : null,
          "total" : 37.70010555505,
          "hasRDI" : false,
          "daily" : 0.0,
          "unit" : "g"
        } ]
      }, {
        "label" : "Carbs",
        "tag" : "CHOCDF",
        "schemaOrgTag" : "carbohydrateContent",
        "total" : 33.9289,
        "hasRDI" : true,
        "daily" : 11.309633333333332,
        "unit" : "g",
        "sub" : [ {
          "label" : "Carbs (net)",
          "tag" : "CHOCDF.net",
          "schemaOrgTag" : null,
          "total" : 27.9029,
          "hasRDI" : false,
          "daily" : 0.0,
          "unit" : "g"
        }, {
          "label" : "Fiber",
          "tag" : "FIBTG",
          "schemaOrgTag" : "fiberContent",
          "total" : 6.026,
          "hasRDI" : true,
          "daily" : 24.104,
          "unit" : "g"
        }, {
          "label" : "Sugars",
          "tag" : "SUGAR",
          "schemaOrgTag" : "sugarContent",
          "total" : 22.3877,
          "hasRDI" : false,
          "daily" : 0.0,
          "unit" : "g"
        }, {
          "label" : "Sugars, added",
          "tag" : "SUGAR.added",
          "schemaOrgTag" : null,
          "total" : 0.0,
          "hasRDI" : false,
          "daily" : 0.0,
          "unit" : "g"
        } ]
      }, {
        "label" : "Protein",
        "tag" : "PROCNT",
        "schemaOrgTag" : "proteinContent",
        "total" : 220.661261091,
        "hasRDI" : true,
        "daily" : 441.32252218200006,
        "unit" : "g"
      }, {
        "label" : "Cholesterol",
        "tag" : "CHOLE",
        "schemaOrgTag" : "cholesterolContent",
        "total" : 871.095407625,
        "hasRDI" : true,
        "daily" : 290.36513587499996,
        "unit" : "mg"
      }, {
        "label" : "Sodium",
        "tag" : "NA",
        "schemaOrgTag" : "sodiumContent",
        "total" : 4846.2337822035,
        "hasRDI" : true,
        "daily" : 201.92640759181248,
        "unit" : "mg"
      }, {
        "label" : "Calcium",
        "tag" : "CA",
        "schemaOrgTag" : null,
        "total" : 222.90477789331527,
        "hasRDI" : true,
        "daily" : 22.290477789331526,
        "unit" : "mg"
      }, {
        "label" : "Magnesium",
        "tag" : "MG",
        "schemaOrgTag" : null,
        "total" : 261.37178028784643,
        "hasRDI" : true,
        "daily" : 62.23137625901106,
        "unit" : "mg"
      }, {
        "label" : "Potassium",
        "tag" : "K",
        "schemaOrgTag" : null,
        "total" : 2761.015799917772,
        "hasRDI" : true,
        "daily" : 58.74501701952706,
        "unit" : "mg"
      }, {
        "label" : "Iron",
        "tag" : "FE",
        "schemaOrgTag" : null,
        "total" : 11.277436515489338,
        "hasRDI" : true,
        "daily" : 62.65242508605187,
        "unit" : "mg"
      }, {
        "label" : "Zinc",
        "tag" : "ZN",
        "schemaOrgTag" : null,
        "total" : 15.501120278634646,
        "hasRDI" : true,
        "daily" : 140.91927526031498,
        "unit" : "mg"
      }, {
        "label" : "Phosphorus",
        "tag" : "P",
        "schemaOrgTag" : null,
        "total" : 1775.850998945,
        "hasRDI" : true,
        "daily" : 253.69299984928568,
        "unit" : "mg"
      }, {
        "label" : "Vitamin A",
        "tag" : "VITA_RAE",
        "schemaOrgTag" : null,
        "total" : 490.42082283499997,
        "hasRDI" : true,
        "daily" : 54.49120253722222,
        "unit" : "µg"
      }, {
        "label" : "Vitamin C",
        "tag" : "VITC",
        "schemaOrgTag" : null,
        "total" : 155.290568696,
        "hasRDI" : true,
        "daily" : 172.5450763288889,
        "unit" : "mg"
      }, {
        "label" : "Thiamin (B1)",
        "tag" : "THIA",
        "schemaOrgTag" : null,
        "total" : 0.9368063261,
        "hasRDI" : true,
        "daily" : 78.06719384166668,
        "unit" : "mg"
      }, {
        "label" : "Riboflavin (B2)",
        "tag" : "RIBF",
        "schemaOrgTag" : null,
        "total" : 1.5761926522,
        "hasRDI" : true,
        "daily" : 121.24558863076923,
        "unit" : "mg"
      }, {
        "label" : "Niacin (B3)",
        "tag" : "NIA",
        "schemaOrgTag" : null,
        "total" : 81.46334356343502,
        "hasRDI" : true,
        "daily" : 509.14589727146887,
        "unit" : "mg"
      }, {
        "label" : "Vitamin B6",
        "tag" : "VITB6A",
        "schemaOrgTag" : null,
        "total" : 4.30201190225,
        "hasRDI" : true,
        "daily" : 330.92399248076924,
        "unit" : "mg"
      }, {
        "label" : "Folate equivalent (total)",
        "tag" : "FOLDFE",
        "schemaOrgTag" : null,
        "total" : 138.83963261,
        "hasRDI" : true,
        "daily" : 34.7099081525,
        "unit" : "µg"
      }, {
        "label" : "Folate (food)",
        "tag" : "FOLFD",
        "schemaOrgTag" : null,
        "total" : 138.83963261,
        "hasRDI" : false,
        "daily" : 0.0,
        "unit" : "µg"
      }, {
        "label" : "Folic acid",
        "tag" : "FOLAC",
        "schemaOrgTag" : null,
        "total" : 0.0,
        "hasRDI" : false,
        "daily" : 0.0,
        "unit" : "µg"
      }, {
        "label" : "Vitamin B12",
        "tag" : "VITB12",
        "schemaOrgTag" : null,
        "total" : 3.58564768485,
        "hasRDI" : true,
        "daily" : 149.40198686875001,
        "unit" : "µg"
      }, {
        "label" : "Vitamin D",
        "tag" : "VITD",
        "schemaOrgTag" : null,
        "total" : 2.313321087,
        "hasRDI" : true,
        "daily" : 15.422140579999999,
        "unit" : "µg"
      }, {
        "label" : "Vitamin E",
        "tag" : "TOCPHA",
        "schemaOrgTag" : null,
        "total" : 3.9767816305000006,
        "hasRDI" : true,
        "daily" : 26.51187753666667,
        "unit" : "mg"
      }, {
        "label" : "Vitamin K",
        "tag" : "VITK1",
        "schemaOrgTag" : null,
        "total" : 17.589908152499998,
        "hasRDI" : true,
        "daily" : 14.658256793749997,
        "unit" : "µg"
      } ]
    },
    "bookmarked" : false,
    "bought" : false
  } ]
}
```

### Now it’s your turn to be creative with the API

Choose and create three new endpoints in your Edamam Recipe Service. 

For example, you could create an endpoint where the user can search for recipes by food type, calorie amount, preparation time, number of ingredients, or cuisine type.

_Example Enpoints_
* GET /api/v1/recipes/food_search?q=food_type
* GET /api/v1/recipes/calorie_search?q=calorie_count
* GET /api/v1/recipes/ingredient_search?q=num_of_ingredients

Now create _two_ additional endpoints that will analyze your recipe results. For example

- With a list of recipes, create an endpoint that finds the average calorie total based off food type
- With a list of recipes, create an endpoint that orders recipes from least to greatest amount of ingredients
- With a list of recipes, create an endpoint that orders recipes from least to great amount of time it takes to prepare the meal

### Option 2 — Build a Frontend for your application

You can use [this repo](https://github.com/turingschool-examples/qs-fe-starter-kit) as your FE starter kit. This starter kit is responsible for a setting up a simple server that will work in your browser. To get started, look inside the `lib` folder and you’ll find a file by the name of `index.js`. This is where you’ll want to write your Javascript code.     

Create a simple frontend that consumes both of your new APIs. This frontend can be a single page application and shouldn't require the user to refresh the page at any time. This means that data will load dynamically. 

Notice: You do _not_ have to write tests for your frontend, but should test features manually to ensure they work as expected.


## Potential Extensions
If you get through your first week’s work and one extension, then you can work on any stretch goals you may have. Below are some options: 

1. Complete the other option you did not choose. 

1. Add a calendar feature 
What's the point of this app if one can't look back in time and see what eating habits they have? You'll need to build out additional endpoints that lists all dates a user has recorded meals, and what they ate for each meal. 

Please note that this extension will require you to create additional endpoints that include the creation of users.

## Expectations

- Reach out to instructors on Slack wherever you'd like feedback.
- Reach out for extra support if you feel like your team is falling behind.
- If there's any question about functionality, let us know!

## Rubric

You will be graded by an instructor on the criteria in [this rubric](./rubric).
