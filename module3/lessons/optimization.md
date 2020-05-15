---
title: Intro to Optimization
length: 120
tags: ruby, rails, activerecord, sql
---

In this lesson, you will be explore an application with a large dataset. Production databases are often very large and present new challenges that we don't often face in our development environments. We will explore various parts of the application that are problematic, try to understand why they are problematic, and discuss some potential solutions to these problems. At the end of this lesson, you will find more resources to help implement those solutions.

## Learning Goals

* Gain exposure to some common problems with large production databases
* Familiarize yourself with some optimization strategies

## Set Up

First, follow the instructions in the readme to set up [this Repo](https://github.com/turingschool-examples/optimization).

## Rails Server

As you go through these activities, use the output from `rails server` to analyze performance. The `rails server` gives you some very important information. Pay close attention to:

* The last line of output for each request. This will tell you the total load time, as well a breakdown of what contributed to the load time (ActiveRecord and Views)
* The SQl queries executed for each request. Pay attention to both the number of queries, as well as the time for each query.

## Activity 1

1. Run `rails server` and visit `localhost:3000`
1. Log in as an admin
    * email: `admin@email.com`
    * password: `password`
1. In the nav bar, click on `Users`. Alternatively, visit `/admin/users`
1. Click on `Send Promotional Email`

Then, discuss the following questions:

* What happens when you click `Send Promotional Email`?
* Why does it take so long?
* How many users exist in the database? How long would this take if the number of users increased 10x? 100x? 1000x?
* At a high level, how could you make this operation less painful?

## Activity 2

1. Stay logged in as an admin
1. In the nav bar, click on `Dashboard`. Alternatively, visit `/admin`
1. Look at the output from your `rails server`.
    * Refresh the page a couple of times and see if the output differs
    * Do you see anything that says `CACHE`? If so, restart your `rails server` and refresh the page. Did anything change? Why or why not?

Then, discuss the following questions:

* Does this operation take a long time? Is it painful for the user?
* How many orders exist in the database? How long would this take if the number of orders increased 10x? 100x? 1000x?
* Look at the output from `rails server`. What is wrong with it? Find the exact line of code that is causing this issue?
* At a high level, how could you make this operation less painful?

## Activity 3

1. In the nav bar, click on `Items`

Then, discuss the following questions:

* What is contributing most to this page load time? How do you know?
* For the information displayed on this page, which pieces of data need to be as accurate as possible? Are there any that can be "close enough"?
* At a high level, how could you make this operation less painful?

## Additional Resources

* [Caching in Rails](./caching_in_rails)
* [Optimization Dojo](./performance_dojo)
* [Background Workers](./background_workers)
