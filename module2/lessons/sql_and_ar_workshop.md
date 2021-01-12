---
layout: page
title: SQL and ActiveRecord Workshop
---

## Learning Goals
1. Get more practice using the more advanced SQL techniques like joins, grouping, and aggregating
1. Use ActiveRecord, SQL, or both to implement queries

## Instructions

Choose one of the following problem sets to work on. You will group up with students who are working on the same problem set.

With your group, work on the problem set. Try to pseudocode the problem first, then check your solution using `rails dbconsole` or `rails c`. You will all have the same data sets, so you should be able to reliably check your query on two different development environments and attain the same results.

### Testing is optional. Say What? If you do decide to test...

Work together to create the feature test and then the queries. Based on how you set up the data/objects in the test, you should be able to reasonably expect a desired result.

## Problem Set 1 (Spicy)

As a merchant
When I visit my dashboard, I see an area with statistics:

1. Top 5 items I have sold by quantity, and the quantity of each that I've sold. Only items on "shipped" orders should be considered sold.
1. Top 3 customers by morning revenue (Orders before 12:00PM)
1. All customers with failed transactions ordered by name
1. Top 3 merchants that have lost the most revenue because of failed transactions
1. Top 3 customers who have spent the most money on my items, and the total amount they've spent.

## Problem Set 2 (Less Spicy)

As an admin
When I visit the items index page ("/items")

I see an area with statistics:

1. The 5 most expensive items.
1. The top 5 merchants by count of items.
1. The 5 best selling items. This is determined by the total revenue the item has generated. Revenue should only be counted for "shipped" orders.
1. The names of the 5 customers who have placed the most orders.
1. The top 5 merchants by number of items sold.
