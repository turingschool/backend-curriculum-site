---
layout: page
title: SQL and ActiveRecord Workshop
---

## Instructions

Choose one of the following problem sets to work on. Group up with students who are working on the same problem set.

With your group, work on the problem set. Try to whiteboard the problem first, then check your solution using `rails dbconsole` or `rails c`.

## Problem Set 1

As a merchant admin
When I visit my dashboard, I see an area with statistics:

1. top 5 items I have sold by quantity, and the quantity of each that I've sold. Only items on "shipped" orders should be considered sold.
1. top 3 states where my items were shipped, and their quantities.
1. top 3 city/state where my items were shipped, and their quantities (Springfield, MI should not be grouped with Springfield, CO)
1. List of all of my items that have an average rating of 4 or greater that were never ordered by one of my employees.
1. top 3 users who have spent the most money on my items, and the total amount they've spent.

## Problem Set 2

As any kind of user on the system
When I visit the items index page ("/items")
I see an area with statistics:

1. The 5 most expensive items.
1. The top 5 merchants by count of items.
1. The 5 best selling items. This is determined by the total revenue the item has generated. Revenue should only be counted for "shipped" orders.
1. The names of the 5 users who have placed the most orders.
1. The top 5 merchants by number of items sold.
