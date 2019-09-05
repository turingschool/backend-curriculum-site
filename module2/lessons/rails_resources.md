---
title: Rails Resources
layout: page
---

##  Learning Goals

* Understand what the `resources` syntax in `routes.rb` generates for us.
* Understand what nesting `resoures` in `routes.rb` generates for us.
* Understand the 5 pieces of information `rake routes` gives us.
* Use route helpers

## Vocab

* routes
* route helper

## WarmUp

In your notebook, without using your computer, fill in the following table for the 8 ReSTful routes for a generic "resource"

| **Verb** | **URI Pattern** | **Controller#Action** |
|   GET    |     /resources  | resources#index       |
|      |             |                   |
|      |             |                   |
|      |             |                   |
|      |             |                   |
|      |             |                   |
|      |             |                   |
|      |             |                   |

## Rails Resources

Rails gives us a handy shortcut for generating the 8 ReSTful routes in our routes.rb file. Open up any Rails app, such as SetList, and add the following line anywhere in your routes file:

```ruby
resources :cats
```

Run `rake routes -c cats` from the command line. The `-c` stands for controller, so it will only show you routes for the cats.

With a partner, explore what this output gives you.

## Only/Except

You never want to create routes that you haven't implemented in your code. If you have `resources :cats` in your routes file, but you haven't implemented the `CatsController#destroy` action, you would be exposing an unused route. Instead, we give our resource an `only` option to explicitly say which ReSTful routes we want created. For example, if we only wanted the cats index, new, and create actions, we could put this in our routes file:

```ruby
resources :cats, only: [:index, :new, :create]
```

You can also use `except`, which will generate the 8 ReSTful routes _except_ the ones specified:

```ruby
resources :cats, except: [:destroy]
```

This would be the same as:

```ruby
resources :cats, only: [:index, :show, :new, :create, :edit, :update]
```

With a partner, refactor some of the ReSTful routes in SetList to use the `resources` syntax.

## Nested Resources

Some resources are logically dependent on other resources. In SetList, Songs can't exist without an Artist.

If we look in our routes for SetList, we'll see:

```
get "/artists/:artist_id/songs/new", to: "songs#new"
```

When we want to make a new song, we need to know which artist we are making the song for. We can also accomplish this with the `resources` syntax by nesting with a `do` block:

```ruby
resources :artists do
  resources :songs
end
```

This will generate 8 ReSTful routes for artists *and* 8 ReSTful routes for songs that are nested under an artist. You can also use only/except for nested resources:

```ruby
resources :artists, only: [:show] do
  resources :songs, only: [:edit]
end
```

Just like before, we only want to create the routes we need.

With a partner, refactor the nested routes in SetList to use the `resources` sytnax.

## Route Helpers

If you run `rake routes`, you'll notice the first column is called "prefix". Rails will use the "prefix" column to build route helpers.

Route helpers will generate a path for you (note: just the path, not the VERB). All you have to do is append `_path` to the end of the prefix name. For example, if you have this in your routes:

```ruby
resources :cats, only: [:index]
```

Then `rake routes -c cats` should give you:

```
Prefix Verb URI Pattern     Controller#Action
  cats GET  /cats(.:format) cats#index
```

Using that prefix `cats`, we can use `cats_path` anywhere in our Rails app to generate the path `/cats`.

Generally, any row in your `rake routes` output that does not include a prefix uses the same prefix as the line above it.

## Passing Parameters to Route Helpers

Some paths include parameters. For example:

```ruby
resources :cats, only: [:show]
```

Gives you this `rake routes` output:

```
Prefix Verb URI Pattern         Controller#Action
   cat GET  /cats/:id(.:format) cats#show
```

You can't generate the path using `cat_path` because it is expecting an `:id`. Any time a route helper needs a dynamic parameter, like `:id` we MUST pass a value to the route helper. For example `cat_path(29)` will generate `/cats/29`.

We can also pass an object rather than the actual value of the parameter and Rails is smart enough to extract that object's id. This is considered best practice:

```ruby
journey = Artist.create(name: 'Journey')
visit artist_path(journey)
```

Be careful. If you forget to pass a parameter to a route helper that needs it, the error message will start to look like a "missing route" error. Read the ENTIRE error, and it will actually tell you that the route helper is missing a parameter.

## Partner Practice

Refactor some of the code in setlist to use Route Helpers rather than hardcoded routes.

## Checks for Understanding

* What are the 8 ReSTful routes and their controller/actions?
* What routes would `resources :dogs, only: [:destroy, :index]` generate?
* What routes would the following generate?

```ruby
resources :owners, only: [:index] do
  resources :dogs, only: [:show]
end
```

* Why should you use `only`/`except`?
* How can you use the prefix column from `rake routes`?
