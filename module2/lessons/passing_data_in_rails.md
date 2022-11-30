---
layout: page
title: Passing Data in Rails
length: 180
---

## Learning Goals
* Understand how a user specifies a particular resource for a show page
* Implement `form_with` to create a new resource
* Implement `form_with` to update a new resource
* Implement `link_to` to destroy a resource
* Define Query Parameters

## Vocabulary
* `form_with`
* `link_to`
* query parameters

## WarmUp

* With a partner, complete the following User Story:

```
As a visitor
When I visit ‘/artists’
I see a list of all artist names
```

## Setup

This lesson builds off of the [Model Testing Lesson](./model_testing). You can find the completed code from this lesson on the `model_testing` branch of [this repo](https://github.com/turingschool-examples/set_list/tree/model_testing)

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
When I visit the artists index
And click on 'New Artist'
Then my current path is '/artists/new'
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
    describe 'When I visit the new artist form by clicking a link on the index' do
      it 'I can create a new artist' do
        visit '/artists'

        click_link 'New Artist'

        expect(current_path).to eq('/artists/new')

        fill_in 'Name', with: 'Megan'
        click_on 'Create Artist'

        expect(current_path).to eq("/artists")
        expect(page).to have_content('Megan')
      end
    end
  end
end
```

Use TDD and what we know about Rails so far to TDD until you reach the following error:

```
Failure/Error: click_link 'New Artist'

Capybara::ElementNotFound:
  Unable to find link "New Artist"
# ./spec/features/artists/new_spec.rb:9:in `block (4 levels) in <top (required)>'
```

What is this error telling us?  We don't have a link on our index page!  Let's go ahead and include that link in our `views/artists/index.html.erb`:

```erb
<%= link_to 'New Artist', '/artists/new' %>
```

**link_to** is a method that Rails gives us, which we can use to create html links.  link_to takes 2 or more arguments; the first is the label the link should have (what a user sees), and the second is the path the link should request.  A link defaults to use the verb (or method) `GET`.

Run the tests again, and use TDD and what we know so far to implement code until you reach the following error:

```
1) New Artist As a visitor When I visit the new artist form I can create a new artist
   Failure/Error: fill_in 'Name', with: 'Megan'

   Capybara::ElementNotFound:
     Unable to find field "Name" that is not disabled
   # ./spec/features/artists/new_spec.rb:13:in `block (4 levels) in <top (required)>'
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

We could use this same form structure to build out our new artist form; but, wouldn't it be nice if rails gave us some help so we didn't have to build this form by hand?  The good news is, it does!  Rails gives us `form_with` to help us build forms:


```erb
<%= form_with url: "/artists", method: :post do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <%= form.submit 'Create Artist' %>
<% end %>
```

Much simpler, right? But do we still have all the information we need? Let's break it down, line by line.

The first line in our HTML form for tasks `<form action="/tasks" method="post">` tells the form the verb and path it should request when the form is submitted.  In `form_with`, we use the `url:` and `method:` keyword arguments to tell the form what verb/path to use.

The next line, `<input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">`, is a security setting that Rails requires on all forms, and `form_with` gives us this out of the box.

The next three lines set up what a user sees in and around an input area, and the button to submit the form.  These three lines are replaced with:

```erb
<%= form.label :name %>
<%= form.text_field :name %>
<%= form.submit 'Create Artist' %>
```

Now that we have a better understanding of `form_with`, let's run our test and we should be getting the following error:

```
Failure/Error: click_on 'Create Artist'

ActionController::RoutingError:
  No route matches [POST] "/artists"
# ./spec/features/songs/index_spec.rb:26:in `block (4 levels) in <top (required)>'
```

What does this mean?  It means that we are trying to submit a form to a route that doesn't exist. So, let's go make that route:

```ruby
Rails.application.routes.draw do

  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#show'
  get '/artists', to: 'artists#index'
  get '/artists/new', to: 'artists#new'
  post '/artists', to: 'artists#create'
end
```

Now, let's add the `create` action to our controller, and put a pry in that method.

```ruby
class ArtistsController < ApplicationController
  def index
  end

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
    Artist.create(name: params[:name])
  end
end
```

Go ahead and run the test again, and let's see if we've got a passing test. Not yet - we should get an error `Unable to find xpath "/html"`. This is capybara telling us that it's not seeing any HTML. This is because we need to tell our create action where to redirect to after creating the artist!  Based on our User Story, we want it to redirect to the artists index page, so let's add the following to make that happen:

```ruby
class ArtistsController < ApplicationController
  def new
  end

  def create
    Artist.create(name: params[:name])
    redirect_to '/artists'
  end
end
```

And now our test should be passing!

Let's do a little bit of refactoring before we call this feature complete. As an experiment try to replace the line in the controller `Artist.create(name: params[:name])` with `Artist.create(params)`. We should get a `ForbiddenAttributesError`. Take a closer look at that `params` object, using a `binding.pry` - at the very end, you will see `permitted: false`.  This means that we cannot use the params 'hash' directly to create or update records in our database. Rails is trying to protect us from malicious users by not allowing us to drop our all of our params directly into a new object that will be saved into our database, so we need to be explicit about which params we are accepting. The syntax `Artist.create(name: params[:name])` will do that, but as our objects get more complex this syntax will get very verbose. Imagine if an artist also had a hometown, years active, genre, etc. The syntax would look like:

```ruby
Artist.create(name: params[:name], hometown: params[:hometown], years_active: params[:years_active], genre: params[:genre])
```

Rather than this long syntax, rails gives us a much nicer way to do this called **strong params**:

```ruby
class ArtistsController < ApplicationController
  def new
  end

  def create
    Artist.create(artist_params)
    redirect_to '/artists'
  end

  private
  def artist_params
    params.permit(:name)
  end
