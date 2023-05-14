---
layout: page
title: Joins in SQL and Active Record
---

## Learning Goals

- Understand and visualize a SQL join query
- Implement an ActiveRecord query using `.joins`


## Homework & Warm Up

Before this class, try working through the directions in the README file of the [joins-homework](https://github.com/turingschool-examples/set-list-7/tree/joins-homework) branch in  Set List Tutorial. 

The 2nd part of the `joins-homework` exercises is to try some Join queries on your own, in the `spec/models/playlist_spec.rb` file. Reference this lesson for help writing AR Joins queries. 

## Set Up

For this lesson's code-along, you can start work from [this branch](https://github.com/turingschool-examples/set-list-7/tree/generic-start) of the Set List Tutorial.
```bash
bundle install
rails db:{drop,create,migrate,seed}
```

---

## Joining Tables

### The SQL Join Query

So far, we have looked at SQL and ActiveRecord queries that deal only with one table, or we have asked our database for information related to a single resource. But you will sometimes need to run queries based on information from more than one table. When we come up against this problem, we rely on `JOIN` queries to accomplish this goal.

At the highest level, a `JOIN` pulls information from multiple tables into one temporary table. Let's use our SetList app to see how this works.

In your terminal, run the following command to open your set_list_development database `rails dbconsole`, and let's take a look at our `songs` and `artists` tables:

```bash
set_list_7_development=# SELECT * FROM songs;
 id |             title             | length | play_count |         created_at         |         updated_at         | artist_id
----+-------------------------------+--------+------------+----------------------------+----------------------------+-----------
  1 | Raspberry Beret               |    345 |         34 | 2023-02-23 16:22:59.81817  | 2023-02-23 16:22:59.81817  |         1
  2 | Purple Rain                   |    524 |         19 | 2023-02-23 16:22:59.820061 | 2023-02-23 16:22:59.820061 |         1
  3 | Legend Has It                 |   2301 |    2300000 | 2023-02-23 16:22:59.821595 | 2023-02-23 16:22:59.821595 |         2
  4 | Talk to Me                    |   2301 |    2300000 | 2023-02-23 16:22:59.822961 | 2023-02-23 16:22:59.822961 |         2
  5 | 26                            |    940 |     150000 | 2023-02-23 16:22:59.82436  | 2023-02-23 16:22:59.82436  |         3
  6 | Vagabond                      |    240 |     120000 | 2023-02-23 16:22:59.825712 | 2023-02-23 16:22:59.825712 |         3
  7 | Aint No Bread In The Breadbox |    540 |      12000 | 2023-02-23 16:22:59.827072 | 2023-02-23 16:22:59.827072 |         4
  8 | The Harder They Come          |    240 |     120000 | 2023-02-23 16:22:59.828354 | 2023-02-23 16:22:59.828354 |         4
  9 | bury a friend                 |    340 |    1200000 | 2023-02-23 16:22:59.829678 | 2023-02-23 16:22:59.829678 |         5
 10 | bad guy                       |    240 |     100000 | 2023-02-23 16:22:59.830952 | 2023-02-23 16:22:59.830952 |         5
 11 | Someone Great                 |    500 |    1000000 | 2023-02-23 16:22:59.832334 | 2023-02-23 16:22:59.832334 |         6
 12 | I Can Change                  |    640 |     100000 | 2023-02-23 16:22:59.833637 | 2023-02-23 16:22:59.833637 |         6
(12 rows)
```

```bash
set_list_7_development=# SELECT * FROM artists;
 id |       name        |         created_at         |         updated_at
----+-------------------+----------------------------+----------------------------
  1 | Prince            | 2023-02-23 16:28:12.228288 | 2023-02-23 16:28:12.228288
  2 | Run The Jewels    | 2023-02-23 16:28:12.229754 | 2023-02-23 16:28:12.229754
  3 | Caamp             | 2023-02-23 16:28:12.230785 | 2023-02-23 16:28:12.230785
  4 | Jerry Garcia Band | 2023-02-23 16:28:12.231814 | 2023-02-23 16:28:12.231814
  5 | Billie Eilish     | 2023-02-23 16:28:12.232855 | 2023-02-23 16:28:12.232855
  6 | LCD Soundsystem   | 2023-02-23 16:28:12.233853 | 2023-02-23 16:28:12.233853
  7 | Taylor Swift      | 2023-02-23 16:28:12.234963 | 2023-02-23 16:28:12.234963
(7 rows)
```

Above, we see our songs and artists table - what happens if we `JOIN` these tables together?

```bash
set_list_7_development=# SELECT artists.*, songs.* FROM songs JOIN artists ON artists.id = songs.artist_id;
 id |       name        |         created_at         |         updated_at         | id |             title             | length | play_count |         created_at         |         updated_at         | artist_id
----+-------------------+----------------------------+----------------------------+----+-------------------------------+--------+------------+----------------------------+----------------------------+-----------
  1 | Prince            | 2023-02-23 16:22:59.802034 | 2023-02-23 16:22:59.802034 |  1 | Raspberry Beret               |    345 |         34 | 2023-02-23 16:22:59.81817  | 2023-02-23 16:22:59.81817  |         1
  1 | Prince            | 2023-02-23 16:22:59.802034 | 2023-02-23 16:22:59.802034 |  2 | Purple Rain                   |    524 |         19 | 2023-02-23 16:22:59.820061 | 2023-02-23 16:22:59.820061 |         1
  2 | Run The Jewels    | 2023-02-23 16:22:59.803489 | 2023-02-23 16:22:59.803489 |  3 | Legend Has It                 |   2301 |    2300000 | 2023-02-23 16:22:59.821595 | 2023-02-23 16:22:59.821595 |         2
  2 | Run The Jewels    | 2023-02-23 16:22:59.803489 | 2023-02-23 16:22:59.803489 |  4 | Talk to Me                    |   2301 |    2300000 | 2023-02-23 16:22:59.822961 | 2023-02-23 16:22:59.822961 |         2
  3 | Caamp             | 2023-02-23 16:22:59.804563 | 2023-02-23 16:22:59.804563 |  5 | 26                            |    940 |     150000 | 2023-02-23 16:22:59.82436  | 2023-02-23 16:22:59.82436  |         3
  3 | Caamp             | 2023-02-23 16:22:59.804563 | 2023-02-23 16:22:59.804563 |  6 | Vagabond                      |    240 |     120000 | 2023-02-23 16:22:59.825712 | 2023-02-23 16:22:59.825712 |         3
  4 | Jerry Garcia Band | 2023-02-23 16:22:59.80559  | 2023-02-23 16:22:59.80559  |  7 | Aint No Bread In The Breadbox |    540 |      12000 | 2023-02-23 16:22:59.827072 | 2023-02-23 16:22:59.827072 |         4
  4 | Jerry Garcia Band | 2023-02-23 16:22:59.80559  | 2023-02-23 16:22:59.80559  |  8 | The Harder They Come          |    240 |     120000 | 2023-02-23 16:22:59.828354 | 2023-02-23 16:22:59.828354 |         4
  5 | Billie Eilish     | 2023-02-23 16:22:59.806621 | 2023-02-23 16:22:59.806621 |  9 | bury a friend                 |    340 |    1200000 | 2023-02-23 16:22:59.829678 | 2023-02-23 16:22:59.829678 |         5
  5 | Billie Eilish     | 2023-02-23 16:22:59.806621 | 2023-02-23 16:22:59.806621 | 10 | bad guy                       |    240 |     100000 | 2023-02-23 16:22:59.830952 | 2023-02-23 16:22:59.830952 |         5
  6 | LCD Soundsystem   | 2023-02-23 16:22:59.807657 | 2023-02-23 16:22:59.807657 | 11 | Someone Great                 |    500 |    1000000 | 2023-02-23 16:22:59.832334 | 2023-02-23 16:22:59.832334 |         6
  6 | LCD Soundsystem   | 2023-02-23 16:22:59.807657 | 2023-02-23 16:22:59.807657 | 12 | I Can Change                  |    640 |     100000 | 2023-02-23 16:22:59.833637 | 2023-02-23 16:22:59.833637 |         6
(12 rows)
```

Write in your notebook, what did this query do? How might you describe the return value of this query?

When we run this `JOIN`, we are *joining* the songs and artists tables together to form a return value that is a table that includes all the information from *both* tables. For each artist, we see a row for each song that they have, with the information from both the artists table and the songs table.

When creating a `JOIN` query, there are three parts essential to the query:

1. `SELECT` - this is what indicates which columns will be included in the resulting table
2. `ON` - this tells the join *how* to join this two tables together, or what is the relationship between the two tables (most often, primary key = foreign key)
3. `JOIN` - the command to join to tables together!

Looking at our joined table, what information could seem to be missing? WHERE IS `TAYLOR SWIFT`?

Write in your notebook, why are we not seeing ***all*** of our artists on this joined table?

## Types of Join Queries

When we create `JOIN` queries, there are a handful of different join types that we can declare that will affect the resulting table. Today, we are going to cover 3 of those join types: **Left Join**, **Inner Join**, and **Right Join.**

### Inner Join

The default `JOIN` type in SQL is an **Inner JOIN**. An inner join will grab only the information from the two tables where the information matches the `ON` condition - in our example above, it will grab only information for artists who have songs, and their song information. This relationship is often visualized like this:

![Inner Join](./images/inner_join.png)

### Left Join

The next most common `JOIN` type is a **Left Join**. A left join will get all the records from one table, regardless of if they have corresponding rows in the joined table. If we run a left join in our setlist app, it could look like this:

```bash
set_list_7_development=# SELECT artists.id, artists.name, songs.id, songs.title FROM artists LEFT JOIN songs ON songs.artist_id = artists.id;
 id |       name        | id |             title
----+-------------------+----+-------------------------------
  1 | Prince            |  1 | Raspberry Beret
  1 | Prince            |  2 | Purple Rain
  2 | Run The Jewels    |  3 | Legend Has It
  2 | Run The Jewels    |  4 | Talk to Me
  3 | Caamp             |  5 | 26
  3 | Caamp             |  6 | Vagabond
  4 | Jerry Garcia Band |  7 | Aint No Bread In The Breadbox
  4 | Jerry Garcia Band |  8 | The Harder They Come
  5 | Billie Eilish     |  9 | bury a friend
  5 | Billie Eilish     | 10 | bad guy
  6 | LCD Soundsystem   | 11 | Someone Great
  6 | LCD Soundsystem   | 12 | I Can Change
  7 | Taylor Swift      |    |
(13 rows)
```

Now, we see `Taylor Swift` even though that artist has no songs. We visualize this relationship like so:

![Left Join](./images/left_join.png)

### Right Join

The last of these join types is a **Right Join** which will get only records from one table if they match with records from the joined table and will get all records from the joined table regardless of if they have a corresponding record from the starting table. We can visualize the join.

![Right Join](./images/right_join.png)

## Joining in ActiveRecord

So what does all this look like in ActiveRecord? Open a new tab in your terminal and open your console with `rails c`.

In ActiveRecord, similar to how we can create a SQL `WHERE` with `.where`, we can use `.joins` to create a SQL `JOIN` query!

```bash
irb(main):001:0> Artist.joins(:songs)
  Artist Load (1.4ms)  SELECT "artists".* FROM "artists" INNER JOIN "songs" ON "songs"."artist_id" = "artists"."id"
=>
[#<Artist:0x0000000109774bd8 id: 1, name: "Prince", created_at: Thu, 23 Feb 2023 16:28:12.228288000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.228288000 UTC +00:00>,
 #<Artist:0x000000010a9cea68 id: 1, name: "Prince", created_at: Thu, 23 Feb 2023 16:28:12.228288000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.228288000 UTC +00:00>,
 #<Artist:0x000000010a9ce1a8 id: 2, name: "Run The Jewels", created_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00>,
 #<Artist:0x000000010a9cd370 id: 2, name: "Run The Jewels", created_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00>,
 #<Artist:0x000000010a9cc6c8 id: 3, name: "Caamp", created_at: Thu, 23 Feb 2023 16:28:12.230785000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.230785000 UTC +00:00>,
 #<Artist:0x000000010a9c7ec0 id: 3, name: "Caamp", created_at: Thu, 23 Feb 2023 16:28:12.230785000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.230785000 UTC +00:00>,
 #<Artist:0x000000010a9bf900 id: 4, name: "Jerry Garcia Band", created_at: Thu, 23 Feb 2023 16:28:12.231814000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.231814000 UTC +00:00>,
 #<Artist:0x000000010a9bf3b0 id: 4, name: "Jerry Garcia Band", created_at: Thu, 23 Feb 2023 16:28:12.231814000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.231814000 UTC +00:00>,
 #<Artist:0x000000010a9bea28 id: 5, name: "Billie Eilish", created_at: Thu, 23 Feb 2023 16:28:12.232855000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.232855000 UTC +00:00>,
 #<Artist:0x000000010a9be410 id: 5, name: "Billie Eilish", created_at: Thu, 23 Feb 2023 16:28:12.232855000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.232855000 UTC +00:00>,
 #<Artist:0x000000010a9bdbc8 id: 6, name: "LCD Soundsystem", created_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00>,
 #<Artist:0x000000010a9bce80 id: 6, name: "LCD Soundsystem", created_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00>]
```

Write in your notebook, why are we not seeing any song information in this `ActiveRecord::Relation`?

Take a look at the SQL query that is generated with the ActiveRecord method call.

```bash
irb(main):001:0> Artist.joins(:songs)
  Artist Load (1.4ms)  SELECT "artists".* FROM "artists" INNER JOIN "songs" ON "songs"."artist_id" = "artists"."id"
```

Now, we are SELECTing from artists *and* songs, but has our return value changed? Unfortunately, no. Because we are starting our ActiveRecord query from our Artist model, ActiveRecord will try to create Artist objects from the resulting data; so, we don't see the song information, but it is actually there! We can access it on each of the resulting 'artist' objects.

```bash
irb(main):002:0> first_record = Artist.select('artists.*, songs.*').joins(:songs).first
  Artist Load (0.6ms)  SELECT artists.*, songs.* FROM "artists" INNER JOIN "songs" ON "songs"."artist_id" = "artists"."id" ORDER BY "artists"."id" ASC LIMIT $1  [["LIMIT", 1]]
=> #<Artist:0x000000010cbef6d8 id: 1, name: "Prince", created_at: Thu, 23 Feb 2023 16:28:12.244984000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.244984000 UTC +00:00>

irb(main):003:0> first_record.title
=> "Raspberry Beret"

irb(main):004:0> first_record.length
=> 345

irb(main):005:0> first_record.play_count
=> 34
```

## Practice

Let's see this in action by imagining that we might want to be able to get a list of artists who have songs longer than '400'. Work with a partner to get this information using both SQL and ActiveRecord. The solutions are below.

### SQL

```bash
set_list_7_development=# SELECT artists.name FROM artists JOIN songs ON artists.id = songs.artist_id WHERE songs.length > 400;
       name
-------------------
 Prince
 Run The Jewels
 Run The Jewels
 Caamp
 Jerry Garcia Band
 LCD Soundsystem
 LCD Soundsystem
(7 rows)
```

### ActiveRecord

```bash
irb(main):001:0> Artist.joins(:songs).where('songs.length > ?', 400)
  Artist Load (1.1ms)  SELECT "artists".* FROM "artists" INNER JOIN "songs" ON "songs"."artist_id" = "artists"."id" WHERE (songs.length > 400)
=>
[#<Artist:0x00000001065ad4b0 id: 1, name: "Prince", created_at: Thu, 23 Feb 2023 16:28:12.228288000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.228288000 UTC +00:00>,
 #<Artist:0x00000001065ddb60 id: 2, name: "Run The Jewels", created_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00>,
 #<Artist:0x00000001065dda98 id: 2, name: "Run The Jewels", created_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.229754000 UTC +00:00>,
 #<Artist:0x00000001065dd9d0 id: 3, name: "Caamp", created_at: Thu, 23 Feb 2023 16:28:12.230785000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.230785000 UTC +00:00>,
 #<Artist:0x00000001065dd908 id: 4, name: "Jerry Garcia Band", created_at: Thu, 23 Feb 2023 16:28:12.231814000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.231814000 UTC +00:00>,
 #<Artist:0x00000001065dd840 id: 6, name: "LCD Soundsystem", created_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00>,
 #<Artist:0x00000001065dd778 id: 6, name: "LCD Soundsystem", created_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00, updated_at: Thu, 23 Feb 2023 16:28:12.233853000 UTC +00:00>]
```

## Checks for Understanding

1. What are the three types of joins covered today? And, what do they return?
2. What is the SQL query to get a list of Artists who have songs that have been played more than 20 times?
3. What is the ActiveRecord query to get a list of Artists who have songs that have been played more than 20 times?

## Further Reading
For an exploration of how to join multiple tables together, and advanced joining techniques, review the lesson [here](./joins_2).