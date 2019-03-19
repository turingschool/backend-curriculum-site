---
layout: page
title: Forms in Rails
---

## Learning Goals

* Explain why we use/need forms
* Understand the role of `form_for`
* Construct a basic form with the help of documentation/references
* Practice building the C portion of a CRUD application with a form

## Vocab
* form_for
* params
* strong params

## WarmUp
* What is the syntax for a form in raw html for the following constraints
  * create a new song
  * field to enter title  
  * field to enter song length
  * field to enter play count
  * labels for each field

### Setup

* Open up a working version of `jukebox`.
* **Get familiar with the `/new` route.** What functionality is there?

### User Story

1. ```
    As a user,
    When I visit "/artists/new"
    Then I see a form where I can create a new artist`
    ```

2. ```
    As a user,
    When I visit "/artists/new"
    And I fill in name
    And I click "Create Artist"
    Then I am taken to the show page for the new artist`
    ```

### Tests

- First things first, let's run our test suite since we added our Artists table. Why isn't it passing?
- Answer: Our songs now require a artist, we can't create songs by themselves any more.
- Lets go into our test suite and add a artist to our songs in our test setup.

```ruby
  journey = Artist.create(name: "Journey")
  song = journey.songs.create(title: "Don't Stop Believin'", length: 231, play_count: 0)
```

Now that we have fixed those errors, lets add a new test:
`touch spec/features/artists/new_spec.rb`

#### New Artist Test

```ruby
# put this content into a new test, don't forget to do your describes, etc
new_artist = "Journey"

visit "/artists/new"

fill_in "artist[name]", with: new_artist
click_on "Create Artist"

expect(page).to have_content(new_artist)
```

### Code Along

Let's run the test and see what happens:

```bash
ActionController::RoutingError:
       No route matches [GET] "/artists/new"
```

So we need to add the route, in fact, lets open up all our artists resources:

```ruby
  #routes.rb
  resources :songs
  resources :artists
```

Now if we run RSpec again, we get a different error:

```bash
     # NameError:
     #   uninitialized constant ArtistsController
```

This is telling us that we need a ArtistsController, let's go make that.  
`touch app/controllers/artists_controller.rb`

```ruby
# app/controllers/artists_controller.rb

class ArtistsController < ApplicationController

end
```
Run RSpec again, and we have a new error.

```bash
The action 'new' could not be found for ArtistsController
```

Adding a `new` method in our ArtistsController should fix this!

```ruby
# app/controllers/artists_controller.rb

class ArtistsController < ApplicationController
  def new

  end
end
```

We get that funny templating error when we run our tests again:

```bash
ArtistsController#new is missing a template for this request format and variant.

request.formats: ["text/html"]
request.variant: []

NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

Clearly (NOT!), we need to add the new html/erb template:  

```
mkdir app/views/artists
touch app/views/artists/new.html.erb
```

```html
<!-- #views/artists/new.html.erb -->

  <%= form_for Artist.new do |f| %>
    <p><%= f.label :name %><br/>
    <%= f.text_field :name %></p>
    <p><%= f.submit %></p>
  <% end %>
```

* What is `form_for`?
  - A form helper: Form helpers are designed to make working with models much easier compared to using just standard HTML elements by providing a set of methods for creating forms based on your models. This helper generates the HTML for forms, providing a method for each sort of input (From the [rails documentation](http://api.rubyonrails.org/v5.1/classes/ActionView/Helpers/FormHelper.html).)

* Why do we need a new `Artist` object defined at our form's route? Why are we calling model code (`.new`) in our VIEW?! Let's change that to `@artist` and define `@artist` in our controller:

```ruby
  def new
    @artist = Artist.new
  end
```

`form_for` figures out where the browser should submit the form, and which HTTP verb to use, based on the object we pass:

* if the object does not have an `id`:
  * form_form will use a POST verb and the action path will be `/resources`
  * the form will start out empty
  * the submit button will say 'Create (resource name)'
  * the action method we need to process the form data will be called `create`
* if the object has an `id`:
  * form_for will use a PUT verb and the action path will be something like `/resources/:id`
  * the form will pre-populate the fields with the data from the database
  * the submit button will say 'Update (resource name)'
  * the action method we need to to process the form data will be called `update`

By creating this form, we should now be further along in our errors:

```bash
The action 'create' could not be found for ArtistsController
```

```ruby
#controllers/artists_controller.rb

class ArtistsController < ApplicationController
  def new
    @artist = Artist.new
  end

  def create
    binding.pry
  end
end
```

What do we have access to?? What should we check when we aren't sure? PARAMS!!!!

But there is some other junk in there too, how can we separate out the things we need and make sure that only the attributes we want are present?

- Strong Parameters
  - Protects against security threats.
  - Presumes that no attributes are accessible unless specified in the model.
  - Since this method is not called from any external object, let's make it `private`

```ruby
  class ArtistsController < ApplicationController
    def new
      @artist = Artist.new
    end

    def create
      artist = Artist.new(artist_params)
      if artist.save
        # everything saved properly
        redirect_to "/artists/#{artist.id}"
      else
        # we were unable to save, so show the user the `new` form again
        # remember to write a test for this !!!
        render :new
      end
    end

    private

    def artist_params
      params.require(:artist).permit(:name)
    end
  end
  ```

  - `params.require(:artist).permit(:name)` - when the params come through, we are going to require that the key of `artist` is present, and ONLY create the object if we see that key. When we see that key, we now are going to only allow ("permit") the attributes that we explicitly list there, like `:name`.


### Exercise: Finish Create Artists and Add Create Playlists

- You're likely still getting a failing test from our last user story. Finish out the actions/view combo to get a passing test.
- Add the functionality for a user to add a new playlist name in a form, including routes
