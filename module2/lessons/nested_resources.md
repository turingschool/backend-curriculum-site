---
layout: page
title: Nested Resources in Rails
---

## Learning Goals

- Understand what nested resources are
- Understand the routes and requests needed to create nested resources

## Warm up

Discuss with a partner:

In SetList, when we fill out the form to create a new Artist and click the submit button, what does the resulting request look like? What information does it contain? To what path is it sent? What verb does it use?

## Nested Resources

Sometimes in our applications we will have resources that are essentially tied to each other, meaning one cannot exist without the other. We refer to these as **Nested Resources**. In our SetList app, our Song model says that it `belongs_to` an Artist. That means that it has to have an Artist. We say that `Songs` are **nested** under `Artists`. So, for some actions we want to take on a Song, we have to know which Artist it belongs to.

In SetList, we want users to be able to create new songs, but we have to know which artist the song is being created for. So, when we send a request to create a new song, we will use these routes:

```
GET  /artists/:artist_id/songs/new   #new song form
POST /artists/:artist_id/songs       #create a song
```

## Writing the test

```ruby
# spec/features/songs/new_spec.rb

require 'rails_helper'

RSpec.describe "creating a new song" do
  it "can create a song" do
    artist = Artist.create(name: "Journey")
    title = "Don't Stop Believin'"
    length = 231
    play_count = 7849

    visit "/artists/#{artist.id}/songs/new"

    fill_in "title", with: title
    fill_in "length", with: length
    fill_in "play_count", with: play_count

    click_on "Create Song"

    new_song = Song.last

    expect(current_path).to eq("/songs/#{new_song.id}")
    expect(page).to have_content(title)
    expect(page).to have_content(length)
    expect(page).to have_content(play_count)
    expect(page).to have_content(artist.name)
  end
end
```

Discuss with the person next to you:

* What route are we visiting?
* What should happen when we click submit?

When we run the test, we see that no route exists for our new song form.

## Creating the Nested Routes

Let's add that nested route now:

```ruby
# config/routes.rb
get '/artists/:artist_id/songs/new', to: 'songs#new'
```

Run `rake routes` and examine what routes this generated for us.

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

Now the tests are telling us that it can't find the form fields.

## Creating the Form

First, let's think about where we want this path to submit. Thinking back to our discussion at the beginning, what verb/path combo should we use?

```erb
<%= form_tag("/artists/#{@artist_id}/songs", method: :post) do %>
<% end %>
```

Notice that we have used `@artist_id` in the path, so let's add that instance variable to our action. Where does that information come from? From the path! Take a look back at `routes.rb` to remind yourself what the route to show this form looks like.

```ruby
def new
  @artist_id = params[:artist_id]
end
```

If we run the test again, we'll still get our error for missing fields, so let's add those fields:

```erb
<%= label_tag "Title" %>
<%= text_field_tag :title %>

<%= label_tag "Length" %>
<%= number_field_tag :length %>

<%= label_tag "Play Count" %>
<%= number_field_tag :play_count %>

<%= submit_tag "Create Song"%>
```

Now when we run the test, we'll see no route matches when we submit the form.

## Creating the New Song

Let's add the route to create a song:

```ruby
post '/artists/:artist_id/songs', to: 'songs#create'
```

Let's add our create action:

```ruby
# songs_controller.rb
def create
end
```

Running the test will give us:

```
NoMethodError:
      undefined method `id' for nil:NilClass
```

Follow the stack trace for this error to figure why this is happening.

We haven't actually created our Song, so let's do that in our Songs controller. As always with handling form data, we are going to use strong params:

```ruby
private

  def song_params
    params.permit(:title, :length, :play_count)
  end
```

Let's try to create our Song with these strong params:

```ruby
def create
  song = Song.create!(song_params)
end
```

Notice how we are using `create!` rather than `create`. The bang (`!`) will give us an error if our creation is unsuccessful, which is useful when developing. It is always a good idea to start with `create!` first to make sure everything is working correctly.

Run the test and, sure enough, our Song was not created successfully. Our error should be

```
ActiveRecord::RecordInvalid:
      Validation failed: Artist must exist
```

Finally, we are seeing the implications of our nested resources. A Song can't exist on its own, it needs an artist. This is why we've been passing the `artist_id` in our path:

```ruby
def create
  artist = Artist.find(params[:artist_id])
  song = artist.songs.create!(song_params)
end
```

Run the test again and we no longer get an error that our Song couldn't be created, so it looks like that is working.

Now we get a failure in our test saying the path is wrong, so all that's left to do is redirect the request:

```ruby
def create
  artist = Artist.find(params[:artist_id])
  song = artist.songs.create!(song_params)
  redirect_to "/songs/#{song.id}"
end
```

It is important to note that the way we've set up the relationship is not the only way to do it. For instance, we don't **have** to find the Artist object to set up the relationship. We could manually use the artist's id to associate it with the song:

```ruby
def create
  song = Song.new(song_params)
  song.artist_id = params[:artist_id]
  song.save!
  redirect_to "/songs/#{song.id}"
end
```

In this case, we have to first do `Song.new`, then change the artist_id, then save the song. `create` will do a `new/save` all at once.

As usual, there are many ways of doing something in Rails. You should be comfortable with using either of these two options we've shown here.

## Checking our work in Development Mode:

* Be sure you have at least one artist in your database (use `rails console` if you need to)
* Run `rails s`
* Visit `/artists/1/songs/new`
* See if it works!

## Independent Practice

Write a test and implement the code for an Artist's Song index page. This page will show all the songs for a particular artist. It should use this route: `get /artists/:artist_id/songs`.

# Checks for Understanding

Turn and talk to your neighbor and discuss:

* What is a nested resource?
* What does the route look like for a nested resource?
* Consider the following features we could add in our app:
  * show a song
  * show all songs
  * delete a song
  * show a particular artist's songs
  * create a song
  * update a song

Which of them would require a nested route?
