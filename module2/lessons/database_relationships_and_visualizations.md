---
title: Database Visualization and Relationships
length: 90
tags: database, schema, relationships
---

## Goals

* Define foreign key, primary key, schema
* Define one-to-many and many-to-many relationships
* Describe the relationship between a foreign key on one table and a primary key on another table.
* Use a schema designer to outline attributes of tables
* Diagram a one-to-many relationship
* Diagram a many-to-many relationship

## Vocabulary

* Foreign Key
* Primary Key
* One-to-Many Relationship
* Many-to-Many Relationship

## Warm-Up
1) Draw a diagram showing which tables we currently have in our Task Manager database. What information lives in that table?

2) In our recent Task Manager client meeting, our client decided their application should scope tasks to a user.
   Based on our conversation, we've decided:

     Users should have tasks.

     Right now, our database only supports tasks. Take a minute to consider what changes we would need to make to our database in order to support the features requested by our client. Add these to your diagram.

### Defining Key Terms

* **Primary Key** - a key in a relational database that is unique for each record. This is also known as an `id`. It is a unique identifier, such as a driver's license, or the VIN on a car. You may have one and only one primary key value per table.
* **Foreign Key** - a foreign key is a field in one table that uniquely identifies a row of another table. A foreign key is defined in a second table, but it refers to the primary key in the first table.

### Schema / Schema Designer

* [Schema Designer](http://ondras.zarovi.cz/sql/demo/)

### One-to-Many Relationships

* The relationship between `users` and `tasks` is a one-to-many relationship.
* `tasks` has a column called `user_id` which refers to the primary key of the `users` table.
* Let's diagram the relationship using a schema designer.

**Independent Practice** - Car Dealership

A car dealership has many cars - diagram this relationship using the schema designer.

### Many-to-Many Relationships

In our recent Task Manager client meeting, our client also decided their users should be able to organize their tasks by marking them with labels. Based on our conversation, we've decided:

  ```
  Users should have tasks. Tasks should have labels.
  ```
  
**Independent Practice** - Labels & Tasks
  Take a minute to consider what changes we would need to make to our database in order to support the features requested by our client. Add these to your diagram.


Many-to-many is a little harder than one-to-many.

Imagine if we wanted to also label all of our tasks that we've created. Labels can belong to many tasks, while at the same time, a task can have many labels. We can implement this relationship by using a **join table**.

_**Note:** Join tables are just ordinary tables with a unique purpose._

Let's diagram the tasks and labels relationship using the schema designer.

**Independent Practice** - Students and Courses

Diagram the many-to-many relationship between students and courses.

## Closing

Let's revist our learning goals by answering the following:

* What is a primary key?
* What is a foreign key?
* What is a schema?
* How does a one-to-many relationship differ from a many-to-many relationship?
* Describe the relationship between a foreign key on one table and a primary key on another table.
