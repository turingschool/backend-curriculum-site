---
title: Models, Databases, and Relationships

tags: models, databases, relationships, rails, migrations, activerecord
---

# Models, Databases, and Relationships

## Checks for Understanding

During and after the lesson you want to be able to answer the questions below. Start a Gist for yourself to write answers and notes along the way.

* What is a primary key?
* What is a foreign key?
* Why would one row of data have both primary and foreign keys?
* What is Rails' convention for the column name of the primary key?
* What is Rails' convention for the column name of a foreign key?
* What are dev, test, and prod databases all about?
* What is the database.yml and how is it used?

## Goals

* describe one-to-one, one-to-many, and many-to-many database relationships
* explain the difference between dev, test, and production environments in Rails
* create a Rails migration that creates a table or modifies a table
* set up relationships in a Rails migration with foreign key fields
* migrate the database and rollback migrations
* explain purpose of ORM (like ActiveRecord)
* use and explain common ActiveRecord class and instance methods
* set up relationships between models using ActiveRecord

## Lesson

### Starter Exercise

Imagine we're going to build a blogging site. It's well overdue!

What might the database schema look like? Let's emphasize figuring out the entities (aka tables), but also figure out some of the key data columns.

### Types of Relationships

Just storing data in a database isn't very interesting. Where the database shines is in the ability to connect or express relationships between elements of data.

* **One-to-one relationships**: a row of table A relates to one and only one row of table B

* **One-to-many relationships**: a row of table A relates to zero, one, or multiple rows of table B. However a row of table B relates to only one row of table A.

* **Many-to-many relationships**: a row of table A relates to zero, one, or multiple rows of table B. A row of table B relates to zero, one, or multiple rows of table A.

### Keys to Relationships

We use keys to "link" data across tables. Let's discuss:

* Primary key & "Auto-increment"
* Foreign keys
* Naming conventions

### Databases in Rails Apps

Let's make a new Rails app with the PG database already set up: `rails new appname --database=postgresql` (or `rails new appname -d postgresql`). The two places where you'll see the effects of this will be in the Gemfile (`gem 'pg'` instead of `gem 'sqlite3'`) and in `config/database.yml`.

Let's look at that file. Getting rid of the comments, it looks like this:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5

development:
  <<: *default
  database: appname_development

test:
  <<: *default
  database: appname_test

production:
  <<: *default
  database: appname_production
  username: appname
  password: <%= ENV['APPNAME_DATABASE_PASSWORD'] %>

```

### One-to-Many Relationships

#### At the Database Level: Articles and Authors

Let's discuss:

* What is a migration?
* What does `t.timestamps` in the migration file give us?

Let's do:

1. First, we'll create a migration and a model: `rails generate migration CreateAuthor first_name:text last_name:text`. The migration generator creates a migration and if we follow the working convention for rails the migration will be prepolulated.

Let's look at the migration inside of `db/migrate`:

```ruby
class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.text :first_name
      t.text :last_name

      t.timestamps
    end
  end
end
```
Now create a model file. `touch app/models/author.rb`
Inside `author.rb` add the code that hooks up out model to ActiveRecord.

```
class Author < ActiveRecord::Base
end
```

You can also use `rails generate model Author first_name:text last_name:text`

The model generator creates a model, a migration, and two files related to testing.

*Notes:*

* `rails g model ...` is shorthand for `rails generate model ...`
* You can also create a model without the attributes from the command line (`rails generate model Author`) but you'll then need to add the attributes into the migration file by hand.
* You can create the migration and the model separately like this: `rails g migration CreateAuthors first_name:text last_name:text` then `touch app/models/author.rb` and adding the two lines of code to define the author class.

* `rails generate model Something` will generate a model and a migration
* `rails generate model Something name:string age:integer` will generate model and migration with those attributes
* Change vs. Up/Down. [More info here](http://edgeguides.rubyonrails.org/active_record_migrations.html)
* Common methods: `add_column`, `create_table` (automatically will generate a primary key), `remove_column`, `drop_table` (these methods take arguments)
* common column types: boolean, string, text, integer, date, datetime
* setting up relationships in a migration using id columns
* column modifier examples: `:null => false` `:default => 0` (more [here](http://guides.rubyonrails.org/migrations.html))
* everything in the migration is executable code (but use a seed file to generate seed data)
* `rake db:migrate` migrates development
* schema.rb contains snapshot of current database structure
* you (generally) don't need to do rake db:test:prepare or RACK_ENV=test rake db:migrate with Rails testing; running `rake test` will load the schema to the test database
* `rake db:rollback` or `rake db:rollback STEP=2` to reverse migrations
* `rake db:drop` and `rake db:create` to wipe out database and recreate it
* click [here](http://guides.rubyonrails.org/migrations.html) for more on migrations

#### What is ActiveRecord?

* Object Relational Mapping (ORM) framework
* connects objects in an application to relational database
* represent models and their data
* represent associations between models
* validate models before they are saved in database

### Models

#### Demonstration with Article model

* inheriting from ActiveRecord::Base -- additional class methods and instance methods
* naming of database tables (snake_case) vs. models (CamelCase)
* example ActiveRecord class methods: `all`, `count`, `find`, `find_by`, `where`
* example ActiveRecord instance methods: `update`, `destroy`, `save`, `attribute?`, `new_record?`
* you don't need to use `initialize` method
* click [here](http://guides.rubyonrails.org/active_record_basics.html) for more on ActiveRecord basics

### Associations

#### Demonstration of One-to-Many Relationships at the Model Level: Article/Author

* ActiveRecord Associations:
* has_many - this is a method
* belongs_to - this is a method

### Many-to-Many

#### Many-to-Many at the Database Level: articles, tags, and article_tags tables

* need three tables
* join table holds foreign keys for each of the other two tables

#### Many-to-Many at the Model Level: Article/Tag/ArticleTag models

* join tables: `has_many :things` and `has_many :things, through: :other_things` - this is a method with an argument
* order matters
* click [here](http://guides.rubyonrails.org/association_basics.html) for more associations
