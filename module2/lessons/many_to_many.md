---
title: Many to Many Relationships
tags: database, schema, relationships
---

## Learning Goals

* Describe the relationship between a foreign key on one table and a primary key on another table
* Diagram a one-to-many relationship
* Diagram a many-to-many relationship
* Understand what a join table is and why we need one
* Create many-to-many relationships in Rails
* Interpret `schema.rb`

## Vocabulary

* Foreign Key
* Primary Key
* One-to-Many Relationship
* Many-to-Many Relationship
* Join Table
* Migration
* Schema

## Setup

You can begin this lesson on the `many_to_many_practice` branch of [this repo](https://github.com/turingschool-examples/set_list_tutorial).

## Warm-Up

In SetList:

1. What is the relationship between Songs and Artists?
1. Diagram the database tables for Songs and Artists.

# One-to-Many Relationships

* **Primary Key** - a key in a relational database that is unique for each record. This is also known as an `id`. It is a unique identifier, such as a driver's license, or the VIN on a car. You may have one and only one primary key value per table.
* **Foreign Key** - a foreign key is a field in one table that uniquely identifies a row of another table. A foreign key is defined in a second table, but it refers to the primary key in the first table.
* The relationship between `songs` and `artists` is a one-to-many relationship.
* `songs` has a column called `artist_id` which refers to the primary key of the `artist` table.
* `artist_id` is the foreign key

**Songs Table**

| id | title  | length  | play_count  | artist_id |
|---|---|---|---|---|
| 1 | This Must Be the Place | 345 | 23 | 1 |
| 2 | Aint No Bread in the Breadbox | 432 | 12 | 1 |
| 3 | Reuben and Cherise | 367 | 45 | 2 |
| 4 | Purple Rain | 183 | 49 | 3 |

**Artists Table**

| id | name  |
|---|---|
| 1 | Talking Heads |
| 2 | Jerry Garcia Band |
| 3 | Prince |

### Independent Practice - Students and Modules

Think about the relationship between students and modules (i.e. "Mod 1: Object Oriented Programming", "Mod 2: Web Applications with Ruby").

Diagram what the database would look like.

# Many-to-Many Relationships

Now, we're going to add playlists to our app.

Let's think about the relationship between songs and playlists.

```
A playlist can have many songs. A song can be in many playlists.
```

If we have Songs and Playlists tables that look like this:

**Songs Table**

| id | title  | length  | play_count  | artist_id |
|---|---|---|---|---|
| 1 | This Must Be the Place | 345 | 23 | 1 |
| 2 | Aint No Bread in the Breadbox | 432 | 12 | 1 |
| 3 | Reuben and Cherise | 367 | 45 | 2 |
| 4 | Purple Rain | 183 | 49 | 3 |

**Playlists Table**

| id | name  |
|---|---|
| 1 | Classic Rock |
| 2 | Uplifting Sound |
| 3 | Jerry Jams |

We can imagine that the "Classic Rock" playlist could include all of our current songs (a playlist has many songs). We can also imagine that the song "Reuben and Cherise" could be in both the "Classic Rock" and "Jerry Jams" playlists (a song has many playlists).

So far, we have used **foreign keys** to create relationships. The problem is that a **foreign key** can identify a *single* record from another table, but in a many-to-many both sides of the relationship need to reference *multiple* records. This means that we're going to need more than just foreign keys.

One solution that might come to mind is, instead of our foreign keys storing a single id, we could store an array of ids. This is a good guess, but in a database there is no concept of an array. The reason is that, for the database to be efficient, it needs to know the exact size of the datatype it is storing. For example, our DB knows exactly how much space an integer takes up (8 bytes).

But what about strings? They can vary in length. The Database handles strings by giving them a maximum length, which is 255 bytes by default. If we tried to do the same thing with arrays, we would be limiting how many relationships we could create, which is a bigger problem than limiting how long a string can be.

 The key takeaway here is **a database can't store an array of ids**, so we're going to need something else.

## Join Tables

Since we can't achieve the many-to-many relationship with our given tables, we are going to add a third table to manage this relationship. This is called a **join table**.

**Songs Table**

| id | title  | length  | play_count  | artist_id |
|---|---|---|---|---|
| 1 | This Must Be the Place | 345 | 23 | 1 |
| 2 | Aint No Bread in the Breadbox | 432 | 12 | 1 |
| 3 | Reuben and Cherise | 367 | 45 | 2 |
| 4 | Purple Rain | 183 | 49 | 3 |

**PlaylistSongs Table**

| id | playlist_id | song_id |
| -- | ----------- | ------- |
| 1  |     1       |    1    |
| 2  |     1       |    2    |
| 3  |     1       |    3    |
| 4  |     2       |    4    |
| 5  |     3       |    2    |
| 6  |     3       |    4    |

**Playlists Table**

| id | name  |
|---|---|
| 1 | Classic Rock |
| 2 | Uplifting Sound |
| 3 | Jerry Jams |



**Note:** Join tables are just ordinary tables with a unique purpose. Each row of our **join table** relates a row of one table to a row of another table.

**Turn and Talk**: Which songs are associated with which playlists?

The join table's name doesn't really matter. We could call it `song_playlists` or `playlist_songs`, it's really up to you as the developer. You could even choose to name it `happy_fun_times` but that would be confusing.

When you're thinking about what to call this table, think about how you're likely to use it most within your application. Since our app's goal will be to show a playlist of songs more often, we're going to call it `playlist_songs`.

**Note**: Don't confuse **join table** with a sql joins operation. They are two different things.

### Independent Practice

Diagram the DB tables you would need to create a many-to-many relationship between two tables that you think up on your own. Include some example data in your tables. If you can't come up with an example on your own, use Photographs and Albums.

# Many-to-Many Relationships in Rails

## Adding Playlists

We're now going to add playlists to our SetList app. We are going to work bottom-up in this case by starting with a model test:

```ruby
# spec/models/playlist_spec.rb

require "rails_helper"

RSpec.describe Playlist, type: :model do
  describe "relationships" do
    it { should have_many :playlist_songs}
  end
end
```

The first thing we need to set up is the connection between our model and our table. Running this gives us:

```bash
NameError:
  uninitialized constant Playlist
```

Let's go create our Playlist model:

```ruby
# app/models/playlist.rb

class Playlist < ApplicationRecord
end
```

When we run our tests again, we get:

```bash
ActiveRecord::StatementInvalid:
       PG::UndefinedTable: ERROR:  relation "playlists" does not exist
```

Let's write a migration to create Playlists.

```bash
rails g migration CreatePlaylists name:string
```

Open up that migration and add timestamps to it. Run it with `rake db:migrate`.

Running rspec again will give us this failure:

```
Failure/Error: it { should have_many :playlist_songs}
       Expected Playlist to have a has_many association called playlist_songs (no association called playlist_songs)
```

Let's go into our model and add that association:

```ruby
class Playlist < ApplicationRecord
  has_many :playlist_songs
end
```

Run rspec again and we get:

```
Failure/Error: it { should have_many :playlist_songs}
  Expected Playlist to have a has_many association called playlist_songs (PlaylistSong does not exist)
```

It says our join table doesn't exist. Let's go create it.

## Creating the PlaylistSongs Join Table

Let's start with a test. First we'll think about what a record in the join table should do. Looking back at our diagram of this table, it should relate a single song with a single playlist:

```ruby
# spec/models/playlist_song_spec.rb
require 'rails_helper'

RSpec.describe PlaylistSong, type: :model do
  describe "relationships" do
    it {should belong_to :playlist}
    it {should belong_to :song}
  end
end
```

Run this test, and we get:

```
NameError:
  uninitialized constant PlaylistSong
```

Go create the model:

```ruby
# app/models/playlist_song.rb
class PlaylistSong < ApplicationRecord
end
```

Run the test again and we get:

```
ActiveRecord::StatementInvalid:
       PG::UndefinedTable: ERROR:  relation "playlist_songs" does not exist
```

Now we'll generate the migration to create our join table:

```
rails g migration CreatePlaylistSongs song:references playlist:references
```

**Add timestamps to your table, and then migrate your database:**

```
rake db:migrate
```

Run the tests again, and both fail:

```
Expected PlaylistSong to have a belongs_to association called playlist (no association called playlist)

Expected PlaylistSong to have a belongs_to association called song (no association called song)
```

Let's go create those associations:

```ruby
class PlaylistSong < ApplicationRecord
  belongs_to :playlist
  belongs_to :song
end
```

Run the test and it passes! Our joins table is now ready to go.

## A Playlist has many Songs

Run the `playlist_spec` again and it passes! Now that our join table is set up, the connection between the `playlist` and `playlist_songs` is working. Now we can set up the has_many relationship between songs and playlists. Let's add this test to our `playlist_spec.rb`:

```ruby
it {should have_many(:songs).through(:playlist_songs)}
```

We are using the ShouldaMatchers `through` method to test that we can access a Playlist's songs through the join table.

Running this test gives us:

```
Failure/Error: it {should have_many(:songs).through(:playlist_songs)}
      Expected Playlist to have a has_many association called songs (no association called songs)
```

Let's try to add a has_many to our Playlist model:

```ruby
class Playlist < ApplicationRecord
  has_many :playlist_songs
  has_many :songs
end
```

Running this gives us:

```
Failure/Error: it { should have_many(:songs).through(:playlist_songs) }
       Expected Playlist to have a has_many association called songs (Song does not have a playlist_id foreign key.)
```

The error is telling us that our songs table doesn't have a foreign key for playlists. We *could* be very literal and add a foreign key to songs, but this won't work per our previous discussion of many to many relationships. Instead, we want to access the songs **through** the join table:

```ruby
class Playlist < ApplicationRecord
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
end
```

Run this test and it passes!

It is very important that for a model with a many to many relationship, that you set up both the `has_many, through:` relationship and the `has_many` with the join table. If we take out the connection to the join table like so:

```ruby
class Playlist < ApplicationRecord
  has_many :songs, through: :playlist_songs
end
```

and run our test, we will get:

```
NoMethodError:
      undefined method `klass' for nil:NilClass
```

Unfortunately, if you do this tdd will let you down a bit since this error is entirely unhelpful.While it may be unintuitive, if you see the `undefined method 'klass' for nil:NilClass`, remember to check that your model associations are set up properly:

```ruby
class Playlist < ApplicationRecord
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
end
```

Run the test again to make sure our Playlist is still working properly.

We've now set up one end of the many-to-many, but what about the other?

## A Song has many Playlists

Let's add tests for our many to many in `song_spec.rb`:

```ruby
it {should have_many :playlist_songs}
it {should have_many(:playlists).through(:playlist_songs)}
```

This is very similar to what we have for our Playlist model tests. When we run these tests, we'll see two failures:

```
Failure/Error: it {should have_many :playlist_songs}
      Expected Song to have a has_many association called playlist_songs (no association called playlist_songs)

Failure/Error: it {should have_many(:playlists).through(:playlist_songs)}
      Expected Song to have a has_many association called playlists (no association called playlists)
```

So now we can go into our Song model and add those relationships:

```ruby
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
```

Run the test again and it passes.

## Check Schema

Open up `schema.rb`. Compare what is in this file with our original diagram of the many-to-many relationship.

## Playlist Index Page

Now that we have playlists, let's add an index page to view all our playlists:

```ruby
# spec/features/playlists/index_spec.rb
require 'rails_helper'

RSpec.describe "the Playlist index page" do
  it "should display all playlists" do
    talking_heads = Artist.create!(name: "Talking Heads")
    jgb = Artist.create!(name: "Jerry Garcia Band")
    prince = Artist.create!(name: "Prince")

    place = talking_heads.songs.create!(title: "This Must Be The Place", length: 832, play_count: 83209)
    breadbox = jgb.songs.create!(title: "Aint No Bread in the Breadbox", length: 832, play_count: 83209)
    r_and_c = jgb.songs.create!(title: "Reuben and Cherise", length: 832, play_count: 83209)

    # Creates a playlist
    uplifting_sound = Playlist.create!(name: "Uplifting Sound")
    jams = Playlist.create!(name: "Jerry Jams")

    # Creates playlist and associates it with a song. Under the hood, creates a row in the playlist_songs table
    rock = breadbox.playlists.create!(name: "Classic Rock")

    # Creates song and associates it with a playlist. Under the hood, creates a row in the playlist_songs table
    purple = uplifting_sound.songs.create!(title: "Purple Rain", length: 4378, play_count: 7453689, artist: prince)

    # Creates a row in the playlist_songs table. Associates a playlist with a song
    PlaylistSong.create!(song: purple, playlist: jams)
    PlaylistSong.create!(song: place, playlist: jams)

    # Creates a row in the playlist_songs table. Associates a playlist with a song
    rock.songs << place

    # Creates a row in the playlist_songs table. Associates a playlist with a song
    r_and_c.playlists << rock

    visit '/playlists'

    within("#playlist-#{rock.id}") do
      expect(page).to have_content(rock.name)
      expect(page).to have_content(place.title)
      expect(page).to have_content(breadbox.title)
      expect(page).to have_content(r_and_c.title)
    end

    within("#playlist-#{uplifting_sound.id}") do
      expect(page).to have_content(uplifting_sound.name)
      expect(page).to have_content(purple.title)
    end

    within("#playlist-#{jams.id}") do
      expect(page).to have_content(jams.name)
      expect(page).to have_content(purple.title)
      expect(page).to have_content(place.title)
    end
  end
end

```

In the setup portion of the test, we are creating the relationships in a couple different ways. Normally, you would want to be more consistent with your syntax, but in this case we want to show a couple different ways to create relationships. Take a minute to review all these different strategies.

In the assertion portion of the test, we want to use the `within` as much as possible to identify specific songs and playlists.

Run this test and you should get an error for a missing route. In `routes.rb`, add:

```ruby
get '/playlists', to: "playlists#index"
```

Run the test again and you'll get an undefined constant for the controller, so we'll add the controller with the index action:

```ruby
# app/controllers/playlists_controller.rb
class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end
end
```

Running the tests now will give us a missing template error, so go create `app/views/playlists/index.html.erb` and add the view:

```erb
<% @playlists.each do |playlist| %>
  <section id="playlist-<%= playlist.id %>">
    <h1><%= playlist.name %></h1>
    <% playlist.songs.each do |song| %>
       <p><%= song.title %></p>
    <% end %>
  </section>
<% end %>
```

 We should now have a passing test. Check your work in development by adding some playlists to the seeds file, seeding the db with `rake db:seed`, and running your server.

## Checks for Understanding

* How is a one-to-many relationship set up in a database?
* What does a join table do? Why would we need one?
* How do we test many-to-many relationships?
* What migrations do we need to create to set up a many-to-many?
* What do we need to add to our models to set up a many-to-many?
* What is the relationship between Songs and Playlists?
