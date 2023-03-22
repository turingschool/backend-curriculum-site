---
layout: page
title: ActiveRecord Associations with TDD
tags: migrations, databases, relationships, rails, activerecord
---

## Learning Goals

* Write migrations in Rails.
* Define Schema.
* Explain what a migration is, and how it relates to our schema.
* Create one-to-many relationships at the database level using foreign keys.
* Use `has_many` and `belongs_to` to create one-to-many relationship at the model level.

## Vocab
* Migration
* Schema
* Relationships

## WarmUp

* In your own words, what is a migration?
* What are some things that we can do with a migration?
* What is the relationship between a migration and our database?

## Set Up

This lesson plan starts at the `songs_show` branch of [this SetList Tutorial repo](https://github.com/turingschool-examples/set_list_tutorial/tree/songs_show). In order to set up the app for this lesson:

* Clone the repo (don't fork!)
* Checkout the `songs_show` branch
* Run `bundle install`
* Run `rails db:{drop,create,migrate,seed}`

## Models, Migrations, and Databases in Rails

In this lesson, we'll be adding to our new SetList Rails app to demonstrate a one-to-many relationship.

We'll add a table `artists` to our database, and connect them to our existing `songs` table. What might the relationships look like?

## One-to-Many Relationships

### At the Database Level: Artist

We want to create some artists with a name. Let's add a test for that! Since this will be a model test, we need to first make a `/models` directory nested under `/spec` then create a `artist_spec.rb`

`mkdir spec/models`  
`touch spec/models/artist_spec.rb`


We're going to use the handy dandy gem [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) to give us some streamlined syntax to use in testing our validations and relationships.

- Add `gem 'shoulda-matchers', '~> 3.1'` to `group :development, :test` in your `Gemfile`  
- run `bundle install`
- Put the following at the bottom of `rails_helper.rb`:

```ruby
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
```

In `artist_spec.rb`

```ruby
require 'rails_helper'

describe Artist, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end
end

```

Run `bundle exec rspec` and we should get an error similar to this:

```
Failure/Error:
  RSpec.describe Artist, type: :model do
    describe 'validations' do
      it {should validate_presence_of :name}
    end
  end

NameError:
  uninitialized constant Artist
# ./spec/models/artist_spec.rb:3:in `<top (required)>'
```

There are a few things that have to happen to get this test passing.

First, let's clear this error by creating our `Artist` model:

```
touch app/models/artist.rb
```

```ruby
# app/models/artist.rb

class Artist < ApplicationRecord

end
```

Now, let's run our test again.  We should see an error like this:

```
# ./spec/models/artist_spec.rb:5:in `block (3 levels) in <top (required)>'
    # ------------------
    # --- Caused by: ---
    # PG::UndefinedTable:
    #   ERROR:  relation "artists" does not exist
    #   LINE 8:                WHERE a.attrelid = '"artists"'::regclass
    #                                             ^
    #   ./spec/models/artist_spec.rb:5:in `block (3 levels) in <top (required)>'
```

This error is telling us that we don't have an `artists` table set up in our database, so let's create that with a migration:

`rails g migration CreateArtists name:string`

The migration generator creates a migration and if we follow the working convention for rails the migration will be pre-populated. Additionally, we can add `t.timestamps` into the `create_table` block inside the migration to create timestamps.

Let's look at the migration inside of `db/migrate`. It should look like this:

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

Will this fix our tests? Discuss with the person next to you why or why not.

Take a look at our `db/schema.rb`; at this point, it should look something like this:

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

There are two things to focus on here. First, we only see a `create_table 'songs'` command, which means that our database only has a `songs` table. Second, take a look at the `version: 20190430171832` - this version number _should_ match the version of our latest migration file, but it doesn't!  That means that we have migrations that have not been run yet.  Let's do that now:

`rails db:migrate`

Now, if we go back to our schema, we should see a command to `create_table 'artists'`, and when we run our tests again, we should be getting a new error!

Let's run rspec again.  

```
Failures:

  1) Artist should validate that :name cannot be empty/falsy
     Failure/Error: it {should validate_presence_of(:name)}

       Artist did not properly validate that :name cannot be empty/falsy.
         After setting :name to ‹nil›, the matcher expected the Artist to be
         invalid, but it was valid instead.
     # ./spec/models/artist_spec.rb:4:in `block (2 levels) in <top (required)>'
```

The important part to read here is `Artist did not properly validate that :name cannot be empty/false.`

Let's add a validation to Artist!

```ruby
class Artist < ApplicationRecord
 validates_presence_of :name
end
```

Run rspec again and we get passing tests!


### What about Songs?

What's the relationship between Song and Artist? Draw this out in a diagram to help visualize the relationship.

Let's create a test to help us drive this out.  Add the following to your `artist_spec.rb` within the greater describe Artist block, but outside of the validations block.

```ruby
require 'rails_helper'

describe Artist, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :songs }
  end
