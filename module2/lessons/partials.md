---
layout: page
title: Using Partials to DRY up our Views
---

## Learning Goals
- Understand how to reduce repeated View code in a Rails application
- Implement partials including View-specific data 

## Vocabulary

- render
- partial
- locals

## Set Up

We can start on this branch of our Set List Repo [here](https://github.com/turingschool-examples/set-list-7/tree/generic-start).

## Warm Up

Reflect on the following questions:

- Thinking about plain Ruby, What are some strategies we use to DRY up our code within a class?
- What about strategies to DRY up code from multiple classes (where there might be shared behavior)?

Read the following excerpts from the Rails Guides:

- The intro paragraph of [3.4 Using Partials](https://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)
- [3.4.1 Naming Partials](https://guides.rubyonrails.org/layouts_and_rendering.html#naming-partials)
- [3.4.2 Using Partials to Simplify Views](https://guides.rubyonrails.org/layouts_and_rendering.html#using-partials-to-simplify-views)

## DRYing Our Views

Often, as we build out our applications, we find ourselves using the same code in multiple view files. For example, when using forms, we generally see nearly identical code being used in `new.html.erb` and `edit.html.erb`. Another example could be some shared code in `show.html.erb` and `index.html.erb` - we might be showing much of the same information in both places. With all this repeated code, things aren't very DRY. So, how can we DRY up these views?

### Using a Partial

A **partial** is a file we can leverage to house code that is shared across multiple views. Our partials live in our view directories, but have a specific naming convention that marks them as a partial: `_partial_name.html.erb`. All partials will be named with a leading `_`. If we wanted to create a partial for a form that would be used to create or update an artist resource, our file structure would probably look like this.

```bash
app/views/artists
    _form.html.erb
    edit.html.erb
    new.html.erb
```

Once we have our partial created, we will need to tell our views to **render** that form: `<%= render "form" %>`. We use this render method inside the view file that our controller looks for when compiling our response back to the client. So, if we are using this `_form` partial for edit and new, we will render the partial on both `edit.html.erb` and `new.html.erb`.

When rendering a partial, you will regularly need to send the partial some action-specific information. In the case of a `new` vs `edit` form, you may want to send the path information, the text for the submit button, and perhaps the method/verb that the form should use. To send this information, we can render our partial with **local variables** that can be used in the partial to customize it for each action:

```html
<%= render partial: 'form', locals: { path: '/artists/1', method: :get, button_text: 'Update Artist' } %>
```

Now, we are sending our render method some additional information, we need to be a bit more specific - we are telling it to render a partial, called `_form`, and to send that partial 3 local variables: `path`, `method`, and `button_text`

### Restricting Local Variables

As of Rails 7.1, there is some additional functionality for local variables. If you'd like to be explicit when defining what local variables your partial will accept, you can add a magic comment in your partial. You'll need to use the `#` and `-` characters at the beginning and end, respectively, of your comment in order to use a comment in an ERB tag. Notice how we refer to these comments as "magic comments." This is because most comments are not interpreted by Ruby and are just ignored. However, there are cases when comments will be interpreted and affect the processing of the code, and this is one of those cases. 

Inside the comment, you'll list the name of the partials you expect. If another view template tries to render your partial with any other variables that are not listed in your comment, Rails will raise an exception. If another view template renders a partial and doesn't pass one of the expected local variables, Rails will again raise an exception.

```html
# app/views/shared/_form.html.erb

<%# locals: (path:, method:, button_text:) -%>
```
In the example above, this magic comment in the partial file indicates that only locals called `path`, `method` and `button_text` should be passed to the partial and no others. If you want to ensure that no locals will be passed to your partial, you can add a magic comment to indicate that locals should be empty.

```html
# app/views/shared/_form.html.erb

<%# locals: () -%>
```
You also have the choice to set default values for local variables when you define them in the magic comment in your partial file. 

```html
# app/views/shared/_form.html.erb

<%# locals: (path: "/artists", method: :post, button_text: "Create Artist") -%>
```

Using these magic comments to indicate what local variables are expected is optional.

### Implementing a Partial in Set List

Let's see if we can put all this together to DRY up our `artists/edit` and `artists/new` views in our SetList app. Before peeking at the code snippets below, see if you and your partner can implement a partial, maintaining our passing tests!

---

You should now have `artists/_form.html.erb`, `artists/new.html.erb`  and  `artists/edit.html.erb` files in your views directory that look somthing like the following.

**app/views/artists/_form.html.erb**

```html
<%# locals: (path:, method:, button_text:) -%>

<%= form_with url: path, method: method do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.submit button_text %>
<% end %>
```

**app/views/artists/new.html.erb**

```html
<%= render partial: 'form', locals: {
                                      path: "/artists",
                                      method: :post,
                                      button_text: 'Create Artist'
																		} %>
```

**app/views/artists/edit.html.erb**

```html
<%= render partial: 'form', locals: {
                                      path: "/artists/#{@artist.id}",
                                      method: :patch,
                                      button_text: 'Update Artist'
																		} %>
```

And our tests should still be passing!

**We showed an example of refactoring a form, but partials are not limited to forms. Partials can be used for any repeated code in your views.**

## Checks for Understanding

1. What are partials, and why do we use them?
2. How do we send specific information to our partials?
3. Reviewing your project, are there any places where a partial could be used?

Completed code for this lesson can be found in the `partials-solutions` branch [here](https://github.com/turingschool-examples/set-list-7/tree/partials-solutions).
