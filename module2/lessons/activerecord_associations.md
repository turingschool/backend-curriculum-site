---
title: ActiveRecord Associations in Sinatra
length: 60
tags: activerecord, migrations, sinatra, relational_database
---

## Learning Goals

* set up relationships between tables at the database level using foreign keys in migrations
* set up relationships between tables at the model level using `has_many` and `belongs_to`
* use rake commands to generate migration files, and migrate the database
* modify a migration in order to create or modify a table
* interpret `schema.rb`

## Vocabulary
* primary key
* foreign key
* one-to-one
* one-to-many
* many-to-many


## Repository

We'll use the Film File repository available [here](https://github.com/turingschool-examples/film-file).

## Warmup

Describe the relationship between the following entities. Consider the relationship from both sides.

* Person and Social Security number
* Owner and pet
* Student and module
* Film and genre
* Book and author

## Lecture

Thus far we've talked about tables in relational databases, but we haven't talked about how to create the relationships between those tables. These relationships actually  exist at two levels: 1) the database, 2) the ActiveRecord model.

### Types of Relationships

Before we begin talking about how to create relationships at the database level, let's talk about the types of relationships that could potentially exist:

* One-to-One: e.g. person/social security number
* One-to-Many: e.g. student/module
* Many-to-Many: e.g. Book/author

### One-to-Many/One-to-One

#### Database Level

How do we create these relationships at the database level? With a column holding foreign keys. A foreign key is a column in a database holding primary keys for other tables in the database.

