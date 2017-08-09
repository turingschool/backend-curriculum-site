---
layout: page
---

# ActiveRecord Association Practice

We'll be using this starter [repository](https://github.com/turingschool-examples/sinatra-active-record-skeleton) to work through the following exercises.

## Self-Eval Statements

*   I feel _very_ comfortable creating has_many and belongs_to associations
*   I feel _very_ comfortable modifying tables and models to accommodate new data
*   I feel pretty confident that I can make a joins table if I need to

## Step 1 - Tables

### Timing

*   Work (20 min)
*   Group Review (10 min)
*   Break (5 min)

### Work

We're going to start building a `BoardGame` tracking application. A `BoardGame` has a `name`, `description`, and `year`. Each board is added by a user, so a user can add many `BoardGames`. Each `BoardGame` will also belong to a `Category` (for example, `family`, `adult`, `card`, etc.). A `Category` simply has a `name`.

Draw the database schema to model this application description. Be sure to follow naming conventions and to put the foreign key in the correct table. When you're done, check with an instructor or your neighbor to ensure you're on the right track.

*   **Baseline:** A `BoardGame` will belong to one `User` at a time and belong to one `Category` at a time.
*   **Spicy:** A `BoardGame` can belong to multiple users, and a user can have multiple `board_games`. Also, a `BoardGame` can belong to multiple `categories`, and each `Category` will have multiple associated `board_games`.

Once your schema looks good, go ahead and create some migrations to setup your database.

## Step 2 - Models

### Timing

*   Work (20 min)
*   Group Review (10 min)
*   Break (5 min)

### Work

What models do you need? How does a model relate to your database?

Setup your models (don't forget to follow naming conventions!).

*   **Finish Early?:** Write tests

## Step 3 - Relationships

### Timing

*   Work (10 min)
*   Group Review (10 min)
*   Break (5 min)

### Work

Given that you have the correct relationship created on the database level, we can now create our relationships on the model level. How does a user relate to a `BoardGame`? How does a `BoardGame` relate to a `Category`? Work through each relationship and add the correct association to the correct model.

*   **Spicy:** You'll also want to add validations to ensure that all `Categories` have a `name`, all `BoardGames` have `users` and `categories`.
*   **Finish Early?:** Write tests

## Step 4 - Does it Work?

### Timing

*   Work (15 min)
*   Group Review (10 min)
*   Break (5 min)

### Work

How do we know if our models and our database tables are associated correctly? Let's hop into `tux`, create some data, and practice calling the methods we've written (our association methods)!

## Done?

*   If you did the baseline with no joins tables, pair with someone who did the joins table and get one up and running in your code.
*   What if we wanted a user to be able to review a `BoardGame`? What tables, models, and associations would we need to create to add this review feature?
*   Read about polymorphic associations [here](http://guides.rubyonrails.org/association_basics.html#polymorphic-associations). They are pretty neat!
