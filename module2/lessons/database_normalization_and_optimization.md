---
title: Database Normalization and Optimization
length: 60
tags: database, schema, relationships
---

## Goals

* Describe "normalization" of a database
* Describe some best practices around optimization of tables
* Describe how indexing mechanics work at a high level


## Vocabulary

* Normalization
* B-Tree


## Warm-Up

1) Clone (or re-use) the [roster repo](https://github.com/turingschool-examples/roster). Run `bundle` to install any missing gems, then run `rake db{create,migrate,seed}`.

2) Re-familiarize yourself with using the `psql` command-line utility for PostgreSQL. From a terminal prompt, run `psql roster-development`. Use `\q` within the psql shell to exit back to your terminal prompt.


### Defining Key Terms

* **Normalization** - An optimization and reorganization of database tables that removes data duplication
* **B-Tree** - A data structure, a generalized version of a "binary tree", sometimes called a "trie", which is commonly used for storing indexes within PostgreSQL


## Normalization

"Normalization" is usually done by examining our database table structure to look for duplicated data, usually strings, and find ways to replace those values with something which is faster to store and search.

For example, our students table in our roster codebase has content which contains a student id, a student name, a course_id, and a score. While this purpose is suited for a small application like this, a more scalable version of our data would split the responsibility of this table into multiple pieces.

Currently, the table holds three sets of data:

- student identification
- a relationship to a course for that student
- a score for that student within the course

This technically breaks the idea of "single responsibility" and becomes a great target for normalization.

### Examining a table definition in ActiveRecord Models vs PostgreSQL

Open `/db/schema.rb` from our codebase and examine the definition for the `students` table:

```ruby
create_table "students", force: :cascade do |t|
  t.string "first_name"
  t.string "last_name"
  t.bigint "course_id"
  t.integer "score"
  t.index ["course_id"], name: "index_students_on_course_id"
end
```

A better breakdown of this data might look like this:

- a student model that only contains a student id, and their name
- a model that links a student id and a course id for enrollment (we'll call this the "student/course" join table)
- a model that a student would have a score, through the student/course join table

**Pair with a partner to sketch what these new tables might look like and how you might make migrations to move data from one table to another.**

As a class, discuss the pros and cons of making these changes.


## How are tables and indexes actually stored in PostgreSQL

Based on the `belongs_to` and `has_many` attributes in our `/app/models/student.rb` and `/app/models/course.rb`, we can see how ActiveRecord constructs our tables. But what do these actually look like in PostgreSQL? Let's take a look.

Run `psql roster-development` in a new terminal window. Here, we can execute a SQL command to list all of our students:

```
roster-development=# select * from students;
 id | first_name | last_name | course_id | score
----+------------+-----------+-----------+-------
  1 | Sal        | Espinosa  |         2 |     3
  2 | Ilana      | Corson    |         2 |     4
  3 | Josh       | Mejia     |         3 |     3
  4 | Casey      | Cumbow    |         4 |     4
  5 | Ali        | Schlereth |         1 |     3
  6 | Victoria   | Vasys     |         1 |     4
  7 | Mike       | Dao       |         1 |     3
(7 rows)
```

This, however, doesn't tell us very much about the table itself, only the data within it. Let's examine the *structure* of the table:

```
roster-development=# \d students
                                   Table "public.students"
   Column   |       Type        | Collation | Nullable |               Default
------------+-------------------+-----------+----------+--------------------------------------
 id         | bigint            |           | not null | nextval('students_id_seq'::regclass)
 first_name | character varying |           |          |
 last_name  | character varying |           |          |
 course_id  | bigint            |           |          |
 score      | integer           |           |          |
Indexes:
    "students_pkey" PRIMARY KEY, btree (id)
    "index_students_on_course_id" btree (course_id)
```

This view allows us to see how ActiveRecord's schema actually built the table in PostgreSQL. Other databases like SQLite and MySQL will use different 'types' for the fields, and may use different index types, but let's break this down into its components.

**Pair up and examine the following:**

- we see the `id` field and `course_id` fields are a type called `bigint` -- what is a `bigint` data type?
- a "varying" character type used for the student's first and last names means the database will accept a string of changing length, instead of a fixed-length string (eg, this field is always 15-characters long)
- the `score` field is an `integer` -- how is that different from a `bigint`?
- we can also see that the `id` field is marked as `not null` -- what does this mean?
- the "default" value for an `id`, if not provided, will use a `sequence` ("seq") -- what is a `sequence` in PostgreSQL?

### What are "btree" indexes?

We can also see from the output that we have a single `PRIMARY KEY` on our `(id)` field, which uses a `btree` type, and that our `course_id` field also uses a `btree` index type.

A b-tree is like the "prefix" tree that you may have used in the [Complete Me](http://backend.turing.io/module1/projects/complete_me) project in Mod 1, where each node in the tree can have multiple children. We won't dive into the theory of it, but this is the most-used index type within PostgreSQL.


## Additional Resources

- the theory of [b-tree data structures](https://en.wikipedia.org/wiki/B-tree)
- [DevShed - An Introduction to Database Normalization](http://www.devshed.com/c/a/mysql/an-introduction-to-database-normalization/)
- [Mike Hillyer's Blog Post - intro to database normalization](http://mikehillyer.com/articles/an-introduction-to-database-normalization/)
- [Watch Sharif Ramadan's intro to 1NF, 2NF and 3NF databases. They're only about 4 minutes each.](https://www.youtube.com/watch?v=K7vzLrGCV50&list=PLQ9AAKW8HuJ5m0rmHKL88ZyjOIKejvrj0)
