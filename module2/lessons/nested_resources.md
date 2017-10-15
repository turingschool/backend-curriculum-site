---
layout: page
title: Nested Resources in Rails
---

## Learning Goals

- How do you use nested resources in Rails?
- When should you use Nested Resources?

## Slides

Available [here](../slides/nested_resources)

## Warm Up

Create a table containing all 8 prefixes, http-verbs, URI-patterns, and controller actions that Rails gives you when you have the following:

```ruby
# config/routes.rb

resources :muffins
```

## Overview

We're going to discuss the concept of nested resources. Last week when we created a relationship between directors and movies we saw that the newest versions of Rails default to not letting us to create a movie without a related director. If that's the case, we will need to make sure that any time we allow a user to create a movie, they also have to enter a director. We could do this with a validation, but there are two other ways that we can enforce this constraint without allowing a user to submit a form before they realize they've done something wrong:

1) Provide a dropdown in our form that does not have a blank option.
2) Nest our route to create movies under directors.

## What is a nested route?

Read [this](http://guides.rubyonrails.org/routing.html#nested-resources) section of the Rails routing documentation and discuss with someone close to you.

Examples:

```
GET  /directors/1/movies
GET  /directors/1/movies/new
POST /directors/1/movies
```

## How do we create nested routes in rails?

Using the MovieMania app that we've been creating, adjust your routes file to include the following:

```
# config/routes.rb
resources :directors do
  resources :movies
end
```

Run `rake routes` to see the routes/paths that are generated with this in your routes file.

One note: some of our resources don't need to be nested. For example, if we want to see a specific movie we can visit `/movies/:id` and see information about that movie. We don't need to know the director in order to see information about that movie if we know it's id.

Rails offers us a tool to only nest those resources that need to be nested: `shallow: true`.

```ruby
# config/routes.rb
resources :directors shallow: true do
  resources :movies
end
```

Run `rake routes` again. How does this differ from what was generated without `shallow: true`?

## Forms with Nested Resources

The Rails `form_for` method takes an object as an argument. It uses that object to determine a few things:

* Whether to render a new form or an update form (based on whether or not the object has been `.persisted?`).
* Whether the fields in the form correspond to attributes on the object.
* What route to use when sending the information when a user hits submit.

Given that our route to create a new movie is now nested (i.e. `POST '/directors/:director_id/movies'`), how do we give our `form_for` the id that it needs to determine the route that will accept our information? We change the argument to an array including both the existing director and the new movie.

First we need to update our controller to pass these two objects. Note that we access the director's id as `director_id` in the params hash. This corresponds to what we see in the output of `rake routes` with our newly nested routes.

```
# app/controllers/movies_controller.rb
def new
  @director = Director.find(params[:director_id])
  @movie    = Movie.new
end
```

Then we need to go update our form to use these two arguments:

```
# app/views/new.html.erb
<h1>Create a New Movie</h1>

<%= form_for [@director, @movie] do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :description %>
  <%= f.text_area :title %>
  <%= f.submit %>
<% end %>
```

Now that we have a form submitting to our new route, we need to make a movie related to our director. How do we have access to the director? Through params! Remember, we're sending this request to `/directors/:director_id/movies`, so that `director_id` is hanging out in our route and getting put into our params hash.

Note that we'll also need to change our redirect since our movies index is now nested to directors.

```ruby
def create
  director = Director.find(params[:director_id])
  director.movies.create(movie_params)
  redirect_to "/directors/#{director.id}/movies"
end
```

Let's run `rails s` check to see what happens when we visit `/directors/1/movies/new`

Be sure that you have at least one director in your database. If not, create one in the console by running `rails c`.

## Mixing Nested and Non-Nested Routes

What if we want to see a list of all movies? We can still do that. Just add the following line to our `config/routes.rb` file **outside of the block related to directors.**

```ruby
resources :movies, only: [:index]
```

Now visit `/movies` and you should see all movies.

## Checks for Understanding

Turn and talk to your neighbor and discuss:

* When would you use a nested resource?
* How do you nest a resource in your routes file?
* How does that change your routes?
* What does it mean to use shallow nesting? Why would you do this?
* What changes do you need to make in your controller when you nest a resource?

