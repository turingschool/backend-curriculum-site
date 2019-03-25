---
layout: page
title: Nested Resources in Rails
---

# Nested Resources

## Learning Goals

- Understand how to use nested resources in Rails
- Understand when you should use Nested Resources

## Warm Up

Create a table containing all of the HTTP verbs, URI patterns, and controller actions that Rails gives you when you have the following in `config/routes.rb`:

```ruby
resources :muffins
```

## Background

Read [this](http://guides.rubyonrails.org/routing.html#nested-resources) section of the Rails routing documentation and discuss with the person next to you.

## Examples

```
GET  /artists/1/songs
GET  /artists/1/songs/new
POST /artists/1/songs
```

To be brief, any time we need to know one resource in order to create a different kind of resource, that's a good signal to use nested resources.


## How do we Create Nested Routes?

Indentation and a do/end marker!

```ruby
# config/routes.rb
resources :artists do
  resources :songs
end
```

* Run `rake routes` -- what's different now?

## Shallow Nesting

```ruby
# config/routes.rb
resources :artists
  resources :songs, shallow: true do
end
```

* Run `rake routes` again.
* How does this differ from what was generated without `shallow: true`?
* When we would we want it one way or the other?

## `form_for` with an un-nested resource

`form_for` uses an object passed to it as an argument to determine:

* Whether to render a new form or an update form
* Whether the fields in the form correspond to attributes on the object
* What route to use when sending the information when a user hits submit

## `form_for` with Nested Resources

* Need to pass **BOTH** the initial resource as well as the nested resource (eg, both `artists` and `songs`)
* Will provide them in an array as an argument
  * the array HAS to be in the correct order!
  * `rake routes` as a debugger will show us in the prefix what order these need to be!
* Need to update both our controller and our view

## Practice

- You should have a test already to see the form for a new song.
- Now let's create a new song with an artist.

Based on what we know about nested routes, let's start here:

Create `spec/features/songs/new_spec.rb` and add the following content into a new test (don't forget your describe blocks, etc)

* note that our test setup needs to create the artist to whom we're assigning this new song

```ruby
artist = Artist.create(name: "Journey")
title = "Don't Stop Believin'"
length = 231

visit new_artist_song_path(artist)

fill_in :song_title, with: title
fill_in :song_length, with: length

click_on "Create Song"

new_song = Song.last

expect(current_path).to eq(song_path(new_song))
expect(page).to have_content(title)
expect(page).to have_content(length)
expect(page).to have_content(artist.name)
```

- What is in your controller? What is in your view?
- We previously wrote a test to see a new form for a new song but did not actually create a new song.

- Our controller should only have an empty `new` method:

```ruby
#app/controllers/songs_controller.rb
def new
end
```

- And our view like this:

```html
# app/views/songs/new.html.erb
<h1>Create a New Song</h1>

<%= form_for  @song do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :length %>
  <%= f.number_field :length %>
  <%= f.label :play_count %>
  <%= f.number_field :play_count %>
  <%= f.submit %>
<% end %>
```

- This should take us all the way to a failing test:

```bash
Failure/Error: click_on "Create Song"

     ActionController::RoutingError:
       No route matches [POST] "/songs"
```

Hmmmm, but we have opened the routes for making a new song for an artist.

Let's check out `rake routes` output to see what route we are actually trying to hit.

* What are we looking for? A route that creates our new song.
* Which HTTP verb do we use when we create a new resource?

```bash
  POST   /artists/:artist_id/songs(.:format)     songs#create
```

- Based on the route above, we need our form to post to a route for a specific artist's songs.
- How can we do that? Through the controller and form! Let's make those adjustments.

```ruby
# app/controllers/songs_controller.rb
def new
  @artist = Artist.find(params[:artist_id])
  @song   = Song.new
end
```

- Lets update our view to use `@song` as a parameter to a form helper:

```
# app/views/songs/new.html.erb
<h1>Create a New Song</h1>

<%= form_for [@artist, @song] do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :length %>
  <%= f.number_field :length %>
  <%= f.label :play_count %>
  <%= f.number_field :play_count %>
  <%= f.submit %>
<% end %>
```

Run `rspec` and adjust our `SongsController` so we can process the form input in a `create` action method

```ruby
# app/controllers/songs_controller.rb

def create
  artist = Artist.find(params[:artist_id])
  song = artist.songs.create(song_params)
  redirect_to song_path(song)
end
```

- We should have a passing test!!!

#### Bonus Points

Have the song page show the artist name!

## Checking our work in Development Mode:

Creating a New Song via localhost:3000

* Be sure you have at least one artist in your database (use `rails console` if you need to)
* Run `rails s`
* Visit `/artists/1/songs/new`

---

# Mixing Nested and Non-Nested Routes

What if we want to see a list of all songs?

Because we have `songs` nested under `artists`, we've lost our `/index` path, so not every test is going to pass!

Let's add one more route:

```ruby
# config/routes.rb
resources :artists
  resources :songs, shallow: true do
end

resources :songs, only: [:index]
```

Visit `/songs` and you should see all songs.

## be sure to replace the missing 'only' commands in your routes file so we don't expose routes to malicious users!

---

# Checks for Understanding

Turn and talk to your neighbor and discuss:

* When would you use a nested resource?
* How do you nest a resource in your routes file?
* How does that change your routes?
* What does it mean to use shallow nesting? Why would you do this?
* What changes do you need to make in your controller when you nest a resource?
