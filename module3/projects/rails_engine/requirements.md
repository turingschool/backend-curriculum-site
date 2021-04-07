---
layout: page
title: Rails Engine Requirements
length: 1 week
tags:
type: project
---

# 1. Set Up

1. Create a Rails API project called `rails-engine` (make sure you do not set up a "traditional" Rails project with a frontend, this is an API-only project)

2. Set Up [SimpleCov](https://github.com/colszowka/simplecov) to track test coverage in your rails-engine API project.

3. Set up your `db/seeds.rb` file with the following content:
```ruby
# before running "rake db:seed", do the following:
# - put the "rails-engine-development.pgdump" file in db/data/
cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)
```

4. Download [rails-engine-development.pgdump](https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/rails-engine-development.pgdump) and move it into the `/db/` folder in another folder called `/data/`, so your project files look like this:
```
/app
/bin
/config
/db
  /data                                     <-- create this folder
    rails-engine-development.pgdump         <-- put the file in the data folder
  seeds.rb
/lib
/log
etc
```
  - this file is in a binary format and your browser may try to automatically download the file instead of viewing it

5. Run `rake db:{drop,create,migrate,seed}` and you may see lots of output including some warnings/errors from `pg_restore` that you can ignore. If you're unsure about the errors you're seeing, ask an instructor.

6. Use a tool like Postico to examine the 6 tables that were created, and build migration files for those tables. Pay careful attention to the data types of each field:
  * items
  * merchants
  * orders
  * order_items
  * invoices
  * transactions

**NOTE** We updated this process to avoid confusion and taking a significant amount of time; the main learning goals of the project are the Rails API endpoints and business intelligence endpoints in ActiveRecord, not the process of importing CSV data. Avoid starting out with a Rake task to do the import and follow these instructions instead. If in doubt, ask your instructors first.

**NOTE** If your `rails new ...` project name from above is NOT exactly called "rails-engine" you will need to modify the `cmd` variable below to change the `-d` parameter from `rails-engine_development` to `<YOUR PROJECT NAME>_development` instead. If you have questions, ask your instructors.

---

# 2. API Endpoints, general definitions

You will need to expose the data through a multitude of API endpoints. All of your endpoints should follow these technical expectations:

* All endpoints should be fully tested for happy path AND sad path. The Postman tests are not a substitute for writing your own tests.
* All endpoints will expect to return JSON data only
* All endpoints should be exposed under an `api` and version (`v1`) namespace (e.g. `/api/v1/items`)
* API will be compliant to the [JSON API spec](https://jsonapi.org/) and match our requirements below precisely
  * if your tests pass but the Postman test does not, you have done something wrong.
* Controller actions should be limited to only the standard Rails actions and follow good RESTful convention.
* Endpoints such as `GET /api/v1/merchants/find?parameters` will NOT follow RESTful convention, and that's okay:

```ruby
module Api
  module V1
    class MerchantsController
      # code omitted
      def find
        # code omitted
      end
    end
  end
end
```

This approach can lead to large controllers. For more info on the reasons why, check out this [blog post](http://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/).

Instead try something like this which adheres to the above approach of only using RESTful actions:

```ruby
module Api
  module V1
    module Merchants
      class SearchController
        def show
        # code omitted
        end
      end
    end
  end
end
```

#### Error Responses

If the user causes an error for which you are sending a 400-series error code, the JSON body of the response should follow a similar JSON Spec of a `data` element, with a `nil` ID, and empty attributes.

As an **EXTENSION**, customize the error message to use this format instead:

```json
{
  "message": "your query could not be completed",
  "errors": [
    "string of error message one",
    "string of error message two",
    "etc"
  ]
}
```

You can customize the value of the `message` element, but the `message` element must be present.

The `errors` element will always be an array and contain one or more strings of why the user's request was unsuccessful. Examples will include a "ID was invalid" in the case of a 404, or "the 'description' parameter was missing"
#### Sad Path vs Edge Case

Sad Path: the user did something which didn't cause an _error_ but didn't work out the way they'd hoped. For example, searching for a merchant by name and getting zero results is a "sad path"

Edge Case: the user did something which broke the functionality of an endpoint. For example, a user searches for an item based on a negative price, or searching between revenue dates where the end date comes before the start date.

## SECTION ONE: RESTful Endpoints, Minimum Requirements:

You will need to expose the following RESTful API endpoints for the following:

* Merchants:
  * get all merchants, a maximum of 20 at a time
  * get one merchant
  * get all items for a given merchant ID
* Items:
  * get all items, a maximum of 20 at a time
  * get one item
  * create an item
  * edit an item
  * delete an item
  * get the merchant data for a given item ID

## SECTION TWO: Non-RESTful Search Endpoints

You will get to choose from the following list:

* ONE of following endpoint pairs:
  * find one MERCHANT based on search criteria AND find all ITEMS based on search criteria
  * OR:
  * find one ITEM based on search criteria AND find all MERCHANTS based on search criteria

## SECTION THREE: Business Intelligence Endpoints

Choose any FOUR of the following seven endpoints:

* find a quantity of merchants sorted by descending revenue
* find a quantity of merchants sorted by descending item quantity sold
* total revenue generated in the whole system over a start/end date range
* total revenue for a given merchant
* find a quantity of items sorted by descending revenue
* total revenue of successful invoices which have not yet been shipped
* revenue report, broken down by month in ascending date order

**HINT**: Invoices must have a successful transaction and be shipped to the customer to be considered as revenue.

## Your Project MVP

In total, the MINIMUM requirement will be 15 endpoints:

* section one has 9 endpoints
* section two has 2 endpoints
* section three has 4 endpoints

---

# 3. API requests/responses, more detail
# SECTION ONE
## RESTful: Fetch all Items/Merchants

These "index" endpoints for items and merchants should:

* render a JSON representation of all records of the requested resource, one "page" of data at a time
* always return an array of data, even if one or zero resources are found
* NOT include dependent data of the resource (eg, if you're fetching merchants, do not send any data about merchant's items or invoices)
* follow this pattern: `GET /api/v1/<resource>`
* allow for the following OPTIONAL query parameters to be sent by the user:
  * `per_page`, an integer value of how many resources should be in the output; defaults to 20 if not specified by the user
  * `page`, an integer value of a "page" of resources to skip before returning data; defaults to 1 if not specified by the user
  * do not use any third-party gems for pagination

Example use of query parameters:

* `GET /api/v1/items?per_page=50&page=2`
* `GET /api/v1/merchants?per_page=50&page=2`

This should fetch items 51 through 100, since we're returning `50` per "page", and we want "page `2`" of data.

Example JSON response for the Merchant resource:

```json
{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store of Fate",
      }
    },
    {
      "id": "3",
      "type": "merchant",
      "attributes": {
        "name": "This is the limit of my creativity",
      }
    }
  ]
}
```
If a user tries to fetch a page for which there is no data, then `data` should report an empty array.

## RESTful: Fetch a single record

This endpoint for Items and Merchants should:

* render a JSON representation of the corresponding record, if found
* follow this pattern: `GET /api/v1/<resource>/:id`

Example JSON response for the Item resource:

```json
{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "Super Widget",
      "description": "A most excellent widget of the finest crafting",
      "unit_price": 109.99
    }
  }
}
```

Note that the `unit_price` is sent as numeric data, and not string data.


## RESTful: Create an Item

This endpoint should:

* create a record and render a JSON representation of the new Item record.
* follow this pattern: `POST /api/v1/items`
* accept the following JSON body with only the following fields:

```
{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 14
}
```
(Note that the unit price is to be sent as a numeric value, not a string.)

* return an error if any attribute is missing
* should ignore any attributes sent by the user which are not allowed

Example JSON response for the Item resource:

```json
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "Widget",
      "description": "High quality widget",
      "unit_price": 100.99,
      "merchant_id": 14
    }
  }
}
```

## RESTful: Update an Item

This endpoint should:

* update the corresponding Item (if found) with whichever details are provided by the user
* render a JSON representation of the updated record.
* follow this pattern: `PATCH /api/v1/items/:id`
* accept the following JSON body with one or more of the following fields:
The body should follow this pattern:

```
{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 7
}
```
(Note that the unit price is to be sent as a numeric value, not a string.)

Example JSON response for the Item resource:

```json
{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "New Widget Name",
      "description": "High quality widget, now with more widgety-ness",
      "unit_price": 299.99,
      "merchant_id": 7
    }
  }
}
```

## RESTful: Destroy an Item

This endpoint should:
* destroy the corresponding record (if found) and any associated data
* destroy any invoice if this was the only item on an invoice
* NOT return any JSON body at all, and should return a 204 HTTP status code
* NOT utilize a Serializer (Rails will handle sending a 204 on its own if you just `.destroy` the object)


## RESTful: Relationship Endpoints

These endpoints should show related records for a given resource. The relationship endpoints you should expose are:

* `GET /api/v1/merchants/:id/items` - return all items associated with a merchant.
  * return a 404 if merchant is not found
* `GET /api/v1/items/:id/merchant` - return the merchant associated with an item
  * return a 404 if the item is not found


---
# SECTION TWO
## Non-RESTful Search Endpoints

In addition to the standard RESTful endpoints described above, you will build the following endpoints which will NOT follow RESTful convention:

* `GET /api/vi/items/find_one`, find a single item which matches a search term
* `GET /api/vi/items/find_all`, find all items which match a search term
* `GET /api/vi/merchants/find_one`, find a single merchant which matches a search term
* `GET /api/vi/merchants/find_all`, find all merchants which match a search term

These endpoints will make use of query parameters as described below:

#### "Find One" endpoints

These endpoints should:

* return a single object, if found
* return the first object in the database in case-sensitive alphabetical order if multiple matches are found
  * eg, if "Ring World" and "Turing" exist as merchant names, "Ring World" would be returned, even if "Turing" was created first
* allow the user to specify a 'name' query parameter:
  * for merchants, the user can send `?name=ring` and it will search the `name` field in the database table
  * for items, the user can send `?name=ring` and it will search the `name` field in the database table
    * this should find a name of 'Titanium Ring' and anything with a description like 'This silver chime will bring you cheer!'
  * the search data in the `name` query parameter should require the database to do a case-insensitive search for text fields
    * eg, searching for 'ring' should find 'Turing' and 'Ring World'
* allow the user to send one or more price-related query parameters, applicable to items only:
  * `min_price=4.99` should look for anything with a price equal to or greater than $4.99
  * `max_price=99.99` should look for anything with a price less than or equal to $99.99
  * both `min_price` and `max_price` can be sent
* for items, the user will send EITHER the `name` parameter OR either/both of the `price` parameters
  * users should get an error if `name` and either/both of the `price` parameters are sent

Valid examples:
* `GET /api/v1/merchants/find_one?name=Mart`
* `GET /api/v1/items/find_one?name=ring`
* `GET /api/v1/items/find_one?min_price=50`
* `GET /api/v1/items/find_one?max_price=150`
* `GET /api/v1/items/find_one?max_price=150&min_price=50`

Invalid examples:
* `GET /api/v1/<resource>/find_one`
  * parameter cannot be missing
* `GET /api/v1/<resource>/find_one?name=`
  * parameter cannot be empty
* `GET /api/v1/items/find_one?name=ring&min_price=50`
  * cannot send both `name` and `min_price`
* `GET /api/v1/items/find_one?name=ring&max_price=50`
  * cannot send both `name` and `max_price`
* `GET /api/v1/items/find_one?name=ring&min_price=50&max_price=250`
  * cannot send both `name` and `min_price` and `max_price`

Example JSON response for `GET /api/v1/merchants/find?name=ring`

```json
{
  "data": {
    "id": 4,
    "type": "merchant",
    "attributes": {
      "name": "Ring World"
    }
  }
}
```

#### "Find All" endpoints

These endpoints will follow the same rules as the "find_one" endpoints.

The JSON response will always be an array of objects, even if zero matches or only one match is found.

It should not return a 404 if no matches are found.

Example JSON response for `GET /api/v1/merchants/find_all?name=ring`

```json
{
  "data": [
    {
      "id": "4",
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
      }
    },
    {
      "id": "1",
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    }
  ]
}


```

---
# SECTION THREE
## Non-RESTful: Merchants with Most Revenue

This endpoint should return a variable number of merchants ranked by total revenue.

The URI should follow this pattern: `GET /api/v1/merchants/most_revenue?quantity=x`

where `x` is the number of merchants to be returned. The quantity parameter is required, and should return an error if it is missing or if it is not an integer greater than 0.


Example JSON response for `GET /api/v1/merchants/most_revenue?quantity=2`

```json
{
  "data": [
    {
      "id": "1",
      "type": "merchant_name_revenue",
      "attributes": {
        "name": "Turing School",
        "revenue": 512.256128
      }
    },
    {
      "id": "4",
      "type": "merchant_name_revenue",
      "attributes": {
        "name": "Ring World",
        "revenue": 245.130001
      }
    }
  ]
}
```


## Non-RESTful: Merchants with Most Items Sold

This endpoint should return a variable number of merchants ranked by total number of items sold:

The URI should follow this pattern: `GET /api/v1/merchants/most_items?quantity=x`

where `x` is the number of merchants to be returned. The quantity should default to 5 if not provided, and return an error if it is not an integer greater than 0.

Example JSON response for `GET /api/v1/merchants/most_items?quantity=2`

```json
{
  "data": [
    {
      "id": "1",
      "type": "items_sold",
      "attributes": {
        "name": "Turing School",
        "count": 512
      }
    },
    {
      "id": "4",
      "type": "items_sold",
      "attributes": {
        "name": "Ring World",
        "count": 128
      }
    }
  ]
}
```


## Non-RESTful: Revenue across Date Range

This endpoint should return the total revenue across all merchants between the given dates, inclusive of the start and end date.

The URI should follow this pattern: `GET /api/v1/revenue?start_date=<start_date>&end_date=<end_date>`

Assume your users will only send dates in the format YYYY-MM-DD. Revenue must be counted for any invoices on the end_date as well.

An error should be returned if either/both the start date or end date are not provided.

Example JSON response for `GET /api/v1/revenue?start=2012-03-09&end=2012-03-24`

```json
{
  "data": {
    "id": null,
    "attributes": {
      "revenue"  : 43201227.8000003
    }
  }
}
```


## Non-RESTful: Total Revenue for a Given Merchant

This endpoint should return the total revenue for a single merchant.

The URI should follow this pattern: `GET /api/v1/revenue/merchants/:id`  

Example JSON response for `GET /api/v1/revenue/merchants/1`


```json
{
  "data": {
    "id": "42",
    "type": "merchant_revenue",
    "attributes": {
      "revenue"  : 532613.9800000001
    }
  }
}
```

## Non-RESTful: Find items ranked by Revenue

The endpoint will return a quantity of items ranked by descending revenue.

The URI should follow this pattern: `GET /api/v1/revenue/items?quantity=x`

where 'x' is the maximum count of results to return.
* quantity should default to 10 if not provided
* endpoint should return an error if it is not an integer greater than 0.

Example JSON response for `GET /api/v1/revenue/items?quantity=1`


```json
{
  "data": [
    {
      "id": 4,
      "type": "item_revenue",
      "attributes": {
        "name": "Men's Titanium Ring",
        "description": "Fine titanium ring",
        "unit_price": 299.99,
        "merchant_id": 54,
        "revenue": 19823.12985
      }
    }
  ]
}
```

## Non-RESTful: Potential Revenue of Unshipped Orders, ranked by "potential" Revenue

Imagine that we want to build a report of the orders which have not yet shipped. How much money is being left on the table for these merchants if they just called Federal Package Logistics to come pick up the boxes...

The URI should follow this pattern: `GET /api/v1/revenue/unshipped?quantity=x`

where 'x' is the maximum count of results to return.
* quantity should default to 10 if not provided
* should return an error if it is not an integer greater than 0.

Example JSON response for `GET /api/v1/revenue/unshipped?quantity=2`


```json
{
  "data": [
    {
      "id": 834,
      "type": "unshipped_order",
      "attributes": {
        "potential_revenue": 5923.78
      }
    },
    {
      "id": 28,
      "type": "unshipped_order",
      "attributes": {
        "potential_revenue": 3298.63
      }
    }
  ]
}
```


## Non-RESTful: Report by Month of Revenue Generated

We would like a full report of all revenue, sorted by week (the database can do this for you!). The dates you get back from PostgreSQL will represent the first day of the week

The URI should follow this pattern: `GET /api/v1/revenue/weekly`

Example JSON response for `GET /api/v1/revenue/weekly`


```json
{
    "data": [
        {
            "id": null,
            "type": "weekly_revenue",
            "attributes": {
                "week": "2012-03-05",
                "revenue": 14981117.170000013
            }
        },
        {
            "id": null,
            "type": "weekly_revenue",
            "attributes": {
                "week": "2012-03-12",
                "revenue": 18778641.380000062
            }
        },
        {
            "id": null,
            "type": "weekly_revenue",
            "attributes": {
                "week": "2012-03-19",
                "revenue": 19106531.87999994
            }
        },
        {
            "id": null,
            "type": "weekly_revenue",
            "attributes": {
                "week": "2012-03-26",
                "revenue": 4627284.439999996
            }
        }
    ]
}
```