end
```

Using strong params, we create a new method that will pull out the parameters we need from our params hash. Put a `pry` into the `create` action and call this new `artist_params` method. What does this return? How does this compare with the `params` object?


We are getting so close!  Run our tests again, and you will see that capybara is unable to find that new artist's information on the index page.  Let's make sure we are displaying that information:

```erb
<%= link_to 'New Artist', '/artists/new' %>

<% @artists.each do |artist| %>
  <h2><%= artist.name %></h2>
<% end %>
```

And since we are iterating over `@artists`, we will need to define that in our `artists#index` action as `@artists = Artist.all`

Your test should now be passing - you have successfully created a new object with `form_with`!

## Destroying an Artist

Now that we have used a form to manipulate data in our database, let's take a look at how a link or button could be used to manipulate data.  To illustrate this, let's implement a button that will allow a user to destroy an artist from the database.

```
As a visitor
When I visit the artists index page
And click a button 'Delete' next to an artist
Then I am redirected back to the artists index page
And I no longer see that artist
```

```ruby
require 'rails_helper'

RSpec.describe 'As a Visitor' do
  it 'I can delete an artist' do
    talking_heads = Artist.create(name: 'Talking Heads')

    visit '/artists'

    click_button 'Delete'

    expect(current_path).to eq('/artists')
    expect(page).to_not have_content(talking_heads.name)
    expect(page).to_not have_button('Delete')
  end
end
```

What do you think your first error is going to be?

Run your tests, were you right?  Capybara can't find a button called 'Delete'.  Rails gives us a method for creating buttons - **button_to**.  button_to works just like link_to, with one big difference; the default verb (or method) for button_to, is `POST`.  So, in order to be more explicit with what we want our button to do, we will want to override the default method to `DELETE` (DELETE is the common verb used when we need to Destroy something from a database).


```erb
<%= link_to 'New Artist', '/artists/new' %>

<% @artists.each do |artist| %>
  <h2><%= artist.name %></h2>
  <%= button_to 'Delete', "/artists/#{artist.id}", method: :delete %>
<% end %>
```

Now, we have a button that indicates which artist we are going to delete by giving our path an artist id.

Can you guess what our next error is going to be?

Run your tests, and you should see something like this:

Failure/Error: click_button 'Delete'

```
ActionController::RoutingError:
  No route matches [DELETE] "/artists/34"
# ./spec/features/artists/delete_spec.rb:9:in `block (2 levels) in <top (required)>'
```

No problem - we have seen errors like this before; our application doesn't know how to handle this request, so let's update our routes.rb:

```ruby
# config/routes.rb
Rails.application.routes.draw do

  get '/songs', to: 'songs#index'
  get '/songs/:id', to: 'songs#show'
  get '/artists', to: 'artists#index'
  get '/artists/new', to: 'artists#new'
  post '/artists', to: 'artists#create'
  delete '/artists/:id', to: 'artists#destroy'
end
```

Now, we have a route which will respond to a `DELETE` with the path of `'/artists/2' or 'artists/45'` where 2 and 45 are ids of existing artists.

Finally, our test will tell us to go create that `destroy` action on our artists controller:

```ruby
# app/controllers/artists_controller.rb

class ArtistsController < ApplicationController
  def index
  end

  def new
  end

  def create
    artist = Artist.create(artist_params)
    redirect_to '/artists'
  end

  def destroy
    Artist.destroy(params[:id])
    redirect_to '/artists'
  end

  private
  def artist_params
    params.permit(:name)
  end
end
```

Now, we should have a passing test!


## Edit Artist Form

Now that we have created an artist with `form_with`, and used a button to send a `DELETE` request (overriding its default method), we are ready to tackle updating an artist using `form_with`.  Thinking back to the explanation of form_with, we know will have to specify the HTTP verb, and when updating something in our database, the common verb that we use is `PATCH`.  Keep this in mind as you build out the following user story and test:

```
As a visitor
When I visit the artists index
And click 'Edit' next to an artist
Then I am taken to an edit artist form
When I enter a new name for the artist
And click a button to 'Update Artist'
Then I am redirected back to the artists index
And I see the updated name
```

```ruby
# spec/features/artists/edit_spec.rb

require 'rails_helper'

RSpec.describe 'New Artist' do
  describe 'As a visitor' do
    describe 'When I visit the artists index' do
      it 'I can update an artist' do
        beatles = Artist.create(name: 'Beatles')

        visit '/artists'

        click_link 'Edit'

        expect(current_path).to eq("/artists/#{beatles.id}/edit")

        fill_in 'Name', with: 'The Beatles'
        click_on 'Update Artist'

        expect(current_path).to eq("/artists")
        expect(page).to have_content('The Beatles')
      end
    end
  end
end
```

See if you can get this test passing without looking at the hint below.

<br>
<br>
<br>


Hint: The first line of your form will likely include something like this `form_with url: "/artists/#{@artist.id}", method: :patch`

If you haven't quite been able to make this update work, check in with your instructor's repo later today - we will post a solution for updating an artist.

## Query Params

There is one other way that users can send information in that we can access through `params` and that is with **query params**.  In the following URL `http://www.setlist.com/artists?age=32`, `age=32` are the **query params**, and the key value pair contained there (`{age: 32}`) will be included in the `params` for that request.  

To see this in action, put a pry in your `songs#index` action, spin up your SetList with `rails s` and navigate to `http://localhost:3000/songs?artist=prince`. Open your terminal, and you should be in a pry session with access to the `params` object:

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
1. How does `form_with` know what method/path combination to use when submitted?
1. What is a query parameter, and how do we identify one within a URL?
