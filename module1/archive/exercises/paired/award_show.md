---
layout: page
title: Practice Paired Assessment
---

### Iteration 1

Clone this [Repository](https://github.com/turingschool-examples/award-show.git)

Use the tests in `actor_test.rb` and `movie_test.rb` to drive the development of the functionality described below.

```ruby
actress_1 = Actor.new("Jennifer Lawrence", 1990, "110000000")
#=> <Actor...>
actress_1.name
#=> "Jennifer Lawrence"
actress_1.birth_year
#=> 1990
actress_1.net_worth
#=> 110000000
movie_1 = Movie.new("Hunger Games", 2012)
#=> <Movie...>
movie_1.name
#=> "Hunger Games"
movie_1.release_year
#=> 2012
```

### Iteration 2

Writing your own tests to drive development, create a `Nominee` and `AwardShow` class with the functionality described below.

```ruby
actress_1 = Actor.new("Jennifer Lawrence", 1990, "110000000")
movie_1 = Movie.new("Hunger Games", 2012)
nominee_1 = Nominee.new(actress_1, movie_1)
#=> <Nominee...>
nominee_1.actor
#=> <Actor...>
nominee_1.movie
#=> <Movie...>

actress_2 = Actor.new("Brie Larson", 1989, "10000000")
movie_2 = Movie.new("Room", 2015)
nominee_2 = Nominee.new(actress_2, movie_2)
#=> <Nominee...>

show = AwardShow.new(2017)
#=> <AwardShow...>
show.year
#=> 2017
show.nominees
#=> []
```


### Iteration 3

Writing your own tests to drive development, create the functionality for the `AwardShow` class described below.

```ruby
show = AwardShow.new(2017)
actress_1 = Actor.new("Jennifer Lawrence", 1990, "110000000")
movie_1 = Movie.new("Hunger Games", 2012)
nominee_1 = Nominee.new(actress_1, movie_1)

actress_2 = Actor.new("Brie Larson", 1989, "10000000")
movie_2 = Movie.new("Room", 2015)
nominee_2 = Nominee.new(actress_2, movie_2)

show.nominees
#=> []

show.add_nominee(nominee_1)
show.nominees
#=> [<Nominee...>]

show.add_nominee(nominee_2)
show.nominees
#=> [<Nominee...>, <Nominee...>]

show.nominated_movies
#=> [<Movie...>, <Movie...>]

show.average_salary
#=> 60000000
```


### Iteration 4

Writing your own tests to drive development, add the following features to `AwardShow`.

```ruby
show = AwardShow.new(2017)
actress_1 = Actor.new("Jennifer Lawrence", 1990, "110000000")
movie_1 = Movie.new("Hunger Games", 2012)
nominee_1 = Nominee.new(actress_1, movie_1)

actress_2 = Actor.new("Brie Larson", 1989, "10000000")
movie_2 = Movie.new("Room", 2015)
nominee_2 = Nominee.new(actress_2, movie_2)

show.add_nominee(nominee_1)
show.add_nominee(nominee_2)

show.nominees_total_net_worth
#=> 120000000

show.nominees_alphabetical_last_names
#=> ["Larson", "Lawrence"]
```
