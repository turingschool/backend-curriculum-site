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

* Open up a working version of `set_list`.
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
- Our songs now require a artist. Lets go into our test suite and add a artist to our songs.

```ruby
  artist = Artist.create(name: "Journey")
  song = Song.create(title: "Don't Stop Believin'", length: 231, play_count: 0, artist: artist)
```

Now that we have fixed those errors, lets add a new test.  
`touch spec/features/user_creates_a_new_artist_spec.rb`

#### New Artist Test

```ruby
artist_name = "Journey"

visit "/artists/new"

fill_in "artist[name]", with: artist_name
click_on "Create Artist"

expect(page).to have_content(artist_name)
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
 # ------------------
     # --- Caused by: ---
     # NameError:
     #   uninitialized constant ArtistsController
     #   /Users/ian/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/etag.rb:25:in `call'
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
    <%= f.label :name %>
    <%= f.text_field :name %>
    <%= f.submit %>
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

- A `form_for` is this: `<%= form_for @post, :as => :post, :url => posts_path, :html => { :class => "new_post", :id => "new_post" } do |f| %>`
- What is all this??
* How does this form know where to submit to?
  - It is using the instance variable to determine whether it is a form for a new object or to edit an object.
  - If the object has a value i.e. `Artist.find(params[:id])` then Rails knows that we are looking to edit a resource and pre-populated the form with all of that object's data. (this is super handy!)
  - If the instance variable holds no information, Rails interprets that as wanting to create a new resource.
  - Finally, the `form_for` line tells us the url (which we can also set manually if we want to through an options hash)
  - `:as => :post`, creates the nested names such as `name="post[title]"`
  - `:url => posts_path` tells Rails which route the request is being sent to
  - `:html {:class => "new_post", :id => "new_post}` are an automatically-generated class and id, the names come from the new route and the `:as` attribute. You can overide the default with this `:html` hash
  - Based on the above, the submit button will be rendered with text reflecting the form's intention.
    - If it is a new form, it says "Create (Resource)"
    - If we're editing an existing resource, the button says "Update Resource".
    - We can change that by adding a string to the `f.submit` line.
  - Notice that `form_for` is a method, we pass it some arguments (a bunch of them in an options hash) and then pass it a block of code. `f` is a block parameter that we then use throughout the rest of the block.

By creating this form, we should now be further along in our errors:

```bash
The action 'create' could not be found for SongsController
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

### `form_for` vs `form_tag`

**Turn and talk** 

With your neighbor discuss the following.

*   What is `form_for`? How is this different from a [`form_tag`](http://api.rubyonrails.org/v5.1/classes/ActionView/Helpers/FormTagHelper.html#method-i-form_tag)?
  - Form_for deals with model/resource attributes while form_tag does not.
*   When would we want to use one over the other?
  - A form that isn't related to a model/resource would be a good place to use a form_tag.

### Exercise: Finish Create Artists and Add Create Playlists

- You're likely still getting a failing test from our last user story. Finish out the actions/view combo to get a passing test.
- We also have Playlists. Add the functionality for a user to add a new playlist. Don't forget - you'll need two routes for this!


## WrapUp

Create a Venn Diagram comparing a form made in raw HTML and one made with a Rails form_helper
