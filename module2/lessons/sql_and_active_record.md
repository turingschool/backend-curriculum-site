---
layout: page
title: SQL and ActiveRecord
---

## Learning Goals

* Write SQL statements using `select`, `where`, `order`, `limit`, and `distinct`.
* Translate SQL statements into ActiveRecord

## Vocabulary

* SQL
* ActiveRecord
* Tables
* Rows
* Columns
* Keyword Arguments

## Review Intermission Work

* With a partner:
  * Review the "Checks for Understanding" from the [SQL Intermission Work](../intermission_work/sql)
* Review CFU questions as a class

# Lecture

In this lesson, we will be writing both raw SQL and ActiveRecord. In order to see both, we are going to open two tabs in Terminal in our SetList app (you can do this with the `cmd + t` shortcut).

In the first tab, open a connection to our SetList database:

```
$ rails dbconsole
```

The default convention for your database name is whatever your app name is appended with `_development`.

Use `select * from songs;` to see what data we've seeded into our database. You can also open up your database in Postico to see what data we've seeded.

In the second tab, open up the Rails console with `rails console` or `rails c`. This will allow us to interact with our application directly. We can use this to execute ActiveRecord queries.

## Select all records from a table

### SQL

From our psql connection we can get all of the Song entries in the database with:

```sql
select * from songs;
```

Whenever we are querying the database (as opposed to inserting or modifying), we need to specify both **what** we want and **where** we want it from. We use `select` to specify what we want (in this case `*` meaning "everything"). We use `from` to specify where we want it from (in this case the `songs` table).

Every sql statement we use to query the database will have a `select` and a `from` clause.

### ActiveRecord

Let's take a look at the equivalent ActiveRecord for this sql query:

```ruby
Song.all
```

Under the hood, ActiveRecord is transforming our Ruby into sql. We can see this using the `to_sql` command:

```ruby
Song.all.to_sql
=> "SELECT \"songs\".* FROM \"songs\""
```

And we see that the sql is functionally the same (although AR is using `songs.*` rather than just `*`).

A couple of things to note here:

* In ActiveRecord, we use the model, `Song`, to start our queries, even though the table is called `songs`.
* We don't have to write the `from` clause in ActiveRecord. ActiveRecord will assume that you are working with the table associated with the model you're using. In this case, the `Song` model is associated with the `songs` table.
* We also don't have to write the `select` clause. ActiveRecord assumes you are selecting everything from the table you're working with.

## Selecting specific columns

### SQL

Sometimes, you don't want to select *everything* from a table. For instance, you might just want to get all of the song titles:

```sql
select songs.title from songs;
```

This is important because you can optimize your queries by only selecting what you need.

A key point here: our sql statements **return new tables**. This table has a single column, the title. This is not a table that is saved in a database, but one that we can use in-memory.

### ActiveRecord

We can do the same thing in AR with:

```ruby
Song.select(:title)
```

We can do the same thing with a string:

```ruby
Song.select("title")
```

Previously, we saw that AR will automatically select everything when we did `Song.all`. If we provide a `select` clause, it will override that.

Notice that this is returning an instance of `ActiveRecord::Relation`. We know our sql statements return tables, which ActiveRecord represents as `ActiveRecord::Relation` objects. You can think of it as an Array where each element is a row. We can interact with it like so:

```ruby
> songs = Song.select("title")
=> #<ActiveRecord::Relation [#<Song id: nil, title: "Don't Stop Believin'">, #<Song id: nil, title: "Don't Worry Be Happy">, #<Song id: nil, title: "Chicken Fried">, #<Song id: nil, title: "Radioactive">]>

> songs.first
=> #<Song id: nil, title: "Don't Stop Believin'">

> songs[1]
=> #<Song id: nil, title: "Don't Worry Be Happy">
```

Notice how each of the Songs in this relation is missing values for `id`, `length`, and `play_count`. That's because we only selected the `title`. This is equivalent to how the sql statement returned a table with one column.

### Pluck

It's important to understand how to work with `ActiveRecord::Relation` objects, but if you just want all the values out of a column as an Array, ActiveRecord has a shortcut:

```ruby
> Song.pluck(:title)
=> ["Don't Stop Believin'", "Don't Worry Be Happy", "Chicken Fried", "Radioactive"]
```

## Selecting specific rows

### SQL

In the previous examples, we were selecting data from all rows, but what if we only want specific rows? For example, what if we wanted to get Songs with a title of "Radioactive"?

