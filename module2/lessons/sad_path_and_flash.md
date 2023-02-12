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

## Set Up
We will start from the [sad_path_setup](https://github.com/turingschool-examples/set_list_tutorial/tree/sad_path_setup) branch of the Set List Tutorial repo.

## Warm Up
* As developers, how do we know when our application isn't working properly?
* As a user, how do we know when we have used an application in an unintended way?

## Testing the Sad Path

When writing tests for our applications, we generally want to have two types of tests:

1. Tests for the correct usage of the application - the **Happy Path**. And,
1. Tests for an incorrect usage - the **Sad Path**.

Sad Path is really all about helping an end user have a better experience within the application.  While we can not anticipate *every* way a user might break the appropriate flow of the application, there are some areas where we can confidently say will be sticking points for users, and we can build sad path feedback around these areas.

Sad Path testing gives us an opportunity to improve an end-users experience by intentionally building in some application feedback to help guide a user to the correct use of the app.  For example, when a user is creating a new resource, they may not know intuitively which of the resources attributes are necessary for that record to be saved in the database.  Rather than letting the application crash in the case of a user trying to create a resource without the required information, we can build a Sad Path that will help guide them through the flow of the creation process.

### Walkthrough

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
# spec/features/artists/new_spec.rb
require 'rails_helper'

RSpec.describe 'New Artist' do
  describe 'As a visitor' do
    describe 'When I visit the new artist form by clicking a link on the index' do
      it 'I can create a new artist' do
        ...
      end

      it 'I can not create an artist without a name' do
        visit '/artists/new'

        click_on 'Create Artist'

        expect(page).to have_content("Artist not created: Required information missing.")
        expect(page).to have_button('Create Artist')
      end
    end
  end
end
```
Use `binding.pry` in your Artists Controller to see what is going on when we try to create an artist without a name:

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

```ruby
9: def create
=> 10:   binding.pry
11:   Artist.create(artist_params)
12:   redirect_to '/artists'
13: end

[1] pry(#<ArtistsController>)> play -l 11
=> #<Artist:0x007fc9f512c480 id: nil, name: "">
```

`play -l <line_number>` is a shortcut in pry to run a line of code. In this case, we're running `Artist.create(artist_params)` in pry by telling it to run line 11. The create method gave us a return value, but the artist object it returned does not have an id - indicating that the artist was not saved in the database. 

<section class="call-to-action">
  <h3>Question for Review:</h3>
  <p>Why was the artist not saved?  Take a look back at the Artist model and see if you can spot what is causing the artist to not be saved.</p>
</section>


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

Now, what is returned when we call `artist.save`? A boolean!  Great, we can use this to control two paths through artist creation - one successful (happy path), one unsuccessful (sad path).

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

### `flash` Objects

Let's take a quick moment to talk about **flash** messages.  `flash` is an object that Rails gives us to help us send information back to a client that will be displayed to a user.  Taking a look at how the flash message is created, what data structure does it look like?  Just like params, the flash object acts just like a ruby hash!

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
    <% flash.each do |type, message| %>
      <p><%= message %></p>
    <% end %>

    <%= yield %>
  </body>
</html>
```

Since our flash object is a collection of key/value pairs, we can iterate over any flashes that may exist, and display their message to a user!

### The `render` method

Now, let's jump back to our artists controller - what's the deal with `render :new`?  We can use the `render` method anytime we want to override the default view in a rails controller action.  In this case, when an artist is not created, we want to respond to the client with the new form, rather than telling it to redirect to another action.

## You Do
- Implement a sad path in SetList that displays a flash message to a user when they use the Edit Artist form, following this user story: 

```
As a visitor
When I visit an artist's Edit page
And I leave the name field empty and click the "Edit Artist" button
Then I see a message telling me that I am missing required information
And I still see the Edit Artist form for that artist.

```

## Checks for Understanding

1. What is an example of a Sad Path - how does it differ from a Happy Path?
1. When we create a flash message, what changes do we need to make in our views?
1. How do you override the default view in Rails?

## Further Exploration
Here are some ideas for extra practice on validations & sad path testing: 

- Write a test that uses a `within` block to test that a flash message is appearing when a user goes down a sad path in your project.
- Use validations to display the errors attached to the model for a specific attribute in your flash message.
- Think about how you could DRY this code up.
- Read the [Guides on flash messages](https://guides.rubyonrails.org/action_controller_overview.html#the-flash)
- Read [this blog post on the flash](https://www.rubyguides.com/2019/11/rails-flash-messages/)
- Style your flash using CSS. 
