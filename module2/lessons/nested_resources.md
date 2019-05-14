---
layout: page
title: Nested Resources in Rails
---

## Learning Goals

- Understand the `resources` syntax for routes
- Understand how to use nested resources in Rails
- Understand when you should use Nested Resources

## Warm Up

Fill out this table for the eight restful actions we could perform on a  `muffin` resource (the first is done for you):

| HTTP Verb | URI Pattern | Controller Action | What does it do? |
| --------- | ----------- | ----------------- | ---------------- |
| GET | `/muffins` | `muffins#index` | Shows all the muffins |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |

## Resources Syntax for Restful Routes

In SetList, open up `routes.rb`. Up until this point, we have been explicitly stating the verb, uri pattern, and controller action for each route (we often refer to this as "handrolling" a route).

Rails gives us a shortcut for defining restful routes. Update the `routes.rb` file to:

```ruby
Rails.application.routes.draw do
  resources :songs
end
```

Run `rake routes` and compare this output to the table you filled out in the warm up.

Whenever we are defining routes, we only want to expose routes that we need. We can do that with an `only` argument:

```ruby
resources :songs, only: [:index, :show]
```

Run `rake routes`. What did this do?

We can do the same thing with `except`:

```ruby
resources :songs, except: [:index, :show]
```

Run `rake routes`. What did this do?

It is important to note that the `resources` syntax only creates restful routes. If you need a non restful route, you will have to handroll it.

### Practice

Recreate the handrolled routes in SetList using the `resources` syntax.

# Nested Resources

## Background

