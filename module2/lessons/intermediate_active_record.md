---
title: Intermediate ActiveRecord
---

## Learning Goals

* Review ActiveRecord concepts
* Introduce specific ActiveRecord methods
* Practice combining ActiveRecord methods

## Slides

Available [here](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module2/slides/intermediate_active_record.md)

## Setup

We will be using [this repository](https://github.com/turingschool-examples/election). Clone it down and follow the setup instructions included in the readme.

## Warmup

Assume a Rails app that has owners and horses.

How would you find the following in ActiveRecord?

* Average age of all horses
* Average age of horses belonging to an owner with an id of 1
* Total winnings of all horses (assume a `winnings` column on horses)
* Total winnings of all horses belonging to an owner with an id of 4

## Lesson

### Background

#### ActiveRecord is About Objects

In the Election repository, drop into a Rails console session and run the following commands.

```
> rails c
> Candidate.all
> Candidate.find(1)
> Party.find(1)
> Candidate.find(1).party
> Candidate.joins(:party)
```

Each of them returns either an object or a collection of objects.

However, frequently it can help to remember that these queries are generating SQL queries.

SQL queries generate *tables*. Each row in a table becomes an instance of the class we're using to generate the query. Each column becomes a method on that instance.

For example:

* Assuming a candidates table with the following columns:
    * `id`
    * `name`
    * `party_id`
* The ActiveRecord model Candidate will generate instances that have the following methods:
    * `#id`
    * `#name`
    * `#party_id`


#### Working with IDs

We'll be working with a lot of code snippets in the coming sections. Many of the new methods that we introduce will return collections with IDs for keys and calculations for values instead of objects. Ideally, we want to work with objects.

Later in the lesson, we'll explore how to get similar results with objects instead of just IDs and values.

#### ActiveRecord Arguments

In most cases we can use symbols/hashes. However, we can also use strings to pass raw SQL. Don't be afraid of raw SQL - it's your friend.

#### Exploration

With a partner, review the existing Election schema.

### New Methods

#### Select

Select tells the query what columns to select.

```ruby
# On Candidate
def self.no_dates
  select(:id, :name, :party_id)
end
```

#### Joins

Joins is a class method. It allows us to pull information from more than one table. This will frequently result in multiple rows with duplicate information.

The results will only include records where related records exist.

```ruby
# On the Candidate model
def self.candidates_with_primary_results
  joins(:primary_results)
end
```

* The symbol argument above uses the `has_many` that exists in the Candidate model.

#### Group

Group is used to group by a characteristic. It needs an aggregate function to replace those columns that are *not* being grouped by. For example:

* AVG
* COUNT
* MIN
* MAX
* SUM

```ruby
# On County model
# Returns a hash with IDs for keys
def self.count_by_state_id
  group(:state_id).count
end

# OR #

# On State model
# Returns a hash with State names for keys
def self.count_of_counties
  joins(:counties).group(:name).count
end
```

You can also use calculations as aggregate functions:

```ruby
# On State
# Returns a hash with State names for keys
def self.votes_by_state
  joins(:primary_results).group(:name).sum(:votes)
end
```

#### Group With Order

Order will allow us to specify the order in which our records are returned. This is especially great with `group`.

```ruby
# On State
# Returns a hash with State names for keys
def self.ordered_votes_by_state
  joins(:primary_results)
    .group(:name)
    .order("sum_votes DESC")
    .sum(:votes)
end
```

#### Getting Back to Select (So what?)

We can use `.select` to help us return objects instead of hashes. The key to this is moving the calculation into the `.select` portion of the query.

```ruby
# On State
# Returns a collection of *objects*
def self.with_votes
  joins(:primary_results)
    .select('states.id,
             states.name,
             states.abbreviation,
             SUM(primary_results.votes) AS sum_of_votes')
    .group('states.id')
end
```

## Exercise

Can you create an array of democratic candidates ordered by the number of results they received that also responds to `total_votes`?

```
# rails c
> candidates = YOUR QUERY HERE
> candidates.first.name
> "Hillary Clinton"
> candidates.first.total_votes
# => 15692452
```

* How would you make this into a method on your Candidate model?

