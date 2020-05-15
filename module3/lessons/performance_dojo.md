---
title: Performance Dojo
length: 180
tags: ruby, rails, activerecord, sql
---

## Learning Goals

* Gain a high level understanding of how to increase the performance of a web application
as it scales.  
* Discuss performance limitations of database queries with regard to
increased DB scale and load
* Practice troubleshooting performance issues related to large datasets
* Discuss common ActiveRecord techniques for managing increased database scale.

## Setup - Blogger with DB Load

For this lesson, we'll use a special branch of blogger configured with a large dataset. Set this up like so:

```
git clone -b blogger-perf-workshop https://github.com/turingschool-examples/optimization-dojo.git
cd optimization-dojo
bundle
rake sample_data:load
```

You should see some postgres output running through your terminal. Once
it's done, fire up your rails console and check the `count` of the Comment
model. You should have a lot (300k+) of them.

## Big Idea
* The goal of every developer is to achieve the best possible user experience.
* Short response times contribute positively to a user's experience of a web application.
* As web applications scale there are two ways to boost performance:
1. Increase throughput
2. Decreasing response times

### Increasing throughput
* Increasing throughput means adding servers
* If you have more servers, then you have more processes that can handle more requests in any given amount of time.
* Common techniques for managing requests to multiple servers include auto scaling and load balancing.

### Decreasing response times
* When your response times are lower you need fewer servers to handle the same amount of requests.
* This is cheaper and avoids the architectural complexity of managing multiple servers.
* Common techniques for decreasing response time include optimizing database queries and caching.


### Decreasing response times through database query optimization

* At a high level most web apps are DB-heavy with low algorithmic complexity.
Additionally, HTTP necessitates lots of i/o even for repeated requests.
* How would we describe the performance profile of most SQL operations?
(find on 10 rows vs find on 10000 rows? where on 10 rows vs where on 10000 rows?)
* Some operations will scale consistently (i.e. constant time) -- last, first, count, find (indexed)
* Some operations will scale linearly with number of rows (where, find_by)

Example: `Article.find_by(title: Article.last.title)`

On master w/10 rows (sqlite)

```
irb(main):001:0> Article.find_by(title: Article.last.title)
  Article Load (0.1ms)  SELECT  "articles".* FROM "articles"   ORDER BY "articles"."id" DESC LIMIT 1
  Article Load (0.2ms)  SELECT  "articles".* FROM "articles"  WHERE "articles"."title" = 'Suscipit Dolores Nihil Et Vero Soluta 9' LIMIT 1
=> #<Article id: 10, title: "Suscipit Dolores Nihil Et Vero Soluta 9", body: "Earum amet voluptatum sunt. Qui doloribus laborum ...", created_at: "2015-07-08 18:57:43", updated_at: "2015-07-13 01:57:43", author_id: 3>
```

On perf branch with 70k rows (postgres)

```
irb(main):001:0> Article.find_by(title: Article.last.title)
  Article Load (1.6ms)  SELECT  "articles".* FROM "articles"   ORDER BY "articles"."id" DESC LIMIT 1
  Article Load (17.1ms)  SELECT  "articles".* FROM "articles"  WHERE "articles"."title" = 'Non Harum Nemo Culpa In Id 70000' LIMIT 1
=> #<Article id: 70001, title: "Non Harum Nemo Culpa In Id 70000", body: "Velit ut veniam dolorem. Molestiae qui aut laudant...", created_at: "2015-04-02 14:16:42", updated_at: "2015-04-27 02:16:42", author_id: 3347>
```

Example: `Comment.where(article_id: 7).count`

On master w/10 rows (sqlite)

```
irb(main):004:0> Comment.where(article_id: 7).count
   (0.3ms)  SELECT COUNT(*) FROM "comments"  WHERE "comments"."article_id" = 7
=> 6
```

On perf branch with 340k rows (postgres)

```
irb(main):008:0> Comment.where(article_id: 7).count
   (55.3ms)  SELECT COUNT(*) FROM "comments"  WHERE "comments"."article_id" = 7
   => 7
```

### A: It turns out that:

* An average web app is very database reliant -- at their core most of them are just
tools for displaying information from a data store and inserting it back in.
* The performance of SQL operations is relatively _inelastic_. The baseline often gives
great perf for small datasets, but for larger datasets the linear time growth is unacceptable.

