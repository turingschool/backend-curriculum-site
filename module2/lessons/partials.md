---
layout: page
title: Using Partials to DRY up Our Views
---

## Vocab
* render
* partial
* locals

## Setup

This lesson builds off of the [Many to Many lesson](./many_to_many). You can start the coding practice for this lesson on the `partials` branch of the [Set List Tutorial repo](https://github.com/turingschool-examples/set_list_tutorial), and you can compare your answers to our completed work in the `partials_solutions` branch. 

## Warm Up

Discuss the following questions with a partner:

* Thinking about plain Ruby, What are some strategies we use to DRY up our code within a class?
* What about strategies to DRY up code from multiple classes (where there might be shared behavior)?

Read the following excerpts from the Rails Guides:

* The intro paragraph of [3.4 Using Partials](https://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)
* [3.4.1 Naming Partials](https://guides.rubyonrails.org/layouts_and_rendering.html#naming-partials)
* [3.4.2 Using Partials to Simplify Views](https://guides.rubyonrails.org/layouts_and_rendering.html#using-partials-to-simplify-views)

## DRYing Our Views

Often, as we build out our applications, we find ourselves using the same code in multiple view files.  For example, when using forms, we generally see nearly identical code being used in `new.html.erb` and `edit.html.erb`.  Another example could be some shared code in `show.html.erb` and `index.html.erb` - we might be showing much of the same information in both places. With all this repeated code, things aren't very DRY.  So, how can we DRY up these views?

### Using a Partial

A **partial** is a file we can leverage to house code that is shared across multiple views. Our partials live in our view directories, but have a specific naming convention that marks them as a partial: `_partial_name.html.erb`.  All partials will be named with a leading `_`.  If we wanted to create a partial for a form that would be used to create or update an artist resource, our file structure would probably look like this:

```
app/views/artists
    _form.html.erb
    edit.html.erb
    new.html.erb
```

Once we have our partial created, we will need to tell our views to **render** that form: `<%= render "form" %>`.  We use this render method inside the view file that our controller looks for when compiling our response back to the client.  So, if we are using this `_form` partial for edit and new, we will render the partial on both `edit.html.erb` and `new.html.erb`.

When rendering a partial, you will regularly need to send the partial some action-specific information. In the case of a `new` vs `edit` form, you may want to send the path information, the text for the submit button, and perhaps the method/verb that the form should use. To send this information, we can render our partial with **local variables** that can be used in the partial to customize it for each action:

```
<%= render partial: 'form', locals: { path: '/artists/1', method: :get, button_text: 'Update Artist' } %>
```

Now, we are sending our render method some additional information, we need to be a bit more specific - we are telling it to render a partial, called `_form`, and to send that partial 3 local variables: `path`, `method`, and `button_text`

### Implementing a Partial in Set List

Let's see if we can put all this together to DRY up our `artists/edit` and `artists/new` views in our SetList app. Before peeking at the code snippets below, see if you and your partner can implement a partial, maintaining our passing tests!

<br/>
<br/>

---------------------------------------

<br/>
<br/>

You should now have `artists/_form.html.erb`, `artists/new.html.erb` and `artists/edit.html.erb` files in your views directory that look somthing like this:

`_form/html.erb`

```ruby
<%= form_with url: path, method: method do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.submit button_text %>
<% end %>
```

<br/>

`new.html.erb`

```ruby
<%= render partial: 'form', locals: {
                                      path: "/artists",
                                      method: :post,
                                      button_text: 'Create Artist'} %>

```

<br/>

`edit.html.erb`

```erb
<%= render partial: 'form', locals: {
                                      path: "/artists/#{@artist.id}",
                                      method: :patch,
                                      button_text: 'Update Artist'} %>

```

And our tests should still be passing!

**We showed an example of refactoring a form, but partials are not limited to forms. Partials can be used for any repeated code in your views.**

## Checks for Understanding

1. What are partials, and why do we use them?
1. How do we send specific information to our partials?
1. Reviewing your project, are there any places where a partial could be used?
