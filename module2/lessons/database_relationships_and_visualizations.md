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

* Draw a diagram of the table for `books` in your Book Club project. What information lives in that table?
* What is the relationship between a `books` and a `review`? What does this relationship look like on a database level?
* How will this relationship be set-up in the models?

### Defining Key Terms

* **Primary Key** - a key in a relational database that is unique for each record. This is also known as an `id`. It is a unique identifier, such as a driver's license, or the VIN on a car. You may have one and only one primary key value per table.
* **Foreign Key** - a foreign key is a field in one table that uniquely identifies a row of another table. A foreign key is defined in a second table, but it refers to the primary key in the first table.

### Schema / Schema Designer

* [Schema Designer](http://ondras.zarovi.cz/sql/demo/)

### One-to-Many Relationships

* The relationship between `book` and `reviews` is a one-to-many relationship.
* `reviews` has a column called `book_id` which refers to the primary key of the `books` table.
* Let's diagram the relationship using a schema designer.

**Independent Practice** - Car Dealership

A car dealership has many cars - diagram this relationship using the schema designer.

### Many-to-Many Relationships

Let's think about the relationship between books and authors.

  ```
  A book can have many authors. An author can have many books.
  ```

**Independent Practice** - Books & Authors
  Take a minute to consider how our database would need to look in order to support this feature. Add these to your diagram.


Many-to-many is a little harder than one-to-many.

Since books can have multiple authors and an author could have many books, we can implement this relationship by using a **join table**.

_**Note:** Join tables are just ordinary tables with a unique purpose._

Let's diagram the books and authors relationship using the schema designer.

**Independent Practice** - Students and Courses

Diagram the many-to-many relationship between students and courses.

## Closing

Let's revisit our learning goals by answering the following:

* What is a primary key?
* What is a foreign key?
* What is a schema?
* How does a one-to-many relationship differ from a many-to-many relationship?
* Describe the relationship between a foreign key on one table and a primary key on another table.
