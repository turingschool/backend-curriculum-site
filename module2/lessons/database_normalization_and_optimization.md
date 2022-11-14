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

## Slides

Available [here](../slides/database_normalization_and_optimization)


## Warm-Up

* Read [this](https://www.essentialsql.com/get-ready-to-learn-sql-database-normalization-explained-in-simple-english/) article on database normalization.
* In your own words summarize what database normalization is.


### Defining Key Terms

* **Normalization** - An optimization and reorganization of database tables that removes data duplication
* **B-Tree** - A data structure, a generalized version of a "binary tree", sometimes called a "trie", which is commonly used for storing indexes within PostgreSQL


## Normalization

"Normalization" is usually done by examining our database table structure to look for duplicated data, usually strings, and find ways to replace those values with something which is faster to store and search.

For example, let's take a look at one potential schema for a database linking students and courses.

```ruby
ActiveRecord::Schema.define(version: 20171204033005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "course_id"
    t.integer "score"
    t.index ["course_id"], name: "index_students_on_course_id"
  end

end
```

Given that `course_id` exists on the students table, we might assume a one-to-many relationship between courses and students. What if the actual relationship was many-to-many? Without changing the database, how would we record the fact that a student was enrolled in multiple courses?

We could potentially put multiple course ids in the `course_id` column. We could also have multiple `course_id` columns (e.g. `course_1_id`, `course_2_id`, etc.). Or we could have multiple rows that had the same first/last name for a student. However, none of these solutions would be *normalized*.

How could we adjust the structure of the database to record a many-to-many relationship between students?


### Why Normalize

Imagine for a moment we did not normalize the database, but instead pursued one of the other solutions described above. How would we find all of the students enrolled in a particular course? What opportunities for error/corrupted information would exist?

How does normalization help resolve these potential issues?


### Practice

* Imagine you were going to create a database to store the information in the JSON hash below. How might you structure your database?

```ruby
payload = '{
  "url":"http://jumpstartlab.com/blog",
  "requestedAt":"2013-02-16 21:38:28 -0700",
  "respondedIn":37,
  "referredBy":"http://jumpstartlab.com",
  "requestType":"GET",
  "eventName": "socialLogin",
  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
  "resolutionWidth":"1920",
  "resolutionHeight":"1280",
  "ip":"63.29.38.211"
}'
```

* Review [this](https://www.kaggle.com/unitednations/global-commodity-trade-statistics/data) commodity trade data. How might you structure a normalized database to store this data?

* Review [this](https://www.kaggle.com/aashita/nyt-comments/data) New York Times article data. How might you structure a normlalized database to store this data?



## How are tables and indexes actually stored in PostgreSQL

Clone (or re-use) the [roster repo](https://github.com/turingschool-examples/roster). Run bundle to install any missing gems, then run rake db:{create,migrate,seed}.

From a terminal prompt, run psql roster-development. Use \q within the psql shell to exit back to your terminal prompt.

Based on the `belongs_to` and `has_many` attributes in our `/app/models/student.rb` and `/app/models/course.rb`, we can see how ActiveRecord constructs our tables. But what do these actually look like in PostgreSQL? Let's take a look.

Run `psql roster-development` in a new terminal window. Here, we can execute a SQL command to list all of our students:

```
roster-development=# select * from students;
id | first_name |  last_name  | course_id | score
----+------------+-------------+-----------+-------
 1 | Brian      | Zanti       |         1 |     3
 2 | Megan      | McMahon     |         1 |     4
 3 | Josh       | Mejia       |         3 |     2
 4 | Mike       | Dao         |         3 |     3
 5 | Dione      | Wilson      |         2 |     2
 6 | Ian        | Douglas     |         2 |     4
 7 | Cory       | Westerfield |         4 |     3
 8 | Sal        | Espinosa    |         1 |     2
(8 rows)
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

A b-tree is like the "prefix" tree that you may have used in the [Complete Me](http://backend.turing.edu/module1/projects/complete_me) project in Mod 1, where each node in the tree can have multiple children. We won't dive into the theory of it, but this is the most-used index type within PostgreSQL.


## Additional Resources

- the theory of [b-tree data structures](https://en.wikipedia.org/wiki/B-tree)
- [DevShed - An Introduction to Database Normalization](http://www.devshed.com/c/a/mysql/an-introduction-to-database-normalization/)
- [Mike Hillyer's Blog Post - intro to database normalization](http://mikehillyer.com/articles/an-introduction-to-database-normalization/)
- [Watch Sharif Ramadan's intro to 1NF, 2NF and 3NF databases. They're only about 4 minutes each.](https://www.youtube.com/watch?v=K7vzLrGCV50&list=PLQ9AAKW8HuJ5m0rmHKL88ZyjOIKejvrj0)
