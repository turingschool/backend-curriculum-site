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
* create routes using `resources :songs`

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

## Starting a New Project

Let's create a whole new Rails app. We're going to use this codebase for the rest of the inning in mod 2. We're going to recreate an app very similar to what we started in Sinatra, but we'll be adding a LOT more to this version!

```bash
$ rails new set_list -T -d="postgresql" --skip-spring --skip-turbolinks
$ cd set_list
```

- `-T` - rails has minitest by default, when this flag is used, `gem 'minitest'` will not be in the Gemfile
- `-d="postgresql"` - by default, Rails uses `sqlite3`. We want to tell it to use `postgresql` instead because platforms we use for deploying our projects will expect to use a PostgreSQL database.
- `--skip-spring` - Spring is a Rails application preloader. It speeds up development by keeping your application running in the background so you don't need to boot it every time you run a test, rake task or migration but it benefits more advanced developers the most. We are going to not include it in our Gemfile.
- `--skip-turbolinks` - Enables faster page loading by using AJAX call behind the scenes but has some nasty/subtle edge cases where your app will not work as expected. For those reasons, we don't enable it by default.

Take a few minutes to explore what `rails new` generates. Which parts are the same as a Sinatra application? 

## Start with a Test

Let's install RSpec and dream drive our application!

### Add gems to Gemfile and run `bundle update`:
  - `rspec-rails` = rspec test suite
  - `capybara` = allows us to interact with the DOM
  - `launchy` = allows us to save_and_open_page to see a live version on the browser
  - `pry` = debugging tool
  - `byebug`= built in rails debugger

### Install and set up RSpec

```bash
$ rails g rspec:install
```

What new files did this generate?
- a whole `spec` directory
- `.rspec` file
- `rails_helper` is the new `spec_helper`
- `spec_helper` - where we keep all specs that don't depend on rails
- `rails_helper` - rails related configuration

### Now lets write a test!

```ruby
  # features/user_sees_all_songs_spec.rb
  require "rails_helper"

  describe "user_index" do
    it "user_can_see_all_songs" do
      song_1 = Song.create(title: "Don't Stop Believin'", length: 303, play_count:123456)
      song_2 = Song.create(title: "Never Gonna Give You Up", length: 253, play_count:987654321)

      visit "/songs"

      expect(page).to have_content("All Songs")
      expect(page).to have_content(song_1.title)
      expect(page).to have_content("Plays: #{song_1.play_count}")
      expect(page).to have_content(song_2.title)
      expect(page).to have_content("Plays: #{song_2.play_count}")
    end
  end
```

Run RSpec, what happens?

```bash
ActiveRecord::NoDatabaseError:
  FATAL:  database "set_list_test" does not exist
```

How do we create a new database? Run `rake db:create`

Running Rspec again gives me this error `Uninitialized Constant Song`, which leads us to add a model

```ruby
#models/song.rb

class Song < ApplicationRecord
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
   PG::UndefinedTable: ERROR:  relation "songs" does not exist
```

Now what? We have to create an actual table for my songs in my database. In Sinatra, how do we create a migration? `rake db:create_migration NAME=create_table`

In rails:

```bash
$ rails g migration CreateSongs title:string length:integer play_count:integer
```

We have written the instructions for our database but haven't executed those instructions. Run `rake db:migrate`

Let's run RSpec again and see our error:

```bash
Failure/Error: visit "/songs"

     ActionController::RoutingError:
       No route matches [GET] "/songs"
     # ./spec/features/user_sees_all_songs_spec.rb:8:in `block (2 levels) in <top (required)>'
```

In `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  get '/songs', to: 'songs#index'
end
```

From the command line, we can see which routes we have available: `$ rake routes`. We should see this output:

```
Prefix Verb URI Pattern      Controller#Action
songs GET   /songs(.:format) songs#index
```

This means whenever a `get` request to `/songs` is received, have the `SongsController` handle it with the `index` action (method).

Don't worry about the `(.:format)` piece on the end of the URI pattern. You'll use that more in mod3. It refers to things like `http://example.com/songs.csv` or `http://example.com/songs.pdf`, etc.

Based on our rake routes - what controller do we need? do we have it? Let's run our test and see what error we get:

```bash
Failure/Error: visit "/songs"

   ActionController::RoutingError:
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

When we RSpec now, we get another error:

```bash
The action 'index' could not be found for SongsController
```

Let's add the index method:

What is ApplicationController? Look at the controllers folder and you should see an `application_controller.rb` file. This file defines the `ApplicationController` class, which (generally) all of your other controllers will inherit from.

Notice that the name of the class matches the name of the file (`songs_controller.rb` => `class SongsController`), the file is "snake-cased" and the class name is "camel-cased".

Without a specific `render` command in our action method, Rails will automatically look for a folder with the same name as the controller (`songs` folder), then look for a view with the same name as the method (`index.erb`).

Running Rspec again gives us this error:

```bash
ActionController::UnknownFormat:
    SongsController#index is missing a template for this request format and variant.

    request.formats: ["text/html"]
    request.variant: []

    NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

