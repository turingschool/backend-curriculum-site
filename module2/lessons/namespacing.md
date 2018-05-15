# Namespacing
## Learning Goals

Why/when do we namespace our routes?
What is the difference between Namespacing and Scoping?
When would we use one over the other?

## Exercise
### Background
Read [this](http://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing) section of the Rails docs about namespacing in Rails.

At a high level, namespacing a route in Rails does three things:

1. Allows us to put the controller for a resource into a directory inside of our controllers directory.
2. Changes the route that a user would visit.
3. Changes the prefix that we would use as a path helper.
Rails also allows us to do each of these three things independently:

* `module` allows us to put the controller into a sub-directory.
* `scope` changes the route that a user would visit.
* `as` allows us to change the prefix we use as a path helper.
Let’s explore this functionality in a new project, first individually, then all together as a namespace.

### Setup
Let’s create an app for CRUDding some cats. Yes, it sounds weird. Yes, it is weird. Weird is good.

`rails new cats -T -d=postgresql`
###Resource Routes Recap:
Let’s add some resource routes to our `routes.rb` for cats.

#### Resources Cats
![cat_resources](http://i.imgur.com/efXfyNW.png)

### Distinguishing Routes
Let’s say we have:

* `cats`
* `administrators`

We want a way to distinguish your routes so an admin has additional functionality/control over your application.

For example, say we want `http://localhost:3000/admin/cats` to show `edit`/`delete` buttons for each individual cat and only admins can get here.

We also want `http://localhost:3000/cats` to show a list of cats (and anyone visiting our application can get here).

What can we do?

### Scope
    # config/routes.rb
    scope :admin do
      resources :cats
    end

Adding `scope` to our routes gives us the following when we run `rake routes`:

![scoped_cat_resources](http://i.imgur.com/O10zMLa.png)

### Potential Problems with scope
We’re going to need a way to **differentiate** our controllers. We want what we already have (the url prefix) **AND** a separate controller to encapsulate the different functionality.

We want both `/admin/cats` and `/cats` to be handled by our controllers in different ways.

### Scope and Module
    scope :admin, module: :admin do
      resources :cats
    end

If we have `scope` with `module` in our routes, we will get the following `rake routes` output:

![scope_module_cat_resources](http://i.imgur.com/GvKOhiv.png)

By using `module`, Rails looks for our controller in a different place.

    # When we hit "http://localhost3000/admin/cats"

    # app/controllers/admin/cats_controller.rb
    class Admin::CatsController < ApplicationController
      def index
        @cats = Cat.all
      end
    end

What does that `::` (scope resolution operator) remind us of?

Note: Where do you think Rails will look for this view template? It will look in the `views/admin/cats` folder.

Recap
What have we done so far to our routes?
What did `module` change for us?
Do you notice anything missing when you run `rake routes`?
As you may have noticed, we don’t have any path helpers that are specific to this “special” admin prefix. Again, Rails can help us out with this.

`scope`, `module` and `as`
    scope :admin, module: :admin, as: :admin do
      resources :cats
    end
Let’s run `rake routes` once again!

![scope_module_as_cat_resources](http://i.imgur.com/eY5o0wx.png)

So what does using `scope`, `module`, and `as` provide for us?

path helpers via the prefix (`admin_cats_path`)
controller prefix (`Admin::CatsController`) for more organization
url prefix for user’s to see in their browser (`http://localhost:3000/admin/cats`)
As you may have expected, this seems like a lot of work for something that’s used quite often. Rails actually makes this even easier for us.

### Namespace
`namespace` = `scope` + `module` + `as`

*Rad!*

Update the routes file to the following:

    namespace :admin do
      resources :cats
    end
vs

    scope :admin, module: :admin, as: :admin do
      resources :cats
    end

### Why should we use namespace, scope, module, or as?
* readability
* organization
* specificity

Can you imagine what happens when you have 400 lines in your routes file?! You’ll be thankful these route blocks exist for organization alone.

### Questions

* Summarize what each of the following things does in the context of our routes file:
  * scope
  * module
  * as
  * namespace

* Why might it be beneficial to have a two controllers for Movies (one in `controllers/admin` and one just in `controllers`)?
* What about different routes? Would we ever want to have `/admin/movies` and `/movies`? Why?
