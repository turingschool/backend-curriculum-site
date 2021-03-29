---
title: Dynamic Routing
layout: page
---

## Learning Goals

* Understand how data is dynamically passed using Routes
* Create a show page
* Use ActiveRecord to retrieve a single object from the database by its id

## Routing and Route Segments

The Rails Router is a pattern matcher. When our app receives an incoming HTTP request, the Router will match the request's **verb** and **path** to one of our routes. The first one it matches, it will run the specified controller#action. If no route matches, our app will throw an error.

Furthermore, a **path** can be separated into segments, each one separate by a slash `/`. For example, if we had a route in routes.rb:

```
get ‘/show/me/the/songs’, to: songs#show_em
```

We would say this route has 4 segments: `show`, `me`, `the`, `songs`. When the Router is try to match an incoming HTTP request's path to one of our routes, each segment needs to match in the correct order. For our example route:

* Only a `GET` request to `/show/me/the/songs` would match this route
* GET to `show/me/some/songs` would not match
* GET to `show/me/songs` would not match
* GET to `show/me/the/songs/please` would not match
* GET to `show/the/me/songs` would not match
* POST to `show/me/the/songs` would not match

## Dynamic Segments

Your routes can also include dynamic segments. These are segments which can accept *any* value for that segment.

We define a dynamic segment with a colon `:`. Let's revisit our example route and make the second segment dynamic:

```
get ‘/show/:me/the/songs’, to: songs#show_em
```

Now that the second segment `:me` is dynamic, any value in that second segment will match this route:

* A GET request to `/show/brian/the/songs` would match
* A GET request to `/show/129482/the/songs` would match
* A GET request to `/show/me/the/songs` would match
* A GET request to `/show/:me/the/songs` would match
* A GET request to `/show/the/me/songs` would **not** match

Note that the dynamic segment looks like a symbol, and may even be referred to as a symbol, but technically it is not a symbol.

## Dynamic Segments in Params

In addition to accepting any value for that segment, a dynamic segment will create a key in the `params` hash. The key in `params` will be the name of the segment, and the value will be whatever is in that segment's place in the incoming HTTP request. Using our example route:

```
get ‘/show/:me/the/songs’, to: songs#show_em
```

If our app receives a GET HTTP request with a path of `/show/brian/the/songs`, then in our params hash will have a key/value pair of `"me" => "brian"`.

## Dynamic Segments in SetList

By including dynamic segments in our routes, we can create routes that are dynamic, meaning that they can accept data and do different things depending on what data is input into the path. This is most commonly used to pass an object's id.

Let's put this into practice by adding a new feature to our SetList app. This feature will be a "Show" page. A Show page is used to show a single record from our database. We are going to create a Song show page, so we will add a route to our application like:

```
get '/songs/:id', to: songs#show
```

Our app will determine which Song to show based on the id passed into the second segment.

Note that there is nothing special about calling the dynamic segment `:id`. We could have called it `:song_id`, or `:id_of_the_song`, or `:flippidy_floppidy_floo`. Just like naming variables in our code, we want to name our segments semantically so that they communicate what they are for, so that is why we typically use `:id`.

## Song Show Page

Let's start with a User Story:

```
As a visitor
When I visit /songs/1 (where 1 is the id of a song in my database)
Then I see that song's title, and artist
And I do not see any of the other songs in my database
```

First, a test!

```ruby
# spec/features/songs/show_spec.rb

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I visit a song show page' do
    it "then I see only that song's title and artist" do
      talking_heads = Artist.create!(name: 'Talking Heads')
      she_was = talking_heads.songs.create(title: 'And She Was', length: 234, play_count: 2994 )
      wild_life = talking_heads.songs.create(title: 'Wild Wild Life', length: 456, play_count: 384889 )

      visit "/songs/#{she_was.id}"

      expect(page).to have_content(she_was.title)
      expect(page).to have_content("By: #{talking_heads.name}")
      expect(page).to_not have_content(wild_life.title)
    end
  end
end
```

Run our tests, and, based on the error that we are getting and what we know about Rails so far, what is our next step?

```
1) As a visitor I visit a song show page then I see only that song's title and artist
   Failure/Error: visit "/songs/#{she_was.id}"

   ActionController::RoutingError:
     No route matches [GET] "/songs/37"
   # ./spec/features/songs/show_spec.rb:10:in `block (3 levels) in <top (required)>'
```

This error is actually telling us what is going wrong - helpful!  So, let's go create a route that matches `GET /songs/37`.

```ruby
# config/routes.rb

Rails.application.routes.draw do

  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#show'
end
```

The route that we created above doesn't look _exactly_ like the route that our error was looking for - why not?.  If we made a route `get '/songs/37', to 'songs#show'`, we are assuming that a user would only ever want to look at the song with the id of '37', which is not dynamic; so instead, we will make use of a dynamic segment, indicating that we expect a user to fill in that information for whichever song they want to see.  More on that in a second; for now, let's run our test and continue clearing errors!

Our error right now, looks something like this:

```
1) As a visitor I visit a song show page then I see only that song's title and artist
   Failure/Error: visit "/songs/#{she_was.id}"

   AbstractController::ActionNotFound:
     The action 'show' could not be found for SongsController
   # ./spec/features/songs/show_spec.rb:10:in `block (3 levels) in <top (required)>'
```

So, let's go make that action in our `SongsController`, and put a pry in there for now:

```ruby
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    binding.pry
  end
end
```

Let's run our test to hit this pry and play around with what we have access to:

```
6: def show
=> 7:   binding.pry
8: end

[1] pry(#<SongsController>)> params
=> <ActionController::Parameters {"controller"=>"songs", "action"=>"show", "id"=>"57"} permitted: false>

[2] pry(#<SongsController>)> params[:id]
=> "57"
```

Rails gives us this nice `params` object that pulls in that `:id` from the URI, which we can use to target the song that a User is looking for, like this:

``` ruby
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end
end
```

When we run our tests now, we see that we need to add a view for this controller#action:

```erb
<h2><%= @song.title %></h2>
<p>By: <%= @song.artist.name %></p>
```

And, now we have a passing test!

## Checks for Understanding

* What is a dynamic segment? Why would you use a dynamic segment?
* What is the relationship between a dynamic segment and `params`?
* What active record method can you use to retrieve a record by its id?
