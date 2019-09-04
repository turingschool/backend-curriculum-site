---
layout: page
title: Namespacing
---

## Learning Goals

- Why/when do we namespace our routes?
- What is the difference between Namespacing and Scoping?
- When would we use one over the other?

## Exercise

### Background

Read [this](http://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing) section of the Rails docs about namespacing in Rails.

At a high level, namespacing a route in Rails does three things:

1. Allows us to put the controller for a resource into a directory inside of our controllers directory.
1. Changes the route that a user would visit.
1. Changes the prefix that we would use as a path helper.

Rails also allows us to do each of these three things independently:

1. `module` allows us to put the controller into a sub-directory.
1. `scope` changes the route that a user would visit.
1. `as` allows us to change the prefix we use as a path helper.

Let's explore this functionality in a new project, first individually, then all together as a namespace.

### Setup

Let's create an app for CRUDding some cats. Yes, it sounds weird. Yes, it is weird. Weird is good.

```bash
rails new cats -T -d="postgresql" --skip-spring --skip-turbolinks
```

### Routes Recap:

Let's add some routes to our `routes.rb` for `cats` that will show all cats, show one cat, delete a cat, and edit a cat.

```ruby
    get '/cats', to: 'cats#index'
    get '/cats/:id', to: 'cats#show'
    patch '/cats', to: 'cats#update'
    get '/cats/edit', to: 'cats#edit'
    delete '/cats/:id', to: 'cats#destroy'
```

At this point, when we run `rake routes`, we get the following: 

```ruby 
   Prefix Verb   URI Pattern          Controller#Action
     cats GET    /cats(.:format)      cats#index
          GET    /cats/:id(.:format)  cats#show
          PATCH  /cats(.:format)      cats#update
cats_edit GET    /cats/edit(.:format) cats#edit
          DELETE /cats/:id(.:format)  cats#destroy
```

### Distinguishing Routes

Let's say we have:

- `cats`
- `administrators`

We want a way to distinguish your routes so an admin has additional functionality/control over your application.

For example, say we want `http://localhost:3000/admin/cats` to show `edit`/`delete` buttons for each individual cat and only admins can get here.

We also want `http://localhost:3000/cats` to show a list of cats (and anyone visiting our application can get here).

What can we do?

### Scope

```ruby
	# config/routes.rb
        get '/cats', to: 'cats#index'
        get '/cats/:id', to: 'cats#show'
	scope :admin do
	      patch '/cats', to: 'cats#update'
   	      get '/cats/edit', to: 'cats#edit'
    	      delete '/cats/:id', to: 'cats#destroy'
	end
```

Adding `scope` to our routes gives us the following when we run `rake routes`:

```ruby 
   Prefix Verb   URI Pattern                Controller#Action
     cats GET    /cats(.:format)            cats#index
          GET    /cats/:id(.:format)        cats#show
          PATCH  /admin/cats(.:format)      cats#update
cats_edit GET    /admin/cats/edit(.:format) cats#edit
          DELETE /admin/cats/:id(.:format)  cats#destroy
```

### Potential Problems with **scope**

We're going to need a way to **differentiate** our controllers. We want what we already have (the url prefix) **AND** a separate controller to encapsulate the different functionality.

We want both `/admin/cats` and `/cats` to be handled by our controllers in different ways.

### Scope and Module

```ruby
	get '/cats', to: 'cats#index'
        get '/cats/:id', to: 'cats#show'
	scope :admin, module: :admin do
	 patch '/cats', to: 'cats#update'
   	 get '/cats/edit', to: 'cats#edit'
    	 delete '/cats/:id', to: 'cats#destroy'
	end
```

If we have `scope` with `module` in our routes, we will get the following `rake routes` output:

```ruby 
     cats GET    /cats(.:format)            cats#index
          GET    /cats/:id(.:format)        cats#show
          PATCH  /admin/cats(.:format)      admin/cats#update
cats_edit GET    /admin/cats/edit(.:format) admin/cats#edit
          DELETE /admin/cats/:id(.:format)  admin/cats#destroy
```

By using `module`, Rails looks for our controller in a different place.

```ruby
	# When we hit "http://localhost3000/admin/cats"

	# app/controllers/admin/cats_controller.rb
	class Admin::CatsController < ApplicationController
 	 def index
	  @cats = Cat.all
	 end
	end

```

What does that `::` (scope resolution operator) remind us of?

**Note:** Where do you think Rails will look for this view template? It will look in the `views/admin/cats` folder.

### Recap

* What have we done so far to our routes?
* What did `module` change for us?
* Do you notice anything missing when you run `rake routes`?

As you may have noticed, we don't have any path helpers that are specific to this "special" `admin` prefix. Again, Rails can help us out with this.

### `scope`, `module` and `as`

```ruby
	get '/cats', to: 'cats#index'
    	get '/cats/:id', to: 'cats#show'
	scope :admin, module: :admin, as: :admin do
         patch '/cats', to: 'cats#update'
   	 get '/cats/edit', to: 'cats#edit'
    	 delete '/cats/:id', to: 'cats#destroy'
	end
```

Let's run `rake routes` once again!


```ruby 
         Prefix Verb   URI Pattern                Controller#Action
           cats GET    /cats(.:format)            cats#index
                GET    /cats/:id(.:format)        cats#show
     admin_cats PATCH  /admin/cats(.:format)      admin/cats#update
admin_cats_edit GET    /admin/cats/edit(.:format) admin/cats#edit
          admin DELETE /admin/cats/:id(.:format)  admin/cats#destroy
```

So what does using `scope`, `module`, and `as` provide for us?

* path helpers via the prefix (`admin_cats_path`)
* controller prefix (`Admin::CatsController`) for more organization
* url prefix for user's to see in their browser (`http://localhost:3000/admin/cats`)

As you may have expected, this seems like a lot of work for something that's used quite often. Rails actually makes this even easier for us.

### Namespace

`namespace` **=** `scope` + `module` + `as`

_Rad!_

Update the routes file to the following:

```ruby
	get '/cats', to: 'cats#index'
    	get '/cats/:id', to: 'cats#show'
	namespace :admin do
	 patch '/cats', to: 'cats#update'
   	 get '/cats/edit', to: 'cats#edit'
    	 delete '/cats/:id', to: 'cats#destroy'
	end
```

vs

```ruby
        get '/cats', to: 'cats#index'
    	get '/cats/:id', to: 'cats#show'
	scope :admin, module: :admin, as: :admin do
	 patch '/cats', to: 'cats#update'
   	 get '/cats/edit', to: 'cats#edit'
    	 delete '/cats/:id', to: 'cats#destroy'
	end
```

### Why should we use `namespace`, `scope`, `module`, or `as`?

* readability
* organization
* specificity

Can you imagine what happens when you have 400 lines in your routes file?! You'll be thankful these route blocks exist for organization alone.

### Test Your Understanding
By the end of this work period have a written response to each of the following questions.

* Describe what each of the following things does in the context of our routes file:
    * `scope`
    * `module`
    * `as`
    * `namespace`
* Why might it be beneficial to have two controllers for Songs (one in `controllers/admin` and one just in `controllers`)? Would it have any downsides?
* What about different routes? Would we ever want to have `/admin/songs` **and** `/songs`? Why or why not?
