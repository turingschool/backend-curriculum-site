---
title: Handling Requests
length: 90
tags: rest, routing, controllers, routes, rspec
---

This lesson plan last updated to use Rails 5.2.4.3 and Ruby 2.5.3

## Learning Goals

* create a new rails app
* explain the purpose of the `routes.rb` file
* interpret the output of `rails routes`
* explain the connection between `routes.rb` and controller files
* create routes by hand
* create and migrate a database
* create a basic view to render some data

## Vocabulary

* CRUD
* MVC
* Migration
* HTTP Request
* HTTP Response
* route
* action

# Setup

## Create your app

Let's create a whole new Rails app. We're going to use this codebase for the rest of the inning in mod 2.

```bash
$ rails _5.2.4.3_ new set_list -T --database=postgresql --skip-spring --skip-turbolinks
$ cd set_list
```

- `_5.2.4.3_` Denotes that we want to use rails version 5.2.4.3.
- `-T` - rails has minitest by default, when this flag is used, `gem 'minitest'` will not be in the Gemfile
- `--database=postgresql` - by default, Rails uses `sqlite3`. We want to tell it to use `postgresql` instead because platforms we use for deploying our projects will expect to use a PostgreSQL database.
- `--skip-spring` - Spring is a Rails application preloader. It speeds up development by keeping your application running in the background so you don't need to boot it every time you run a test, rake task or migration but it benefits more advanced developers the most. We are going to not include it in our Gemfile.
- `--skip-turbolinks` - Enables faster page loading by using AJAX call behind the scenes but has some nasty/subtle edge cases where your app will not work as expected. For those reasons, we don't enable it by default.

Take a few minutes to explore what `rails new` generates.

## Gems

Add `pry` to your `group :development, :test` block in your Gemfile. You can also remove `byebug`:

```ruby
group :development, :test do
  gem 'pry'
end
```

Always run `bundle` or `bundle install` whenever you update your Gemfile.

## Create the Database

If you try to run your server with `rails s` and visit `localhost:3000` in your browser you will see the error:

```
FATAL: database "set_list_development" does not exist
```

Let's create our app's database with

```
rails db:create
```

Refresh the page and you should see "Yay! You're on Rails!"

# End of Setup

# Developing the Index Page

<blockquote>  
"Convention over Configuration"
</blockquote>  

