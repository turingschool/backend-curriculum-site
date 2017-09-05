---
title: Passing Data with Sinatra
length: 60
tags: parameters, sinatra
---

## Passing Data with Sinatra

Yesterday, we talked about three ways to pass data in Sinatra. Now you'll get to test your skills with two of them.

In this workshop, you'll practice passing data between a client and a Sinatra server.

Remember, there are a few different ways to pass data: through the query string parameters in the URL, through dynamic parameters in the URL, and through forms. We'll be focus on passing data via query params and via forms.

## Learning Goals

* Practice accessing query string parameters in a controller.
* Practice accessing form parameters in a controller.

## Setup

1) Clone this app: [http://github.com/turingschool/shopping](http://github.com/turingschool/shopping)

2) Create and migrate the database by running the two migration files:

* `ruby db/migrations/001_create_items.rb`
* `ruby db/migrations/002_create_users.rb`

Running these migrations will also create five items for your shop.

## Query String Parameters

#### Activity 1

You'll see a route defined in `shopping_app.rb` that handles requests to the index of all items (`/items`). Start up your server and check that five items appear.

For this task, you will *not* need to add or change any code. Instead, take a look at the route, then modify only the URL in order to filter these items by a word in their description.

For example, type a URL that will:

* show only the items made by Apple
* show only the items made by Samsung
* show only the year 2016 items
* show only the year 2017 items

If you're stuck, research query string parameters.

Confused about the use of LIKE in the SQL in the `.find_by` method? Check out [this explanation of the LIKE operator](https://www.tutorialspoint.com/sqlite/sqlite_like_clause.htm).

#### Activity 2

Imagine that the company whose website you're building no longer wants to use "term", but instead wants to use "filter". What do you need to modify in your code? Make the change(s), then test out this URL to make sure it works: `localhost:9393/items?filter=Samsung`.

#### Activity 3

Modify the URL, controller, and view to make this message appear when a user looks at the items index.

`Note: Contact your local stores in Denver to check item availability.`

or

`Note: Contact your local stores in Los Angeles to check item availability.`

...etc...

The value of the city should be able to be modified based on my URL query params.

#### Questions to Consider

* What are some common use cases for query strings on the internet?
* What are some of the limitations of passing data through query strings?

## Form Parameters

#### Activity 1

Take a look in `views/new_item.erb`. You'll see an existing form, but something is wrong with it! Use your debugging skills and tools to fix *just the form*.

#### Activity 2

You'll see a route in your `shopping_app.rb` to `get '/users/new'`. It renders a view template that currently blank. Create a form in this file that will accept two attributes: a name and an email address. Use the `<label>` HTML tag to differentiate between the name and email address input fields.

Create a route that handles the submission of this form (follow the conventions from our CRUD chart) and ultimately brings the user back to the list of all users.

# Done?

If you're finished, here are some ideas:

* Build out full CRUD functionality for Users.
* Use Bootstrap to style your views.
