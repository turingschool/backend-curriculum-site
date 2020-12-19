---
layout: page
title: Rails Engine Requirements
length: 1 week
tags:
type: project
---

# 1. Set Up

1. Create a folder called "rails-engine" and inside of that folder, do the following:
   1. Clone [Rails Driver](https://github.com/turingschool-examples/rails_driver) and follow its README instructions.
   2. Run your `rails new ...` instruction to create a project called `rails-engine`
2. Set Up [SimpleCov](https://github.com/colszowka/simplecov) to track test coverage in your rails-engine API project.

# 2. Data Importing

You will need to replace your `db/seeds.rb` file with the following content. When you run `rake db:{drop,create,migrate,seed}`, you will see some errors/warnings from pg_restore that you can safely ignore, but if you think it didn't work properly, ask an instructor for guidance.

**NOTE** We updated this process to avoid confusion and taking a significant amount of time; the main learning goals of the project are the Rails API endpoints and business intelligence endpoints in ActiveRecord, not the process of importing CSV data. Avoid starting out with a Rake task to do the import and follow these instructions instead. If in doubt, ask your instructors first.

**NOTE** If your `rails new ...` project name from above is NOT exactly called "rails-engine" you will need to modify the `cmd` variable below to change the `-d` parameter from `rails-engine_development` to `<YOUR PROJECT NAME>_development` instead. If you have questions, ask your instructors.

```ruby
require 'csv'

# before running "rake db:seed", do the following:
# - put the "rails-engine-development.pgdump" file in db/data/
# - put the "items.csv" file in db/data/

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

# TODO
# - Import the CSV data into the Items table
# - Add code to reset the primary key sequences on all 6 tables (merchants, items, customers, invoices, invoice_items, transactions)
*   - look into `reset_pk_sequence`
```

**Note: Resetting the Primary Key sequence is ONLY necessary to do within the `seeds.rb` file, it is not necessary anywhere in your application code.**

- Create migration files for the other 5 tables created by this `pg_restore` application: merchants, customers, invoices, invoice_items, transactions
  - use a tool like Postico to examine the database tables for the correct data types and relationships
- Create a migration file for the "items" table, based on the provided "items.csv" file

Data Files: (put both of these inside a folder called `db/data` in your Rails API project)
- [items.csv](https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/items.csv)
  - be sure to use the ID values in this CSV file, or the database will not work correctly!
  - convert all prices from pennies to dollars/cents before you save them in the database, or the spec harness tests will not succeed!
- [rails-engine-development.pgdump](https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/rails-engine-development.pgdump)
  - this file is in a binary format and your browser may try to automatically download the file instead of viewing it

Once the "items.csv" file is finished importing in `db/seeds.rb`, add instructions in that file to use ActiveRecord to reset the Primary Key sequences in PostgreSQL for all 6 tables.

---

# 3. API Endpoints

You will need to expose the data through a multitude of API endpoints. All of your endpoints should follow these technical expectations:

* All endpoints should be fully tested for happy path AND sad path. The Rails Driver Spec Harness is not a substitute for writing your own tests.
* All endpoints will expect to return JSON data only
* All endpoints should be exposed under an `api` and version (`v1`) namespace (e.g. `/api/v1/items`)
* API will be compliant to the [JSON API spec](https://jsonapi.org/) and match our requirements below precisely
  * if your tests pass but the Rails Driver spec harness does not, you have done something wrong.
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


## RESTful Endpoints, Minimum Requirements:

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

## Non-RESTful Endpoints, Minimum Requirements:

You will get to choose from the following list:

* ONE of following endpoint pairs:
  * find one MERCHANT based on search criteria AND find all ITEMS based on search criteria
  * OR:
  * find one ITEM based on search criteria AND find all MERCHANTS based on search criteria

* FOUR of the following endpoints:
  * find a quantity of merchants sorted by descending revenue
  * find a quantity of merchants sorted by descending items sold
  * total revenue generated in the whole system over a start/end date range
  * total revenue for a given merchant
  * find a quantity of items sorted by descending revenue
  * total revenue of successful invoices which have not yet been shipped
  * revenue report, broken down by month in ascending date order

In total, the MINIMUM requirement will be 15 endpoints.

**HINT**: Invoices must have a successful transaction and shipped to the customer to be considered as revenue.

---

## RESTful: Fetch all Items/Merchants

These "index" endpoints for items and merchants should:

* render a JSON representation of all records of the requested resource, one "page" of data at a time
* always return an array of data, even if one or zero resources are found
* NOT include dependent data of the resource (eg, if you're fetching merchants, do not send any data about merchant's items or invoices)
* follow this pattern: `GET /api/v1/<resource>`
* allow for the following OPTIONAL query parameters to be sent by the user:
  * perPage, an integer value of how many resources should be in the output; defaults to 20 if not specified by the user
  * page, an integer value of a "page" of resources to skip before returning data; defaults to 1 if not specified by the user

Example use of query parameters:

* `GET /api/v1/items?perPage=50&page=2`
* `GET /api/v1/merchants?perPage=50&page=2`

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

## RESTful: Fetch a single record

This endpoint for items and merchants should:

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
      "description": "A most excellent widget of the finest crafting"
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
  "unit_price": 100.99
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
      "created_at": "2020-12-18T13:42:56 UTC",
      "updated_at": "2020-12-18T13:42:56 UTC"
    }
  }
}
```

## RESTful: Update an Item

This endpoint should:

* update the corresponding Item (if found)
* render a JSON representation of the updated record.
* follow this pattern: `PATCH /api/v1/items/:id`
* accept the following JSON body with one or more of the following fields:
The body should follow this pattern:

```
{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99
}
```
(Note that the unit price is to be sent as a numeric value, not a string.)

Example JSON response for the Item resource:

```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "New Widget Name",
      "description": "High quality widget, now with more widgety-ness",
      "unit_price": 299.99,
      "created_at": "2020-12-18T13:42:56 UTC",
      "updated_at": "2020-12-20T18:12:45 UTC"
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
* allow the user to specify a 'text' query parameter:
  * for merchants, the user can send `?text=ring` and it will search the `name` field in the database table
  * for items, the user can send `?text=ring` and it will search the `name` AND `description` fields in the database table
    * this should find a name of 'Titanium Ring' and anything with a description like 'This silver chime will bring you cheer!'
  * the search data in the `text` query parameter should require the database to do a case-insensitive search for text fields
    * eg, searching for 'ring' should find 'Turing' and 'Ring World'