### Q: What about database "load"?

* What's the difference between performance of a single query and load/performance of the entire DB?
* What sort of limitations might we run into as the DB _load_ increases? (Even if avg query
time is relatively good)

### A: A DB is also relatively inelastic from the perspective of load as well

Consider the `Comment.where(article_id: 7).count` example above. If our avg
query time is `0.3 ms` for that query, how many can we run in a second?

```
1000 ms / 0.3 ms per query = 3,333 queries per second
```

Not bad.

What about in the slower example?

```
1000 ms / 55 ms per query = 18 queries per second
```

Unsurprisingly, that's a lot less. But most importantly, what happens
if we start to go _over_ 18 queries per second?

With some exceptions (parallel query access, etc) a DB does have hard limits
to how much it can process in a given amount of time. Surpass that limit, and it
just can't keep up -- the query queue will start to grow, so that even a query
which by itself takes 20 ms will take 80 ms to get processed.

Since queries are ultimately triggered by user requests, this means users are
waiting as well, and the whole thing crawls toward a standstill. This brings
us to the dreaded web application database bottleneck, and explains
why it's such an important topic in web application performance and
architecture discussions.

## Avoiding the DB Bottleneck -- SQL and ActiveRecord Performance Techniques

Fortunately this doesn't have to be us. Modern databases are quite powerful and
give us a lot of tuning and optimization tools. All we have to do is learn them.

Let's talk through a few of these:

1. Measuring and Analyzing Queries (if you can't measure it, you can't fix it)
2. Improving query times with indexing
3. Removing N+1 queries with `ActiveRecord::Base.includes`
4. Reducing query size with `select` and `pluck`

## 1. Measuring and Analyzing Queries

As with all performance work, when tuning a DB we want to focus our
efforts on the "biggest wins", i.e. the bottlenecks. Optimizing
a query that takes 0.5 ms probably won't help our application much,
but optimizing one that takes 1 s will.

Additionally, ActiveRecord can sometimes take us by surprise with the
queries it generates, so we'll look at some tools for getting more
detail about what exactly ActiveRecord plans to do in response to a
given query.

Let's look at a few tools:

1. ActiveRecord#to_sql
2. ActiveRecord#explain
3. Skylight query tracking

#### 1. Console

In Rails 3.2+, ActiveRecord logs query strings and query times of
all SQL it executes.

__Exercise (5 minutes): Using SQL Query Time output__

Students use ActiveRecord from the Blogger rails console to find the following information, and note
the reported query times:

1. The last article ordered by `created_at` date
2. The first Comment
3. All comments attached to the article with the title "Earum Sequi Labore A Corporis Tenetur 66999"
4. All comments posted by the author "Brayan Larkin"

#### 2. `to_sql`

`ActiveRelation#to_sql` returns a string of the literal SQL used to generate that relation.

This can be a really excellent tool for understanding how adding more ARel method calls and parameters affect the resulting SQL.

__Exercise (3 minutes): Using to_sql__

Try running `to_sql` on some queries in the console. Experiment
with several different queries to find:

1. A query that uses `SELECT some_table.*` in its execution
2. A query that uses a `WHERE` clause in its execution
3. A query that uses an `ORDER BY ` clause in its execution

#### 3. `explain`

Viewing the raw SQL for a query can be a good place to start debugging it, but there's actually
more to a query than just a string of SQL statements.

Under the hood, the database is responsible for reading strings of
SQL statements and fetching the requested data from its storage.

It does this by generating a "query plan" -- a type of algorithm describing
the steps needed to find a given piece of data.

This can also be a useful piece of information to have when troubleshooting
queries, and fortunately ActiveRecord makes it available to us
via the `.explain` method.

__Exercise: SQL explain__

Use Arel to write queries for the following pieces of information:

