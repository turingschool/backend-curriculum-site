---
title: ActiveRecord Queries
length: 60
tags: activerecord, migrations, sinatra
---

## Learning Goals

* Use `joins` to collect information from multiple tables
* Use `group` to group results by a common characteristic
* Use `order` to order grouped results

## Warmup

* What new ActiveRecord methods did you learn over the weekend?
* How would you do the following in SQL?
  * Join results from multiple tables?
  * Order results
  * Group results

## Lecture

Thus far we've talked about using ActiveRecord to create, find, and delete records, as well as to find related records on other tables. In your project, you've begun using ActiveRecord to query your database for more analytical purposes. Today we're going to review three ActiveRecord methods that will help you with some of those analytics.

### Joins

The `.joins` method creates a `JOIN` query at the SQL level. What does this do?

Assume we have the following tables.

courses:

| id | title | description                             |
|----|-------|-----------------------------------------|
| 1  | BE M1 | OOP with Ruby                           |
| 2  | BE M2 | Web Applications with Ruby              |
| 3  | BE M3 | Professional Rails Applications         |
| 4  | BE M4 | Client-Side Development with JavaScript |

students:

| id | first_name | last_name | course_id |
|----|------------|-----------|-----------|
| 1  | Sal        | Espinosa  | 2         |
| 2  | Ilana      | Corson    | 2         |
| 3  | Josh       | Mejia     | 3         |
| 4  | Casey      | Cumbow    | 4         |
| 5  | Ali        | Schlereth | 1         |
| 6  | Victoria   | Vasys     | 1         |
| 7  | Mike       | Dao       | 1         |


In another tab, let's open a connection to `psql`
```
$ psql
$ \c roster-development
```
A `JOIN` query would look something like this:

```SQL
SELECT * FROM courses JOIN students ON students.course_id = courses.id;
```

And it would result in a table like the following:

| id | title | description                             | id | first_name | last_name | module_id |
|----|-------|-----------------------------------------|----|------------|-----------|-----------|
| 1  | BE M1 | OOP with Ruby                           | 5  | Ali        | Schlereth | 1         |
| 1  | BE M1 | OOP with Ruby                           | 6  | Victoria   | Vasys     | 1         |
| 1  | BE M1 | OOP with Ruby                           | 7  | Mike       | Dao       | 1         |
| 2  | BE M2 | Web Applications with Ruby              | 1  | Sal        | Espinosa  | 2         |
| 2  | BE M2 | Web Applications with Ruby              | 2  | Ilana      | Corson    | 2         |
| 3  | BE M3 | Professional Rails Applications         | 3  | Josh       | Mejia     | 3         |
| 4  | BE M4 | Client-Side Development with JavaScript | 4  | Casey      | Cumbow    | 4         |

Notice that there is duplicated information in the table that resulted from this JOIN.

How does this look in ActiveRecord?

First, in order to create the query, we use the ActiveRecord `.joins` method. Note that this is a **class** method. It creates a new table with a row for each record that would be in the resulting table.

```ruby
# In the Course model
def self.with_students
  joins(:students)
end

# From Tux
Course.joins(:students)
```

If we add `.count(:id)` to the end of those statements, we will get seven, even though there are only four courses. This is because the resulting table would have seven rows.

The Course objects that are returned from this query will only know about Course attributes. In order to access attributes from both tables, we need to add one more piece:

```ruby
# In the Course model
def self.with_students
  select("courses.*, students.*").joins(:students)
end

# From Tux
Module.select("modules.*, students.*").joins(:students)
```

With that in place, we can get student attributes out of our Course object, like so:

```
Course.selct("courses.*, students.*")
  .joins(:students)
  .first
  .first_name
```

More on how we might use `.joins` shortly.

### Group

Group will take the results and group them by a particular attribute. So, for example:

```ruby
# In the Student model
def self.count_by_course_id
  group(:course_id).count
end
```

Will return a hash like the following:

```ruby
{1 => 3, 2 => 2, 3 => 1, 4 => 1}
```

That's fine. Let's keep pushing.

### Order

Assume we want to take the same request, but now sort it by the count, getting the courses with the lowest counts of students first. We could use order.

```ruby
# In the Student model
def self.count_by_course_id
  group(:course_id).order("count_all").count
end
```

Now the resultant hash would look something like the following:

```ruby
{3 => 1, 4 => 1, 2 => 2, 1 => 3}
```

Interestingly, if you add a `select` clause with a calculation as an argument, it is possible for a `group` and `order` query to return objects. For example:

```ruby
Genre.select("genres.*, sum(box_office_sales) AS total_sales")
  .joins(:films)
  .group(:genre_id)
  .order("total_sales DESC")
```

This query will return a collection of Genre objects. The first will be the Genre with the highest total box office sales across all films.

## Checks for Understanding

* What does a `.joins` query do in ActiveRecord?
* `.group`?
* `.order`?
* `.select`?
* What does a `.group` query return when you have `.count` on the end?
* Without it?
