# ActiveRecord Associations

---

# Warmup

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

---

We'll add some genres to our database using Tux, an interactive console for your app:

```ruby
$ tux
animation = Genre.create(name: "Animation")
scifi = Genre.create(name: "Sci Fi")
drama = Genre.create(name: "Drama")
romance = Genre.create(name: "Romance")
```

---

# Genre/Films Relationship

* How are genres and films related?
* What change do we need to make to the DB to create this association?
* What changes do we need to make to our models to make this association?

---

# Database Change

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

```
$ rake db:migrate
```

---

# Model Changes

```ruby
class Genre < ActiveRecord::Base
  has_many :films
end
```

```ruby
class Film < ActiveRecord::Base
  belongs_to :genre
end
```

If you have a `has_many` relationship on a model, it is **not** necessary to have a `belongs_to` on another model and vice versa.

---

# In Tux

```ruby
$ tux
animation = Genre.find_by(name: "Animation")
animation.films
# returns a collection of associated Film objects
```

---

# Adding Relationships

```ruby
animation.films << Film.find_by(title: "The Lion King")
...and so on
```

```ruby
Film.find_by(title: "The Lion King").update(genre_id: 1)
```

```ruby
animation = Genre.find_by(name: "Animation")
animation.films.create(title: "The Lion King", year: 1994, box_office_sales: 422783777)
```

---

# Updating our View

```erb
# films/index.erb
<h1>All Films</h1>

<div id="films">
  <% @films.each do |film| %>
    <h3><%= film.title %> (<%= film.year %>)</h3>
    <p>Genre: <%= film.genre %></p>
    <p>Gross US Box Office Sales: $<%= film.box_office_sales %></p>
  <% end %>
</div>
```
