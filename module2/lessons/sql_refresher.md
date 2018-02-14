---
title: SQL Refresher
---

## Learning Goals

* Review SQL concepts from intermission work
* Practice writing SQL queries in a familiar database

## Warmup

* How do you determine which columns will be returned from a SQL query?
* What else do you remember from your SQL prework?

## Lesson

### Setup

Enter `psql` from your terminal. This should drop you into an interactive postgres session where you can run SQL commends from the terminal.

Note: if you get an error about no user existing, check [this](https://stackoverflow.com/questions/17633422/psql-fatal-database-user-does-not-exist) Stack Overflow post.

The first thing you will see is a helpful note to enter `help` if you need some more information about how to use this interactive session. `\?` will provide you with some terminal specific commands, while `\h` will provide you with a list of SQL commands that offer additional documentation.

In order to interact with our BikeShare database, we'll first need to connect to it. How do we know it exists or what it's named? First type `\list`. This will provide you with a list of databases avaialble to you.

In order to connect to our database, type `\c little-shop-redux-development` (or whatever `\list` tells you your database is called). Now you should be able to run SQL commands.

When you're ready to disconnect type `\q`

### Practice

With a partner, see if you can complete each of the tasks below. After each section we will check in as a group.

#### SELECT FROM LIMIT

* All of the information on the `merchants` table.
* `id`, `merchant_id`, and `description` of five items.

#### WHERE

* Items that have a merchant with an id of 12334284.
* Items that have a `unit_price` of 800.
* id, unit price, and description for items more expensive than 800.

#### max/min/count/average

* Max, min, and mean unit_price from the `items` table.
* Average price for all items.
* Id, merchant id, and description of the most expensive item.
* Id, merchant id, and description of the least expensive item.
* Count of items created after 1993-09-29.
* All information about the oldest Merchant.
* All information about the newest Merchant.

#### JOIN

* Highest items `unit_price` for merchant with id of 12334284.
* Average items `unit_price` for merchant with id of 12334284.

#### GROUP

* Count of items for each merchant.
* Name of the merchant with the most items.
* Name of the category that has the most merchants.
* Name of the category that has the least merchants.

#### ORDER

* Top five merchants with the most items.
* Top five most expensive items.
* Least popular merchant (by item count).
* `name` for the five merchants with the most items.

## Additional Resources

1. [Fundamental SQL](http://tutorials.jumpstartlab.com/topics/sql/fundamental_sql.html) (review from intermission work)
1. [SQL by repetition](http://sql-by-repetition.herokuapp.com/)
1. [Intermediate SQL](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/intermediate_sql.md)
