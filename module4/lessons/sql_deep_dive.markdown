---
layout: page
title: SQL Deep Dive
length: 180 minutes
tags: SQL
---
Overview
------------

### Learning Goals

*   Student has refreshed their understanding of SELECT statements in SQL
*   Student has deepened their understanding of foreign key relationships
*   Student uses COUNT functions in SQL
*   Student understands the purpose and trade-offs with SQL indices
*   Student can create a single-column index on a table
*   Student can explain the concept of an INNER JOIN
*   Student can design and execute an INNER JOIN across two tables

Class Time
------

### Setup

#### Checking PostgreSQL

From your terminal, let's create a database and open it:

```
$ createdb food
$ psql food
```

Within that database let's make a table:

```
CREATE TABLE fruits(id SERIAL, name VARCHAR, seed_count int);
```

Then insert a bit of data:

```
INSERT INTO fruits (name, seed_count)
VALUES ('apple', 6),
       ('orange', 14),
       ('avocado', 1);
```

And finally run a SELECT:

```
SELECT * from fruits;
```

If you see the three fruits you inserted then you're good to go. Go ahead and exit `psql` with the command `\q`.

#### Loading the Sample Data

For the bulk of this tutorial we want to focus on working with existing data. We've setup a sample database for you to use. Create a folder named `sql_deep_dive` in your terminal and get the DB:

```
$ mkdir sql_deep_dive
$ cd sql_deep_dive
$ brew install wget
$ wget https://cl.ly/2k1q0J070W2S/download/imdb.pgsql
$ createdb imdb
$ psql imdb < imdb.pgsql
```

#### Testing with the Data

Then connect to the database and run a sample query:

```
$ psql imdb
psql> select * from movies where id=100 limit 1;
100|The Hobbit: An Unexpected Journey |182|303001229|http://www.imdb.com/title/tt0903624/?ref_=fn_tt_tt_1|PG-13|180000000|2012|English|1|2016-12-11 20:52:25.675416|2016-12-11 20:52:25.675416
```

If you get a movie record like that then you're ready to go!

### Part 1: Practicing with SQL

Let's start with a series of challenges. Work with your partner to solve the following questions. Record both the queries you used to get the answer and the answer itself.

Solve the *EASY* and *MEDIUM* questions of each section before trying any of the *HARD* questions.

#### Round 1: Using SELECT

*   Easy: Which movie in our database had the largest gross revenue?
*   Medium: Which movie released in 2012 had the largest gross revenue?
*   Hard: For films that we have both the budget and gross, what were the top three flops of 2012 (ie: lowest profit)?

#### Round 2: Using COUNT

*   Easy: How many movies have a known budget (ie: not null or zero)?
*   Medium: How many movies in our database were released in 2012?
*   Hard: How many movies in 2012 had a budget over $100M?

#### Round 3: Connecting Data Across Tables

*   Easy: How many roles does Rosario Dawson have in our database?
*   Medium: What movies did Justin Lin direct?
*   Hard: What movies did Donald Glover appear in?

### Part 2: Searching with and without Indices

Let's whiteboard and discuss the following:

*   Finding records by the primary key
*   Quick recap of foreign keys
*   Finding records by the foreign key
*   Primary uniqueness => quick stop, foreign repeats => long search
*   An *index* on a column makes lookups faster
*   An index increases memory usage and makes inserts slower

#### In `psql`

```
imdb=# \timing
imdb=# SELECT COUNT(*) from roles WHERE actor_id=158;
```

*   Note how long it took to execute the query.
*   Think about how many rows of the `roles` table had to be looked through

#### Creating & Testing the Index

```
imdb=# CREATE INDEX roles_actor_id_index on roles (actor_id);
imdb=# SELECT COUNT(*) from roles WHERE actor_id=158;
```

*   What do you observe about the difference in execution speed?
*   Skeptical that there's some kind of caching going on? Try the same query looking for id `534` which has even more roles

#### Experiment In Pairs

Go through this process again with the movies table and it's relationship to directors.

*   Find how many movies were directed by Steven Spielberg and note the query time
*   Create an index on the relevant column
*   Re-run your query. What percentage speed-up did you observe?

### Part 3: Using Inner Joins

Now it gets a little trickier. Preview the idea of JOINS with [this article](https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/).

Let's whiteboard and discuss the following:

*   Selecting data without a join
*   Selecting related data in a second query
*   Joining based on a foreign key

We'll use these queries:

```
imdb=# select * from directors where name='Justin Lin';
imdb=# select * from movies where director_id=42;
imdb=# select * from movies INNER JOIN directors ON movies.director_id=directors.id where directors.name='Justin Lin';
imdb=# select title, year, name from movies INNER JOIN directors ON movies.director_id=directors.id where directors.name='Justin Lin';
```

Then take it a step further

```
imdb=# select * from actors where name='Rosario Dawson';
imdb=# select * from roles INNER JOIN actors ON roles.actor_id=actors.id WHERE actors.name='Rosario Dawson';
imdb=# select * from movies INNER JOIN roles ON movies.id=roles.movie_id INNER JOIN actors ON roles.actor_id=actors.id WHERE actors.name='Rosario Dawson';
imdb=# select movies.title, movies.year, actors.name from movies INNER JOIN roles ON movies.id=roles.movie_id INNER JOIN actors ON roles.actor_id=actors.id WHERE actors.name='Rosario Dawson';
```

And one more degree to the search:

```
imdb=# select movies.title, movies.year, actors.name from movies INNER JOIN roles ON movies.id=roles.movie_id INNER JOIN actors ON roles.actor_id=actors.id WHERE movies.title like 'Fast%';
```

#### First Experiment in Pairs

Make sure you do this iteratively, building up a little at a time.

Write a query that returns this data about movies and directors:

```
title     | year |       name       
---------------+------+------------------
Spider-Man 3  | 2007 | Sam Raimi
Spider-Man 2  | 2004 | Sam Raimi
Spider-Man    | 2002 | Sam Raimi
Spider        | 2002 | David Cronenberg
Spider-Man 3  | 2007 | Sam Raimi
```

#### Big Finish

*   How many films was Morgan Freeman in?
*   What was his highest-grossing movie?
*   How many films was he the lead (`rank` of `1` in roles)?

#### Extra Challenges

*   What director did Morgan Freeman work with the most?
*   What are the titles of the dramas he appeared in?

### Part 4: Grab Bag

Here are some other things worth investigating:

*   `SELECT sum(column_name) FROM table_name; `
*   `SELECT avg(column_name) FROM table_name; `
*   `SELECT max(column_name) FROM table_name; `
*   `SELECT min(column_name) FROM table_name;`
*   `SELECT count(column_name) FROM table_name; `
*   Subqueries
*   Aliases with `AS`

#### Exercises

*   What's the difference between the average profit of a Spiderman movie versus a Batman movie?
*   Over her career, how much total profit has Meryl Streep generated?
*   What's the percentage chance that a movie with Adam Sandler is profitable?
