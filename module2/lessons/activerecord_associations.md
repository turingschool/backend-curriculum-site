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

## Warmup

Describe the relationship between the following entities. Consider the relationship from both sides.

* Person and Social Security number
* Owner and pet
* Student and module
* Film and genre
* Book and author

## Lecture (~30 min)

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
| 2  | BE M2 | Intro to Rails                          |
| 3  | BE M3 | APIs in Rails                           |
| 4  | BE M4 | JavaScript                              |

Sample students table:

| id | first_name | last_name | course_id |
|----|------------|-----------|-----------|
| 1  | Sal        | Espinosa  | 4         |
| 2  | Ian        | Douglas   | 2         |
| 3  | Josh       | Mejia     | 3         |
| 4  | Megan      | McMahon   | 1         |
| 5  | Dione      | Wilson    | 2         |
| 6  | Brian      | Zanti     | 1         |
| 7  | Mike       | Dao       | 3         |

We can use this same pattern to create a one-to-one relationship, though we would need to validate the uniqueness of the foreign key (e.g. `course_id`) above.

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
amy = m4.students.create(first_name: "Amy", last_name: "Holt")

cory = Student.create(first_name: "Cory", last_name: "Westerfield")
m4.students << cory
```

## Practice (~30 min)

We'll use the [Set List repo](https://github.com/turingschool-examples/set-list).

Let's add an `playlist` table to our app and then create relationships between the existing songs and their playlist.

### Creating the Playlist Table

Create a new migration to create the new table.

```bash
$ rake db:create_migration NAME=create_playlists
```

Use `ActiveRecord`'s `create_table` method to specify what we want to name this table and the fields it will include. For now, a playlist only needs a name.

```ruby
class CreatePlaylists < ActiveRecord::Migration[5.1]
  def change
    create_table :playlists do |t|
      t.string :name

      t.timestamps
    end
  end
end
```

Run `rake db:migrate` to run your migrations against the database.

Inspect the `schema.rb` file:

```ruby
ActiveRecord::Schema.define(version: 20160217022804) do

  create_table "songs", force: :cascade do |t|
    t.text     "title"
    t.integer  "length"
    t.integer  "play_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlists", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
```

### Create the Playlist Model

Add a `playlist` model:

```
$ touch app/models/playlist.rb
```

Inside of that file:

```ruby
class Playlist < ActiveRecord::Base
end
```

We'll add some playlists to our database using Tux, an interactive console for your app:

```ruby
$ tux
funky_beats = Playlist.create(name: "Funky Beats 2018")
dance_party = Playlist.create(name: "1980's Dance Party")
power_ballads = Playlist.create(name: "Power Ballads")
classic_rock = Playlist.create(name: "Classic Rock")
```

### Playlists and Songs - How do they relate?

Let's assume that a song can only belongs to a single playlist, and a playlist has many songs. How will we connect these two tables?

If a playlist has many songs, then we'll add a foreign key **on the song** model. This allows a song to **belong** to a playlist.

#### Relating the data at the database level first

Before ActiveRecord can understand the relationship between two tables, we have to do some work in the database first.

We'll need to add a `playlist_id` column to the `songs` table. An individual `Song` will always have a reference to one `Playlist` by using the `playlist_id` field.

Let's add the migration to add a `playlist_id` to the `songs` table.

```bash
$ rake db:create_migration NAME=add_playlist_id_to_songs
```

Inside of that file:

```ruby
class AddPlaylistIdToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :playlist_id, :integer
  end
end

```

Let's migrate: `rake db:migrate` and take a look at `schema.rb`:

```ruby
ActiveRecord::Schema.define(version: 20160217022905) do

  create_table "songs", force: :cascade do |t|
    t.text     "title"
    t.integer  "length"
    t.integer  "play_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
```

### Associating the Playlist and Song Models in our Application

At a database level, we have what we need for now, but our application still isn't aware that these models are somehow working together.

Let's add an `ActiveRecord` association to our `Playlist` to describe the relationship between a playlist and a song. This will make it easy to find all of a specific Playlist's songs.

```ruby
class Playlist < ActiveRecord::Base
  has_many :songs
end
```

Now, when we have an **instance** of a single `Playlist`, we have access to a method called `songs` on that instance.

```ruby
my_playlist = Playlist.create(name: 'Funky Beats 2018')
# let's imagine some songs were added to that playlist
puts my_playlist.songs
# this would give us the list of all songs associated with that playlist.
```

Behind the scenes, ActiveRecord and the database will go through the `songs` table and find all songs where the `playlist_id` attribute is the same as the primary key `id` of the playlist it's being called on.

Curious about how this is implemented? Check out [this blog post](http://callahanchris.github.io/blog/2014/10/08/behind-the-scenes-of-the-has-many-active-record-association/).

A song has the opposite relationship with a playlist. Because a song can only have a single `playlist_id` value, it "belongs" to that playlist, and only that playlist. `ActiveRecord` gives us another association method:

```ruby
class Song < ActiveRecord::Base
  belongs_to :playlist
end
```

This will allow us to get an instance of a single song, and call `song.playlist` to get back the `Playlist` object associated with that song. Behind the scenes, this is searching the database for the playlist that has the primary key `id` of the `playlist_id` column on the `song` instance.

If you have a `has_many` relationship on a model, it is **not** necessary to have a `belongs_to` on another model.


Let's test it out:

```ruby
$ tux
classic_rock_playlist = Playlist.find_by(name: "Classic Rock")
classic_rock_playlist.songs
# returns a collection of associated Song objects

```

**Why is our result empty?**

We've added a `playlist_id` field to each `Song`, but we haven't given that field a value on any of our existing songs.

There are a few different ways to associate your data. If both objects are already created, but we want to associate them, we could do the following:

```ruby
# let's imagine we've already added this song:
# Song.create(title: "Don't Stop Believin'", length: 251, play_count: 760847)
classic_rock_playlist.songs << Song.find_by(title: "Don't Stop Believin'")
...and so on
```

The `<<` shovel operator will automatically build the association for us, through ActiveRecord, to populate the song's `playlist_id`. This isn't super clear, though, so here's another method:

```ruby
Song.find_by(title: "Don't Stop Belivin'").update(playlist_id: classic_rock_playlist.id)
```

The better way, and our preferred way, is to associate data upon creation:

```ruby
classic_rock_playlist = Playlist.find_by(name: "Classic Rock")
classic_rock_playlist.songs.create(title: "Don't Stop Believin'", length: 251, play_count: 760847)
```

This will create a new `Song` record AND place our playlist's `id` is in the `playlist_id` field in the song's database record.


### Updating our View

Let's update our `songs/index.erb` view to show all the songs in each playlist:

```erb
<h1>All Songs</h1>

<div id="songs">
  <% @songs.each do |song| %>
    <h3><%= song.title %></h3>
    <p>Song length: <%= song.length %></p>
    <p>Playlist: <%= song.playlist.name %></p>
    <p>Play Count: $<%= song.play_count %></p>
  <% end %>
</div>
```

Run `shotgun` from the command line, then navigate to `localhost:9393/songs`. You should see the songs listed along with their respective playlist.

### Extension

What would this look like for a many-to-many relationship? How do you structure the tables in the database? What do the migrations look like to get this done? How are your models impacted? How will this impact data prep in tests or controller methods?

## WrapUp (~30 min)

* How do you associate two resources on the database level?
* How do you associate two resources on the model level?
* How do you associate two resources when doing data prep in a test or controller?
* Compare and contrast a primary key and foreign key. Where do each live?
* Write out the steps you took to create the relationship and display the information for playlists and songs.
