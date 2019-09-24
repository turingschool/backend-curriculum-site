---
title: REST, Routing, and Controllers in Rails
length: 90
tags: rest, routing, controllers, routes, rspec
---

## Learning Goals

* create a new rails app
* explain/implement feature tests
* explain the purpose of the `routes.rb` file
* interpret the output of `rake routes`
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

## Warm Up

- What is REST?
- Where do our routes live?

## Reminder - REST

* Representational State Transfer is a web architecture style
* Purpose: Aims to give a URI (uniform resource identifier) to everything that can be manipulated and let the software determine what to do from there
* [Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer) on Wikipedia
* [What is Rest?](http://www.restapitutorial.com/lessons/whatisrest.html) from REST API Tutorial

Want to know more about REST? Check out [this video](https://www.youtube.com/watch?v=2zz_XvKTVxI).

## Routes + Controllers in Rails

"Convention over configuration"

# Starting a New Project

## Create your app

Let's create a whole new Rails app. We're going to use this codebase for the rest of the inning in mod 2.

```bash
$ rails new set_list -T --database=postgresql --skip-spring --skip-turbolinks
$ cd set_list
```

- `-T` - rails has minitest by default, when this flag is used, `gem 'minitest'` will not be in the Gemfile
- `--database=postgresql` - by default, Rails uses `sqlite3`. We want to tell it to use `postgresql` instead because platforms we use for deploying our projects will expect to use a PostgreSQL database.
- `--skip-spring` - Spring is a Rails application preloader. It speeds up development by keeping your application running in the background so you don't need to boot it every time you run a test, rake task or migration but it benefits more advanced developers the most. We are going to not include it in our Gemfile.
- `--skip-turbolinks` - Enables faster page loading by using AJAX call behind the scenes but has some nasty/subtle edge cases where your app will not work as expected. For those reasons, we don't enable it by default.

Take a few minutes to explore what `rails new` generates.

## Gems

Add the following Gems to your Gemfile. Since these are all testing/debugging tools, we will add them inside the existing `group :development, :test` block:

  - `rspec-rails` = our test suite
  - `capybara` = gives us tools for feature testing
  - `launchy` = allows us to save_and_open_page to see a live version on the browser
  - `pry` = debugging tool
  - `simplecov` = track test coverage

Your Gemfile should now have:

```ruby
group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'pry'
  gem 'simplecov'
end
```

Always run `bundle install` whenever you update your Gemfile.

## Install and set up RSpec

```bash
$ rails g rspec:install
```

What new files did this generate?

- `./.rspec` file
- a whole `./spec/` directory
- `./spec/rails_helper.rb` is the new `spec_helper`, holds Rails-specific configurations
- `./spec/spec_helper.rb` - where we keep all specs that don't depend on rails

## Configure SimpleCov

At the top of your `rails_helper.rb`, add these lines:

```ruby
require 'simplecov'
SimpleCov.start
```

# Feature Testing

## What are Feature Tests?

* Feature tests mimic the behavior of the user: In the case of web apps, this behavior will be clicking, filling in forms, visiting new pages, etc.
* Just like a user, the feature test should not need to know about underlying code
* Based on user stories

## What are User Stories?

* A tool used to communicate user needs to software developers.
* They are used in Agile Development, and it was first introduced in 1998 by proponents of Extreme Programming.
* They describe what a user needs to do in order to fulfill a function.
* They are part of our "top-down" design.

```txt
As a user
When I visit the home page
  And I fill in title
  And I fill in description
  And I click submit
Then my task is saved
```

We can generalize this pattern as follows:

```
As a [user/user-type]
When I [action]
And I [action]
And I [action]
...
Then [expected result]
```

Depending on how encompassing a user story is, you may want to break a single user story into multiple, smaller user stories.

## Capybara: Feature Testing Tools

[Capybara](https://github.com/teamcapybara/capybara#using-capybara-with-rspec)

Capybara is a Ruby test framework that allows you to feature test any RACK-based app.

It provides a DSL (domain specific language) to help you query and interact with the DOM.

For example, the following methods are included in the Capybara DSL:

* `visit '/path'`
* `expect(current_path).to eq('/')`
* `expect(page).to have_content("Content")`
* `within ".css-class"  { Assertions here }`
* `within "#css-id"  { Assertions here }`
* `fill_in "identifier", with: "Content"`
* `expect(page).to have_link("Click here")`
* `click_link "Click Here"`
* `expect(page).to have_button("Submit")`
* `click_button "Submit"`
* `click_on "identifier"`

## Always, Always, Always, Write Tests First

As usual, we are going to TDD our applications. There are two approaches we could take here:

1. Bottom Up: Start with the smallest thing you can build and work your way up. In the context of a web app, this means you start at the database level (model tests).
1. Top Down: Start at the end goal and work your way down. In the context of a web app, this means you start by thinking about how a user interacts with the application (feature tests).

Both are valid approaches. We are going to work Top Down. We will start with this user story:

```text
As a user,
when I visit '/songs'
I see each songs title and play count
```

## Create the test file

First, let's make a directory for our feature tests:

```bash
$ mkdir spec/features
```

And a directory for all features related to `songs`:

```bash
$ mkdir spec/features/songs
```

Finally, create your test file:

```bash
$ touch spec/features/songs/user_can_see_all_songs_spec.rb
```

The names of the files you create for feature testing MUST end in `_spec.rb`. Without that 'spec' part of the filename, RSpec will completely ignore the file.

How many tests should go in one file? It's totally up to you, but having multiple tests in a file is marginally faster than putting a single test in a single file. Also, grouping lots of tests into one file allows you to share the setup across your tests.

You can group your test files into subfolders to organize them in a similar format to your `/app/views` folder, and can help with strong organization. Every team you work on, every job you have, could have a completely different organizational method for test files, so keep that 'growth mindset' and be flexible!

```
/spec
/spec/features
/spec/features/songs
/spec/features/songs/user_can_see_all_songs_spec.rb 
/spec/features/songs/user_can_see_one_song_spec.rb
etc
```

## Writing the Test

Inside our `user_can_see_all_songs_spec.rb `:

```ruby
require 'rails_helper'

RSpec.describe "songs index page", type: :feature do
  it "can see all songs titles and play count" do
    song_1 = Song.create(title:       "I Really Like You",
                         length:      208,
                         play_count:  243810867)
    song_2 = Song.create(title:       "Call Me Maybe",
                         length:      199,
                         play_count:  1214722172)

    visit "/songs"

    expect(page).to have_content(song_1.title)
    expect(page).to have_content("Play Count: #{song_1.play_count}")
    expect(page).to have_content(song_2.title)
    expect(page).to have_content("Play Count: #{song_2.play_count}")
  end
end

```

# Developing the Index Page

## Set up the Database

Run `rspec`, what happens?

```bash
ActiveRecord::NoDatabaseError:
  FATAL:  database "set_list_test" does not exist
```

Currently, our database does not exist. In order to create your database, run:

```bash
rails db:create
```

Running RSpec again gives me this error `Uninitialized Constant Song`.

Since this is happening on a line of code that does `Song.create` that tells us that we don't have a `Song` model, so let's go make one.

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

That file inherits from `ActiveRecord` already, so if we inherit from `ApplicationRecord` then we'll also inherit `ActiveRecord`. This allows us to have a master model that could contain some shared methods/behaviors.

Run `rspec` again:

```bash
ActiveRecord::StatementInvalid:
   PG::UndefinedTable: ERROR:  relation "songs" does not exist
```

Errors that start with "PG::" from ActiveRecord failures can indicate problems at a PostgreSQL database level.

In this case, PostgreSQL is telling us that we have an "undefined table". We have to create an actual table for songs in the database.

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
class CreateSongs < ActiveRecord::Migration[5.1]
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







## Route the Request

Let's run RSpec again and see our error:

```bash
Failure/Error: visit "/songs"

     ActionController::RoutingError:
       No route matches [GET] "/songs"
     # ./spec/features/user_sees_all_songs_spec.rb:8:in `block (2 levels) in <top (required)>'
```

Rails doesn't know how to route a `GET` request to `/songs`, so let's tell it how to do that:

In `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  get '/songs', to: 'songs#index'
end
```

Remember, an HTTP request includes both the verb (`GET` in this case) and the path (`/songs`).

The second argument, `to: 'songs#index'`, tells rails what controller action should handle the request.

From the command line, we can see which routes we have available by running `$ rake routes`. We should see this output:

```
Prefix Verb URI Pattern      Controller#Action
songs  GET  /songs(.:format) songs#index
```

This means whenever a `get` VERB is used in a request to the path `/songs`, the application will look at a "Songs" controller, and look for an "action method" in there called `index`.

Don't worry about the `(.:format)` piece on the end of the URI pattern. You'll use that more in mod3 and allows us to retrieve resource data in different formats than HTML, such as CSV or XML.

**Based on our rake routes - what controller do we need? do we have it?**

Now that we've made the route that RSpec was looking for, let's run `rspec` to see if the error changed.

```bash
Failure/Error: visit "/songs"

   ActionController::RoutingError:
     uninitialized constant SongsController
```

**TDD is now telling us step-by-step what to go build next.**

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

When we run RSpec now, we get another error:

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

### Rendering the View

Running Rspec again gives us this error:

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

Now that we've give our action a template, let's see what RSpec gives us:

```bash
1) songs index page user can see all songs
   Failure/Error: expect(page).to have_content(song_1.title)
     expected to find text "Don't Stop Believin'" in ""
   # ./spec/features/songs/index_spec.rb:10:in `block (2 levels) in <top (required)>'
```

Capybara isn't finding the text we expect because our view is empty. Within `app/views/songs/index.html.erb`, add this code:

```html
<h1>All Songs</h1>

<% @songs.each do |song| %>
  <h2><%= song.title %></h2>
  <p>Play Count: <%= song.play_count %></p>
<% end %>  
```

Now when we run our tests, we see a new error:

```bash
undefined method 'each' for nil:NilClass
```

We have not defined our instance variable `@songs` so this makes sense! Remember, we can define instance variables in our controller action to make them available in views. Lets go do that:

```ruby
#controllers/songs_controller.rb
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end
end
```

Run RSpec one last time and we have a passing test!

### Checking our work in the Development Environment

Everything seems to be working in our "Test" environment, but we should also check our "Development" environment.

Start up your rails server: `rails server` or `rails s` from the command line.

Navigate to `localhost:3000/songs` and what do you see? NOTHING!

Why don't we have any data on our page even though we created data in our test?

### Adding data to our Development Environment

Run `rails console` or `rails c` form the command line. The Rails Console allows us to interact with our app directly in Development. Let's add some songs and start the server again to see our songs!

```ruby
Song.create(title: "Don't Stop Believin'", length: 251, play_count: 760847)
Song.create(title: "Don't Worry Be Happy", length: 280, play_count: 65862)
Song.create(title: "Chicken Fried", length: 183, play_count: 521771)
Song.create(title: "Radioactive", length: 10000, play_count: 623547)
```

## Checks for Understanding

- What setup do you need to do to start a new Rails application?
- What is a feature test?
- What is Capybara?
- What is a migration?
- What `rake` command do you use to create a database?
- What `rake` command do you use to apply migrations?
- Where do our routes live?
- What is the syntax to define a route?
- How is MVC implemented in Rails?
- Explain the four pieces of information that `rake routes` give us.
- In a Rails app, what is an "action"?
- Where does Rails look for a view by default?

### More Reading

Read [this article](https://www.theodinproject.com/courses/ruby-on-rails/lessons/routing).
