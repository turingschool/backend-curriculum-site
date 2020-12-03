---
title: Class vs Instance Methods
length: 120
layout: page
---

## Learning Goals

* Identify use cases for class methods and instance methods in the context of a Rails app
* Identify available AR methods depending on current context of `self`
* Differentiate when to use a class method or an instance method

# Lesson

## Discussion Questions

* What is a class method?
* What is an instance method?
* What is self in each context?

## SetList Activity

In your SetList app:

* Create a method that returns an artist name given a song
* Create a method to retrieve a random song
* Create a method to retrieve a random song given an artist
* Create a method that orders an artist's songs by name
* Create a method that finds an artist's longest song
* Create a method that finds the song with the most plays

**Extensions**

If you complete the activity and answer the follow up questions, try to execute the following SQL queries:

* Add a new task to the Tasks table
* Retrieve all tasks sorted by title in reverse alphabetical order
* Find all Tasks where the description **contains** the string "shop". (Need help? See [this](https://www.postgresql.org/docs/8.3/functions-matching.html))
* Delete a task
* Create a new table called "People". A Person should have a name and an age.

## Discussion Questions pt. 2

* What is an ORM? How does it relate to the DB?
* Why would you want/need to use an ORM?
* What is ActiveRecord?
* What is a Model in a Rails application?
* What is the Rails Console? Why would you use the Rails console?

## Rails Console Activity

1. In TaskManager, open up the Rails console by running `rails c` from the command line (make sure that you navigate to your TaskManager repo first)
1. Open up your `Tasks` table in Postico. Now run `tasks = Task.all` in your Rails console. Is this what you would expect? What type of object is returned from this method call? What SQL query do you see in the Rails Console after running this command? Now run `Task.all.to_sql`. How does this compare to the SQL command you saw in the Rails Console?
1. In the Rails Console, run `Task.create(title: "Laundry", description: "Clean the clothes")`. Now open up the Tasks table in Postico. Do you see your new Task? If not, try to refresh your table. What SQL query do you see in the Rails Console after running this command? What does the `create` method do?
1. In the Rails Console, run `task = Task.new(title: "Grocery Shopping", description: "need to eat")`. What `id` do you see stored in the new Task object? Now open up the Tasks table in Postico. Do you see your new Task? In the Rails Console, run `task.save`. Now what `id` do you see for the Task object? Do you see it stored in the Tasks table in Postico? What is the difference between `new` and `create`?
1. In the Rails Console, run `task.update(description: "go buy food")`. Now check your Tasks table in Postico. Did it change? Is this what you expected?
1. In the Rails Console, run `task.destroy`. Now check your Tasks table in Postico. Did it change? Is this what you expected?
1. In the Rails Console, run `Task.find(<id>)` where `<id>` is the `id` of a Task in your database. What does this return? Now run the same command with an `id` that is not in the database. What does this produce?

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
