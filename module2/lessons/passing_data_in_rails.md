---
layout: page
title: Passing Data in Rails
length: 180
---

## Learning Goals
* Understand how a user specifies a particular resource for a show page
* Implement `form_for` to create a new resource
* Define Query Parameters

## Vocabulary
* `form_for`
* query parameters

## WarmUp

* With a partner, review your TaskManager app and walk through how a new task is created by a user.

## Getting Data from Users

There are three ways that we get information from users in order to manipulate things in our application:

1. User input into a URL (like the id of a resource for a show page)
1. Forms
1. Query Params

## Song Show Page

One way that we allow users to send us information, is through URIs that request a specific resource.  To explore this, let's implement the following user story into our Set List app.

```
As a visitor
When I visit /songs/1 (where 1 is the id of a song in my database)
Then I see that song's title, and artist
And I do not see any of the other songs in my database
```

First, a test!

```ruby
# spec/features/songs/show.html.erb

require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I visit a song show page' do
    it "then I see only that song's title and artist" do
      talking_heads = Artist.create!(name: 'Talking Heads')
      she_was = talking_heads.songs.create(title: 'And She Was', length: 234 )
      wild_life = talking_heads.songs.create(title: 'Wild Wild Life', length: 456 )

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

The route that we created above doesn't look _exactly_ like the route that our error was looking for - why not?.  If we made a route `get '/songs/37', to 'songs#show'`, we are assuming that a user would only ever want to look at the song with the id of '37', which is not very useful; so, we use `:id` as a stand-in, indicating that we expect a user to fill in that information for whichever song they want to see.  More on that in a second; for now, let's run our test and continue clearing errors!

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

## New Artist Form

The second way users can send information to our application is through forms. To help illustrate this, let's add the ability for a visitor to add a new artist to our Set List app.

```
As a visitor
When I visit '/artists/new'
and I fill in the artist's name
Then I click 'Create Artist'
I am redirected to this new artists show page
```

First, a test!

```ruby
# spec/features/artists/new_spec.rb

require 'rails_helper'

RSpec.describe 'New Artist' do
  describe 'As a visitor' do
    describe 'When I visit the new artist form' do
      it 'I can create a new artist' do
        visit '/artists/new'

        fill_in 'Name', with: 'Megan'
        click_on 'Create Artist'

        new_artist = Artist.last

        expect(current_path).to eq("/artists/#{new_artist.id}")
      end
    end
  end
end
```

Use TDD and what we know about Rails so far to TDD until you reach the following error:

```
1) New Artist As a visitor When I visit the new artist form I can create a new artist
   Failure/Error: fill_in 'Name', with: 'Megan'

   Capybara::ElementNotFound:
     Unable to find field "Name" that is not disabled
   # ./spec/features/artists/new_spec.rb:9:in `block (4 levels) in <top (required)>'
```

You should now have a route for `get '/artists/new', to: 'artists#new'`, an `ArtistsController`, a `new` action in that controller and a view for `view/artists/new.html.erb`.  Now its time to build out our form!

Looking back at your Task Manager from the intermission work, we see a form that looks like this:

```erb
<form action="/tasks" method="post">
  <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
  <p>Enter a new task:</p>
  <input type='text' name='task[title]'/><br/>
  <textarea name='task[description]'></textarea><br/>
  <input type='submit'/>
</form>
```

We could use this same form structure to build out our new artist form; but, wouldn't it be nice if rails gave us some help so we didn't have to build this form by hand?  The good news is, it does!  Rails gives us `form_for` to help us build forms:


```erb
<%= form_for Artist.new do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.submit %>
<% end %>
```

Much simpler, right? But do we still have all the information we need? Let's break it down, line by line.

The first line in our HTML form for tasks `<form action="/tasks" method="post">` tells the form the verb and path it should request when the form is submitted.  In `form_for`, Rails will build out this path based on the object that you pass it, in this case `Artist.new`; because we are passing the form a new (but empty) Artist, Rails will assume that we will want to `POST` to `/artists` based on the conventions of ReSTful routes.

The next line, `<input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">`, is a security setting that Rails requires on all forms, and `form_for` gives us this out of the box.

The next three lines set up what a user sees in and around an input area, and the button to submit the form.  These three lines are replaced with:

```erb
<%= f.label :name %>
<%= f.text_field :name %>

<%= f.submit %>
```

Now that we have a better understanding of `form_for`, let's run our test and we should be getting the following error:

