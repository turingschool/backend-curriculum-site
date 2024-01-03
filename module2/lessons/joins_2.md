---
layout: page
title: Multiple Joins
---

## Prerequisites
For success in this lesson, be sure you have reviewed the [Joins](./joins) lesson first. 

## Set Up
Clone and check out the `joins-homework` branch of the [Set List Tutorial](https://github.com/turingschool-examples/set-list-7/tree/joins-homework). 

## Joining Multiple Tables
As you have learned, a Join query is what we use to combine data from at least two tables. If we push that idea further, it is also possible to join *many* tables together in order to gather information from multiple tables. 

In Set List, we have tables for Artists, Songs, and Playlists. Using a simple join query, we could get the names of artists that have songs with a play count greater than 400: 

```sql
   SELECT DISTINCT artists.name FROM artists JOIN songs ON artists.id = songs.artist_id WHERE songs.play_count > 400;
```

If we run this query in Postico or `rails dbconsole`, we would see the names of a few artists. We add the `distinct` keyword because without it, we would see that some of those artists have multiple songs with a play count greater than 400. 
 
In ActiveRecord, we can write this query by joining on the Artist association to `:songs`: 
```ruby
Artist.joins(:songs).where("songs.play_count > 400").distinct.pluck("artists.name")

# Remember that we can use `.pluck` at the end of our queries to only grab the column we need in the format of an array. 
```

But what about Playlists? What would the queries look like if we wanted to get the unique names of Artists from all Playlists? 

First, we know we could join Playlists to Songs, which is we have a join table already set up for. 

```ruby
Playlist.joins(:songs)
```
Run this query and add `.to_sql`. What do you notice about the output? 

When we run this in ActiveRecord, it will first perform an inner join from `playlists` to `playlist_songs` (our join table), and then from there it can join `playlist_songs` to `songs`. But we're not quite there - we need information from the `artists` table too. And since we want to end up with Artist names, let's start our query with the `Artist` model: 

```ruby
Artist.joins(songs: :playlists).distinct.pluck(:name)
```

This query looks a little funny, doesn't it? Why would we join like that? And what are those colons (`:`) doing? Read on...

## Joining on Associations

Whenever we are joining between multiple tables/models in ActiveRecord, it is important to remember that our associations are what *relate* our models together, in the same way that primary & foriegn keys between our database tables are what *relate* our tables together. 

Much like the stories of pirates following a treasure map, we should *follow the relationships* of our Models via their associations. If we start with a Playlist but want to end up with information from an Artist (or vice-versa), we should look at our model files and ask "which associations can get us there?". 

Let's take a look at the query we performed above, and break it down step-by-step: 

#### Prompt: Return the unique names of Artists from all Playlists. 

```ruby
Artist.joins(songs: :playlists).distinct.pluck(:name)
```

1. We start with `Artist` because that's the kind of object we want returned. 
2. The `Artist` model has an association `has_many :songs`. So, since we join on associations, we start with `songs:` from the Artist model. However, the symbol is actually facing the `:playlists` association... An Artist doesn't have an association to playlists, but our `Song` model does! This join is doing 3 things: 
   1. Joining `artists` to `songs`, 
   2. then joining `songs` to `playlist_songs` through the join table, 
   3. and finally joining `playlist_songs` to `playlists` through the join table. 
3. Then, we want unique records back and not duplicated artists, so we call `.distinct` on the result. 
4. Finally, we make an array of the `:name` attribute from the `artists` table (AR assumes it's from the Artist table because it will call that attribute on whatever model we started with; alternatively we can do `.pluck("artists.name")` instead). 

Try running the above query in your `rails console`. Did it work? 

Try running it again with `.to_sql` at the end. Can you follow the different joins that it creates? 


## Relying on Associations (or, The Easy Way)
That query still has a lot of joins logic to it, though. Is there an easier way? You bet! Let's double-down on our love for associations and make this query possible: 

```ruby
Artist.joins(:playlists).distinct.pluck(:name)
```

Right now, this query would not work, because an Artist does not yet have a *direct* association with the Playlist model. However, if we work through the logic in the above example, we can add that relationship as an association to the Artist model: 

**app/models/artist.rb**
```ruby
class Artist < ApplicationRecord
   has_many :songs
   has_many :playlists, through: :songs
   #...
```

Logically, if an Artist has many Songs, and a Song has many Playlists, then we can tell the Artist that it `has_many :playlists, through: :songs` as a direct route to get to a collection of playlists from one artist! 

## AR without Associations (or, The Hard Way)

If we don't make more associations, we can still make this query work. ActiveRecord syntax *can* make it a little difficult, though...

For this example, we can start from Playlist and try to make it to Artist: 

```ruby
Playlist.joins(playlist_songs: {song: :artist})
# or 
Model.joins(x: {y: :z})
```

This syntax can also be read as: 

1. playlists joins playlist_songs (Model to "x")
2. playlist_songs joins songs ("x" to "y")
3. a song joins an artist ("y" to "z")

The end of that explanation sounds a little odd - but remember in ActiveRecord we still **join on associations**, and a Song `belongs_to` one Artist. 


## Over-joining
It is also possible to join many times in ActiveRecord using an array or comma syntax: 

```ruby
Song.joins([:artist, :playlists])
# or: 
Song.joins(:artist, :playlists)
```

In both of the above examples, AR generates this SQL for us (below). Follow along like a "treasure map" with this SQL statement: 
```sql
SELECT "songs".* FROM "songs" 
   INNER JOIN "artists" ON "artists"."id" = "songs"."artist_id" 
   INNER JOIN "playlist_songs" ON "playlist_songs"."song_id" = "songs"."id" 
   INNER JOIN "playlists" ON "playlists"."id" = "playlist_songs"."playlist_id";
```

However, it is also possible to **over-join** when writing multiple joins: 

```ruby
Song.joins([:playlist_songs, :playlists])
```
Run this query in `rails c`. Does it work? 

Then, run the query again with `.to_sql` at the end. What do you notice? 

The SQL that this query generates is: 
```sql
SELECT "songs".* FROM "songs" 
   INNER JOIN "playlist_songs" ON "playlist_songs"."song_id" = "songs"."id" 
   INNER JOIN "playlist_songs" "playlist_songs_songs_join" ON "playlist_songs_songs_join"."song_id" = "songs"."id" 
   INNER JOIN "playlists" ON "playlists"."id" = "playlist_songs_songs_join"."playlist_id";
```

This syntax actually joins `playlist_songs` **twice**, since the `Song.joins(:playlists)` association already joins to `playlist_songs` by necessity. 

The takeaway here is, if we're not careful with our joins, it may result in some data being duplicated when a query returns its data. Remember that as developers we're responsible for the integrity of our data, and strong model tests around each model method we write will help to ensure we're returning exactly what we need, and no more. 

## Further Practice
Try implementing some of these queries on your own. You may want to try writing them out in SQL first, before translating them to ActiveRecord. 

* Return a unique list of songs that appear on at least 1 playlist. 
* Return the names of the artists with songs on the "summer rewind" playlist. Use an additional association in the Artist model (i.e. join the "Easy Way"). 
* Return the names of the artists with songs on the "summer rewind" playlist, but this time don't use an additional association (try it the "Hard Way").

## Checks for Understanding
1. When would we want to use multiple joins in a query?
2. What is one hazard of potential over-joining? 
3. In your own words, describe the process for creating a multiple-join query. 

