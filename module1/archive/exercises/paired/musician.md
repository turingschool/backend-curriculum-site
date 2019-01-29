---
layout: page
title: Practice Paired Assessment
---

## ITERATION 1 (tests provided)

```ruby
demi = Musician.new("Demi Lovato")
# => <#Musician:943576874387>
demi.name
# => "Demi Lovato"
demi.songs
# => []
demi.song_count
# => 0
```


**Tests:**

```ruby
require 'minitest/autorun'

class MusicianTest < Minitest::Test
  def test_it_exists
    musician = Musician.new("Demi Lovato")

    assert_instance_of Musician, musician
  end

  def test_it_has_name
    skip
    musician = Musician.new("Demi Lovato")

    assert_equal "Demi Lovato", musician.name
  end

  def test_it_has_songs
    skip
    musician = Musician.new("Justin Bieber")

    assert_equal [], musician.songs
  end

  def test_it_has_song_count
    skip
    musician = Musician.new("Selena Gomez")

    assert_equal 0, musician.song_count
  end
end
```

## ITERATION 2

```ruby
song = Song.new("Cool for the Summer", 2015, "Confident", 3)
# => <#Song:876876423423>
song.title
# => "Cool for the Summer"
song.year
# => 2015
song.album
# => "Confident"
song.rank
# => 3
```

## ITERATION 3

```ruby
song_1 = Song.new("Cool for the Summer", 2015, "Confident", 4)
song_2 = Song.new("Stone Cold", 2015, "Confident", 5)
song_3 = Song.new("This is Me", 2008, "Camp Rock", 6)

musician = Musician.new("Demi Lovato")

musician.add_song(song_1)
musician.song_count
# => 1
musician.add_song(song_2)
musician.song_count
# => 2
musician.add_song(song_3)
musician.average_rank
# => 5
```


## ITERATION 4


```ruby
song_1 = Song.new("Cool for the Summer", 2015, "Confident", 1)
song_2 = Song.new("Stone Cold", 2015, "Confident", 5)
song_3 = Song.new("This is Me", 2008, "Camp Rock", 10)

m = Musician.new("Demi Lovato")

musician.add_song(song_1)
musician.add_song(song_2)
musician.add_song(song_3)
musician.songs_by_album
# => { "Confident" => 2, "Camp Rock" => 1 }
