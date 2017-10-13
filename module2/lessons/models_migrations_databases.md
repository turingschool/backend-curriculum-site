---
layout: page
title: Models, Migrations, and Databases
tags: migrations, databases, relationships, rails, migrations, activerecord
---

## Overview

In this lesson, we'll be coding along to create an example of an app that demonstrates a one-to-many and a many-to-many relationship.

We're going to add two tables (`directors`, and `actors`) to our database, and connect them to our existing `films` table.

What might the relationships look like? Let's emphasize figuring out the entities (aka tables), but also figure out some of the key data columns.

## Learning Goals

* Create one-to-many relationships at the database level using foreign keys.
* Create many-to-many relationships at the database level using join tables with foreign keys.
* Use `has_many` and `belongs_to` to create one-to-many and many-to-many relationships at the model level.
* Define primary and foreign keys, and describe conventions used to name the columns containing each in a database.

## Types of Relationships

Just storing data in a database isn't very interesting. Where the database shines is in the ability to connect or express relationships between elements of data.

* **One-to-one relationships**: a row of table A relates to one and only one row of table B

* **One-to-many relationships**: a row of table A relates to zero, one, or multiple rows of table B. However a row of table B relates to only one row of table A.

* **Many-to-many relationships**: a row of table A relates to zero, one, or multiple rows of table B. A row of table B relates to zero, one, or multiple rows of table A.

## Warmup

With a partner, brainstorm at least one example of each of the three relationships mentioned above.

## Databases in Rails Apps

By default, the `rails new appname` command creates a Rails project with a sqlite database. If you're creating a production app, you do not want a sqlite database.

The two places where you'll see the effects of this will be in the Gemfile (`gem 'pg'` instead of `gem 'sqlite3'`) and in `config/database.yml`.

Let's look at that file. Getting rid of the comments, it looks like this:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: pgapp_development

test:
  <<: *default
  database: pgapp_test

production:
  <<: *default
  database: pgapp_production
  username: pgapp
  password: <%= ENV['PGAPP_DATABASE_PASSWORD'] %>
```

## One-to-Many Relationships

### At the Database Level: Directors

Let's do:

1. First, we'll create a migration and a model:

`rails generate migration CreateDirectors name:string`

or

`rails g migration CreateDirectors name`

The migration generator creates a migration and if we follow the working convention for rails the migration will be pre-populated.

Let's look at the migration inside of `db/migrate`:

```ruby
class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :name

      t.timestamps
    end
  end
end
```

Now create a model file. `touch app/models/director.rb`
Inside `director.rb` add the code that hooks up our model to ActiveRecord.

```ruby
class Director < ApplicationRecord
end
```

### What about Movies?

What's the relationship between movie and director?

```bash
rails g migration AddDirectorsToMovies director:references
```

Let's look at what this migration creates.

What else do we need?

## Associations

### One-to-Many Relationships at the Model Level: Movie/Director

Let's implement some model-level associations using our handy methods.

* `has_many`
* `belongs_to`

Why do we need a foreign key at the database level and the `belongs_to` method in the model? What do each of these things allow for?

*In the console*:

Create a director. Create a movie.

What are different ways to associate movies with directors?

## Many-to-Many: Movies and Actors?

Let's first draw out the relationship for movies and actors.

```bash
rails g migration createActors name
```

```bash
rails g migration createActorMovies actor:references movie:references
```

```bash
rake db:migrate
```

Now create the models to go with these new tables.

*In the console*:

Create a actor.

What are different ways to associate movies with actors?

Need a refresher on associations? Click [here](http://guides.rubyonrails.org/association_basics.html).

## Notes

* common column types: `boolean`, `string`, `text`, `integer`, `date`, `datetime`
* `rake db:migrate` migrates development
* you (generally) don't need to run `rake db:test:prepare`; running `rake test` will load the schema to the test database

## Checks for Understanding

* What is a primary key?
* What is a foreign key?
* In what situation would one row of data have both primary and foreign keys?
* In what situation would two entities be related but *not* have foreign keys stored on either of the tables?
* What is Rails' convention for the column name of the primary key?
* What is Rails' convention for the column name of a foreign key?
* What are dev, test, and prod databases all about?
* What is the database.yml and how is it used?
