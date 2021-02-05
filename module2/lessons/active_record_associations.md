---
layout: page
title: ActiveRecord Associations
tags: migrations, databases, relationships, rails, activerecord
---

## Learning Goals

* Write migrations in Rails.
* Explain what a migration is, and how it relates to our schema.
* Create one-to-many relationships at the database level using foreign keys.
* Use `has_many` and `belongs_to` to create one-to-many relationship at the model level.
* Create instance methods on a Rails model

## Vocab

* Migration
* Schema
* Relationships

## Set Up

This lesson builds off of the [Handling Requests Lessons](./handling_requests). You can find the completed code from this lesson on the `handling_requests` branch of [this repo](https://github.com/turingschool-examples/set_list/tree/handling_requests)

## TDD Version

This tutorial does not make use of any testing. You can find a version of this tutorial using the TDD workflow [here](./active_record_associations_tdd)

## WarmUp

* In your own words, what is a migration?
* What are some things that we can do with a migration?
* What is the relationship between a migration and our database?

## Models, Migrations, and Databases in Rails

In this lesson, we'll be adding to our new SetList Rails app to demonstrate a one-to-many relationship.

We'll add a table `artists` to our database, and connect them to our existing `songs` table. What might the relationships look like?

### At the Database Level: Artists

We want to be able to create some artists with a name, so we'll add an "Artists" table to our database in order to store this data. Take a look at our `db/schema.rb`; at this point, it should look something like this:

```ruby
ActiveRecord::Schema.define(version: 20190430171832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.integer "length"
    t.integer "play_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
```

Currently, our schema does not have an Artists table, so we are going to have to update it. Whenever we need to alter the database schema, we are going to write a **migration**.

From the command line, run `rails g migration CreateArtists name:string`

The migration generator creates a migration and if we follow the working convention for rails the migration will be pre-populated.

Let's look at the migration inside of `db/migrate`. We will also add the line `t.timestamps` to add `created_at` and `updated_at` timestamps to our table.

```ruby
class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name

      t.timestamps
    end
  end
end
```

This migration looks good. Open up the `schema.rb` file again. Do you see the new "artists" table? Take a look at the version number next to `ActiveRecord::Schema.define(version: `. This version number _should_ match the version of our latest migration file, but it doesn't!  Both of these mean that we have migrations that have not been run yet.  Let's do that now:

`rails db:migrate`


Now, if we go back to our schema, we should see `create_table 'artists'`. Our migrations have been applied.

Now that we have a database table, we'll need to create a new model that can connect to this database table:

```ruby
# app/models/artist.rb

class Artist < ApplicationRecord

end
```

Now that we have our model and database table set up, we should be able to create some new Artists using the rails console. Open up a new console from the command line using `rails c` and run the following to create some artists:

```ruby
Artist.create(name: "Talking Heads")
Artist.create(name: "Prince")
Artist.create(name: "Britney Spears")
```

We should see some SQL output in our rails console confirming that each Artist is saved to the database. Double check that we can read all of those artists back from the database by running:

```ruby
Artist.all
```

and make sure that all of your new Artists are returned.

### At the Database Level: Songs

Since each Song should belong to an Artist, each song is going to need a **foreign key** that references its artist. If we open up our schema file, we don't see a column for that foreign key on our Songs table, so we are going to need another migration to alter our schema:

```bash
rails g migration AddArtistsToSongs artist:references
```

Take a look at what this migration creates.

```ruby
class AddArtistsToSongs < ActiveRecord::Migration[5.2]
  def change
    add_reference :songs, :artist, foreign_key: true
  end
end
```

Don't forget to run your migration with `rails db:migrate`. Check your schema file to make sure you Songs table now has an `artist_id` column.

## ActiveRecord Associations

### One-to-Many Relationships the Hard Way

Now that we have set up our database, we should be able to create some songs and relate them to artists in the rails console:

```ruby
prince = Artist.create!(name: 'Prince')
beret = Song.create!(title: 'Raspberry Beret', length: 345, play_count: 34, artist_id: prince.id)
rain = Song.create!(title: 'Purple Rain', length: 524, play_count: 19, artist_id: prince.id)
```

And what if we want to retrieve all of an Artist's Songs? The ActiveRecord would like something like this:

```ruby
prince = Artist.find_by(name: 'Prince')
prince_songs = Song.where(artist_id: prince.id)
```

Similarly, we could find the Artist for a Song:

```ruby
purple_rain = Song.find_by(title: 'Purple Rain')
purple_rain_artist = Artist.find(purple_rain.artist_id)
```

This will work, but working with associated records is something we are going to have to do very often, and writing the queries to retrieve and create records this way can get overly verbose. Luckily ActiveRecord gives us some nice helper methods to make this much easier.

### ActiveRecord Associations: The Path to Enlightenment

Rather than do things the hard way, we can create **ActiveRecord Associations**. In your Song model, add a line to associate it to the Artist Model:

```ruby
class Song < ApplicationRecord
  belongs_to :artist
end
```

Similarly, add a line in your Artist model to associate it with the Song model:

```ruby
class Artist < ApplicationRecord
  has_many :songs
end
```

Writing our migrations and altering our schema made this association at the database level. Now we have added **ActiveRecord Associations** to relate them at the Model level.

The association `has_many :songs` in our Artist model gives us the ability to call `.songs` on an Artist object. We can use this to more easily associate a Song to an Artist when creating a Song:

```ruby
prince = Artist.create!(name: 'Prince')
beret = prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
rain = prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)
```

We can also use this new `.songs` method to retrieve all the Songs related to an Artist:

```ruby
prince_songs = prince.songs
```

Take a look at the SQL that is generated in the Rails Console when you run this command. You'll notice that it is very similar to the query we wrote in the last section to retrieve an Artist's Songs. So under the hood, the same SQL is still being executed, but the code we wrote to make it happen is now much more elegant and concise.

Similarly, the association `belongs_to :artist` in our Song model gives us the ability to call `.artist` on a Song object:

```ruby
beret_artist = beret.artist
```

Finally, ActiveRecord associations will put some constraints or **validations** on our Models. Let's try to create a Song without an Artist:

```ruby
Song.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
```

The bang `!` on the end of the `create` method tells ActiveRecord to throw an error if anything goes wrong which is useful when developing or debugging. This command should produce an error that the Artist must exist. Now that a `song` **belongs_to** an `artist`, a `song` can not exist without an `artist`. So when we create a Song, we also have to tell it which Artist it belongs to.

## Seeds

Now that our App is getting more complex, it would be good to add some seeds. Seeding your database is when you insert a set of data into the database. It is useful to have some seed data when we are experimenting and developing. You could consider what we've done in the Rails Console so far as a type of seeding, but doing things manually in the Rails Console can get very tedious, so what we will do instead is write a script to seed our database that we can reuse. Rails comes with a file for us to write this script in `db/seeds.rb`. Open up that file and add the following:

```ruby
Song.destroy_all
Artist.destroy_all

prince = Artist.create!(name: 'Prince')
rtj = Artist.create!(name: 'Run The Jewels')
caamp = Artist.create!(name: 'Caamp')
jgb = Artist.create!(name: 'Jerry Garcia Band')
billie = Artist.create!(name: 'Billie Eilish')
lcd = Artist.create!(name: 'LCD Soundsystem')

prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)

rtj.songs.create!(title: 'Legend Has It', length: 2301, play_count: 2300000)
rtj.songs.create!(title: 'Talk to Me', length: 2301, play_count: 2300000)

caamp.songs.create!(title: '26', length: 940, play_count: 150000)
caamp.songs.create!(title: 'Vagabond', length: 240, play_count: 120000)

jgb.songs.create!(title: 'Aint No Bread In The Breadbox', length: 540, play_count: 12000)
jgb.songs.create!(title: 'The Harder They Come', length: 240, play_count: 120000)

billie.songs.create!(title: 'bury a friend', length: 340, play_count: 1200000)
billie.songs.create!(title: 'bad guy', length: 240, play_count: 100000)

lcd.songs.create!(title: 'Someone Great', length: 500, play_count: 1000000)
lcd.songs.create!(title: 'I Can Change', length: 640, play_count: 100000)
```

Now that we have our seeds file, we can run it with `rails db:seed`. Additionally, if we check this file into our version control system, other developers working on this app will be able to easily seed their local databases.

Notice that the first two lines of this seeds file will destroy all Songs and Artists from the database. The reason we want to do this is so that we know we are starting with an empty database every time we want to reseed our database. If we did not have these two lines, this script would create duplicate records every time we reran `rails db:seed`.

## Adding Behaviors to Models

Now, we have two models that are related to each other with **has_many** and **belongs_to**, and these models can handle basic CRUD functionality through the methods that they inherit from ActiveRecord - but what if we need our models to be customized to perform behaviors related to our application? For example, what if we want to find the average length of an artist's songs?

In our Artist model, we can create an instance method to perform this logic:

```ruby
class Artist < ApplicationRecord
  has_many :songs

  def average_song_length
    songs.average(:length)
  end
end
```

Because we have `has_many :songs` in this class, we can call `.songs` on an Artist instance, and because we have defined an instance method, we can call `songs` inside of it to get all the Songs associated to the Artist object. We can then chain on the ActiveRecord method `.average` to average the length column of all of those associated records.

Let's open the rails console up again and try out our new method:

```ruby
prince = Artist.find_by(name: 'Prince')
prince.average_song_length
```

## Checks for Understanding

* What are two different types of table relationships that you might need to implement? In what scenario would you use each?
* What is the syntax for the following migrations in Rails?
  * Create a table
  * Add a column to a table, with or without a data type
  * Add a reference from one table to another
* What does a `has_many` association in a model do?
* What does a `belongs_to` association in a model do?