end

```

When we run this test, we get an error similar to this:

```
Failures:

  1) Artist relationships should have many songs
     Failure/Error: it {should have_many(:songs)}
       Expected Artist to have a has_many association called songs (no association called songs)
     # ./spec/models/artist_spec.rb:9:in `block (3 levels) in <top (required)>'
```

The important part to read here `Expected Artist to have a has_many association called songs (no association called songs)` Tells us we are missing a relationship. Let's go make one!


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

Run `rails db:migrate` to run this migration. Now open `schema.rb` and make sure that your `songs` table now has the `artist_id` foreign key.

Run the tests again and you'll see that we're still getting `Expected Artist to have a has_many association called songs (no association called songs)`. We've added the foreign key at the database level, but our we still haven't set up our model to make use of that foreign key.

## Associations

### One-to-Many Relationships at the Model Level: Song/Artist

We have set up our database level relationships, now let's implement some model-level associations using some handy ActiveRecord methods.

* `has_many`
* `belongs_to`

```ruby
class Song < ApplicationRecord
  belongs_to :artist

end
```

```ruby
class Artist < ApplicationRecord
  has_many :songs

  validates_presence_of :name
end
```

Run the tests again and now they should be passing!

Why do we need a foreign key at the database level and the `belongs_to` method in the model? What do each of these things allow for?

Let's play around in our development database by dropping in to the rails console `rails console` or `rails c`

*In the console*:

- Create a artist `Artist.create!(name: 'Prince')`
- Create a song `Song.create!(title: 'Raspberry Beret', length: 345, play_count: 34)`

Did you get an error?

- Why are we getting this error?
- What do we need to do to fix this error?

Now that a `song` **belongs to** an `artist`, a `song` can not exist without an `artist`

- What are different ways to associate songs with artists?

  ```ruby
  artist = Artist.create(name: 'Prince')
  song = Song.create(title: 'Raspberry Beret', length: 345, play_count: 34, artist: artist)

  # OR

  artist = Artist.create(name: 'Prince')
  song = Song.create(title: 'Raspberry Beret', length: 345, play_count: 34, artist_id: artist.id)
  # OR

  artist = Artist.create(name: 'Prince')
  song = artist.songs.create(title: 'Raspberry Beret', length: 345, play_count: 34)
  ```

Since we've added code into our Song model, it would also be a good idea to create a `song_spec.rb` (if you don't already have one) and add a test for the relationship from Songs to Artists:

```ruby
require 'rails_helper'

RSpec.describe Song do

  describe 'relationships' do
    it {should belong_to :artist}
  end
end

```

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

Now, we have two models that are related to each other with **has_many** and **belongs_to**, and these models can handle basic CRUD functionality through the methods that they inherit from ActiveRecord - but what if we need our models to be customized to perform behaviors related to our application? For example, what if we want our `Song` model to be able to tell us how many songs exist in our database, and we want an `artist` to be able to tell us the average length of all their songs.

First - Test!

```ruby
# spec/models/song_spec.rb

require 'rails_helper'

RSpec.describe Song do
  describe 'relationships' do
    it {should belong_to :artist}
  end

  describe 'class methods' do
    it '.song_count' do
      prince = Artist.create!(name: 'Prince')
      talking_heads = Artist.create!(name: 'Talking Heads')
      rasperry_beret = prince.songs.create!(title: 'Raspberry Beret', length: 234, play_count: 34)
      wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45)

      expect(Song.song_count).to eq(2)
    end
  end
end
```

Use TDD to create a class method on our `Song` model that returns a count of the songs in our database. As you build out this method, remember to use `pry` and `self` to help debug and guide your implementations!

And, for our next method - a test!

```ruby
require 'rails_helper'

RSpec.describe Artist do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :songs}
  end

  describe 'instance methods' do
    it '.average_song_length' do
      talking_heads = Artist.create!(name: 'Talking Heads')
      she_was = talking_heads.songs.create!(title: 'And She Was', length: 234, play_count: 34)
      wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45)

      expect(talking_heads.average_song_length).to eq(345)
    end
  end
end
```

Use TDD to create an instance method on our `Artist` model that returns the average of a single artist's songs. As you build out this method, remember to use `pry` and `self` to help debug and guide your implementations!

---

## WrapUp

* What are two different types of table relationships that you might need to implement? In what scenario would you use each?
* What is the syntax for the following migrations in Rails?
  * Create a table
  * Add a column to a table, with or without a data type
  * Add a reference from one table to another