```
Failure/Error: <%= form_for Artist.new do |f| %>

     ActionView::Template::Error:
       undefined method `artists_path' for #<#<Class:0x007f83a7bae988>:0x007f83a7b96c98>
       Did you mean?  artists_new_path
     # ./app/views/artists/new.html.erb:1:in `_app_views_artists_new_html_erb___3306135970899696149_70101715771920'
     # ./spec/features/artists/new_spec.rb:7:in `block (4 levels) in <top (required)>'
     # ------------------
     # --- Caused by: ---
     # NoMethodError:
     #   undefined method `artists_path' for #<#<Class:0x007f83a7bae988>:0x007f83a7b96c98>
     #   Did you mean?  artists_new_path
     #   ./app/views/artists/new.html.erb:1:in `_app_views_artists_new_html_erb___3306135970899696149_70101715771920'
```

Yikes! What does this mean?  It means that rails is trying to build a form to post to a route that doesn't exist. So, let's go make that route:

```ruby
Rails.application.routes.draw do

  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#show'
  get '/artists/new', to: 'artists#new'
  post '/artists', to: 'artists#create'
end
```

Now, let's add the `create` action to our controller, and put a pry in that method.

```ruby
class ArtistsController < ApplicationController
  def new
  end

  def create
    binding.pry
  end
end
```

When we run our tests and hit that pry - what do we now have access to in our `params`?

```
5: def create
=> 6:   binding.pry
7: end

[1] pry(#<ArtistsController>)> params
=> <ActionController::Parameters {"utf8"=>"✓", "artist"=>{"name"=>"Megan"}, "commit"=>"Create Artist", "controller"=>"artists", "action"=>"create"} permitted: false>
```

Our new artist information!  Fantastic!  We can now use that information to create a new artist in our `ArtistsController`:

```ruby
class ArtistsController < ApplicationController
  def new
  end

  def create
    Artist.create(artist_params)
  end

  private
  def artist_params
    params.require(:artist).permit(:name)
  end
end
```

Woah, where did this `artist_params` method come from?  Why couldn't we just use `Artist.create(params[:artist])`?  Let's try it and see what happens... errors!  Rails is trying to protect us from malicious users by not allowing us to drop our `params[:artist]` sub-hash directly into a new object in our database, so we need to create a method that is often referred to as **strong params** to effectively use the information we are getting from our form to create a new object.

Go ahead and run the test again, and let's see if we've got a passing test. Not yet - we need to tell our create action where to redirect to after creating the artist!  Based on our User Story, we want it to redirect to that artists show page, so let's add the following to make that happen:

```ruby
# app/controllers/artists_controller.rb

class ArtistsController < ApplicationController
  def show
  end

  def new
  end

  def create
    artist = Artist.create(artist_params)
    redirect_to "/artists/#{artist.id}"
  end

  private
  def artist_params
    params.require(:artist).permit(:name)
  end
end
```

```ruby
# config/routes.rb
Rails.application.routes.draw do

  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#show'
  get '/artists/new', to: 'artists#new'
  post '/artists', to: 'artists#create'
  get '/artists/:id', to: 'artists#show'
end
```

```bash
touch app/views/artists/show.html.erb
```

Your test should now be passing - you have successfully created a new object with `form_for`!

BUT - before we move on, let's clean things up a bit so that we are sticking to MVC.  Right now, in our `app/views/artists/new.html.erb`, we are making a call directly from a view to our database by using `Artist.new`. Let's refactor so that our form is relying on an instance variable that our controller sends down to it:

```ruby
class ArtistsController < ApplicationController
  def show
  end

  def new
    @artist = Artist.new
  end

  def create
    artist = Artist.create(artist_params)
    redirect_to "/artists/#{artist.id}"
  end

  private
  def artist_params
    params.require(:artist).permit(:name)
  end
end
```

```erb
# app/views/artists/new.html.erb

<%= form_for @artist do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.submit %>
<% end %>
```

Much better!

## Query Params

There is one other way that users can send information in that we can access through `params` and that is with **query params**.  In the following URL `http://www.setlist.com/artists?age=32`, `age=32` are the **query params**, and the key value pair contained there (`{age: 32}`) will be included in the `params` for that request.  

To see this in action, put a pry in your `songs#index` action, spin up your SetList with `rails s` and navigate to [http://localhost:3000/songs?artist=prince](http://localhost:3000/songs?artist=prince). Open your terminal, and you should be in a pry session with access to the `params` object:

```
2: def index
=> 3:   binding.pry
4:   @songs = Song.all
5: end

[1] pry(#<SongsController>)> params
=> <ActionController::Parameters {"artist"=>"prince", "controller"=>"songs", "action"=>"index"} permitted: false>

[2] pry(#<SongsController>)> params[:artist]
=> "prince"
```

Now, our params include the key/value pair from the query params and we can use that information in our controllers to filter or change what a user sees!

## Checks for Understanding

1. What is the syntax for creating a route for a show page for a `zebra` resource?
1. How does `form_for` know what method/path combination to use when submitted?
1. What is a query parameter, and how do we identify one within a URL?