Read [this](http://guides.rubyonrails.org/routing.html#nested-resources) section of the Rails routing documentation and discuss with the person next to you.

To be brief, any time we need to know one resource in order to create a different kind of resource, that's a good signal to use nested resources.

## Creating a New Song for an Artist

In SetList, we want users to be able to create new songs, but we have to know which artist the song is being created for. We're going to utilize nested resources to accomplish this.

Our application will need these routes to create a song:

```
GET  /artists/:artist_id/songs/new   #new song form
POST /artists/:artist_id/songs       #create a song
```

### Practice

Change your routes file to:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  resources :artists do
    resources :songs
  end
end
```

Run `rake routes`. With a partner, discuss:

* What routes did this give us?
* Did this generate the routes we need to create a new song?

Now change the routes to:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  resources :artists do
    resources :songs, shallow: true
  end
end
```

Run `rake routes` again. With a partner, discuss:

* How does this differ from what was generated without shallow: true?
* Did this generate the routes we need to create a new song?

## Writing the test

```ruby
# spec/features/songs/new_spec.rb

artist = Artist.create(name: "Journey")
title = "Don't Stop Believin'"
length = 231
play_count = 7849

visit new_artist_song_path(artist)

fill_in :song_title, with: title
fill_in :song_length, with: length
fill_in :song_play_count, with: play_count

click_on "Create Song"

new_song = Song.last

expect(current_path).to eq(song_path(new_song))
expect(page).to have_content(title)
expect(page).to have_content(length)
expect(page).to have_content(play_count)
expect(page).to have_content(artist.name)
```

Discuss with the person next to you:

* What route are we visiting?
* What should happen when we click submit?

When we run the test, we see that our path helper is undefined.

## Creating the Nested Routes

First, let's nest our Songs inside Artists:

```ruby
# config/routes.rb
resources :artists do
  resources :songs
end
```

Run `rake routes` and examine what routes this generated for us.

If you run only the new test, you'll see that we did indeed fix the undefined path helper error, but if you run all the tests you'll notice that many of them are broken. This is because *all* our routes for Songs are now dependent on an Artist. We've lost our Songs index and show pages. Let's fix this using `only`/`except`:

```ruby
resources :artists do
  resources :songs, only: [:new]
end

resources :songs, only: [:index, :show]
```

In order to only expose the   we need, we'll add an `only` to `:artists`:

```ruby
resources :artists, only: [:new, :create, :show] do
  resources :songs, only: [:new]
end

resources :songs, only: [:index, :show]
```

In this case, we're not using the `shallow: true` syntax since that will generate  an `index` route that is also nested. This would mean that our songs index pages only show songs for a specific artist. Since we want to keep our index page for *all* songs, we will skip the `shallow: true` syntax.

## Creating the Form

Running the test gives us an `ActionNotFound` error.

Create the `new` action:

```ruby
#songs_controller.rb

def new
end
```

Next we'll get a missing template error, so go create the view:

```
touch app/views/songs/new.html.erb
```

Now the tests are telling us that it can find the form fields.

### `form_for` with an un-nested resource

Let's try to create a new form with the pattern we've seen before. In the `songs_controller`:

```ruby
def new
  @song = Song.new
end
```

and in `new.html.erb`:

```erb
<%= form_for @song do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>

  <%= f.label :title %>
  <%= f.number_field :length %>

  <%= f.label :title %>
  <%= f.number_field :play_count %>

  <%= f.submit %>
<% end %>
```

Run this test and we'll get this error:

```
ActionController::RoutingError:
  No route matches [POST] "/songs"
```

This error is happening in our tests when we try to submit the form.

`form_for` is using the object passed to it as an argument to determine where to submit the form. In this case, the object passed to it is `@song` which was defined in our controller as `Song.new`. It first builds a path helper to determine the path to submit. Since `@song` is an instance of `Song`, it builds `songs_path` as the path helper. `form_for` is also determining that since this is a new Song (a song without an id), it should be a `POST` request. That's where `No route matches [POST] "/songs"` is coming from.

`POST /songs` is not what we want. Where we really want the form to submit is `POST /artists/:artist_id/songs`.

### `form_for` with Nested Resources

When creating a `form_for` a nested resource, we need to pass **BOTH** the  resource we are trying to create as well as the nested resource. We'll provide them in an array as an argument:

```erb
<%= form_for [@artist, @song] do |f| %>
```

This array HAS to be in the correct order! We can use `rake routes` as a debugger to show us in the prefix what order these need to be!

We'll also have to define `@artist` in our controller. We should have access to the Artist id in our path because of our nested routes which we can access through `params`. Run `rake routes` to figure out the name of this parameter.

```ruby
def new
  @song = Song.new
  @artist = Artist.find(params[:artist_id])
end
```

Now when we run the test, we get:

```
ActionView::Template::Error:
      undefined method `artist_songs_path' for #<#<Class:0x00007fa78a335480>:0x00007fa78a4581f0>
```

Since we are now passing an array of two objects to `form_for`, it is trying to use both of them to build the path helper to submit the form. An Artist object plus a Song object builds `artist_songs_path` as the path to submit to. We can create this route (and the corresponding path helper) in our `routes.rb` file by adding `:create` to our nested songs routes:

```ruby
resources :artists, only: [:new, :create, :show] do
  resources :songs, only: [:new, :create]
end
```

Now we can an error for undefined action `create`.

## Creating the New Song

Let's add our create action:

```ruby
# songs_controller.rb
def create
end
```

Running the test will give us:

```
ActionController::UrlGenerationError:
       No route matches {:action=>"show", :controller=>"songs", :id=>nil}, possible unmatched constraints: [:id]
```

Looking closely at this error, we can see that we're trying to go to a song show page, but the `id` is `nil`. The error is even giving us a hint in `possible unmatched constraints: [:id]`. Looking at the stack trace, this happening on this line in our test:

```ruby
new_song = Song.last

expect(current_path).to eq(song_path(new_song))
```

Since we haven't actually created `new_song` yet, we don't have any Songs in our db, and so `Song.last` is giving us nothing. Let's actually create the song. First, we'll need to find the artist associated with this song to properly set up the relationship. This is why it is so important that our route is nested.

```ruby
def create
  artist = Artist.find(params[:artist_id])
  artist.songs.create(song_params)
end

private

def song_params
  params.require(:song).permit(:title, :length, :play_count)
end
```

As always, we are using **strong params** when accessing our form data.

Run this test, and we will get:

```
Failure/Error: expect(current_path).to eq(song_path(new_song))

     expected: "/songs/495"
          got: "/artists/295/songs"
```

We're no longer getting that `nil` id in our route, so our Song has been successfully created. The last thing we need to do is redirect our user to the song show page:

```ruby
def create
  artist = Artist.find(params[:artist_id])
  song = artist.songs.create(song_params)
  redirect_to song_path(song)
end
```

## Checking our work in Development Mode:

Creating a New Song via `localhost:3000`

* Be sure you have at least one artist in your database (use `rails console` if you need to)
* Run `rails s`
* Visit `/artists/1/songs/new`

# Checks for Understanding

Turn and talk to your neighbor and discuss:

* When would you use a nested resource?
* How do you nest a resource in your routes file?
* How does that change your routes?
* What does it mean to use shallow nesting? Why would you do this?
* What changes do you need to make in your controller when you nest a resource?
