---
title: SQL Intermission Work
layout: page
---

SQL is a programming language used to interact with a database. Learning to interact with databases is crucial to your work as a backend developer. While we eventually want to use libraries that will write SQL for us, it is important to be familiar with how SQL works under the hood so that you understand what your code is doing at the database level.

For your SQl intermission work, you will complete an introductory tutorial, and then will complete some exercises to help you practice the most important SQL concepts. This assignment is meant as an introduction to sql, so don't be alarmed if you don't feel like you have mastered these concepts. Use the accompanying Checks for Understanding to assess yourself.

## Jumpstart Lab Tutorial

Work through the [Jumpstart Lab SQL Tutorial](http://tutorials.jumpstartlab.com/topics/sql/fundamental_sql.html), **but do not complete the "Sequel" tutorial linked at the bottom of the Jumpstart Lab page.** Then complete the Checks for Understanding.

### Checks for Understanding

1. What is a database?
1. What is SQL?
1. What is SQLite3?
1. What is a Table?
1. What is a primary key?
1. What is a foreign key?
1. Explain what each of the following SQL commands do:
  * insert
  * select
  * where
  * order by
  * inner join

## SQL Exercises

Now you'll work through some of the exercises at [pgexercises.com](https://pgexercises.com/). In the Jumpstart Lab tutorial, you used SQLite3. In these exercises, you will use Postgresql. It's largely the same, but make sure that when you are looking at documentation you are looking at the [Postgresql Documentation](https://www.postgresql.org/docs/9.3/index.html).

Work through the three following sections (Basic, Joins, Aggregates) of exercises on the site. Make sure you are also reading the Answers and Discussion section at the bottom, even if you get the answer right. There are some helpful explanations and alternative solutions.

To reiterate from before, you do not need to be a master of SQL coming out these exercises, so you should **timebox these exercises**. Timebox each of the three sections to **no more than 2 hours** for a maximum of 6 hours spent on these exercises. There will likely be exercises that you have difficulty completing, and that's okay! Use the provided hints, give it your best effort, and skip to the answer if you can't get it. Just make sure you read and understand the answer before moving on.

After you complete the exercises, answer the Checks for Understanding.

### Basics

1. [Getting Started](https://pgexercises.com/gettingstarted.html). Skip the "I want to use my own Postgres system" at the end.
1. [Select All](https://pgexercises.com/questions/basic/selectall.html)
1. [Selecting Columns](https://pgexercises.com/questions/basic/selectspecific.html)
1. [Where](https://pgexercises.com/questions/basic/where.html)
1. [Where 2](https://pgexercises.com/questions/basic/where2.html)
1. [String Search](https://pgexercises.com/questions/basic/where3.html)
1. [Where 3](https://pgexercises.com/questions/basic/where4.html)
1. [Case](https://pgexercises.com/questions/basic/classify.html)
1. [Dates](https://pgexercises.com/questions/basic/date.html)
1. [Unique and Order](https://pgexercises.com/questions/basic/unique.html)
1. [Basic Aggregate](https://pgexercises.com/questions/basic/agg.html)

### Joins

1. [Intro to Joins](https://pgexercises.com/questions/joins/simplejoin.html)
1. [More Joins](https://pgexercises.com/questions/joins/simplejoin2.html)
1. [Joining a Table to Itself](https://pgexercises.com/questions/joins/self.html)
1. [Multiple Joins](https://pgexercises.com/questions/joins/threejoin.html)
1. [Multiple Joins 2](https://pgexercises.com/questions/joins/threejoin2.html)

### Aggregates

1. [Count](https://pgexercises.com/questions/aggregates/count.html)
1. [More Counting](https://pgexercises.com/questions/aggregates/count2.html)
1. [Group](https://pgexercises.com/questions/aggregates/count3.html)
1. [Sum](https://pgexercises.com/questions/aggregates/fachours.html)
1. [More Summing](https://pgexercises.com/questions/aggregates/fachoursbymonth.html)
1. [Having](https://pgexercises.com/questions/aggregates/fachours1a.html)
1. [Aggregates and Joins](https://pgexercises.com/questions/aggregates/facrev.html)

### Checks for Understanding

1. How can you limit which columns you select from a table?
1. How can you limit which rows you select from a table?
1. How can you give a selected column a different name in your output?
1. How can you sort your output from a SQL statement?
1. What is joining? When do you need to join?
1. What is an aggregate function?
1. List three aggregate functions and what they do.
1. What does the `group` statement do?
1. How does the `group` statement relate to aggregates?
