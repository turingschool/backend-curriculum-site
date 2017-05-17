---
layout: page
title: Advanced Routing in Rails
---

## Learning Goals

- Why/when do we namespace our routes?
- What is the difference between Namespacing and Scoping?
- When would we use one over the other?
- In what case should you use Nested Resources?

## Warm Up

How confident are you that you can create all 8 prefixes, http-verbs, URI-patterns, and controller actions that Rails gives you when you have the following?

```ruby
# config/routes.rb

resources :cats
```

## Setup

Let's create an app for CRUDding some cats. Yes, it sounds weird. Yes, it is weird. Weird is good.

```bash
rails new cats -T -d=postgresql
```

### Resource Routes Recap:

Let's add some resource routes to our `routes.rb` for `cats`.

![Resources Cats](http://i.imgur.com/efXfyNW.png)

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
	scope :admin do
	 resources :cats
	end
```

Adding `scope` to our routes gives us the following when we run `rake routes`:

![Scope 150%](http://i.imgur.com/O10zMLa.png)

### Potential Problems with **scope**

We're going to need a way to **differentiate** our controllers. We want what we already have (the url prefix) **AND** a separate controller to encapsulate the different functionality.

We want both `/admin/cats` and `/cats` to be handled by our controllers in different ways.

### Scope and Module

```ruby
	scope :admin, module: :admin do
	 resources :cats
	end
```

If we have `scope` with `module` in our routes, we will get the following `rake routes` output:

![Scope-Module 150%](http://i.imgur.com/GvKOhiv.png)

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
	scope :admin, module: :admin, as: :admin do
	 resources :cats
	end
```

Let's run `rake routes` once again!

![Scope-Module-As 150%](http://i.imgur.com/eY5o0wx.png)

So what does using `scope`, `module`, and `as` provide for us?

* path helpers via the prefix (`admin_cats_path`)
* controller prefix (`Admin::CatsController`) for more organization
* url prefix for user's to see in their browser (`http://localhost:3000/admin/cats`)

As you may have expected, this seems like a lot of work for something that's used quite often. Rails actually makes this even easier for us.

### Namespace

`namespace` **=** `scope` + `module` + `as`

_Rad!_

```ruby
	namespace :admin do
	 resources :cats
	end
```

vs

```ruby
	scope :admin, module: :admin, as: :admin do
	 resources :cats
	end
```

### Why should we use `namespace`, `scope`, `module`, or `as`?

* readability
* organization
* specificity

Can you imagine what happens when you have 400 lines in your routes file?! You'll be thankful these route blocks exist for organization alone.

### Nested Resources

Imagine we have these relationships:

```ruby
	class Owner < ActiveRecord::Base
	 has_many :cats
	end

	class Cat < ActiveRecord::Base
	 belongs_to :owner
	end

```

Let's set up our resource routes as follows:

```ruby
resources :owners do
 resources :cats
end
```

Run `rake routes` now. Why might we want this setup for our routes?

### Recap

Turn and talk to your neighbor and discuss:

*   What are differences between using **namespace** and **nested resources**?
*   What are use cases for one or the other? Could you think of use cases for both?

### Closing

Can you answer these questions?

- Why do we namespace things?
- What is the difference between namespacing and scoping?
- When would we use one over the other?
- When should you use nested resources?
