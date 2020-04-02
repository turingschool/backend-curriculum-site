---
layout: page
title: Rales Engine
length: 1 week
tags:
type: project
---


## Project Description

In this project, you will use Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema.

The project requirements are listed below:

  * [Learning Goals](#learning-goals)
  * [Technical Expectations](#technical-expectations)
  * [Check-ins](#check-ins-and-milestones)
  * [Evaluation](#evaluation)

## Learning Goals

  * Learn how to to build Single-Responsibility controllers to provide a well-designed and versioned API.
  * Learn how to use controller tests to drive your design.
  * Use Ruby and ActiveRecord to perform more complicated business intelligence.


## Technical Expectations
  * All endpoints will expect to return JSON data
  * All endpoints should be exposed under an `api` and version (`v1`)
namespace (e.g. `/api/v1/merchants`)
  * JSON responses should include `ids` only for associated records unless otherwise indicated (that is, don't embed the whole associated record, just the id)
  * Prices are in cents, therefore you will need to transform them in dollars. (`12345` becomes `123.45`)
  * API will be compliant to the JSON API spec. [Documentation](https://jsonapi.org/)

### Data Importing

  * You will create an ActiveRecord model for each
  entity included in the [sales engine data](https://github.com/turingschool/sales_engine/tree/master/data).
  * Your application should include a rake task which imports all of the CSV's and creates the corresponding records.

### Record Endpoints

#### Index of Record

  Each data category should include an `index` action which
  renders a JSON representation of all the appropriate records:

##### Request URL

  `GET /api/v1/merchants`

##### JSON Output

(The following is an example of a response if only three records were saved in the database)

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

#### Show Record

Each data category should include a `show` action which
renders a JSON representation of the appropriate record:

##### Request URL

`GET /api/v1/merchants/1`

##### JSON Output

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

#### Single Finders

Each data category should offer a `find` endpoint to return a single object representation. The endpoint should work with any of the attributes defined on the data type and always be case insensitive.

##### Request URL

```
GET /api/v1/merchants/find?parameters
```

##### Request Parameters


| parameter  | description                          |
|------------|--------------------------------------|
| id         | search based on the primary key      |
| name       | search based on the name attribute   |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |

##### JSON Output

`GET /api/v1/merchants/find?name=Schroeder-Jerde`

```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Schroeder-Jerde"
    }
  }
}
```

#### Multi-Finders

Each category should offer a `find_all` endpoint which should return all matches for the given query. It should work with any of the attributes defined on the data type and always be case insensitive.

##### Request URL

`GET /api/v1/merchants/find_all?parameters`

##### Request Parameters

| parameter  | description                          |
|------------|--------------------------------------|
| id         | search based on the primary key      |
| name       | search based on the name attribute   |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |

##### JSON Output

`GET /api/v1/merchants/find_all?name=Cummings-Thiel`

```json
{
  "data":
  [
  {
    "id": "4",
    "type": "merchant",
    "attributes": {
      "name": "Cummings-Thiel"
    }
  }
  ]
}
```

Note: Although this search returns one record, it comes back in an array.

#### Random

##### Request URL

Returns a random resource.

`api/v1/merchants/random`

```json
{
  "data": {
    "id": "23",
    "type": "merchant",
    "attributes": {
      "name": "Thing Thingers"
    }
  }
}
```

### Relationship Endpoints

In addition to the direct queries against single resources, we would like to also be able to pull relationship data from the API.

We'll expose these relationships using nested URLs, as outlined in the sections below.

#### Merchants

* `GET /api/v1/merchants/:id/items` returns a collection of items associated with that merchant
* `GET /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

#### Invoices

* `GET /api/v1/invoices/:id/transactions` returns a collection of associated transactions
* `GET /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/invoices/:id/items` returns a collection of associated items
* `GET /api/v1/invoices/:id/customer` returns the associated customer
* `GET /api/v1/invoices/:id/merchant` returns the associated merchant

#### Invoice Items

* `GET /api/v1/invoice_items/:id/invoice` returns the associated invoice
* `GET /api/v1/invoice_items/:id/item` returns the associated item

#### Items

* `GET /api/v1/items/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/items/:id/merchant` returns the associated merchant

#### Transactions

* `GET /api/v1/transactions/:id/invoice` returns the associated invoice

#### Customers

* `GET /api/v1/customers/:id/invoices` returns a collection of associated invoices
* `GET /api/v1/customers/:id/transactions` returns a collection of associated transactions

### Business Intelligence Endpoints

We want to maintain the original Business Intelligence functionality
of SalesEngine, but this time expose the data through our API.

Remember that ActiveRecord is your friend. Much of the complicated logic
from your original SalesEngine can be expressed quite succinctly
using ActiveRecord queries.

#### All Merchants

* `GET /api/v1/merchants/most_revenue?quantity=x` returns the top `x` merchants ranked by total revenue
* `GET /api/v1/merchants/revenue?date=x` returns the total revenue for date `x` across all merchants

Assume the dates provided match the format of a standard ActiveRecord timestamp.

#### Single Merchant

* `GET /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.

#### Items

* `GET /api/v1/items/most_revenue?quantity=x` returns the top `x` items ranked by total revenue generated

* `GET /api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

#### Customers

* `GET /api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions

_NOTE_: Failed charges should never be counted in revenue totals or statistics.

_NOTE_: All revenues should be reported as a float with two decimal places.

#### Extensions
<!--
#### All Merchants

* `GET /api/v1/merchants/most_items?quantity=x` returns the top `x` merchants
ranked by total number of items sold -->

#### Single Merchant

* **BOSS MODE:** `GET /api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices. A pending invoice has no transactions with a result of `success`. This means all transactions are `failed`. Postgres has an `EXCEPT` operator that might be useful. `ActiveRecord` also has a `find_by_sql` that might help.

<!--
* `GET /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across successful transactions
* `GET /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date `x` -->

<!-- #### Items

* `GET /api/v1/items/most_items?quantity=x` returns the top `x` item instances ranked by total number sold -->


## Code Expectations

### Controller Actions

It's expected that you limit your controller actions to only the standard Rails actions.
For endpoints such as `GET /api/v1/merchants/find?parameters` the initial thought might be to do something like this:

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

## Milestones & Feedback

#### Milestones

The organization of this project spec is by feature type. However, much of the unfamiliar or more difficult work is in the business intelligence portion of the project. To the degree possible instructors encourage you to use an agile approach to completing this assignment. Furthermore, we encourage you to review the work and develop estimated milestones before you begin. **Any good set of milestones will allow for some slippage before the project is due.**

There is an Advanced ActiveRecord class scheduled for Wednesday. We *highly* encourage you to have attempted some of the business intelligence queries before that class.

#### What to expect from instructors

There will not be formal check-ins for this project. Instructors will generally be available during scheduled work time to discuss issues absent other commitments. Students should also view this as an opportunity to practice discussing code on GitHub, and instructors will prefer reviewing PRs to discussing code on Slack.

In their reviews, instructors will go over whatever technical, planning or other challenges you're having. They also may give you feedback, or suggest a different path than the one you're on.

## <a name="evaluation"></a> Evaluation

### Feature Delivery

Feature completeness will be determined using the [spec harness](https://github.com/turingschool/rales_engine_spec_harness)

**1. Completion**

* 4: Project completes all base requirements according to the spec harness plus one or more extensions.
* 3: Project completes all base requirements according to the spec harness.
* 2: Project completes most requirements but fails 4 or fewer spec harness tests.
* 1: Project fails more than 5-8 spec harness tests.

### Technical Quality

**1. Test-Driven Development**

* 4: Project demonstrates high test coverage (>90%) and tests at the controller and unit levels.
* 3: Project demonstrates high test coverage (>80%) and tests at the controller and unit levels.
* 2: Project demonstrates high test coverage (>70%) but does not adequately balance controller and unit tests.
* 1: Project does not have 70% test coverage.

**2. Code Quality**

* 4: Project demonstrates exceptionally well factored code.
* 3: Project demonstrates solid code quality and MVC principles.
* 2: Project demonstrates some gaps in code quality and/or application of MVC principles.
* 1: Project demonstrates poor factoring and/or understanding of MVC.

**3. API Design**

* 4: Project exemplifies API design idioms, with consistent and coherent response structures, serializers to format JSON data, and effective request format handling.
* 3: Project uses strong and consistent data formats throughout, while relying mostly on standard Rails JSON features.
* 2: Project has inconsistencies or gaps in how its JSON data is organized or formatted.
* 1: Project's API is not fully functional or has significant confusion around request formats.

**4. Queries**

* 4: Project makes great use of ActiveRecord relationships and queries, including some advanced query functionality such as `joins` and `select` to create virtual attributes.
* 3: Project makes good use of `ActiveRecord`, but drops to ruby enumerables for some query methods.
* 2: Project has some gaps in ActiveRecord usage, including numerous business methods that rely on ruby enumerables to find the appropriate data.
* 1: Project struggles to establish a coherent ActiveRecords schema, including missing relationships or dysfunctional queries.

## Peer Review

### Independent Review of Your Partner's Code

Clone and setup your parter's code on your machine.

* Is their README clear?
* Would a potential employer be able to understand the setup instructions and easily get this running on their machine?

#### Scaling Back the Number of Queries

When writing Ruby, we should generally prefer to work with instance methods since this tends to lead to object oriented code. However, SQL isn't object oriented and therefore ActiveRecord isn't truly OO. For this reason class methods tend to be more performant when writing ActiveRecord queries.

Example:

```ruby
class User < ApplicationRecord
  has_many :articles

  def animal_articles
    articles.where(category: "animals")
  end
end

# makes two queries
user = User.find 1 # first query
animal_articles = user.animal_articles # second query
```

```ruby
class Article < ApplicationRecord
  def self.animals(filter = {})
    where(category: "animals").where(filter)
  end
end

# This example makes one query
animal_articles = Article.animals(user_id: 1)
```

**Put it into Practice**

* Using this technique, are there any places in your partner's codebase where we can cut back on the number of queries being made?
* If not, are there any places you see they were able to cut back on queries that you might have missed in your own codebase?

#### Making Code More Flexible

Possibly the most important thing to strive for when building software is for it to be maintainable and easy to expand.

In the `Article` class above...
* what happens if we call `Article.animals` with no parameter? *Hint:* If you want to try this in your app, call `.where({})` or `.where(nil)` on any ActiveRecord class and look at the SQL that gets generated.
* does `.animals` limit what attributes we can filter by?
* how many filters can we send `.animals` at once?

**Put it into Practice**

Business concepts are frequently reusable and it's common to find variations of the same business intelligence logic in multiple places. Repeating logic leads to maintenance difficulties and sometimes inconsistent ways of accomplishing the same task.

* Does the project call two separate methods in `Merchant` for the `GET /api/v1/merchants/:id/revenue` and `GET /api/v1/merchants/:id/revenue?date=x` endpoints?
* If yes, how much of the logic is the same?
* If no, is there a conditional statement with most of the same logic in each branch?
* Can you refactor this method in a way that makes use of the `.where({})` technique above?
* What else will this allow you to filter the `revenue` by?

#### Dealing with Random

* Why do models inherit from `ApplicationRecord` instead of `ActiveRecord::Base`?

**Put it into Practice**

* Does this project define a `.random` method in `ApplicationRecord`?
  - If no...
    * Create one.
  - If yes...
    * Did you do this in your project?
      - No...
        * Add it to your project.
      - Yes...
        * Does your definition look the same?
* Different ways to define `random`
  * Postgres has a `RANDOM` function you can use.
  * That's specific to this database and isn't flexible if we ever need to switch it to MySQL.
  * On small datasets `RANDOM` is usually faster. On large datasets it can be slower than [using an offset based on count](https://stackoverflow.com/questions/2752231/random-record-in-activerecord).
  * What could we do if we've defined `.random` in `ApplicationRecord` but one model is experiencing a performance issue with that definition due to a different size of dataset?

### With Your Partner

* Go through each section above and discuss your findings.
* Did you come to the same conclusions?
* Is there anything that is still fuzzy?
