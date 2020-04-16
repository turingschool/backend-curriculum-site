---
layout: page
title: Understanding Multi-tenant Applications
length: 120
Tags: multi-tenancy, rails, pivot, controllers, models, routes, namespacing
---

### Learning Goals

By the end of this lesson, you will know/be able to:

* Explain what a multi-tenant application is, and why we need one.
* Implement multi-tenancy at a routes level
* Implement multi-tenancy at the controller level.
* Design a database scheme for a multi-tenant application.

### Warmup

* Write a description of the store you built for Little Shop.
* How is this different from a place like Etsy or eBay?
* What about sites that aren't stores? What about Reddit, GitHub, or Airbnb?

### Overview

#### Multi-tenancy. What is it? and why do we need it?

* First there was a store.
* Then there was a marketplace.
* Examples of Multi-tenant applications - ebay, shopify, squarespace, etsy.
* Basically a single instance of the software is deployed vs. many instances.
* Single maintained large dataset that breaks down into smaller datasets for each customer/owner.

#### Issues/Concerns of a Multi-tanant site.

* Authentication.
* Authorization - Scoping by role.
  * keeping one store from accessing and changing data from a different store.
* Database design and relationships.

### Code Along

With a partner, attempt to implement the following functionality below. We will share out after each piece of functionality is implemented.

```
git clone https://github.com/turingschool-examples/storedom-5.git multitenancy
cd multitenancy
bundle && bundle exec rake db:drop db:setup
```

#### Goals

* Persist stores to the database
* View stores in the app (index and show)
* Associate item with a store
* View an item with info about its store
* Prevent accessing items in the wrong store


#### Database Updates

* Add `stores` table
* Add relationship between `items` and `stores`

#### Model Updates

* Add Store model
* Add uniqueness validations for name and slug
* Add relationships between Store and Item

#### Route and Controller Updates

* Add route to view store
* Add `StoresController`
* Add `index` and `show` actions to `StoresController`

#### Views

* Add show
* Add index

#### Create a Store

* `rails c`
* `rails s`

#### Save a Store's Slug

* Use a callback to set the store's slug

I don't completely expect that you will have memorized how to create a callback at this point. See if you can find resources online that will allow you to implement this functionality.

#### Update Controller

* Change the controller to find a store using its slug

#### Add Items

* How would we refactor if we wanted a view to show items only for a particular store?
* What would the route look like?
* What if we wanted to keep our view for all items, but also have a view for only items associated with a store?

#### Change Route

* What if we wanted to have the same functionality, but delete the `/stores` part of our route?

Similar to the callbacks section, see if you can find any resources online that will allow you to implement this before looking below.

#### Revised Routes

```rb
namespace :store, path: ':store', as: :store do
  resources :items, only: [:index, :show]
end
```

```rb
# Stores::ItemsController
def index
  @store = Store.find(params[:store])
  @items = @store.items
end
```

#### Takeaways

* Multitenancy will generally lead to new relationships between resources
* Nested routes can help us work with related resources

### Video

* [Understanding Multi-Tenancy - Oct. 2015](https://vimeo.com/142297870)
* [Understanding Multi-Tenancy - May. 2015](https://vimeo.com/128198524)

### Repository

* [Repo for the lesson](https://github.com/turingschool-examples/storedom)

### Resources

* [QuickLeft blog post/ discussion on Multi-tenancy](https://quickleft.com/blog/what-is-a-multi-tenant-application/)
*
