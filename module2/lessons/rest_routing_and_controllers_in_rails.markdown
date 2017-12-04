---
title: REST, Routing, and Controllers in Rails
length: 90
tags: rest, routing, controllers, routes
---

## Prework

Read [this article](http://www.theodinproject.com/ruby-on-rails/routing).

## Learning Goals

* explain the purpose of the `routes.rb` file
* interpret the output of `rake routes`
* explain the connection between `routes.rb` and controller files
* create routes by hand
* create routes using `resources :movies`


## Intro to REST

* Representational State Transfer is a web architecture style
* Coined by Roy Fielding in doctoral dissertation (2000)
* Things vs. Actions
* Stateless
* Layerable
* All about resources
* Purpose: Aims to give a URI (uniform resource identifier) to everything that can be manipulated and let the software determine what to do from there
* [Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer) on Wikipedia
* [What is Rest?](http://www.restapitutorial.com/lessons/whatisrest.html) from REST API Tutorial

Want to know more about REST? Check out [this video](https://www.youtube.com/watch?v=2zz_XvKTVxI).

### REST, simplified.

* a pattern for creating combinations of HTTP verbs and URIs to access resources

```ruby
get '/movies'
put '/movies/:id'
get '/movies/new'
# ...etc...
```

### What is a "resource"?

“A resource is a conceptual object that has identity, state, and behavior," such as:

* a document
* home page
* search result
* a session

Often, there will be a one-to-one(-to-one) between a resource's routes, controller and model.


## HTTP Verb Overview

* The HTTP verb (GET, POST, DELETE, PUT, PATCH) changes the action a request is routed to.
* HTTP verb + path = controller + action

**get**: retrieve a resource from a url

**post**: create a new resource

**delete**: remove/destroy a resource

**put**: update an entire resource

**patch**: update part of a resource

### Sinatra & REST

Remember two weeks ago when we looked at the seven routes we were going to be creating with `TaskManager`? We were already following REST conventions!

```
get '/tasks'
# shows all tasks

get '/tasks/new'
# shows form to create new task

get '/tasks/:id'
# shows a specific task

post '/tasks'
# creates a new task
```

## Routes + Controllers in Rails

"Convention over configuration"

```bash
$ rails new movie_mania -T -d="postgresql" --skip-spring --skip-turbolinks
$ cd movie_mania
```

Let's take a few minutes to explore what `rails new` generates.


Let's install RSpec and dream drive our application!

Add gems to Gemfile and bundle:
  - 'rspec-rails'
  - 'capybara'
  - 'launchy'
  - 'pry'

Install RSpec

```bash
$ rails g rspec:install
```

What new files did this generate?

Now lets write a test!

```ruby
  # user_sees_all_movies_spec.rb
  describe "user_index" do
    it "user_can_see_all_movies" do
      movie_1 = Movie.create(title: "Drop Dead Fred", description: "An unhappy housewife gets a lift from the return of her imaginary childhood friend")
      movie_2 = Movie.create(title: "Empire Records", description: "Independent Delaware store that employs a tight-knit group of music-savvy youths.")

      visit "/movies"

      expect(page).to have_content("All Movies")
      expect(page).to have_content(movie_1.title)
      expect(page).to have_content(movie_1.description)
      expect(page).to have_content(movie_2.title)
      expect(page).to have_content(movie_2.description)
    end
  end
```

Run RSpec, what happens? `Uninitialized Constant Movie` leads us to add a model but then what? I have to create an actual table for my movies in my database.

```bash
$ rails g model Movie title description:text
```

Overwrite the record `movie.rb` so we can see what that generated.

Now look at our migrations, we have what we want so lets create and then migrate.   
Run `rails db:create`
Run `rails db:migrate`

In `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  get '/movies', to: 'movies#index'
end
```

From the command line, see which routes you have available: `$ rake routes`. You should see this output:

```
Prefix Verb URI Pattern      Controller#Action
movies GET  /movies(.:format) movies#index
```

This means whenever a `get` request to `/movies` is received, have the `MoviesController` handle it with the `index` action (method). The `(.:format)` piece on the end of the URI pattern refers to things like `http://example.com/movies.csv` or `http://example.com/movies.pdf`, etc.

Based on our rake routes - what controller to we need? do we have it?


Make a movies controller:

```bash
$ touch app/controllers/movies_controller.rb
```

Naming is important. The name of the file should be the plural of what it is handling (in this case, tasks).

Inside of that file:

```ruby
class MoviesController < ApplicationController
  def index
    render :plain => "hello world"
  end
end
```

What is ApplicationController? Look at the controllers folder and you should see an `application_controller.rb` file. This file defines the `ApplicationController` class, which (generally) all of your other controllers will inherit from.

Notice that the name of the class matches the name of the file (`movies_controller.rb` => `class MoviesController`), one snake-cased and one camel-cased.

Normally we would not put in the line `render :text => "hello world"`. Without the render line, Rails will automatically look for a view inside of a folder with the same name as the controller (`movies` folder), then look for a view with the same name as the method (`index.erb`). However, we are not going to deal with views today, so rendering text is the easiest way to see if a route is working.

Start up your rails server: `rails server` or `rails s` from the command line.

Navigate to `localhost:3000/movies` and you should see your text.

### Workshop

1) Can you create a `new` route that would bring the user to a form where they can enter a new movie?

2) Can you create a `show` route that would allow a user to see one movie? Just like in Sinatra, the route will need a changeable `/:id`. You *do not* need to create a show view; just get a message like "You are viewing the show page" to show up.

3) Can you create an `edit` route that would allow a user to get to the edit page for a movie? Again, the route will need a changeable `/:id`. You *do not* need to create a form; just get a message like "You are viewing the edit page" to show up.

