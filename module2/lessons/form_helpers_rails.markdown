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
  * create a new movie
  * field to enter title  
  * field to enter description

### Setup

* Open up a working version of `movie_mania`.
* **Get familiar with the `/new` route.** What functionality is there?

### User Story

1. `As a user, when I visit "/directors/new" , I see a form where I can create a new director`
2. `When I fill in name and click "Create Director", I am taken to the director that I just created's show page`

### Tests

- First things first, let's run our test suite since we added our Directors table. Why isn't it passing?
- Our movies now require a director. Lets go into our test suite and add a director to our movies.

```ruby
  director = Director.create(name: "Sal Espinosa")
  movie = Movie.create(title: "Awesome Sauce", description: "NOT something made up!", director: director)
```

Now that we have fixed those errors, lets add a new test.  
`touch spec/features/user_creates_a_new_movie_spec.rb`

#### New Director Test

```ruby

visit "/directors/new"

fill_in "director[name]", with: "Sal Espinosa"

click_on "Create Director"

expect(current_path).to eq("/directors/#{Director.last.id}")
expect(page).to have_content("Sal Espinosa")
```

### Code Along

Let's run the test and see what happens:

```bash
ActionController::RoutingError:
       No route matches [GET] "/directors/new"
```

So we need to add the route, in fact, lets open up all our directors resources:

```ruby
  #routes.rb
  resources :movies
  resources :directors
```

Now if we run RSpec again, we get a different error:

```bash
 # ------------------
     # --- Caused by: ---
     # NameError:
     #   uninitialized constant DirectorsController
     #   /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/rack-2.0.3/lib/rack/etag.rb:25:in `call'
```

This is telling us that we need a DirectorsController, let's go make that.  
`touch app/controllers/directors_controller.rb`

```ruby
#directors_controller.rb

class DirectorsController < ApplicationController

end
```
Run RSpec again, and we have a new error.

```bash
The action 'new' could not be found for DirectorsController
```

Adding a `new` method in our DirectorsController should fix this!

```ruby
#controllers/directors_controller.rb

class DirectorsController < ApplicationController
  def new

  end
end
```

We get that funny templating error when we run our tests again:

```bash
DirectorsController#new is missing a template for this request format and variant.

request.formats: ["text/html"]
request.variant: []

NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

Clearly (NOT!), we need to add the new html/erb template:  

```
mkdir app/views/directors
touch app/views/directors/new.html.erb
```

```html
<!-- #views/directors/new.html.erb -->

  <%= form_for Director.new do |f| %>
    <%= f.label :name %>
    <%= f.text_field :name %>
    <%= f.submit %>
  <% end %>
```

* What is `form_for`?
  - A form helper: Form helpers are designed to make working with models much easier compared to using just standard HTML elements by providing a set of methods for creating forms based on your models. This helper generates the HTML for forms, providing a method for each sort of input (From the [rails documentation](http://api.rubyonrails.org/v5.1/classes/ActionView/Helpers/FormHelper.html).)
* Why do we need a new `Director` object defined at our route? Let's change that to `@director` and define `@director` in our controller:

```ruby
  def new
    @director = Director.new
  end
```

- A form_for is this: `<%= form_for @post, :as => :post, :url => posts_path, :html => { :class => "new_post", :id => "new_post" } do |f| %>`
- What is all this??
* How does this form know where to submit to?
  - It is using the instance variable to determine whether it is a form for a new object or to edit an object. If the object has a value i.e. `Director.find(params[:id])` then rails knows that we are looking to edit a resource. If the instance variable holds no information, rails interprets that as wanting to create a new resource. Andddddd the `form_for` line tells us the url (which we can also set manually if we want)
  - :as => :post, creates the nested names such as name="post[title]"
  - :url => posts_path tells rails which route the request is being sent to
  - :html {:class => "new_post", :id => "new_post} are an automatically generated class and id, the names come from the new route and the :as attribute
  - Based on the above, the submit button will be rendered to reflect the form it is on. If it is a new form, it says "Create Resource" and if edit, "Update Resource". We can change that by adding a string to the `f.submit` line.
  - Notice that form_for is a method, we pass it some arguments (a bunch of them in an options hash) and then pass it a block. `f` is a block parameter that we then use throughout the rest of the block.

By creating this form, we should now be further along in our errors:

```bash
The action 'create' could not be found for MoviesController
```

```ruby
#controllers/directors_controller.rb

class DirectorsController < ApplicationController
  def new
    @director = Director.new
  end

  def create
    binding.pry
  end
end
```

What do we have access to?? PARAMS!!!!

But there is some other junk in there too, how can we separate out the things we need and make sure that only the attributes we want are present?

- Strong Parameters
  - BUT WHYYYYY - Presumes that no attributes are accessible unless specified in the model. Protects against security threats.
  - Since this method is not called from any external object, let's make it private

```ruby
  class DirectorsController < ApplicationController
    def new
      @director = Director.new
    end

    def create
      director = Director.new(director_params)
      if director.save
        redirect_to "/directors/#{director.id}"
      else
        render :new
      end
    end

    private

    def director_params
      params.require(:director).permit(:name)
    end
  end
  ```

  - `params.require(:director).permit(:name)` - when the params come through, we are going to require that the key of `director` is present and only create the object if we see that key. When we see that key, we now are going to only recognize attributes with the nested keys of `:name`.

### `form_for` vs `form_tag`

Turn and talk with your neighbor to discuss the following.

*   What is `form_for`? How is this different from a [`form_tag`](http://api.rubyonrails.org/v5.1/classes/ActionView/Helpers/FormTagHelper.html#method-i-form_tag)?
  - Form_for deals with model attributes while form_tag does not.
*   When would we want to use one over the other?
  - A form that isn't related to a model would be a good place to use a form_tag.

### Exercise: Finish Create Directors and Add Create Actors

- You're likely still getting a failing test from our user story. Finish out the actions/view combo to get a passing test.
- We also have Actors. Add the functionality for a user to add a new actor. Don't forget - you'll need two routes for this!


## WrapUp
Create a Venn Diagram comparing a form made in raw HTML and one made with a Rails form_helper