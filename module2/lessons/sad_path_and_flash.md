---
layout: page
title: Sad Path Testing and Flash Messages
---

## Learning Goals
* Describe sad path testing, and why it is necessary
* Implement a sad path user story

## Vocabulary
* Sad Path
* Flash

## Warm Up
* As developers, how do we know when our application isn't working properly?
* As a user, how do we know when we have used an application in an unintended way?

## Testing the Sad Path

When writing tests for our applications, we generally want to have two types of tests:

1. Tests for the correct usage of the application - the **Happy Path**. And,
1. Tests for an incorrect usage - the **Sad Path**.

Sad Path is really all about helping an end user have a better experience within the application.  While we can not anticipate *every* way a user might break the appropriate flow of the application, there are some areas where we can confidently say will be sticking points for users, and we can build sad path feedback around these areas.

Sad Path testing gives us an opportunity to improve an end-users experience by intentionally building in some application feedback to help guide a user to the correct use of the app.  For example, when a user is creating a new resource, they may not know intuitively which of the resources attributes are necessary for that record to be saved in the database.  Rather than letting the application crash in the case of a user trying to create a resource without the required information, we can build a Sad Path that will help guide them through the flow of the creation process.


To illustrate this concept, let's implement the following user story in our Set List app:

```
As a Visitor
I visit the new artist page
And click 'Create Artist' without filling in a name
Then I see a message telling me that I am missing required information
And I still see the new artist form
```

Before jumping in to TDD, let's check out this functionality as a user would see it by spinning up our server locally and walking through the user story.  What happened?  Did we create an artist? Did something go wrong?  At this point, as a user, it is difficult to tell what happened.  The user sees no error (the app didn't crash), but also doesn't see any indication that they may have done anything wrong.

Let's update our existing test for artist creation to include this corresponding test:

```ruby
# spec/features/artist/new_spec.rb
require 'rails_helper'

RSpec.describe 'New Artist' do
  describe 'As a visitor' do
    describe 'When I visit the new artist form by clicking a link on the index' do
      it 'I can create a new artist' do
        ...
      end

      it 'I can not create an artist without a name' do
        visit new_artist_path

        click_on 'Create Artist'

        expect(page).to have_content("Artist not created: Required information missing.")
        expect(page).to have_button('Create Artist')
      end
    end
  end
end
```
Use `binding.pry` in you Artists Controller see what is going on when we try to create an artist without a name:

```ruby
#app/controllers/artists_controller.rb

class ArtistsController < ApplicationController

  ...

  def create
    binding.pry
    Artist.create(artist_params)
    redirect_to '/artists'
  end

  ...

  private

  def artist_params
    params.permit(:name)
  end
end
```

If we run this new test, we can see the output of trying to create an artist without a name:

```
9: def create
=> 10:   binding.pry
11:   Artist.create(artist_params)
12:   redirect_to '/artists'
13: end

[1] pry(#<ArtistsController>)> play -l 11
=> #<Artist:0x007fc9f512c480 id: nil, name: "">
```

The create method gave us a return value, but the artist object it returned does not have an id - indicating that the artist was not saved in the database.  Why was the artist not saved?  Take a look back at the Artist model and see if you can spot what is causing the artist to not be saved.

Now that we are writing tests for our Sad Path, using `.create` isn't really the best choice.  What we would like is to be able to send the user some feedback if the record is not saved in the database; so, let's use a combination of `.new` and `.save`.

```ruby
class ArtistsController < ApplicationController

  ...

  def create
    artist = Artist.new(artist_params)
    binding.pry
    artist.save
    redirect_to '/artists'
  end

  ...

  private

  def artist_params
    params.permit(:name)
  end
end
```

Now, what happens when we call `artist.save` - a boolean!  Great, we can use this to control two paths through artist creation - one successful, one not so much.

```ruby
class ArtistsController < ApplicationController

  ...

  def create
    artist = Artist.new(artist_params)
    if artist.save
      redirect_to '/artists'
    else
      flash[:notice] = "Artist not created: Required information missing."
      render :new
    end
  end

  ...

  private

  def artist_params
    params.permit(:name)
  end
end
```

Let's take a quick moment to talk about **flash** messages.  flash is an object that Rails gives us to help us send information back to a client that will be displayed to a user.  Taking a look at how the flash message is created, what data structure does it look like?  Just like sessions and params, the flash object acts just like a ruby hash!

But, just because we created the flash, doesn't mean a user will automatically see it - we will need to tell our views to display the flash information:

`app/views/layouts/application.html.erb`
```html
<!DOCTYPE html>
<html>
  <head>
    <title>SetList</title>
    <%= csrf_meta_tags %>
    <%= stylesheet_link_tag "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"%>
    <%= stylesheet_link_tag    'application', media: 'all' %>
    <%= javascript_include_tag 'application' %>
  </head>

  <body>
    <nav class="nav">
      <a class="nav-link active" href="/artists">Artists</a>
      <a class="nav-link active">Cart: <%= cart.total %></a>
    </nav>

    <% flash.each do |type, message| %>
      <p><%= message %></p>
    <% end %>

    <%= yield %>
  </body>
</html>
```

Since our flash object is a collection of key/value pairs, we can iterate over any flashes that may exist, and display their message to a user!

Now, let's jump back to our artists controller - what's the deal with `render :new`?  We can use the `render` method anytime we want to override the default view in a rails controller action.  In this case, when an artist is not created, we want to respond to the client with the new form, rather than telling it to redirect to another action.

## Checks for Understanding

1. What is an example of a Sad Path - how does it differ from a Happy Path?
1. When we create a flash message, what changes do we need to make in our views?
