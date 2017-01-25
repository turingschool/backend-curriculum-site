# ActiveRecord Association Practice

We'll be using this starter [repository](https://github.com/turingschool-examples/sinatra-active-record-skeleton) to work through the following exercises.

## Step 1 - Tables

We're going to start building a board game tracking application. A board game has a name, description, and year. Each board is added by a user, so a user can add many board games, but for our purposes, a board game will belong to one user at a time. Each board game will also have a category (for example, family, adult, card, etc.). A category simply has a name.

Draw the database schema to model this application description. Be sure to follow naming conventions and to put the foreign key in the correct table. When your done, check with an instructor or your neighbor to ensure you're on the right track.

Once your schema looks good, go ahead and create some migrations to setup your database.

## Step 2 - Models

What models do you need? How does a model relate to a database?

Setup your models (don't forget to follow naming conventions!).

## Step 3 - Relationships

Given that you have the correct relationship created on the database level, we can now create our relationships on the model level. How does a user relate to a game? How does a game relate to a category? Work through each relationship and add the correct association to the correct model.

## Step 4 - Does it work?

How do we know if our models and our database tables are associated correctly? Let's hop into `tux`, create some data, and practice calling the methods we've written (our association methods)!

## Done?

* What if we wanted a user to be able to review a board game? What tables, models, and associations would we need to create to add this feature?
* Read about polymorphic associations [here](http://guides.rubyonrails.org/association_basics.html#polymorphic-associations). They are pretty neat!
