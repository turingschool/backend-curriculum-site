---
layout: page
title: Mix Master
subheading: Part 5 - Some Refactoring
length: forever
tags: rails, many-to-many, one-to-many, rspec, testing
---


### Iterations:

* [1 Getting Started](1_getting_started.markdown)
* [2 Implementing artists](2_implementing_artists.markdown)
* [3 Implementing songs](3_implementing_songs.markdown)
* [3.1 Optional Additional Song Features](3_optional_additional_song_features.markdown)
* [4 Implementing Playlists](4_implementing_playlists.markdown)
* [5 Refactoring](5_refactoring.markdown)
* [6 Controller Tests](6_controller_tests.markdown)
* [7 Implementing users](7_implementing_users.markdown)
* [7.1 Extensions](wip-image-upload.markdown)


All of our tests are passing. Remember red, green, refactor? Now would be a good time to refactor a few things and see if our tests still pass.

```
$ git checkout -b 5_refactoring
```

### Using Partials

Go ahead and open up `app/views/artists/new.html.erb` and `app/views/artists/edit.html/erb`. What do you notice? How can you refactor this?

Since these two views contain the exact same form, we should pull out the form into a partial.

* If you already know how to do this, excellent! Do it.
* If you don't know how, check out [this documentation](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)
* If you still can't figure it out, here's how I did it. Each of the files below will be in your `app/views/artists` folder.


`new.html.erb`

```erb
<h1>New Artist</h1>

<%= render partial: "form" %>
```

`edit.html.erb`

```erb
<h1>Edit Artist</h1>

<%= render partial: "form" %>
```

`_form.html.erb`

```erb
<%= form_for(@artist) do |f| %>
  <% if @artist.errors.any? %>
    <h2><%= pluralize(@artist.errors.count, "error") %> prohibited this record from being saved:</h2>
    <ul>
      <% @artist.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  <% end %>

  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.label :image_path %>
  <%= f.text_field :image_path %>

  <%= f.submit %>
<% end %>
```

If you run `rspec`, all of your tests should still be passing.

#### Your Turn

Find other places where you've duplicated view code and extract it into a partial. Run `rspec` to make sure that all of your tests are still passing.

### Setting Variables Using Before Actions

Look at your `artists_controller.rb` and find a line that is repeated. Can you use a [before_action](http://guides.rubyonrails.org/action_controller_overview.html#filters) to eliminate this duplication?

If you're stuck, check out the refactored version below:

```ruby
class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @artist.update(artist_params)
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist.destroy
    redirect_to artists_path
  end

private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name, :image_path)
  end
end
```

If you run `rspec`, all of your tests should still be passing.

#### Your Turn

Find other places where you've duplicated view code and extract it into a partial. Run `rspec` to make sure that all of your tests are still passing.

#### Error Messages

Depending on how you implemented your forms for songs, artists, and playlists, you may have this bit of code duplicated for those three objects.

```erb
<% if @artist.errors.any? %>
    <h2><%= pluralize(@artist.errors.count, "error") %> prohibited this record from being saved:</h2>
    <ul>
      <% @artist.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  <% end %>
```

Let's make a folder for our shared partials:

```
$ mkdir app/views/shared
```

Then can also extract this into a partial called `shared/_errors.html.erb` and pass in a local variable. Instead of `@artist.errors.count`, we can do something like `target.errors.count`:

```erb
<% if target.errors.any? %>
  <h2><%= pluralize(target.errors.count, "error") %> prohibited this record from being saved:</h2>
    <ul>
      <% target.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
<% end %>
```

Then in the form, we can just render the partial:

```erb
<%= render partial: "shared/errors", locals: { target: @artist } %>
```

Make sure to commit your work! Use proper commit message manners. All tests should be passing.

```
$ git add .
$ git commit
$ git checkout master
$ git merge 5_refactoring
$ git push heroku master
$ heroku run rake db:migrate
```

### On to [Mix Master Part 6: Testing Your Controllers](6_controller_tests.markdown)
