---
title: Intro to Databases and ORMs
length: 120
layout: page
---

## Learning Goals

* Describe what a database is and how it relates to web applications
* Describe what SQL is
* Define key database vocabulary including "table", "column", "row", "primary key", and "schema"
* Use Postico to visualize the Database
* Describe what an ORM is and how it relates to the database
* Use built in ActiveRecord methods to CRUD resources in the Rails Console  

## Prerequisites

You should have installed Postico as part of the [mod 2 intermission work](../intermission_work/). If not, [download Postico](https://eggerapps.at/postico/) and install it. 

After launching Postico, be sure you can connect to your TaskManager database by filling in the "Database" field with `task_manager_development`. You should be able to leave the other fields as default (other than "Nickname" - this is just an easier way to find this database after connecting to it). 

# Lesson

## Postico Activity

Use Postico to do the following:

* Open your `task_manager_development` database
* View all `tasks`
* Add some new rows to your tasks table
* Change one of the attributes of a task
* Delete a task
* Execute the following SQL queries
    * Retrieve all Tasks
    * Retrieve all Tasks with a title of "Laundry"

Then, answer the following questions:

* What is a database?
* Compare and contrast a database with a collection of CSV files.
* How does a DB relate to web applications?
* Define each of the following terms
    * Table
    * Column
    * Row
    * Primary Key   
    * Schema
* How would you describe your `task_manager_development` database's schema
* What is SQL? How does it relate to the DB?

**Extensions**

If you complete the activity and answer the follow up questions, try to execute the following SQL queries:

* Add a new task to the Tasks table
* Retrieve all tasks sorted by title in reverse alphabetical order
* Find all Tasks where the description **contains** the string "shop". (Need help? See [this](https://www.postgresql.org/docs/8.3/functions-matching.html))
* Delete a task
* Create a new table called "People". A Person should have a name and an age.

## Rails Console Activity

1. First, open Postico and double check that you have deleted any tasks you made during the Postico Activity
1. In TaskManager, open up the Rails console by running `rails c` from the command line (make sure that you navigate to your TaskManager repo first)
1. Open up your `Tasks` table in Postico. Now run `tasks = Task.all` in your Rails console. Is this what you would expect? What type of object is returned from this method call? What SQL query do you see in the Rails Console after running this command? Now run `Task.all.to_sql`. How does this compare to the SQL command you saw in the Rails Console?
1. In the Rails Console, run `Task.create(title: "Laundry", description: "Clean the clothes")`. Now open up the Tasks table in Postico. Do you see your new Task? If not, try to refresh your table. What SQL query do you see in the Rails Console after running this command? What does the `create` method do?
1. In the Rails Console, run `task = Task.new(title: "Grocery Shopping", description: "need to eat")`. What `id` do you see stored in the new Task object? Now open up the Tasks table in Postico. Do you see your new Task? In the Rails Console, run `task.save`. Now what `id` do you see for the Task object? Do you see it stored in the Tasks table in Postico? If not try to refresh your table. What is the difference between `new` and `create`?
1. In the Rails Console, run `task.update(description: "go buy food")`. Now check your Tasks table in Postico. Did it change? Is this what you expected?
1. In the Rails Console, run `task.destroy`. Now check your Tasks table in Postico. Did it change? Is this what you expected?
1. In the Rails Console, run `Task.find(<id>)` where `<id>` is the `id` of a Task in your database. What does this return? Now run the same command with an `id` that is not in the database. What does this produce?

When you are finished with the activity, answer the following questions:

* What is an ORM? How does it relate to the DB?
* Why would you want/need to use an ORM?
* What is ActiveRecord?
* What is a Model in a Rails application?
* What is the Rails Console? Why would you use the Rails console?

Key Takeaways:

* ActiveRecord objects are a representation of what is stored in the database
* ActiveRecord has many built in methods for querying the database
* All ActiveRecord commands execute SQL under the hood.

## Checks for Understanding

* What is a database? How does a database relate to web applications? What is Postgresql?
* What is the database schema?
* What is an ORM? What is ActiveRecord? How do they relate to the database?
* What is a model in a Rails application?
* Assuming you have a `Song` model, what ActiveRecord methods would you use to do the following?
    * Retrieve a Song from the DB with a specific ID
    * Retrieve all Songs from the DB
    * Store a new Song in the database
    * Change the attributes of an existing Song in the DB
    * Delete a particular Song from the DB
