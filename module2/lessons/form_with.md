---
layout: page
title: Rails form_with
---

## Warm Up

- Thinking about our Set List application, what is the structure of the forms we use to create and edit artists? (Share your screen and put them side by side)
    - How do we tell our forms the path and verb it should use when the form is submitted?
    - What connection exists between the form and the objects we are creating or updating?

## form_with

### form_with syntax

**form_with** is a Rails form helper, similar to `form_tag` - it is a method that allows us to use ruby code to build an HTML form.  The biggest difference between the two is that `form_with` generally binds the form to a model object - it uses an object to make some educated guesses about how the HTML form should be built.  If we were going to use `form_with` to create a Dog with name, breed, and age attributes, our form would look something like this:

```html
<!-- app/views/dogs/new.html.erb -->
<%= form_with model: Dog.new do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.label :breed %>
  <%= f.text_field :breed %>

  <%= f.label :age %>
  <%= f.number_field :age %>

  <%= f.submit %>
<% end %>
```

In this example, we are binding our form to a new Dog object `Dog.new`.  While this works from a functionality standpoint, we don't ever want to be reaching from our views into our database, so, we would want our controller to send this object to our views:

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

### Strong Params with form_with

Another difference between `form_tag` and `form_with` is how the params gets built when the form is submitted and handled through Rails. With `form_tag`,  all of the fields are inserted directly into the params hash - the params looks like an un-nested hash; in this format, we use `params.permit(:attribute1, :attribute2)` in our strong params method.  

With `form_with`, the form fields are inserted into the params in a nested hash - the key is the name of the resource, and it points to a collection of key/value pairs representing the field labels and user inputs.  With this nested hash, our strong params will need some additional instructions:

```ruby
def dog_params
  params.require(:dog).permit(:name, :breed, :age)
end
```

### Practice

In our Set List app or in your project, update a few forms to use the `form_with` instead of `form_tag` - see if you can keep using partials! Can you create another partial using form_with?

## Checks for Understanding

* How does `form_with` know which verb/path combination to submit to?
* Could we use `form_with` for a log in form?
* What is a benefit of using `form_with` over `form_tag`? Are there any drawbacks?
