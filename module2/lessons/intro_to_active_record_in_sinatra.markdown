---
title: Intro to ActiveRecord in Sinatra
length: 60
tags: activerecord, migrations, sinatra
---

## Learning Goals

* Generate a migration in order to create or modify a table
* Use rake commands to create a database/drop a database/generate migration files/and migrate the database
* Interpret schema.rb
* Utilize ActiveRecord Models in the controller to pass information to views

## Vocabulary

* ActiveRecord
* Relational database
* Schema
* Object Relational Map (ORM)

## Warmup

* What are the pieces of MVC? How do we use them in a Sinatra app?
* What do you know about ActiveRecord?
* Name two ActiveRecord methods you explored yesterday.

## Repository

Clone [this](https://github.com/turingschool-examples/film-file) repository and run `bundle install`.

## Lecture

Using the Film File repository that we've cloned down, we're going to create an application that displays information about films in our database.

### Background

#### Relational Databases
Database systems are helpful when handling massive datasets by helping to optimize complicated queries. Relational databases make it easy to relate tables to one another.

For example, if we have a table of songs and artists, and a song belongs to one artist, we'll need to keep track of how these pieces of data relate to one another. We might keep that information in our app in something like a YAML file but the problem is, there's no easy way to query a YAML file for this info.

#### Object Relational Mappers
"An ORM framework is written in an object oriented language (like Ruby, Python, PHP etc.) and wrapped around a relational database. The object classes are mapped to the data tables in the database and the object instances are mapped to rows in those tables."

(from sitepoint.com)

![400% ORM Diagram](http://wiki.expertiza.ncsu.edu/images/2/2c/ORM_Flowchart.jpg)

* Someone has done the hard work of allowing us to easily interact with the relational database, through Ruby.

#### Ruby ORM's
* ActiveRecord (lots)
* DataMapper (a few)
* Sequel (pretty much none)

#### Why do we need an ORM?

We want to wrap our data in Ruby objects so we can easily manipulate them. If we didn't wrap them in Ruby objects, we'd simply have strings in arrays and other simple data types. This wouldn't be very easy to work with or manage.

#### How does a database map to a Ruby class?

* a file represents a table
* the table represents the collection of instances
* a row represents one specific instance
* the columns represent the attributes of an instance

**Partnered Practice**

With someone near you, draw out a diagram representing the above four aspects.

## Tutorial

We're going to use ActiveRecord migrations to create a `films` table, and then create a Film model that allows us to interact with that table from our app.

A `Film` will have a title (text), year (integer), and box_office_sales (integer).

At a high level, we are going to follow these steps:

1. Create a migration file.
1. Write code in that migration to create the `films` table with the necessary fields
1. Run the migration.
1. Inspect `schema.rb` to ensure your table was created as intended.
1. Create a `Film` model.
1. Add data using `tux`
1. Review our controller to see that we have a route to see all films
1. Launch our server to see your films!

### Creating the database

(make sure you've run `bundle install` before you start these instructions)

Before we begin, we'll need to create a database.

If you look in the `db` folder, you'll notice that we don't have any database files. In order to create our database, we need to run `rake db:create`. After running this command, you'll see an empty sqlite file now inside the `db` folder.

### Creating a Films Table

Now we want to add a table to our database. In order to do that, we'll need to create a migration to hold the instructions to add this table to our database. When we `run` our migrations, we make those changes to our database.

Rake gives us some handy commands to help us generate migration files.

```ruby
$ rake db:create_migration NAME=create_films
```

Inside of that file you should see an empty migration file:

```ruby
class CreateFilms < ActiveRecord::Migration
  def change
  end
end
```

We are going to use ActiveRecord's `create_table` method to specify what we want to name this table and what fields it will include.

```ruby
class CreateFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :films do |t|
      t.text    :title
      t.integer :year
      t.integer :box_office_sales

      t.timestamps null: false
    end
  end
end
```

Run `rake db:migrate` to run your migrations against the database.

Inspect the schema.rb file:

```ruby
ActiveRecord::Schema.define(version: 20160217022804) do

  create_table "films", force: :cascade do |t|
    t.text     "title"
    t.integer  "year"
    t.integer  "box_office_sales"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
```

### Creating a Film Model

Now that we have a `films` table, we'll want to create a Film model to interact with that table.

```
$ touch app/models/film.rb
```

Inside of that file:

```ruby
class Film < ActiveRecord::Base
end
```

By inheriting from `ActiveRecord::Base`, we're given a bunch of class and instance methods we can use to manipulate the films in our database. These methods will take the place of the methods that you wrote yourself in Task Manager (e.g. `::all`, `::find`, `::new`, `::save`).

Now that we have a model, we can use `tux` (an interactive console for your app) to add some films to our database.

```ruby
$ tux
Film.create(title: "Avatar", year: 2009, box_office_sales: 760505847)
Film.create(title: "Titanic", year: 1997, box_office_sales: 658672302)
Film.create(title: "Jurassic World", year: 2015, box_office_sales: 652177271)
Film.create(title: "The Avengers", year: 2012, box_office_sales: 623279547)
Film.create(title: "The Dark Knight Rises", year: 2008, box_office_sales: 533316061)
Film.create(title: "Star Wars: Episode I - The Phantom Menace", year: 1999, box_office_sales: 474544677)
Film.create(title: "The Lion King", year: 1994, box_office_sales: 422783777)
```

### Updating the Controller

Now that we have some films, let's check our controller to see that we're doing the database prep that we need to do in order to see our films.

```ruby
class FilmFile < Sinatra::Base
  get '/films' do
    @films = Film.all
    erb :"films/index"
  end
end
```

### Creating the View

We are going to start to have LOTS of resources as our apps get bigger so let's start to organize our views. Let's create a `films` folder in `views` with an `index.erb` file.

Throw this html in that file:

```html
  <!-- views/films/index.erb -->
   <% @films.each do |film| %>
    <ul>
      <li><%= film.title %></li>
      <li><%= film.year %></li>
      <li><%= film.box_office_sales %></li>
    </ul>
   <% end %>  
```

Run `shotgun` from the command line. Visit `localhost:9393/films` and see your films.

### Inspecting the Setup

If you have additional time, review the files below.

* `Gemfile`: note that this is where we pull in ActiveRecord and Tux.
* `Rakefile` (find the included rake tasks [here](https://github.com/janko-m/sinatra-activerecord)): provides access to ActiveRecord's Rake commands.
* `config/environment.rb`: Pulls in our models/controllers, and sets some configuration values related to our database and our Sinatra app.
* `config/database.rb`: Tells our app which database to use, and sets some configuration values.
* `config/database.yml`: Tells our app where to look for our databases and how to access them.

## Check for Understanding

* What does a migration do?
* What's the syntax to create a migration from the command line using ActiveRecord?
* How do our models relate to our database?
* What do our models inherit from when we're using ActiveRecord?
* What are some methods that we have available to us when we inherit from ActiveRecord?

## Food for thought

* What happens if you try to create an object when you have a model but not a table?
* What happens if you try to create an object when you have a table but not a model?