```sql
select * from songs where songs.title = 'Radioactive';
```

Note that we can't interchange double and single quotes in sql.

We can also do comparisons in sql. What if we wanted to get songs with a length greater than 200?

```sql
select * from songs where songs.length > 200;
```

### ActiveRecord

We can use `where` clauses in ActiveRecord as well:

```ruby
Song.where(title: "Radioactive")
=> #<ActiveRecord::Relation [#<Song id: 4, title: "Radioactive", length: 10000, play_count: 623547, created_at: "2019-04-22 22:22:01", updated_at: "2019-04-22 22:22:01">]>
```

Again, notice how this is returning an `ActiveRecord::Relation` even though there is only one matching row.

When using a `where` in AR, you can use **keyword arguments** to specify a column/value match you are looking for.

Our second example, however, is a bit different:

```ruby
Song.where("length > 90")
=> #<ActiveRecord::Relation [#<Song id: 1, title: "Don't Stop Believin'", length: 251, play_count: 760847, created_at: "2019-04-22 22:22:00", updated_at: "2019-04-22 22:22:00">, #<Song id: 2, title: "Don't Worry Be Happy", length: 280, play_count: 65862, created_at: "2019-04-22 22:22:00", updated_at: "2019-04-22 22:22:00">, #<Song id: 4, title: "Radioactive", length: 10000, play_count: 623547, created_at: "2019-04-22 22:22:01", updated_at: "2019-04-22 22:22:01">]>
```

Because we are looking for a comparison ("greater than 200") rather than an exact match, we can't use the keyword argument syntax. Instead, we have to write out the sql in strings. **Any ActiveRecord method that takes a String argument will insert that string as-is into the SQL**. This is why it is so important to know sql when learning ActiveRecord. As our queries get more complex, we will have to tell AR the exact sql we want to execute.

## Ordering rows

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

Again, we can use Strings to write the sql manually:

```ruby
Song.order("title")
Song.order("title desc")
```

## Limiting rows

### SQL

Sometimes, you may only need so many rows. For example, if we need 2 songs:

```sql
select * from songs limit 2;
```

### Active Record

We can do the same thing in AR:

```ruby
Song.limit(2)
```

You may be asking yourself, what is the point of limiting our output? We could just grab all the data and then select what we need using Ruby. The key here is that **the Database is more efficient than Ruby**. In general, relational database are built to optimize queries. The rule of thumb is, if you can do it in the database, you should. For example, you shouldn't do this:

```ruby
songs = Song.all
first_two = [songs[0], songs[1]]
```

If we had a million songs in our database, we would be making our database do the extra work of retrieving a million rows when we only needed two.

## Distinct rows

### SQL

If we want to get distinct (aka unique) rows:

```sql
select distinct * from songs;
```

Note that since all of our Songs have a unique id, there will never be completely duplicate rows, so this will do exactly the same thing as `select * from songs;`, even if we have Songs with the exact same title, length, and play count.

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

* "get the titles" = `select songs.title from songs`
* "of the two songs" = `limit 2`
* "with the longest length" = `order by length desc`
* "that have at least 60,000 plays" = `where play_count >= 60000`

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

You'll notice that, unlike sql, the order of the ActiveRecord methods does not matter. For example, we can reverse the order and achieve the same output:

```ruby
Song.limit(2)
    .order("length desc")
    .where("play_count >= 60000")
    .select(:title)
```

This is illustrating a very important fact about ActiveRecord queries. **ActiveRecord will take methods chained together and execute them as a single SQL statement**. This behavior is different than what we normally see in Ruby where chained methods execute left to right, and the next method is called on the return value of the previous method.

## Practice

Write the following in SQL, then ActiveRecord. See the beginning of the lesson plan for help opening psql and rails console connections.

1. Get all songs
1. Get all the song lengths
1. Get the songs with a play count greater than zero.
1. Get the titles of the songs with a play count greater than zero.
1. Get the titles of the songs with a play count greater than zero, sorted alphabetically.
1. Get the titles of the songs with a play count greater than zero, sorted reverse alphabetically.
1. Get the titles of the two songs with a play count greater than zero, sorted reverse alphabetically.
1. Get the length of the song with the most plays.


## Checks for Understanding

In your own words, what do each of the following ActiveRecord methods do?

* select
* where
* all
* order
* first
* pluck
* limit
* distinct
* last
