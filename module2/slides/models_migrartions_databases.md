# Models, Databases, and Relationships

---

# Warmup: Migration Review (15 minutes)

* In your own words, what is a migration?
* What are some things that we can do with a migration?
* What is the relationship between a migration, our database, and our schema?
* What does `rake db:rollback` do? When **wouldn't** I want to use it?

---

# One-to-Many Relationships

---

# Database Level: Directors

`rails generate migration CreateDirectors name:string`

or

`rails g migration CreateDirectors name`

Let's look at the migration inside of `db/migrate`:

---

# Model Level: Directors

`touch app/models/director.rb`

```ruby
class Director < ApplicationRecord
end
```

---

# What about Movies?

What's the relationship between movie and director?

---

# `g migration` with Foreign Key

```bash
rails g migration AddDirectorsToMovies director:references
```

Let's look at what this migration creates.

---

# Associations in the Models: One-to-Many


* `has_many`
* `belongs_to`

---

# Creating Directors/Movies in the Console

What are different ways to associate movies with directors?

---

# Many-to-Many: Movies and Actors?

* What is the relationship?
* How can we create this relationship?

---

# Database Level: Actors

```bash
rails g migration createActors name
rails g migration createActorMovies actor:references movie:references
rake db:migrate
```

---

# Model Level: Actors

Now create the models to go with these new tables.

---

# Creating Actors/Movies in the Console

Create a actor.

What are different ways to associate movies with actors?

---

# Notes

* common column types: `boolean`, `string`, `text`, `integer`, `date`, `datetime`
* `rake db:migrate` migrates development
* you (generally) don't need to run `rake db:test:prepare`; running `rake test` will load the schema to the test database

---

# Checks for Understanding

* What is a primary key?
* What is a foreign key?
* In what situation would one row of data have both primary and foreign keys?
* In what situation would two entities be related but *not* have foreign keys stored on either of the tables?
* What is Rails' convention for the column name of the primary key?
* What is Rails' convention for the column name of a foreign key?
* What are dev, test, and prod databases all about?
* What is the database.yml and how is it used?

---

# Practice

* Add `genres` to our project
* A movie can have many genres
* A genre can have many movies