* allow the user to send one or more price-related query parameters, applicable to items only:
  * `min_price=4.99` should look for anything with a price equal to or greater than $4.99
  * `max_price=99.99` should look for anything with a price less than or equal to $99.99
  * both `min_price` and `max_price` can be sent
* for items, the user will send EITHER the `text` parameter OR either/both of the `price` parameters
  * users should get an error if `text` and either/both of the `price` parameters are sent
  
Valid examples:
* `GET /api/v1/merchants/find_one?text=Mart`
* `GET /api/v1/items/find_one?text=ring`
* `GET /api/v1/items/find_one?min_price=50`
* `GET /api/v1/items/find_one?max_price=150`
* `GET /api/v1/items/find_one?max_price=150&min_price=50`

Invalid examples:
* `GET /api/v1/<resource>/find_one`
  * parameter cannot be missing
* `GET /api/v1/<resource>/find_one?text=`
  * parameter cannot be empty
* `GET /api/v1/items/find_one?text=ring&min_price=50`
  * cannot send both `text` and `min_price`
* `GET /api/v1/items/find_one?text=ring&max_price=50`
  * cannot send both `text` and `max_price`
* `GET /api/v1/items/find_one?text=ring&min_price=50&max_price=250`
  * cannot send both `text` and `min_price` and `max_price`
  
Example JSON response for `GET /api/v1/merchants/find?text=ring`

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

## Non-RESTful: Merchants with Most Revenue

This endpoint should return a variable number of merchants ranked by total revenue.

The URI should follow this pattern: `GET /api/v1/merchants/most_revenue?quantity=x`

where `x` is the number of merchants to be returned. The quantity should default to 5 if not provided, and return an error if it is not an integer greater than 0.


Example JSON response for `GET /api/v1/merchants/most_revenue?quantity=2`

```json
{
  "data": [
    {
      "id": "1",
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    },
    {
      "id": "4",
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
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
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    },
    {
      "id": "4",
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
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

The URI should follow this pattern: `GET /api/v1/merchants/:id/revenue`  

Example JSON response for `GET /api/v1/merchants/1/revenue`


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

## Non-RESTful: Find items ranked by Revenue

The endpoint will return a quantity of items ranked by descending revenue.

The URI should follow this pattern: `GET /api/v1/items/revenue?quantity=x`

where 'x' is the maximum count of results to return. The quantity should default to 5 if not provided, and return an error if it is not an integer greater than 0.

Example JSON response for `GET /api/v1/items/revenue?quantity=2`


```json
{
  "data": [
    {
      "id": 4,
      "attributes": {
        "name": "Men's Titanium Ring",
        "description": "Fine titanium ring",
        "unit_price": 299.99
      }
    },
    {
      "id": 2,
      "attributes": {
        "name": "Tennis Racket",
        "description": "Only the finest materials",
        "unit_price": 199.99
      }
    }
  ]
}
```

## Non-RESTful: Merchants with unshipped invoices, ranked by "potential" Revenue

Imagine that we want to build a report of the merchants who haven't shipped their merchandise yet. How much money is being left on the table for these merchants if they just called Federal Package Logistics to come pick up the boxes...

The URI should follow this pattern: `GET /api/v1/items/revenue?quantity=x`

where 'x' is the maximum count of results to return. The quantity should default to 5 if not provided, and return an error if it is not an integer greater than 0.

Example JSON response for `GET /api/v1/items/revenue?quantity=2`


```json
{
  "data": [
    {
      "id": 834,
      "attributes": {
        "name": "Ring World",
        "potential_revenue": 5923.78
      }
    },
    {
      "id": 28,
      "attributes": {
        "name": "Rackets By Russ",
        "potential_revenue": 3298.63
      }
    }
  ]
}
```


## Non-RESTful: Report by Month of Revenue Generated

We would like a full report of all revenue, sorted by YYYY-MM

The URI should follow this pattern: `GET /api/v1/monthly_revenue`

Example JSON response for `GET /api/v1/items/revenue?quantity=2`


```json
{
  "data": [
    {
      "id": null,
      "attributes": {
        "month": "2020-01",
        "revenue": 923.78
      }
    },
    {
      "id": null,
      "attributes": {
        "month": "2020-02",
        "revenue": 3298.63
      }
    },
    {
      "id": null,
      "attributes": {
        "month": "2020-03",
        "revenue": 2892.76
      }
    }
  ]
}
```