For example, assume we have tables for students and courses (we're going to use `course` here instead of `module` because module has a specific meaning within Ruby).

Our courses table might hold the following attributes:

* id
* title
* description

Meanwhile, our students table might have the following attributes:

* id
* first_name
* last_name
* course_id

The `course_id` on student indicates that there is a one-to-many relationship between course and student. More specifically, it indicates that a module has many students and a student belongs to a module. How do we know this?

Sample courses table:

| id | title | description                             |
|----|-------|-----------------------------------------|
| 1  | BE M1 | OOP with Ruby                           |
| 2  | BE M2 | Web Applications with Ruby              |
| 3  | BE M3 | Professional Rails Applications         |
| 4  | BE M4 | Client-Side Development with JavaScript |

Sample students table:

| id | first_name | last_name | course_id |
|----|------------|-----------|-----------|
| 1  | Sal        | Espinosa  | 2         |
| 2  | Ilana      | Corson    | 2         |
| 3  | Josh       | Mejia     | 3         |
| 4  | Casey      | Cumbow    | 4         |
| 5  | Ali        | Schlereth | 1         |
| 6  | Victoria   | Vasys     | 1         |
| 7  | Mike       | Dao       | 1         |

We can use this same pattern to create a one-to-one relationship, though we would need to validate the uniquness of the foreign key (e.g. `course_id`) above.

#### Model Level

We need to provide ActiveRecord with some additional information to use these relationships at the model level.

In the example above, we would need to add the following line to our Course model:

```ruby
has_many :students
```

and the following line to our Student model:

```ruby
belongs_to :course
```

Notice that `:course` is singular, and `:students` is plural.

Adding these lines gives us access to additional methods on our models.

```ruby
Student.find(1).course
Course.find(3).students
m2 = Course.find(2)
m2.students

m4 = Course.find(4)
jeff = m4.students.create(first_name: "Jeff", last_name: "Casimir")

jorge = Student.create(first_name: "Jorge", last_name: "Tellez")
m4.students << jorge
```

## Code Along

Let's add a `genres` table to our `FilmFile` app and then create relationships between the existing movies and their genre.

### Creating the Genres Table

Create a new migration to create the genres table.

```
$ rake db:create_migration NAME=create_genres

```

Use `ActiveRecord`'s `create_table` method to specify what we want to name this table and what fields it will include.


```ruby
class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
```

Run `rake db:migrate` to run your migrations against the database.

Inspect the `schema.rb` file:

```ruby
ActiveRecord::Schema.define(version: 20160217022804) do

  create_table "films", force: :cascade do |t|
    t.text     "title"
    t.integer  "year"
    t.integer  "box_office_sales"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "genre_id"
  end

  create_table "genres", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
```

### Create the Genre Model

Add a `genre` model:

```
$ touch app/models/genre.rb
```

Inside of that file:

```ruby
class Genre < ActiveRecord::Base
end
```

We'll add some genres to our database using Tux, an interactive console for your app:

```ruby
$ tux
animation = Genre.create(name: "Animation")
scifi = Genre.create(name: "Sci Fi")
drama = Genre.create(name: "Drama")
romance = Genre.create(name: "Romance")
```

### Genres and Films - How do they relate?

Let's assume that a film belongs to a genre, and a genre has many films. How will we connect these two tables?

If a genre has many films, then we'll add a foreign key on the film.

We'll need to add a `genre_id` column to the `films` table. An individual `Film` will always have a reference to one `Genre` via the `genre_id` field.

Let's add the migration to add a `genre_id` to the `films` table.

```ruby
$ rake db:create_migration NAME=add_genre_id_to_films
```

Inside of that file:

```ruby
class AddGenreIdToFilms < ActiveRecord::Migration
  def change
    add_column :films, :genre_id, :integer
  end
end

```

Let's migrate: `rake db:migrate` and take a look at `schema.rb`:

```ruby
ActiveRecord::Schema.define(version: 20160217022905) do

  create_table "films", force: :cascade do |t|
    t.text     "title"
    t.integer  "year"
    t.integer  "box_office_sales"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "genre_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
```

### Associating the Genre and Film Models

Let's add an `ActiveRecord` association to our `Genre` to describe the relationship between a genre and a film. This will make it easy to find all of a specific Genre's films.

```ruby
class Genre < ActiveRecord::Base
  has_many :films
end
```

This will allow us to call the method `films` on an instance of `Genre`. Behind the scenes, it will go through the `films` table and find all films where the `genre_id` attribute is the same as the primary key `id` of the genre it's being called on.

Curious about how this is implemented? Check out [this blog post](http://callahanchris.github.io/blog/2014/10/08/behind-the-scenes-of-the-has-many-active-record-association/).

A film has the opposite relationship with a genre. `ActiveRecord` gives us another association method:

```ruby
class Film < ActiveRecord::Base
  belongs_to :genre
end
```

This will allow us to call `film.genre` and get back the genre object associated with that film. Behind the scenes, this is finding the genre that has the primary key `id` of the `genre_id` column on the `film`.

If you have a `has_many` relationship on a model, it is **not** necessary to have a `belongs_to` on another model.


Let's test it out:

```ruby
$ tux
animation = Genre.find_by(name: "Animation")
animation.films
# returns a collection of associated Film objects

```

Why is our result empty?

We've added a `genre_id` field to each `Film`, but we haven't given that field a value on any of our existing films.

There are a few different ways to associate your data. If both objects are already created, but we want to associate them, we could do the following:

```ruby
animation.films << Film.find_by(title: "The Lion King")
...and so on
```

Another way to do this would be:

```ruby
Film.find_by(title: "The Lion King").update(genre_id: 1)
```

The better way to associate data is to do it upon creation:

```ruby
animation = Genre.find_by(name: "Animation")
animation.films.create(title: "The Lion King", year: 1994, box_office_sales: 422783777)
```

This will create a new `Film` record and place whatever animation's `id` is in the `genre_id` field in the film.

### Updating our View

Let's update our `films/index.erb` view to show all the films in each genre:

```erb
<h1>All Films</h1>

<div id="films">
  <% @films.each do |film| %>
    <h3><%= film.title %> (<%= film.year %>)</h3>
    <p>Genre: <%= film.genre %></p>
    <p>Gross US Box Office Sales: $<%= film.box_office_sales %></p>
  <% end %>
</div>
```

Run `shotgun` from the command line, then navigate to `localhost:9393/films`. You should see the films listed along with their respective genre.
