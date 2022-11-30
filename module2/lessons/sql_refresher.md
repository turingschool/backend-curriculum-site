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
This activity relies on a pre-created database. Make sure you have created and seeded the database from your little-shop-redux. If you do not have a little-shop-redux, you can pull down a completed version [here](https://github.com/kolyaventuri/little-shop-redux/tree/d14150d9b0e004db6057b42f2b3c933723f996cc).

Enter `psql` from your terminal. This should drop you into an interactive postgres session where you can run SQL commands from the terminal.

Note: If you get an error that says something like `Database username "YOUR_NAME" does not exist.` you will need to create a database that shares the username. Run `createdb "YOUR_NAME"` and re-run psql.

The first thing you will see is a helpful note to enter `help` if you need some more information about how to use this interactive session. `\?` will provide you with some terminal specific commands, while `\h` will provide you with a list of SQL commands that offer additional documentation.

In order to interact with our LittleShop database, we'll first need to connect to it. How do we know it exists or what it's named? First type `\list`. This will provide you with a list of databases avaialble to you.

In order to connect to our database, type `\c little-shop-development` (or whatever `\list` tells you your database is called). Now you should be able to run SQL commands.

When you're ready to disconnect type `\q`

### Practice

With a partner, see if you can complete each of the tasks below. After each section we will check in as a group.

#### SELECT FROM LIMIT

* All of the information on the `merchants` table.
* `id`, `merchant_id`, and `description` of five items.

#### WHERE

* Items that have a merchant with an id of 12334284.
* Items that have a `price` of 800.
* id, price, and description for items more expensive than 800.

#### Aggregate Functions
(Complete these without using Order)

* Max, and min price from the `items` table.
* Average price for all items.
* Id, merchant id, and description of the most expensive item.
* Id, merchant id, and description of the least expensive item.
* Count of items created after 1993-09-29.
* All information about the oldest Merchant.
* All information about the newest Merchant.

#### JOIN

* Highest items `price` for merchant with id of 12334284.
* Average items `price` for merchant with id of 12334284.

#### GROUP

* Count of items for each merchant.
* Total price of all items for each merchant.
* Total income for each merchant.

#### ORDER

* Name of the merchant with the most items.
* Top five merchants with the most invoices.
* Top 10 most expensive items.
* Least prolific merchant (by item count).
* `name` for the five merchants with the most items.

#### Extensions

* Total of each invoice for each merchant.
* Merchant ID and Invoice ID for the top 5 least expensive invoices.
* Merchant ID and Invoice ID for the top 5 most expensive invoices.

## Additional Resources

1. [Fundamental SQL](http://tutorials.jumpstartlab.com/topics/sql/fundamental_sql.html) (review from intermission work)
1. [Intermediate SQL](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/intermediate_sql.md)
