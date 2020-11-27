---
layout: page
title: Rails Engine Requirements
length: 1 week
tags:
type: project
---

# 1. Set Up

1. Create a folder called "rails-engine" and inside of that folder, do the following:
   1. Clone [Rails Driver](https://github.com/turingschool-examples/rails_driver).
   2. Run your `rails new ...` instruction to create a project called `rails-engine`
2. Set Up [SimpleCov](https://github.com/colszowka/simplecov) to track test coverage in your rails-engine API project.

# 2. Data Importing

You will need to replace your `db/seeds.rb` file with the following content. When you run `rake db:{drop,create,migrate,seed}`, you will see some errors/warnings that you can safely ignore, but if think it didn't work properly, ask an instructor for guidance.

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

```

- Create migration files for the 5 tables created by this `pg_restore` application. (merchants, customers, invoices, invoice_items, transactions)
  - use a tool like Postico to examine the database tables for the correct data types and relationships
- Create a migration file for the "items" table, based on the provided "items.csv" file

Data Files: (put both of these inside a folder called `db/data` in your Rails API project)
- [items.csv](https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/items.csv)
  - be sure to use the ID values in this CSV file, or the database will not work correctly!
  - convert all prices from pennies to dollars/cents before you save them in the database, or the spec harness tests will not succeed!
- [rails-engine-development.pgdump](https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/rails-engine-development.pgdump)
  - this file is in a binary format and your browser may try to automatically download the file instead of viewing it

Once the "items.csv" file is finished importing in `db/seeds.rb`, add instructions in that file to use ActiveRecord to reset the Primary Key sequences in PostgreSQL for all 6 tables.

# 3. API Endpoints

You will need to expose the data through a multitude of API endpoints. All of your endpoints should follow these technical expectations:

* All endpoints should be fully tested. The Rails Driver Spec Harness is not a substitute for writing your own tests.
* All endpoints will expect to return JSON data
* All endpoints should be exposed under an `api` and version (`v1`) namespace (e.g. `/api/v1/merchants`)
* API will be compliant to the [JSON API spec](https://jsonapi.org/)
* Controller actions should be limited to only the standard Rails actions. For endpoints such as `GET /api/v1/merchants/find?parameters` the initial thought might be to do something like this:

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

## 3a. ReST Endpoints

You will need to expose Restful API endpoints for both **Items** and **Merchants**.

The endpoints you need to expose are:

### Index of Resource

This endpoint renders a JSON representation of all records of the requested resource.

The URI should follow this pattern: `GET /api/v1/<resource>`

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

### Show Record

This endpoint renders a JSON representation of the corresponding record.

The URI should follow this pattern: `GET /api/v1/<resource>/:id`

Example JSON response for the Merchant resource:

```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Store Name"
    }
  }
}
```

### Create Record

This endpoint should create a record and render a JSON representation of the new record.

The URI should follow this pattern: `POST /api/v1/<resource>`

The body should follow this pattern:

```
{
  "attribute1": "value1",
  "attribute2": "value2",
}
```

Example JSON response for the Merchant resource:

```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Store Name"
    }
  }
}
```

### Update Record

This endpoint should update the corresponding record and render a JSON representation of the updated record.

The URI should follow this pattern: `PATCH /api/v1/<resource>/:id`

The body should follow this pattern:

```
{
  "attribute1": "value1",
  "attribute2": "value2",
}
```

Example JSON response for the Merchant resource:

```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Store Name"
    }
  }
}
```

### Destroy Record

This endpoint should destroy the corresponding record (and any associated data, eg if you delete a merchant you should delete their items too). Since this is a permanent destruction of data, we do not return any response body of any kind, and should send a 204 HTTP status code.

*Extension*: when you delete an item, you will delete entries in the invoice_items table per the work above. This, however, might leave invoices in the database with no items at all, so you should find a way to clean those up, too.


## 3b. Relationships

These endpoints should show related records. The relationship endpoints you should expose are:

* `GET /api/v1/merchants/:id/items` - return all items associated with a merchant.
* `GET /api/v1/items/:id/merchants` - return the merchant associated with an item

## 3c. Find Endpoints

In addition to the standard ReST endpoints, you will need to build "find" endpoints for both **Items** and **Merchants**.

### Single Finders

This endpoint should return a single record that matches a set of criteria. Criteria will be input through query parameters.

The URI should follow this pattern: `GET /api/v1/<resource>/find?<attribute>=<value>`

This endpoint should:

* work for any attribute of the corresponding resource including the `updated_at` and `created_at` timestamps.
* find partial matches for strings and be case insensitive, for example a request to `GET /api/v1/merchants/find?name=ring` would match a merchant with the name `Turing` and a merchant with the name `Ring World`.
_Note: It does_ __NOT__ _need to accept multiple attributes, for example_ `GET /api/v1/items/find?name=pen&description=blue`

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

### Multi-Finders

This endpoint should return all records that match a set of criteria. Criteria will be input through query parameters.

The URI should follow this pattern: `GET /api/v1/<resource>/find_all?<attribute>=<value>`

This endpoint should follow all of the same requirements for matching as the Single Finder endpoints.

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

## 3d. Business Intelligence Endpoints

Expose the following business intelligence endpoints.

**HINT**: Invoices must have a successful transaction and shipped to the customer to be considered as revenue.

### Merchants with Most Revenue

This endpoint should return a variable number of merchants ranked by total revenue.

The URI should follow this pattern: `GET /api/v1/merchants/most_revenue?quantity=x`

where `x` is the number of merchants to be returned.


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

### Merchants with Most Items Sold

This endpoint should return a variable number of merchants ranked by total number of items sold:

The URI should follow this pattern: `GET /api/v1/merchants/most_items?quantity=x`

where `x` is the number of merchants to be returned.

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

### Revenue across Date Range

This endpoint should return the total revenue across all merchants between the given dates.

The URI should follow this pattern: `GET /api/v1/revenue?start=<start_date>&end=<end_date>`

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

### Revenue for a Merchant

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
