---
title: Introduction to Sinatra
length: 60
tags: sinatra
---

## Goals

By the end of this lesson, you will know/be able to:

* identify use cases for Sinatra
* define routes
* pass local and instance variables to the view
* access form data through params

## Prework

Before this lesson, students should already have completed [WebGuesser](http://tutorials.jumpstartlab.com/projects/web_guesser.html) and [Task Manager](https://github.com/s-espinosa/task_manager_redux).

## Sinatra Questions from Intermission Prework?

Let's jot these down on the whiteboard.

## Sinatra Use Cases

Biggest use case? You want to serve a Ruby application with some sort of user interface, fast! Sinatra is lightweight, meaning it doesn't add too many files/too much complexity on top of raw Ruby.

## [Modular Sinatra Setup](http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style)

It's almost always the case that we want to use Modular vs Classic Sinatra (except for the case of teeny applications like Web Guesser).

```ruby
# Gemfile

source 'https://rubygems.org'

gem 'sinatra', require: 'sinatra/base'
gem 'shotgun'
gem 'sqlite3'
gem 'pry'
```

```ruby
# config.ru

require 'bundler'
Bundler.require

$LOAD_PATH.unshift(File.expand_path("app", __dir__))

require 'controllers/task_manager_app'

run TaskManagerApp
```

```ruby
# app/controllers/task_manager_app.rb

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

end
```

Once that's set, it's just a matter of:

```bash
bundle install
bundle exec shotgun
```

## CRUD / HTTP Verbs && Client vs. Server

Let's step back from Sinatra for a moment to talk generally about the web.

## [Routes](http://www.sinatrarb.com/intro.html#Routes)

Routes in Sinatra are defined as part of its DSL (Domain Specific Language).

These routes should look similar to other `do`/`end` blocks you're used to from Ruby.

The first keyword of these routes corresponds with the **HTTP verb** the request is making to the route.

The param this keyword takes is a string version of the **path** the request is being made to.

Inside the block, we tell Sinatra how to handle the request.

### How Do We Handle Route Requests?

Most likely with one of the following:

* `erb`
* `redirect`

## Instance Variables and the View

With Sinatra, we're allowed to pass variables to rendered views with the `:locals` option. This is handy, but adds more overhead than is necessary.

Sinatra allows us to access instance variables defined in a particular route within that route's corresponding rendered view. Not only does this save us a little bit of code to write, this is very in line with how things work in Rails! For that reason alone, let's get into this habit, rather than use `:locals`.

## Views

Let's always save our views to a `views/` directory within project root. This is where Sinatra loads them from by default.

In Sinatra, we're rendering views using `erb` files. This stands for Embedded Ruby. Essentially, we've got all the freedom we need to write HTML, but are able to interpolate Ruby when needed.

`<%= %>` allows us to interpolate variables.

We can also embed blocks with `erb`. Here's an example using `if`/`else`:

```ruby
<% if @tasks %>
  # do something
<% end %>
```

## Params

Sinatra is able to collect information from the client to pass to the server.

This information gets bundled up in a hash for us called `params`. Another thing Rails also does!

This `params` hash is typically populated in one of the following ways:

### URL Query Params

Take a look at this URL:  `http://example.com?name=Lauren&role=instructor`.

That `?` signals that everything coming after it are params.

Keys and values pairs are separated by `&`.

This would yield:

```ruby
params = {
  name: "Lauren",
  role: "instructor"
}
```

### Forms

Creating an HTML form with a `POST` request as its action does essentially the same thing. The keys are defined by the `name` attribute of the form, values coming from what the user enters in each field.

```ruby
<form action="/tasks" method="post">
  <p>Enter a new task:</p>
  <input type='text' name='task[title]'/><br/>
  <textarea name='task[description]'></textarea><br/>
  <input type='submit'/>
</form>
```

In the case above, the `name` attribute is creating a nested `task` hash, so `params` would look like this:

```ruby
params = {
  task: {
    title: "Whatever title user enters",
    description: "Whatever description user enters"
  }
}
```

### URL Params

Sometimes, you want a user to be able to load things dynamically based on something like an `id`.

Sinatra allows you to define routes with dynamic segments. The `:` segment of this route denotes a named segment. When the URL is accessed and something is populated in that segment of the URL, the name of the segment defined in your routes becomes the key, the populated segment of the URL becomes the value.

For example, if the following was defined in our routes:

```ruby
get '/tasks/:id' do
  # do something with params[:id]
end
```

If we visited `/tasks/1`, `params` would look like this:

```ruby
params = {
  id: 1
}
```

It's always a good idea to `pry` in and check out `params`!

<!-- [Slides](https://www.dropbox.com/s/k9b5ppidhdyw29o/Sinatra-Intro.pdf?dl=0) -->

## Other Resources

* [Rails Girls Intro to Sinatra Tutorial](http://guides.railsgirls.com/sinatra-app/)
* [Sinatra Documentation](http://www.sinatrarb.com/intro.html)
