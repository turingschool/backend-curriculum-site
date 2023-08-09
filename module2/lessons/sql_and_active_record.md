---
layout: page
title: SQL and ActiveRecord
---

## Learning Goals

- Write SQL statements using `select`, `where`, `order`, `limit`, and `distinct`.
- Translate SQL statements into ActiveRecord

## Vocabulary

- SQL
- ActiveRecord
- Tables
- Rows
- Columns
- Keyword Arguments

## Review Intermission Work

- With a partner:
    - Review the "Checks for Understanding" from the [SQL Intermission Work](../intermission_work/sql)
- Review CFU questions as a class

## Lecture

### Setup

You can pull down the `sql-ar-setup` branch of our [Set List Tutorial repo](https://github.com/turingschool-examples/set-list-7/tree/sql-ar-setup).

Make sure you start by running:

```bash
$ rails db:{drop,create,migrate,seed}
```

In this lesson, we will be writing both raw SQL and ActiveRecord. In order to see both, we are going to open two tabs in Terminal in our SetList app (you can do this with the `cmd + t` shortcut).

In the first tab, open a connection to our SetList database:

```bash
$ rails dbconsole
```

The default convention for your database name is whatever your app name is appended with `_development`.

Use `select * from songs;` to see what data we've seeded into our database. You can also open up your database in Postico to see what data we've seeded.

In the second tab, open up the Rails console with `rails console` or `rails c`. This will allow us to interact with our application directly. We can use this to execute ActiveRecord queries.

## Select all records from a table

### SQL

From our psql connection we can get all of the Song entries in the database with:

```sql
select * from songs;
```

Whenever we are querying the database (as opposed to inserting or modifying), we need to specify both **what** we want and **where** we want it from. We use `select` to specify what we want (in this case `*` meaning "everything"). We use `from` to specify where we want it from (in this case the `songs` table).

Every sql statement we use to query the database will have a `select` and a `from` clause.

### ActiveRecord

Let's take a look at the equivalent ActiveRecord for this sql query:

```ruby
Song.all
```

Under the hood, ActiveRecord is transforming our Ruby into sql. We can see this using the `to_sql` command:

```ruby
Song.all.to_sql
=> "SELECT \"songs\".* FROM \"songs\""
```

And we see that the sql is functionally the same (although AR is using `songs.*` rather than just `*`).

A couple of things to note here:

- In ActiveRecord, we use the model, `Song`, to start our queries, even though the table is called `songs`.
- We don't have to write the `from` clause in ActiveRecord. ActiveRecord will assume that you are working with the table associated with the model you're using. In this case, the `Song` model is associated with the `songs` table.
- We also don't have to write the `select` clause. ActiveRecord assumes you are selecting everything from the table you're working with.

## Selecting Specific Columns

### SQL

Sometimes, you don't want to select *everything* from a table. For instance, you might just want to get all of the song titles:

```sql
select songs.title from songs;
```

This is important because you can optimize your queries by only selecting what you need.

A key point here: our sql statements **return new tables**. This table has a single column, the title. This is not a table that is saved in a database, but one that we can use in-memory.

### ActiveRecord

We can do the same thing in AR with:

```ruby
Song.select(:title)
```

We can do the same thing with a string:

```ruby
Song.select("title")
```

Previously, we saw that AR will automatically select everything when we did `Song.all`. If we provide a `select` clause, it will override that.

Notice that this is returning an instance of `ActiveRecord::Relation`. We know our sql statements return tables, which ActiveRecord represents as `ActiveRecord::Relation` objects. You can think of it as an Array where each element is a row. We can interact with it like so:

```ruby
> songs = Song.select("title")
=> #<ActiveRecord::Relation [#<Song id: nil, title: "Don't Stop Believin'">, #<Song id: nil, title: "Don't Worry Be Happy">, #<Song id: nil, title: "Chicken Fried">, #<Song id: nil, title: "Radioactive">]>

> songs.first
=> #<Song id: nil, title: "Don't Stop Believin'">

> songs[1]
=> #<Song id: nil, title: "Don't Worry Be Happy">
```

Notice how each of the Songs in this relation is missing values for `id`, `length`, and `play_count`. That's because we only selected the `title`. This is equivalent to how the sql statement returned a table with one column.

### Pluck

It's important to understand how to work with `ActiveRecord::Relation` objects, but if you just want all the values out of a column as an Array, ActiveRecord has a shortcut:

```ruby
> Song.pluck(:title)
=> ["Don't Stop Believin'", "Don't Worry Be Happy", "Chicken Fried", "Radioactive"]
```

## Selecting Specific Rows

### SQL

In the previous examples, we were selecting data from all rows, but what if we only want specific rows? For example, what if we wanted to get Songs with a title of "bad guy"?

```sql
select * from songs where songs.title = 'bad guy';
```

Note that we can't interchange double and single quotes in sql.

We can also do comparisons in sql. What if we wanted to get songs with a length greater than 350?

```sql
select * from songs where songs.length > 350;
```

### ActiveRecord

We can use `where` clauses in ActiveRecord as well:

```ruby
Song.where(title: "bad guy")
=>
[#<Song:0x0000000109daceb0
  id: 10,
  title: "bad guy",
  length: 240,
  play_count: 100000,
  created_at: Wed, 22 Feb 2023 19:28:07.778033000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.778033000 UTC +00:00>]
```

Again, notice how this is returning an `ActiveRecord::Relation` even though there is only one matching row.

When using a `where` in AR, you can use **keyword arguments** to specify a column/value match you are looking for.

Our second example, however, is a bit different:

```ruby
Song.where("length > 350")
=>
[#<Song:0x000000010ab8de30
  id: 2,
  title: "Purple Rain",
  length: 524,
  play_count: 19,
  created_at: Wed, 22 Feb 2023 19:28:07.769108000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.769108000 UTC +00:00>,
 #<Song:0x000000010ab8dd68
  id: 3,
  title: "Legend Has It",
  length: 2301,
  play_count: 2300000,
  created_at: Wed, 22 Feb 2023 19:28:07.770231000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.770231000 UTC +00:00>,
 #<Song:0x000000010ab8dca0
  id: 4,
  title: "Talk to Me",
  length: 2301,
  play_count: 2300000,
  created_at: Wed, 22 Feb 2023 19:28:07.771346000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.771346000 UTC +00:00>,
 #<Song:0x000000010ab8dbd8
  id: 5,
  title: "26",
  length: 940,
  play_count: 150000,
  created_at: Wed, 22 Feb 2023 19:28:07.772502000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.772502000 UTC +00:00>,
 #<Song:0x000000010ab8db10
  id: 7,
  title: "Aint No Bread In The Breadbox",
  length: 540,
  play_count: 12000,
  created_at: Wed, 22 Feb 2023 19:28:07.774658000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.774658000 UTC +00:00>,
 #<Song:0x000000010ab8da48
  id: 11,
  title: "Someone Great",
  length: 500,
  play_count: 1000000,
  created_at: Wed, 22 Feb 2023 19:28:07.779265000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.779265000 UTC +00:00>,
 #<Song:0x000000010ab8d980
  id: 12,
  title: "I Can Change",
  length: 640,
  play_count: 100000,
  created_at: Wed, 22 Feb 2023 19:28:07.780357000 UTC +00:00,
  updated_at: Wed, 22 Feb 2023 19:28:07.780357000 UTC +00:00>]
```

Because we are looking for a comparison ("greater than 350") rather than an exact match, we can't use the keyword argument syntax. Instead, we have to write out the sql in strings. **Any ActiveRecord method that takes a String argument will insert that string as-is into the SQL**. This is why it is so important to know sql when learning ActiveRecord. As our queries get more complex, we will have to tell AR the exact sql we want to execute.****

## Ordering Rows

### SQL

If we want our returned table to be in a certain order, for example alphabetical by title:

```sql
select * from songs order by title;
```

And if we want it in descending order:

```sql
select * from songs order by title desc;
```

### ActiveRecord

The AR syntax is very similar:

```ruby
Song.order(:title)
```

Descending:

```ruby
Song.order(title: :desc)
```

And remember, we can use strings to write the SQL manually.

```ruby
Song.order("title")
Song.order("title desc")
```

## Limiting Rows

### SQL

Sometimes, you may only need so many rows. For example, if we need 2 songs:

```sql
select * from songs limit 2;
```

### ActiveRecord

We can do the same thing in AR:

```ruby
Song.limit(2)
```

You may be asking yourself, what is the point of limiting our output? We could just grab all the data and then select what we need using Ruby. The key here is that **the Database is more efficient than Ruby**. In general, relational database are built to optimize queries. The rule of thumb is, if you can do it in the database, you should. For example, you *shouldn't* do this:

```ruby
songs = Song.all
first_two = [songs[0], songs[1]]
```

If we had a million songs in our database, we would be making our database do the extra work of retrieving a million rows when we only needed two.

## Distinct Rows

### SQL

If we want to get distinct (aka unique) rows:

```sql
select distinct * from songs;
```

Note that since all of our Songs have a unique id, there will never be completely duplicate rows, so this will do exactly the same thing as `select * from songs;`, even if we have Songs with the exact same title, length, and play count.

We can see this in action if we have two Songs with duplicate titles in our DB, and then do:

```sql
select distinct songs.title from songs;
```

### ActiveRecord

We can do this in ActiveRecord with:

```ruby
Song.select(:title).distinct
```

## Putting it all together

Let's say we want to get the titles of the two Songs with the longest length that have at least 60,000 plays. Let's break this down:

- "get the titles" = `select songs.title from songs`
- "of the two songs" = `limit 2`
- "with the longest length" = `order by length desc`
- "that have at least 60,000 plays" = `where play_count >= 60000`

We can write the sql like this:

```sql
select songs.title from songs
where play_count >= 60000
order by length desc
limit 2;
```

As your sql/AR statements get longer, it is helpful to write each clause on its own line.

Once you know the sql you want to execute, then we can translate to ActiveRecord. The below is the ActiveRecord version of the above.

```ruby
Song.select(:title)
    .where("play_count >= 60000")
    .order("length desc")
    .limit(2)
```

This is illustrating a very important fact about ActiveRecord queries. **ActiveRecord will take methods chained together and execute them as a single SQL statement**. This behavior is different than what we normally see in Ruby where chained methods execute left to right, and the next method is called on the return value of the previous method.

## Practice

Write the following in SQL, then ActiveRecord. See the beginning of the lesson plan for help opening psql and rails console connections.

1. Get all songs
2. Get all the song lengths
3. Get the songs with a play count greater than zero.
4. Get the titles of the songs with a play count greater than zero.
5. Get the titles of the songs with a play count greater than zero, sorted alphabetically.
6. Get the titles of the songs with a play count greater than zero, sorted reverse alphabetically.
7. Get the titles of the two songs with a play count greater than zero, sorted reverse alphabetically.
8. Get the length of the song with the most plays.

## Checks for Understanding

In your own words, what do each of the following ActiveRecord methods do?

- select
- where
- all
- order
- first
- pluck
- limit
- distinct
- last

## Solutions to Practice Problems
Don't look at these until you've attempted the practice problems! 

<section class="answer">
<h3>#1: Get all songs</h3>
```ruby
   #SQL
   SELECT * FROM songs;

   #AR
   Song.all
```
</section>

<section class="answer">
<h3>#2: Get all song lengths</h3>
```ruby
   #SQL
   SELECT length FROM songs;
   
   #AR
   Song.select(:length) 
   # OR - Song.pluck(:length)
```
</section>

<section class="answer">
<h3>#3: Get the songs with a play count greater than zero</h3>
```ruby
   #SQL
   SELECT * FROM songs WHERE play_count > 0;
   
   #AR
   Song.where("play_count > 0")
```
</section>

<section class="answer">
<h3>#4: Get the titles of songs with a play count greater than zero</h3>
```ruby
   #SQL
   SELECT title FROM songs WHERE play_count > 0;
   
   #AR
   Song.select(:title).where("play_count > 0")
   # OR - Song.where("play_count > 0").pluck(:title)
```
</section>

<section class="answer">
<h3>#5: Get the titles of the songs with a play count greater than zero, sorted alphabetically</h3>
```ruby
   #SQL
   SELECT title FROM songs WHERE play_count > 0 ORDER BY title;
   
   #AR
   Song.select(:title).where("play_count > 0").order(:title)
   # OR - Song.where("play_count > 0").order(:title).pluck(:title)
```
</section>

<section class="answer">
<h3>#6: Get the titles of the songs with a play count greater than zero, sorted reverse alphabetically</h3>
```ruby
   #SQL
   SELECT title FROM songs WHERE play_count > 0 ORDER BY title DESC;
   
   #AR
   Song.select(:title).where("play_count > 0").order(title: :desc)
   # OR - Song.where("play_count > 0").order(title: :desc).pluck(:title)
```
</section>

<section class="answer">
<h3>#7: Get the titles of the TWO songs with a play count greater than zero, sorted reverse alphabetically</h3>
```ruby
   #SQL
   SELECT title FROM songs WHERE play_count > 0 ORDER BY title DESC LIMIT 2;
   
   #AR
   Song.select(:title).where("play_count > 0").order(title: :desc).limit(2)
```
</section>

<section class="answer">
<h3>#8: Get the length of the song with the most plays</h3>
```ruby
   #SQL
   SELECT length FROM songs ORDER BY play_count DESC LIMIT 1;
   
   #AR
   Song.order(play_count: :desc).first.length
```
</section>

