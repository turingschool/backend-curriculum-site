---
title: REST, Routing, and Controllers in Rails
length: 90
tags: rest, routing, controllers, routes, rspec
---

## Prework

Read [this article](https://www.theodinproject.com/courses/ruby-on-rails/lessons/routing).

## Learning Goals

* explain the purpose of the `routes.rb` file
* interpret the output of `rake routes`
* explain the connection between `routes.rb` and controller files
* create routes by hand
* create routes using `resources :movies`

## Vocabulary

- `routes.rb`
- `rake routes`
- CRUD
- MVC

## Warm Up

- What is REST?
- How are routes applied in Sinatra?
- Where do our routes live?
- How is MVC implemented in Sinatra?

## Reminder - REST

* Representational State Transfer is a web architecture style
* Purpose: Aims to give a URI (uniform resource identifier) to everything that can be manipulated and let the software determine what to do from there
* [Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer) on Wikipedia
* [What is Rest?](http://www.restapitutorial.com/lessons/whatisrest.html) from REST API Tutorial

Want to know more about REST? Check out [this video](https://www.youtube.com/watch?v=2zz_XvKTVxI).

## Routes + Controllers in Rails

"Convention over configuration"

```bash
$ rails new movie_mania -T -d="postgresql" --skip-spring --skip-turbolinks
$ cd movie_mania
```

- `-T` - rails has minitest by default, when this flag is used, `gem 'minitest'` will not be in the Gemfile
- `-d="postgresql"` - by default, Rails uses `sqlite3`. We want to tell it to use `postgres` instead because sites that we use for deploying, expect a postgres database.
- `--skip-spring` - Spring is a Rails application preloader. It speeds up development by keeping your application running in the background so you don't need to boot it every time you run a test, rake task or migration but it benefits more advanced developers the most. We are going to not include it in our Gemfile.
- `--skip-turbolinks` - Enables faster page loading by using AJAX call behind the scenes but has some subtle edge cases where it will not work as expected. For those reasons, we don't enable it by default.

Take a few minutes to explore what `rails new` generates.

## Start with a Test

Let's install RSpec and dream drive our application!

Add gems to Gemfile and bundle:
  - `rspec-rails` = rspec test suite
  - `capybara` = allows us to interact with the DOM
  - `launchy` = allows us to save_and_open_page to see a live version on the browser
  - `pry` = debugging tool
  - `byebug`= built in rails debugger

Install RSpec

```bash
$ rails g rspec:install
```

What new files did this generate?
- a whole `spec` directory
- `.rspec` file
- `rails_helper` is the new `spec_helper`
- `spec_helper` - where we keep all specs that don't depend on rails
- `rails_helper` - rails related configuration

Now lets write a test!

```ruby
  # features/user_sees_all_movies_spec.rb
  require "rails_helper"

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

Run RSpec, what happens?

```bash
ActiveRecord::NoDatabaseError:
  FATAL:  database "mania_test" does not exist
```

How do we create a new database? Run `rake db:create`

Running Rspec again gives me this error `Uninitialized Constant Movie`, which leads us to add a model

```ruby
#models/movie.rb

class Movie < ApplicationRecord
end
```

We want this model to inherit from ActiveRecord so why ApplicationRecord? If we take a look around, we see a base file in the model directory called `application_record.rb`. Open that and peek around:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

That file inherits from ActiveRecord so we want to inherit from ApplicationRecord. This allows us to have a master model that could contain some shared methods.

Run Rspec again:

```bash
ActiveRecord::StatementInvalid:
   PG::UndefinedTable: ERROR:  relation "movies" does not exist
```

Now what? We have to create an actual table for my movies in my database. In Sinatra, how do we create a migration? `rake db:create_migration NAME=create_table`

In rails:

```bash
$ rails g migration CreateMovies title description:text
```

We have written the instructions for our database but haven't executed those instructions. Run `rake db:migrate`

Let's run RSpec again and see our error:

```bash
Failure/Error: visit "/movies"

     ActionController::RoutingError:
       No route matches [GET] "/movies"
     # ./spec/features/user_sees_all_movies_spec.rb:8:in `block (2 levels) in <top (required)>'
```

In `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  get '/movies', to: 'movies#index'
end
```

From the command line, we can see which routes we have available: `$ rake routes`. We should see this output:

```
Prefix Verb URI Pattern      Controller#Action
movies GET  /movies(.:format) movies#index
```

This means whenever a `get` request to `/movies` is received, have the `MoviesController` handle it with the `index` action (method). The `(.:format)` piece on the end of the URI pattern refers to things like `http://example.com/movies.csv` or `http://example.com/movies.pdf`, etc.

Based on our rake routes - what controller do we need? do we have it? Let's run our test and see what error we get:

```bash
Failure/Error: visit "/movies"

   ActionController::RoutingError:
     uninitialized constant MoviesController
```

Make a movies controller:

```bash
$ touch app/controllers/movies_controller.rb
```

Naming is important. The name of the file should be the plural of what it is handling (in this case, movies).

Inside of that file:

```ruby
class MoviesController < ApplicationController

end
```

When we RSpec now, we get another error:

```bash
The action 'index' could not be found for MoviesController
```

Let's add the index method:

What is ApplicationController? Look at the controllers folder and you should see an `application_controller.rb` file. This file defines the `ApplicationController` class, which (generally) all of your other controllers will inherit from.

Notice that the name of the class matches the name of the file (`movies_controller.rb` => `class MoviesController`), one snake-cased and one camel-cased.

Without a specific render line, Rails will automatically look for a view inside of a folder with the same name as the controller (`movies` folder), then look for a view with the same name as the method (`index.erb`).

Running Rspec again gives us this error:

```bash
ActionController::UnknownFormat:
    MoviesController#index is missing a template for this request format and variant.

    request.formats: ["text/html"]
    request.variant: []

    NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

What is this funny error?? We see a line `MoviesController#index is missing a template for this request format and variant.`. Template refers to an erb/html file. This means we are missing a erb/html file. In rails, we want to use `.html.erb` file extension.

WHY THO? Rails convention says that we should include the output type and the end with the `.erb` extension.

```html
#views/movies/index.html.erb

<h1>All Movies</h1>


<% @movies.each do |movie| %>
  <h2><%= movie.title %></h2>
  <p><%= movie.description %></p>
<% end %>  
```

Now when we run our tests, we see a new error:

```bash
undefined method 'each' for nil:NilClass
```

We have not defined our instance variable `@movies` so this makes sense! Let's do that:

```ruby
#controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
end
```

Run RSpec one last time and we have a passing test!

Start up your rails server: `rails server` or `rails s` from the command line.

Navigate to `localhost:3000/movies` and what do you see? NOTHING!

Let's add some movies in `rails console` and start the server again to see our movies!

### Workshop

1) Can you create a `new` route that would bring the user to a form where they can enter a new movie?

2) Can you create a `show` route that would allow a user to see one movie? Just like in Sinatra, the route will need a changeable `/:id`. You *do not* need to create a show view; just get a message like "You are viewing the show page" to show up.

3) Can you create an `edit` route that would allow a user to get to the edit page for a movie? Again, the route will need a changeable `/:id`. You *do not* need to create a form because you already have one! (Think about a partial); just get a message like "You are viewing the edit page" to show up.

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

Now try `$ rake routes`.

### Other things

* We can add a route for our root with:

```ruby
Rails.application.routes.draw do
  root 'movies#index'
end
```

This will direct any get request to `localhost:3000` to the `movies_controller.rb` `index` action.

## Wrap Up Questions

- How are routes applied in Rails?
- Where do our routes live?
- How is MVC implemented in Rails?

### Homework

* [Routes and Controllers Assignment](https://github.com/turingschool/challenges/blob/master/routes_controllers_rails.markdown)
