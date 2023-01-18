---
layout: page
title: Rails form_with
---

## Warm Up

We'll start today from the [Set List main branch](https://github.com/turingschool-examples/set_list_tutorial)

- Thinking about our Set List application, what is the structure of the forms we use to create and update artists? (Share your screen and put them side by side)
    - How do we tell our forms the path and verb it should use when the form is submitted?
    - What connection exists between the form and the objects we are creating or updating?

## form_with

### form_with syntax

**form_with** is a Rails form helper, similar to `form_tag` and `form_for` which have both been soft deprecated. It is a form helper that allows us to use ruby code to build an HTML form.  `form_with` can bind a form to a model object or it can create a simple form that does not require a model. It uses a number of helper options to make some educated guesses about how the HTML form should be built.

If we were going to use `form_with` without a model to create a simple search form then we could do it like so:

```html
<%= form_with(url: "/search", method: "get") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %>
<% end %>
```

The resulting html:

```html
<form accept-charset="UTF-8" action="/search" data-remote="true" method="get">
  <label for="q">Search for:</label>
  <input id="q" name="q" type="text" />
  <input name="commit" type="submit" value="Search" data-disable-with="Search" />
</form>
```

For every form `input`, an ID attribute is generated from its name ("q" in above example). These IDs can be very useful for CSS styling or manipulation of form controls with JavaScript.


If we were going to use `form_with` to create a Dog object with name, breed, and age attributes, our form would look something like this:

```html
<!-- app/views/dogs/new.html.erb -->
<%= form_with model: Dog.new, local: true do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.label :breed %>
  <%= f.text_field :breed %>

  <%= f.label :age %>
  <%= f.number_field :age %>

  <%= f.submit %>
<% end %>
```

Notice the **`local: true`** option.
**You must include this option for your form to work properly with the `form_with` helper**

This helper is set to false by default when using the `form_with` helper. This is because `form_with` was built with performance improvements in mind. Within professional rails applications, this helper defaults to taking advantage of AJAX (Asynchronous JavaScript And XML) to send requests. We won't dive into the advantages and disadvantages of this just yet, but know that this option expects a JavaScript response as opposed to an HTML response. We aren't implementing JavaScript in our applications, so we want our request to be sent expecting an HTML response.

In the above example, we are binding our form to a new Dog object `Dog.new`.  While this works from a functionality standpoint, we don't ever want to be reaching from our views into our database, so, we would want our controller to send this object to our views:

```ruby
# app/controllers/dogs_controller.rb

class DogsController
  def new
    @dog = Dog.new
  end
end
```

```html
<!-- app/views/dogs/new.html.erb -->
<%= form_with model: @dog, class: "doggos_form" do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.label :breed %>
  <%= f.text_field :breed %>

  <%= f.label :age %>
  <%= f.number_field :age %>

  <%= f.submit %>
<% end %>
```

`form_with` figures out where the browser should submit the form, and which HTTP verb to use, based on the object we pass:

* if the object does not have an `id`:
  * form_with will use a POST verb and the action path will be `/resources`
  * the form will start out empty
  * the submit button will say 'Create (resource name)'
  * the action method we need to process the form data will be called `create`
* if the object has an `id`:
  * form_with will use a PUT verb and the action path will be something like `/resources/:id`
  * the form will pre-populate the fields with the data from the database
  * the submit button will say 'Update (resource name)'
  * the action method we need to to process the form data will be called `update`

  From the [docs](https://guides.rubyonrails.org/form_helpers.html):
  * @dog is the actual object being edited or created
  * There is a single hash of options. HTML options (except id and class) are passed in the :html hash
  * The form_with method yields a form builder object (the f variable)
  * If you wish to direct your form request to a particular URL, you would use form_with url: my_nifty_url_path instead. To see more in depth options on what form_with accepts be sure to check out the [API documentation](https://api.rubyonrails.org/v6.0.3.4/classes/ActionView/Helpers/FormHelper.html#method-i-form_with).
  * Methods to create form controls are called on the form builder object `f`.
  * `form_with` can be used to create forms that are not tied to a model
  * We need to pass the option `local: true` in order to avoid our form being submitted using AJAX

### Strong Params with form_with

Another difference between `form_with url` and `form_with model` is how the params gets built when the form is submitted and handled through Rails. When using `url`,  all of the fields are inserted directly into the params hash - the params looks like an un-nested hash; in this format, we use `params.permit(:attribute1, :attribute2)` in our strong params method.  

With `form_with model`, the form fields are inserted into the params in a nested hash - the key is the name of the resource, and it points to a collection of key/value pairs representing the field labels and user inputs.  With this nested hash, our strong params will need some additional instructions:

```ruby
def dog_params
  params.require(:dog).permit(:name, :breed, :age)
end
```

If we aren't using strong params, then we can access our form data by calling:
```ruby
params[:dog][:name]
```

from the controller action that the form submits to.

Again, notice the nesting.


### Practice

In our Set List app: 
1. Update the Artist Edit form to use `form_with model` instead of `form_with url`. 
2. Using TDD, create a New Song form using `form_with model`. 

In your project, update a few forms to use the `form with model` instead of `form_with url` - see if you can keep using partials! 


#### Extra Practice: 

3. Using TDD, create a Edit Song form using `form_with model`. 
4. Using TDD, creaet a New Playlist form using `form_with model`. 


## Checks for Understanding

* How does `form_with model` know which verb/path combination to submit to?
* What is a benefit of using `form_with model` over `form_with url` or `form_tag`? Are there any drawbacks?
