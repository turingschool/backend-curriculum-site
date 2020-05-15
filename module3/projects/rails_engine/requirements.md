---
layout: page
title: Rails Engine Requirements
length: 1 week
tags:
type: project
---

# 0. Set Up

1. Set Up [Rails Driver](https://github.com/turingschool-examples/rails_driver).
2. Set Up [SimpleCov](https://github.com/colszowka/simplecov) to track test coverage.

# 1. Data Importing

Copy [these CSV files](https://github.com/turingschool/sales_engine/tree/master/data) into your project and create a Rake Task to seed your database using that data.

Your Rake Task should:

* Clear your Development database to prevent data duplication
* Seed your Development database with the CSV data
* Be invokable through Rake, i.e. you should be able to run `bundle exec rake <your_rake_task_name>` from the command line
* Convert all prices before storing. Prices are in cents, therefore you will need to transform them to dollars. (`12345` becomes `123.45`)
* Reset the primary key sequence for each table you import so that new records will receive the next valid primary key.

**You do not need to test your Rake Task**

# 2. API Endpoints

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

## 2a. ReST Endpoints

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

This endpoint should destroy the corresponding record and render a JSON representation of the destroyed record.

The URI should follow this pattern: `DELETE /api/v1/<resource>/:id`

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

## 2b. Relationships

These endpoints should show related records. The relationship endpoints you should expose are:

* `GET /api/v1/merchants/:id/items` - return all items associated with a merchant.
* `GET /api/v1/items/:id/merchant` - return the merchant associated with an item

## 2c. Find Endpoints

In addition to the standard ReST endpoints, you will need to build "find" endpoints for both **Items** and **Merchants**.

### Single Finders

This endpoint should return a single record that matches a set of criteria. Criteria will be input through query parameters.

The URI should follow this pattern: `GET /api/v1/<resource>/find?<attribute>=<value>`

This endpoint should:

* work for any attribute of the corresponding resource including the `updated_at` and `created_at` timestamps.
* find partial matches for strings and be case insensitive, for example a request to `GET /api/v1/merchants/find?name=ring` would match a merchant with the name `Turing` and a merchant with the name `Ring World`.
* accept multiple attributes, for example `GET /api/v1/items/find?name=pen&description=blue`

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

Example JSON response for `GET /api/v1/merchants/find?name=ring`

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

## 2d. Business Intelligence Endpoints

Expose the following business intelligence endpoints.

**NOTE**: Only paid invoices should be counted in revenue totals or statistics. A paid invoice has at least one successful transaction.

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
