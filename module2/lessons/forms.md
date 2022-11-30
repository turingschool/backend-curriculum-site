---
title: Forms
length: 90
tags: forms, form_with
---

## Learning Goals

* Understand how HTML forms work
* Understand how form data is passed in an HTTP Request Body
* Use view helpers to create HTML forms/buttons

## Vocabulary

* Form
* View helpers
* HTTP Request Body

## Exploration

Using the TaskManager app from the intermission work, discuss the following:

**Discussion Questions Part 1**

* What are all of the steps a user needs to follow to create a task?
* How many HTTP requests are sent during those steps?
* Which steps cause an HTTP request to be sent?

**Discussion Questions Part 2**

* Open the file `app/views/tasks/new.html.erb`
* What does each part of this file do? Specifically, discuss:
    * the `form` element
    * the `action` attribute of the `form` element
    * the `method` attribute of the `form` element
    * the `input` elements
    * the `type` attributes of the `input` elements
    * the `textarea` element
    * `<%= form_authenticity_token %>`

# Forms

Forms are used to collect user input. They can have many types of inputs including:

* Text Fields
* Number Fields
* Select Fields (drop downs)
* Check Boxes
* Radio Buttons

A form will also typically have a submit button which actually submits the form when it is clicked. In most forms, a user can also submit the form with the enter/return key on their keyboard. When the form is submitted, a new HTTP request will be sent back to our server. This HTTP Request will have:

* A **verb** that corresponds to the `method` attribute of the `form` element
* A **path** that corresponds to the `action` attribute of the `form` element
* A **body** that contains the data from the `input` elements

We've seen **verb** and **path** before. The **body** is another key part of an HTTP request. The HTTP Request body is used to send data over to a server. For example:

* If we want to create a new task, the body of the request will contain the new task's attributes
* If we want to update a task, the body of the request will contain the attributes we want to change for the task

Typically, Request Bodies are used for `POST` and `PATCH`/`PUT` requests since those indicate that the user is trying to create or update some data on our server. Requests like `GET` and `DELETE` typically do not have bodies since additional data is not needed; the server simply needs to retrieve or delete the resource specified by the **path**.

## New Artist Form

 To help illustrate this, let's add the ability for a visitor to add a new artist to our Set List app.

```
As a visitor
When I visit the artists index
And click on 'New Artist'
Then my current path is '/artists/new'
and I fill in the artist's name
Then I click 'Create Artist'
I am redirected to the artist index page
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
<%= form_with url: "/artists", method: :post, local: true do |form| %>
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
=> <ActionController::Parameters {"utf8"=>"✓", name"=>"Megan", "commit"=>"Create Artist", "controller"=>"artists", "action"=>"create"} permitted: false>
```

Our new artist information! Fantastic! When we submitted the form, the data from the inputs was sent in the HTTP Request body, and now it is being populated in `params`. We can now use that information to create a new artist in our `ArtistsController`:

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

# Buttons

Another way we can use forms is to create buttons. Think of a button as a form that only has 1 input: the submit button. Rather than the user filling in information into text boxes, drops downs, etc., a button just does whatever it is designed to do, for example, delete an artist, activate/deactivate an item, toggle a filter, etc.


## Destroying an Artist

To illustrate this, let's implement a button that will allow a user to destroy an artist from the database.

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

Let's do one more thing before we move on. Put a `save_and_open_page` inside your test so that we can view our button:

```ruby
require 'rails_helper'

RSpec.describe 'As a Visitor' do
  it 'I can delete an artist' do
    talking_heads = Artist.create(name: 'Talking Heads')

    visit '/artists'

    save_and_open_page
    click_button 'Delete'

    expect(current_path).to eq('/artists')
    expect(page).to_not have_content(talking_heads.name)
    expect(page).to_not have_button('Delete')
  end
end
```

When you run your test, this should open up the page in Google Chrome (if not, make sure that Chrome is set as your default web browser). Open the Chrome Developer Tools by double clicking the page and select the `inspect` option. You can use these tools to view the HTML that your code generated. Remember, the code we write in our view files ultimately creates an HTML file. The developer tools are very useful for viewing that resulting HTML. Find the HTML that was generated by your `button_to` view helper, and you should see that it is implemented as an HTML form.

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

1. How do HTML forms work?
1. What is an HTTP Request Body? How does it relate to forms?
1. How does `form_with` know what method/path combination to use when submitted?
1. What is a query parameter, and how do we identify one within a URL?
