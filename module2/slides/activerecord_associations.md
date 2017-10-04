# ActiveRecord Associations

---

## Warmup

Describe the relationship between the following entities. Consider the relationship from both sides.

* Person and Social Security number
* Owner and pet
* Student and module
* Film and genre
* Book and author

---

# Types of Relationships

* One-to-One: e.g. person/social security number
* One-to-Many: e.g. student/module
* Many-to-Many: e.g. Book/author

---

# Database Level

* Tables
* Primary Keys
* Foreign Keys

---

# Example: Courses Table

| id | title | description                             |
|----|-------|-----------------------------------------|
| 1  | BE M1 | OOP with Ruby                           |
| 2  | BE M2 | Web Applications with Ruby              |
| 3  | BE M3 | Professional Rails Applications         |
| 4  | BE M4 | Client-Side Development with JavaScript |

---

# Example: Students Table

| id | first_name | last_name | module_id |
|----|------------|-----------|-----------|
| 1  | Sal        | Espinosa  | 2         |
| 2  | Ilana      | Corson    | 2         |
| 3  | Josh       | Mejia     | 3         |
| 4  | Casey      | Cumbow    | 4         |
| 5  | Ali        | Schlereth | 1         |
| 6  | Victoria   | Vasys     | 1         |
| 7  | Mike       | Dao       | 1         |

---

# Model Level

* `has_many`
* `belongs_to`

---

# Example: Course Model

```ruby
class Course < ActiveRecord::Base
  has_many :students
end
```

* Note: `:students` is plural.

---

# Example: Student Model

```ruby
class Student < ActiveRecord::Base
  belongs_to :course
end
```

* Note: `:course` is singular.

---

# New Methods on Student

```ruby
Student.find(1).course # returns course

sal = Student.find_by(first_name: "Sal")
sal.course # returns M2
```

---

# New Methods on Course

```ruby
m2 = Course.find(2)
m2.students #returns a collection of students

Course.find(3).students
m4 = Course.find(4)
jeff = m4.students.create(first_name: "Jeff", last_name: "Casimir")
# creates a new student in M4

jorge = Student.create(first_name: "Jorge", last_name: "Tellez")
m4.students << jorge
# adds Jorge to M4
```

---

# Code Along

---

# Create Genres Table

```
$ rake db:create_migration NAME=create_genres
```

---

# Update Genres Migration

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

---

# Migrate & Check Schema

---

# Create the Genre Model

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

Let's update our `films_index.erb` view to show all the films in each genre:

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

Run `shotgun` from the command line, then navigate to `localhost:9393/genres`. You should see the films listed along with their respective genre.
