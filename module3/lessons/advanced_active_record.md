---
layout: page
title: Advanced ActiveRecord
length: 180
tags: rails, active record
---

## Resources

* [Video](https://www.youtube.com/watch?v=OccKyvGvLKE&t=1329s) from a past class and the core ideas

## Prior to Class

* Students need to have a solid understanding of inner joins, grouping, ordering, filtering, and aggregate functions in SQL.
* **Important:** All students should spend 3 hours the evening prior to this class attempting to solve a business intelligence problem from their project. It will get them familiar with the schema and get them familiar with the types of challenges they will encounter.

## Completion Goals

* The instructor will use class input to build an ActiveRecord query to find the **top 5 most expensive invoices with successful transactions**.
* The afternoon after the class is complete students should be working in groups to diagram one additional business intelligence challenge and work on solving it together.

## Learning Goals

* Student can diagram the required connections needed for ActiveRecord and SQL queries
* Student can execute raw SQL in Rails
* Student can connect to a SQL interface in Rails to visualize query results
* Student can explain why GROUP BY is needed with aggregate functions
* Student can explain what a virtual attribute is in ActiveRecord and how it relates to a SQL alias

---

## Warmup (5 mins)

* Have students read about Entity Relationship Diagrams

---

## Intro (10 mins)

* What are ER Diagrams?
* What are the advantages of this approach?
* What are the disadvantages?

As we work on more difficult business intelligence it becomes more difficult to hold all of the moving parts in our head. A great strategy for managing this complexity is offloading the parts we care about to a visual representation. While ER Diagrams are an official way to do this, it is frequently easier to sketch something out on a whiteboard or in a notebook.

As a class we're going to start solving our ActiveRecord problem mentioned above by diagraming the problem.

## Student Writing (5 mins)

Have each student create a visual representation of the tables and columns that will be necessary to solve the BI challenge mentioned above.

## Break (5 mins)

## Diagraming as a Group (20 mins)

* Using popsicle sticks (or some other method) select students to share out a column they believe is necessary to accomplish the goal mentioned above.
* After all columns and tables are present, continue selecting students to explain why we care about each column. Use the SQL functions names and write them on the board with relation to the column(s) they are relevant to.
* Be sure to note things such as `INNER JOIN`, `WHERE`, `GROUP`, `ORDER BY` etc., as well as aggregate functions on the board.

## Break (10 mins)

## Instructor Led Terminal Session (~2 hours)

Start out in a Rails console.

It's common for students to start their queries in a join table since they usually frequently touch the most tables directly. When using `ActiveRecord` this will usually lead to making two queries. For example: For this query, we are trying to return a collection of `Invoice`s. We could retrieve all of the invoice id's from the invoice_items table but then we'd need to do a second lookup to the invoices table.

Generally it's best to start in the model that corresponds to the object(s) you are trying to return. If you are trying to return Invoices then start in the `Invoice` model.

#### How to work through:

* Using the diagram created above, work through and make sure each piece is accounted for.
* Start with the easiest parts of the query.
* Only add complexity when you are sure what you have is working the way you expect it to.
* Read the SQL output as you execute the `ActiveRecord` queries.

## Cheatsheet (without the answers ;)

Use the methods and tools below to work through the BI.

### .to_sql

Generates a string of the SQL that your `ActiveRecord` query generates.

### dbconsole

`$ rails dbconsole`

Connects you to your database console defined in `database.yml`. This will allow you to execute and write SQL and see the typical table style output which can be really useful when troubleshooting. Paste in the results of `.to_sql` to visualize the results.

### .joins()

Cheatsheet:

* `Author.joins(:articles).distinct` - Returns unique authors who have articles
* `Author.joins(articles: [:comments]).distinct` - Returns unique authors who have articles that have been commented on
* `Author.joins(:articles, :writing_departments).where(articles: {tutorial: "true"}, writing_departments: {title: "Software Development"}).distinct` - Returns unique authors that have written tutorials for the Software Development department.

### .select()

Simple: Return 5 authors with only their id and name.

```ruby
Author.select(:id, :name).limit(5)
```

Complex: Return the authors with the most commented on articles limited to 10. We only need their name, id, and comment count.

```ruby
Author.joins(articles: [:comments])
  .select("authors.id, authors.name, COUNT(comments) as total_comments")
  .group(:id)
  .order("total_comments DESC")
  .limit(10)
```

Breaking down the query above:
* `select` - Grabs the id and name then runs an aggregate function to count how many comments this authors articles have received. It saves this count into an alias called `total_comments`. `ActiveRecord` will define a virtual attribute that shares the same name as the alias. e.g. `author.total_comments # => 178`
* `group` - Is required when we run an aggregate function since the resulting alias isn't clearly associated with anything. We need to specify how to organize the results. In this case: each author's id's.
* `order` - We're ordering by the alias from the aggregate function. When ordering by something that is not stored on the starting table we need to do it as a string.

### .merge() and scopes

Return the authors with the most commented on articles limited to 10. Only return articles marked as a tutorial.

```ruby
Author.joins(articles: [:comments])
  .select("authors.* COUNT(comments) as total_comments")
  .group(:id)
  .where(articles: {tutorial: true})
  .order("total_comments DESC")
  .limit(10)
```

It's not great for the `Author` model to know about the inner workings of the articles table. And we might want to query for tutorials in other places. We can use `.merge` to share pull in logic from other places.

```ruby
# article.rb
class Article < ApplicationRecord
  scope :tutorials, -> { where(tutorial: true) }
  # ...
end

# rails console
Author.joins(articles: [:comments])
  .select("authors.* COUNT(comments) as total_comments")
  .group(:id)
  .merge(Article.tutorials) # this is where we merge
  .order("total_comments DESC")
  .limit(10)
```

### default scope

What order does your database return the results when you run `Article.all`? Hint: take a look at the SQL that gets generated.

You can set a default order using a default scope:

```ruby
class Article < ApplicationRecord
  scope :tutorials, -> { where(tutorial: true) }

  default_scope { order(:id) }
# ...
end
```

How does SQL generated from `Article.all` differ now?

Gotcha: What happens when we run this query now?

```ruby
Author.joins(articles: [:comments])
  .select("authors.* COUNT(comments) as total_comments")
  .group(:id)
  .merge(Article.tutorials) # the merge pulls in the default scope now
  .order("total_comments DESC")
  .limit(10)
```

What SQL gets generated if we were to run: `Article.unscoped.all`?

Putting it all together...

```ruby
Author.joins(articles: [:comments])
  .select("authors.* COUNT(comments) as total_comments")
  .group(:id)
  .merge(Article.unscoped.tutorials) # unscoping our merge
  .order("total_comments DESC")
  .limit(10)
```

### .find_by_sql()

### ActiveRecord.connection.execute()
