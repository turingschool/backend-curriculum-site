---
layout: page
title: Mix Master
subheading: Part 1 - Getting Started
---

# Mix Master: Getting Started

Welcome to Mix Master! We'll create an app where we keep track of songs, artists, and playlists. Maybe we'll even add in some user ownership. Who knows! It will be an adventure.

### Goals

By the end of this tutorial, you will know/be able to:

* deploy an app to Heroku
* write model tests using RSpec
* write feature tests using RSpec and Capybara
* use branches and commits to develop git workflow
* model one-to-many data relationships
* model many-to-many data relationships
* use factories to create objects to use in tests

<!-- Depending on if/when the rest of the tutorial gets written, you may also know/be able to:

* use partials and helpers to tidy up views
* model one-to-one data relationships
* use polymorphic associations to associate an object with one of several other models
* implement authentication using Twitter OAuth
* write controller and view specs -->

### Iterations:

* [1 Getting Started](1_getting_started.markdown)
* [2 Implementing artists](2_implementing_artists.markdown)
* [3 Implementing songs](3_implementing_songs.markdown)
* [3.1 Optional Additional Song Features](3_optional_additional_song_features.markdown)
* [4 Implementing Playlists](4_implementing_playlists.markdown)
* [5 Refactoring](5_refactoring.markdown)
* [6 Controller Tests](6_controller_tests.markdown)
* [7 Implementing users](7_implementing_users.markdown)
* [7.1 Extensions](wip-image-upload.markdown)


### Getting Started

Check that you have Rails installed. From your terminal, type:

```
$ rails -v
Rails 5.1.1
```

Create a new Rails project:

```
$ rails new mix_master -d postgresql -T
```

What do these things do?

* `-d postgresql` will give us a Rails project that already has Postgresql configured
* `-T` will not create MiniTest files for you by default (MiniTest comes with Rails by default)

### Using RSpec in Rails

So far, we've done a lot with [RSpec](https://github.com/rspec/rspec-rails) and we're going to continue using it for this tutorial. You should be comfortable with both MiniTest and RSpec. There are a few steps we'll take to configure RSpec for our Rails project.

1) Add RSpec as a dependency in the Gemfile. The `group :development, :test...` probably already exists in the Gemfile. You'll just need to add `gem 'rspec-rails'`.

```ruby
group :development, :test do
  gem 'rspec-rails'
end
```

2) Install this dependency:

```
$ bundle install
```

(`install` is the default for Bundler, so `bundle install` and `bundle` will get you the same behavior)

3) Run the generator to create initial RSpec setup:

```
$ rails generate rspec:install
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
```

This created a [`.rspec` file](https://www.relishapp.com/rspec/rspec-core/v/2-0/docs/configuration/read-command-line-configuration-options-from-files), a [`spec` directory](https://www.relishapp.com/rspec/rspec-rails/docs/directory-structure) (this is equivalent to the `test` directory if we were using Test::Unit), and [two helper files](https://relishapp.com/rspec/rspec-rails/docs/upgrade).

### Git Setup

Make sure your project is git initialized. If you're on Rails 5+, this should be done automatically for you. If not:

```
$ git init
```

Then add and commit:

```
$ git add .
$ git commit -m 'Initial commit.'
```

### Shipping to Heroku

We want to host our Rails application on the internet using the popular [Heroku](https://www.heroku.com/) service.

If you don’t already have one, you’ll need to create a [Heroku account](https://signup.heroku.com/www-header). After creating your account download and install the [Heroku Toolbelt](https://toolbelt.heroku.com/).

Heroku requires applications to use a PostgresSQL database and not a Sqlite database. Good thing we generated our Rails project with a Postgres database! Some people may choose to use Sqlite locally when running in test and development and PostgresSQL only on Heroku. This configuration is indeed possible; however, it's important to remember that these databases have slightly different behaviors, so something that works with Sqlite may not work with Postgres, and vice versa.

Now, let's ship to Heroku! This next command will only work if you installed the Heroku Toolbelt.

```
$ heroku create
Creating adjective-noun-number... done, stack is cedar-14
https://adjective-noun-number.herokuapp.com/ | https://git.heroku.com/adjective-noun-number.git
Git remote heroku added
```

The toolbelt will ask for your username and password the first time you run the create, but after that you’ll be using an SSH key for authentication.

After running the create command, you’ll get back the URL where the app is accessible. Try loading the URL in your browser and you’ll see the generic Heroku splash screen. This is because we haven't actually pushed our code to Heroku. All we did was create the remote.

Now push to Heroku:

```
$ git push heroku master
...
...lots and lots of output
...
remote: -----> Launching... done, v5
remote:        https://adjective-noun-number.herokuapp.com/ deployed to Heroku
```

Now navigate to your Heroku URL and **you should see an error**:

```
The page you were looking for doesn't exist.

You may have mistyped the address or the page may have moved.

If you are the application owner check the logs for more information.
```

Don't worry! Everything is fine. The reason we see this is because we haven't written any code yet.

### On to [Mix Master Part 2: Implementing Artists](2_implementing_artists.markdown)
