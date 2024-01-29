---
title: Intro to Databases and ORMs
length: 120
layout: page
---

## Learning Goals

- Describe what a database is and how it relates to web applications
- Define key database vocabulary including "table", "column", "row", "primary key", "migration", and "schema"
- Describe the purpose of database migrations
- Write a simple database migration
- Use Postico to visualize the Database
- Describe what an ORM is and how it relates to the database
- Use built in ActiveRecord methods to CRUD resources in the Rails Console

## Prerequisites

You should have installed Postico as part of the [mod 2 intermission work](../intermission_work). If not, [download Postico](https://eggerapps.at/postico/) and install it. 

Setup instructions for Postico can be found [here](./setting_up_postico).

## Database Exploration

### Part 1: Migrations

To reset your database and start from a blank slate, run `rails db:drop` in your terminal at the root director of your Task Manager repo. This will delete the local task manager database. Then, run `rails db:create` to recreate the database. You can also run these two tasks together by writing `rails db:{drop,create}`. 

At this point, you have a local database running, and memory allocated on your machine to hold data, but your database is completely blank. Consider it like an empty lot before a house gets built. Your database, however, is not yet ready to hold records though, because there is no structure for the data to follow. There are no tables, with no columns to indicate the data's shape and attributes. That's where migrations come in. 

Migrations are files that define changes that are made to your database in order to alter its structure, or schema. Migrations are written in order to create tables, add columns, delete columns, create relationships, etc. In your task manager tutorial, you created a migration to create the tasks table by running:

```
$ rails generate migration CreateTask title:string description:string
```

This command generated a migration file in the `db/migrate` directory that looked something like this:

```
class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
```

This file indicates that you want to create a table in your database, and it will contain the attributes `title` and `description`, as well as timestamp columns which will be added automatically, `created_at` and `updated_at`. 

If you now run `rails db:migrate`, you are telling your local database to execute this migration file in order to make this change. Once you've migrated your databsae, it's ready to hold task records. 

### Migrations and Fixing Forward

Creating a migration file and running it might seem overkill when you could just go into your database and run a SQL `create` command. However, migrations are very important when working on collaborative software. Migration files are like version control for your database because they track every change that's been made. Therefore, you can make sure every computer that is running your Rails application has a corresponding database that is in the same state. 

The alternative to migrations is an onerous and annoying process. Imagine, every time you pulled changes from a group project, you had to ask your project mates if they made any changes to the database, and if they did, you would have to go in and manually make those same changes. Instead, migrations make it easy to track all of these changes and running the `rails db:migrate` command will execute any migration files you haven't yet made on your local machine. 

When you create a migration file, the file name will contain a timestamp (something like `db/migrate/20190414173402_create_task.rb`). This timestamp is used by Rails to determine whether it has run that migration yet. Therefore, when you need to make another change to the database, it's best practice to create a new migration file rather than updating an existing migration file (which your machine has already run). This is called fixing-forward. 

### Part 2: Postico

Use Postico to do the following:

- Open your `task_manager_development` database
- View all `tasks`
- Add some new rows to your tasks table
- Change one of the attributes of a task
- Delete a task
- Execute the following SQL queries
    - Retrieve all Tasks
    - Retrieve all Tasks with a title of "Laundry"

Then, answer the following questions:

- What is a database?
- Compare and contrast a database with a collection of CSV files.
- How does a DB relate to web applications?
- Define each of the following terms
    - Table
    - Column
    - Row
    - Primary Key
    - Schema
- How would you describe your `task_manager_development` database's schema
- What is SQL? How does it relate to the DB?

**Extensions**

If you complete the activity and answer the follow up questions, try to execute the following SQL queries:

- Add a new task to the Tasks table
- Retrieve all tasks sorted by title in reverse alphabetical order
- Find all Tasks where the description **contains** the string "shop". (Need help? See [this](https://www.postgresql.org/docs/8.3/functions-matching.html))
- Delete a task
- Create a new table called "People". A Person should have a name and an age.

## Rails Console Activity

1. First, open Postico and double check that you have deleted any tasks you made during the Postico Activity
2. In TaskManager, open up the Rails console by running `rails c` from the command line (make sure that you navigate to your TaskManager repo first)
3. Open up your `Tasks` table in Postico. Now run `tasks = Task.all` in your Rails console. Is this what you would expect? What type of object is returned from this method call? What SQL query do you see in the Rails Console after running this command? Now run `Task.all.to_sql`. How does this compare to the SQL command you saw in the Rails Console?
4. In the Rails Console, run `Task.create(title: "Laundry", description: "Clean the clothes")`. Now open up the Tasks table in Postico. Do you see your new Task? If not, try to refresh your table. What SQL query do you see in the Rails Console after running this command? What does the `create` method do?
5. In the Rails Console, run `task = Task.new(title: "Grocery Shopping", description: "need to eat")`. What `id` do you see stored in the new Task object? Now open up the Tasks table in Postico. Do you see your new Task? In the Rails Console, run `task.save`. Now what `id` do you see for the Task object? Do you see it stored in the Tasks table in Postico? If not try to refresh your table. What is the difference between `new` and `create`?
6. In the Rails Console, run `task.update(description: "go buy food")`. Now check your Tasks table in Postico. Did it change? Is this what you expected?
7. In the Rails Console, run `task.destroy`. Now check your Tasks table in Postico. Did it change? Is this what you expected?
8. In the Rails Console, run `Task.find(<id>)` where `<id>` is the `id` of a Task in your database. What does this return? Now run the same command with an `id` that is not in the database. What does this produce?

When you are finished with the activity, answer the following questions:

- What is an ORM? How does it relate to the DB?
- Why would you want/need to use an ORM?
- What is ActiveRecord?
- What is a Model in a Rails application?
- What is the Rails Console? Why would you use the Rails console?

Key Takeaways (Read these after answering the questions above!):

- ActiveRecord as an ORM is the "middleman" between our Rails application and our database. It encapsulates access to the database and allows us to easily query and mutate data.
- ActiveRecord has many built in methods for querying the database
- All ActiveRecord commands execute SQL under the hood.
- ActiveRecord objects are a representation of what is stored in the database, and they are called Models
- We can use the Rails Console to execute ActiveRecord queries. This is a great option for testing out ActiveRecord you are going to add to your application.
- We can use the Rails dbconsole to execute raw SQL queries as an alternative to the Rails Console. 


## Checks for Understanding

- What is a database? How does a database relate to web applications? What is Postgresql?
- What is the database schema?
- What is an ORM? What is ActiveRecord? How do they relate to the database?
- What is a model in a Rails application?
- Assuming you have a `Song` model, what ActiveRecord methods would you use to do the following?
    - Retrieve a Song from the DB with a specific ID
    - Retrieve all Songs from the DB
    - Store a new Song in the database
    - Change the attributes of an existing Song in the DB
    - Delete a particular Song from the DB