What is this funny error?? We see a line `SongsController#index is missing a template for this request format and variant.`. Template refers to an erb/html file. This means we are missing a erb/html file. In rails, we want to use `.html.erb` file extension.

WHY THO? Rails convention says that we should include the output type and end with the `.erb` extension.

```html
#views/songs/index.html.erb

<h1>All Songs</h1>


<% @songs.each do |song| %>
  <h2><%= song.title %></h2>
  <p>Plays: <%= song.play_count %></p>
<% end %>  
```

Now when we run our tests, we see a new error:

```bash
undefined method 'each' for nil:NilClass
```

We have not defined our instance variable `@songs` so this makes sense! Let's do that:

```ruby
#controllers/songs_controller.rb
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end
end
```

Run RSpec one last time and we have a passing test!

Start up your rails server: `rails server` or `rails s` from the command line.

Navigate to `localhost:3000/songs` and what do you see? NOTHING!

#### Check for Understanding

Why don't we have any data on our page even though we created data in our test? 


Let's add some songs in `rails console` and start the server again to see our songs!

### Workshop

```
As a user
When I visit a new route
Then I see a form with fields for title and length
```

```
As a user
When I visit a show route
Then I see the title of a song
Then I see the length of a song
```

Just like in Sinatra, the route will need a changeable `/:id`. You *do not* need to create a `show` view; just get a message like "You are viewing the show page" to show up.


```
As a user
When I visit an edit route for a specific song
Then I see a form with a title field
Then I see a form with a length field
Then I see each field pre-populated with the song's data
```

Again, the route will need a changeable `/:id`. You *do not* need to create a form because you already have one! (Think about a partial); just get a message like "You are viewing the edit page" to show up.


```
As a user
When I visit show or edit
Then I see the id of the song
```

Display the id param in the text that you render. You *do not* need to create a form; just get a message like "You are editing song 2" to show up.

In Sinatra, you could access the `:id` from the URL like this:

```ruby
get '/songs/:id' do |id|
  puts id
end
```

In Rails, you'll need to use `params[:id]`.

### Using Resources in the Routes File

**Turn & Talk** 
What are the common CRUD actions? They match up to eight routes. Can you name all of them?


Since Rails is all about "convention over configuration", it has a nice way of allowing us to easily create all eight RESTful routes at one time via a shortcut.

We can use the shortcut `resources`. As an example, we can change our `config/routes.rb` file to to look like this:

```ruby
Rails.application.routes.draw do
  resources :songs
end
```

Now let's look at the routes we have available: `$ rake routes`.

Using `resources :songs` gives us eight RESTful routes that correspond to CRUD functionality.

```
   Prefix Verb   URI Pattern               Controller#Action
    songs GET    /songs(.:format)          songs#index
          POST   /songs(.:format)          songs#create
 new_song GET    /songs/new(.:format)      songs#new
edit_song GET    /songs/:id/edit(.:format) songs#edit
     song GET    /songs/:id(.:format)      songs#show
          PATCH  /songs/:id(.:format)      songs#update
          PUT    /songs/:id(.:format)      songs#update
          DELETE /songs/:id(.:format)      songs#destroy
```

Any methods with `:id` require an id to be passed into the URL. These values are dynamically added (like viewing the seventh song via `/songs/7`).

#### Questions:

* What actions (methods) would we need in our `SongsController` in order to handle all of these routes?
* Which actions would render a form and which actions would redirect?

Don't worry about putting `render :text` in these actions. You won't be able to test out `post`, `patch`, `put`, or `delete` by navigating in your browser.

If you add a whole bunch of `resources :things` to your routes file, it will generate these eight routes for all of the things you've specified:

```ruby
Rails.application.routes.draw do
  resources :songs
  resources :artists
  resources :playlists
end
```

Now try `$ rake routes`.

### Other things

* We can add a route for our root with:

```ruby
Rails.application.routes.draw do
  root 'songs#index'
end
```

This will direct any get request to `localhost:3000` to the `songs_controller.rb` `index` action.

## Wrap Up Questions

- How are routes applied in Rails?
- Where do our routes live?
- How is MVC implemented in Rails?

### Homework

* [Routes and Controllers Assignment](https://github.com/turingschool/challenges/blob/master/routes_controllers_rails.markdown)