4) For the previous two routes (show and edit), can you get the id param to display in the text that you render? You *do not* need to create a form; just get a message like "You are editing movie 2" to show up.

In Sinatra, you could access the `:id` from the URL like this:

```ruby
get '/movies/:id' do |id|
  puts id
end
```

In Rails, you'll need to use `params[:id]`.

### Using Resources in the Routes File

What are the common CRUD actions? They match up to eight routes. Can you name all of them?

Since Rails is all about "convention over configuration", it has a nice way of allowing us to easily create all eight RESTful routes at one time via a shortcut.

We can use the shortcut `resources`. As an example, we can change our `config/routes.rb` file to to look like this:

```ruby
Rails.application.routes.draw do
  resources :movies
end
```

Now let's look at the routes we have available: `$ rake routes`.

Using `resources :movies` gives us eight RESTful routes that correspond to CRUD functionality.

```
   Prefix Verb   URI Pattern               Controller#Action
    movies GET    /movies(.:format)          movies#index
          POST   /movies(.:format)          movies#create
 new_movie GET    /movies/new(.:format)      movies#new
edit_movie GET    /movies/:id/edit(.:format) movies#edit
     movie GET    /movies/:id(.:format)      movies#show
          PATCH  /movies/:id(.:format)      movies#update
          PUT    /movies/:id(.:format)      movies#update
          DELETE /movies/:id(.:format)      movies#destroy
```

Any methods with `:id` require an id to be passed into the URL. These values are dynamically added (like viewing the seventh movie via `/movies/7`).

#### Questions:

* What actions (methods) would we need in our `MoviesController` in order to handle all of these routes?
* Which actions would render a form and which actions would redirect? (Think of TaskManager in Sinatra)

Don't worry about putting `render :text` in these actions. You won't be able to test out `post`, `patch`, `put`, or `delete` by navigating in your browser.

If you add a whole bunch of `resources :things` to your routes file, it will generate these eight routes for all of the things you've specified:

```ruby
Rails.application.routes.draw do
  resources :movies
  resources :directors
  resources :actors
end
```

Noxw try `$ rake routes`.

### Other things

* We can add a route for our root with:

```ruby
Rails.application.routes.draw do
  root 'movies#index'
end
```

This will direct any get request to `localhost:3000` to the `movies_controller.rb` `index` action.

### Homework

* [Routes and Controllers Assignment](https://github.com/turingschool/challenges/blob/master/routes_controllers_rails.markdown)