1. The _second 5_ articles
2. The article with ID 70000 (note: you won't be able to use explain with `find_by`, so you may need to rephrase this query using `where`)
3. The _first 3_ comments with Article ID 2

Then use `explain` on each query and note the response ActiveRecord gives you.

__Discussion: Query Plan Types -- Sequential Scan vs Index__

## 2. Improving Performance with Indices

What difference did we notice using SQL Explain between
finding articles by ID vs just grabbing 5 in order out of the table?

An index is one of the easiest ways to improve performance when querying
your tables.

__Exercise: Indexing Comments on Article ID__

One of the most common types of columns to index is a foreign key. This
provides a lot of benefit because we tend to query on these columns frequently.

For example, consider how we look up the comments associated with a given
article. Using ActiveRecord, we can simply request `Article.find(2).comments`.

But at the database layer, this requires a query which goes through the comments
table and pulls out all the rows with a matching `article_id` of 2.

Practice indexing using this example.

1. Check the current SQL methodology for finding article-related comments
by using `.explain` to explain the query for finding all comments
associated with the first article.
2. Generate a migration to add an index to the `comments` table on the
`article_id` column.
3. Run the migration then re-try the query from before. Note the change
in the SQL explanation.

## 3. Removing N+1 Queries using `includes`

Sometimes we run into performance trouble not from the speed of a single
query but from the _number_ of queries a piece of code generates.

This is often called an __N+1__ query. To understand why, let's look
at an example.

__Exercise: Students Generate an N+1 Query__

In your Rails console, write a piece of code that does the following:

1. Find the first 5 Articles
2. For each article: __a)__ Print its title to the terminal and __b)__ For each of its comments, print the comment's Author Name
3. Scan through the terminal output this produces and pull out the lines
indicating query executions. What do you notice about them?

One thing to keep in mind is that many of the features (especially indexing
and SQL explaining) we've been looked at are things baked into the
database engine which ActiveRecord simply gives us a convenient interface
to.

`ActiveRelation.includes` is a convenient feature to help us eliminate N+1
queries by moving a bunch of small queries into a single bulk query.

However this is something implemented at the Ruby / ActiveRelation layer rather
than something baked specially into the DB.

When using `.includes`, ActiveRecord _automatically_ makes a second query on our
behalf. This helps us avoid the N+1 scenario because it takes something that
was previously:

* 1 query for a collection of articles
* A bunch (N) of small queries for groups of comments

and turns it into:

* 1 query for a collection of articles
* 1 query for a bunch of comments associated with those articles

__Without includes:__

1. Make a query for a collection of articles
2. Start iterating through the articles
3. Make a query for the comments attached to the current article
4. Do something with the comments
5. Repeat 2 through 3 until we run out of articles

__With includes:__

1. Make a query for a collection of articles
2. ActiveRecord automatically generates a query to fetch all
comments associated with those specific articles
3. Iterate through the articles
4. Iterate through the comments attached to the current article,
but we don't need to make a query since AR already did it for us
5. Repeat 3-4

__Exercise: Use includes to avoid N+1 queries in previous example__

Re-write your console printing snippet of code to use
`includes`. Read through all the lines of output produces, and
note the lines representing query executions. Are they different
from our initial example? How? Is the overall time faster?

## 4. Saving Time by Fetching Less Data -- `pluck` and `select`

So far we've looked at a technique to re-structure the way the DB engine
retrieves data we request (indexing) and a way to get ActiveRecord to
generate more optimal query patterns on our behalf (inclusion).

The next techniques are perhaps more subtle, but allow us
to gain a bit of extra performance in some situations by limiting
the amount of data we retrieve from the database.

__Exercise: Identify What Data an Average ARel Query Retrieves__

1. In console, generate a query to fetch the last 6 comments.
2. Read the SQL output for the generated query.
3. What columns is ARel fetching from the table on our behalf? How do we know?

__Discussion: ARel default queries and deserialization__

* Why does ARel default to retrieving all columns?
* What type of objects do we get back from a standard ARel query?
* What work is ARel doing behind the scenes to make this work?
* In what scenarios might we be able to do without those objects / use
a more simplified version of the data?

Main Points

* Pluck and Select can be easily chained onto other ARel queries
* Select is not used as frequently -- sometimes surprising to get an ActiveRecord
object without all of its attributes (`MissingAttributeError`) so watch out for that
* Pluck is great when you're going to fetch some records then iterate through them
and only use certain attributes (e.g. `Comment.all.map(&:body)` -- just use `pluck`)

__Exercise: Use Pluck__

1. Use pluck to fetch only the bodies of Comments attached to articles 7,9,182,and 6009
2. Use pluck to fetch only the titles of Articles written by the 587th Author