\- From [The Rails Doctrine](https://rubyonrails.org/doctrine/#convention-over-configuration) by David Heinemeier Hansson (DHH) in January, 2016

Our first feature of our SetList app will be a Songs index page. Using ReST as convention, we want our app to be able to:

* Receive a GET request to /songs
* Respond with a web page showing all songs

We can simulate a GET request by typing the url into our web browser. Run your Rails server with `rails s` and navigate to `localhost:3000/songs`.

## Routing the Request

Our first error when we visit `localhost:3000/songs` is a RoutingError `No route matches [GET] "/songs"`.

Rails doesn't know how to route a `GET` request to `/songs`, so let's tell it how to do that:

In `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  get '/songs', to: 'songs#index'
end
```

Remember, an HTTP request includes both the verb (`GET` in this case) and the path (`/songs`).

The second argument, `to: 'songs#index'`, tells Rails what controller action should handle the request. The format is `<controller>#<action>`. In this format, the controller name is snaked case. Rails will interpret this snake case into a camel-cased controller name. For example, `to: snake_cased_names#index` would look for a `SnakeCasedNames` controller.

From the command line, we can see which routes we have available by running `$ rails routes`. We should see this output:

```
Prefix Verb URI Pattern      Controller#Action
songs  GET  /songs(.:format) songs#index
```

This means whenever a `get` VERB is used in a request to the path `/songs`, the application will look at a "Songs" controller, and look for an "action method" in there called `index`.

Don't worry about the `(.:format)` piece on the end of the URI pattern. You'll use that more in mod3 and allows us to retrieve resource data in different formats than HTML, such as CSV or XML.

**Based on our rails routes - what controller do we need? do we have it?**

Let's refresh our browser request to `localhost:3000/songs`.

```bash
  uninitialized constant SongsController
```

Make a songs controller:

```bash
$ touch app/controllers/songs_controller.rb
```

Naming is important. The **name of the file should be the plural of what it is handling** (in this case, songs).

Inside of that file:

```ruby
class SongsController < ApplicationController

end
```

Notice that the name of the class matches the name of the file (`songs_controller.rb` => `class SongsController`), the file is "snake-cased" and the class name is "camel-cased".

What is ApplicationController? Look at the controllers folder and you should see an `application_controller.rb` file. This file defines the `ApplicationController` class, which (generally) all of your other controllers will inherit from. This is very similar to how we have an `ApplicationRecord` which all of our models inherit from.

When we refresh our browser, we get this error:

```bash
The action 'index' could not be found for SongsController
```

Let's add the index action:

```ruby
class SongsController < ApplicationController
  def index
  end
end
```

An `action` in the context of a rails app is just a method defined inside a Controller.

We have now successfully routed our request to a controller action.

### Rendering the View

Refresh the page again and you should see this error:

```bash
ActionController::UnknownFormat:
    SongsController#index is missing a template for this request format and variant.

    request.formats: ["text/html"]
    request.variant: []

    NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

Remember, HTTP consists of both requests and **responses**. At this point, we have set up our App to receive a request, but haven't told it how to respond. By default, rails will try to respond by rendering a view. It automatically looks for a view folder with the same name as the controller (`app/views/songs` folder), then look for a template file with the same name as the action method (`index.html.erb`). We can override this behavior by using the `render` or `redirect` commands, but for now we will follow the Rails convention:

```bash
$ mkdir app/views/songs
$ touch app/views/songs/index.html.erb
```

Rails convention says that we should include the output format type in the filename and then the `.erb` extension. That's why this file is `index.html.erb` rather than `index.erb`. The latter would work, but it would not be following convention.

Refresh your page and you should see a blank page. We have successfully rendered a response.

## Database Setup

We want this page to show all the Songs from our database. Let's set up our Songs table.

We are going to need a **migration** in order to create a table. Any time we need to alter the structure of our database, we are going to do so with a migration. Other examples of what you might need a migration for:

* Creating a Table
* Adding/removing a column from a table
* Renaming a table/column

Luckily, Rails gives us some built in syntax for generating migrations:

```bash
$ rails g migration CreateSongs title:string length:integer play_count:integer
```

Look inside the `db/migrate` folder and you should see a file named something like `20190422213736_create_songs.rb`. That number at the beginning is a timestamp, so yours will be different. Inside it, you should see:

```ruby
class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :length
      t.integer :play_count
    end
  end
end
```

We're also going to add timestamps to our Song model, so add that line to the `create_table` block:

```ruby
create_table :songs do |t|
  t.string :title
  t.integer :length
  t.integer :play_count

  t.timestamps
end
```

We have written the instructions for our database but haven't executed those instructions. Run `rails db:migrate`.

Our Database should be good to go.

## Song Model

Now that we have our table set up, we will need to create a corresponding Model in order to interact with that table from our Ruby code.

```bash
$ touch app/models/song.rb
```

Note that our model files will always be named in singular form (`song.rb`, not `songs.rb`)

In `song.rb`:

```ruby
class Song < ApplicationRecord
end
```

We want this model to inherit from `ActiveRecord` so why are we using `ApplicationRecord` instead? If we take a look around, we see a file in the `app/models` directory called `application_record.rb`. Open that and peek around:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

That file inherits from `ActiveRecord` already, so if we inherit from `ApplicationRecord` then we'll also inherit `ActiveRecord`. This allows us to have a parent model that could contain some shared methods/behaviors.

## Creating Songs

In order to see Songs on our index page, we are going to need to create some Songs. We might later add in a feature where can create a new song with a form, but we don't have the feature yet, so we are going to have to insert Songs into our database manually.

Let's open up the Rails console with `rails console` or `rails c` from the command line.

The Rails console will give you access to your development database through your models. If you enter `Song.all` into the console, you should get back an empty ActiveRecord Relation. This is because we don't have any Songs in our database yet, so let's create some:


```
irb(main):015:0> Song.create(title: "I Really Like You", length: 208, play_count: 23546543)
irb(main):016:0> Song.create(title: "Call Me Maybe", length: 431, play_count: 8759430)
```

You should see this output:

```
   (0.3ms)  BEGIN
  Song Create (0.5ms)  INSERT INTO "songs" ("title", "length", "play_count", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["title", "I Really Like You"], ["length", 208], ["play_count", 23546543], ["created_at", "2020-08-10 20:45:58.643242"], ["updated_at", "2020-08-10 20:45:58.643242"]]
   (0.5ms)  COMMIT

...
   (0.4ms)  BEGIN
  Song Create (0.4ms)  INSERT INTO "songs" ("title", "length", "play_count", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["title", "Call Me Maybe"], ["length", 431], ["play_count", 8759430], ["created_at", "2020-08-10 20:46:21.379206"], ["updated_at", "2020-08-10 20:46:21.379206"]]
   (1.7ms)  COMMIT
```

You can see in this output that our ActiveRecord commands were translated into SQL to insert new rows into the database.

Now if we do `Song.all`, we should see some Songs coming back from our Database.

## Displaying Songs in the View

Now that we have Songs in our Database, let's retrieve them in our controller action:

```ruby
#controllers/songs_controller.rb
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end
end
```

Remember, any instance variables you create in the controller action will be available in the view.

Let's display these songs in the view:

```html
# app/views/songs/index.html.erb
<h1>All Songs</h1>

<% @songs.each do |song| %>
  <h2><%= song.title %></h2>
  <p>Play Count: <%= song.play_count %></p>
<% end %>  
```

Start up your rails server: `rails server` or `rails s` from the command line.

Navigate to `localhost:3000/songs` to see your songs.

## Checks for Understanding

- What setup do you need to do to start a new Rails application?
- What is a migration?
- What command do you use to create a database?
- What command do you use to apply migrations?
- Where do our routes live?
- What is the syntax to define a route?
- How is MVC implemented in Rails?
- Explain the four pieces of information that `rails routes` give us.
- In a Rails app, what is an "action"?
- Where does Rails look for a view by default?

### More Reading

Read [this article](https://www.theodinproject.com/courses/ruby-on-rails/lessons/routing).
