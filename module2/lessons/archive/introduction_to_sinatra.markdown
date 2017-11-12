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

Let's jot these down on an Etherpad. 

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

We're going to do some experiments with our task manager, so let's first checkout a new branch:

```
git checkout -b playground
```

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

### Experiment: Test Your Understanding of Routes

Try these two things: 

1) Add a new route and view so that the user can successfully visit "localhost:9393/easteregg" and see a new view of your choice. 
2) Add a new route so that the user can go to "localhost:9393/showmethetasks" and be redirected to all of the tasks. NOTE: You should not have to create a new view, nor should you use the `erb` method. 

Let's also quickly talk about why the 2nd path isn't a good idea. 

## Instance Variables, Local Variables, and the View

### Experiment: Locals vs. Instance Variables

Try this out:

1) Go to your controller, and change your `get '/tasks' do...` route to say this:

```ruby
get '/tasks' do
  tasks = Task.all
  erb :index, :locals => { :tasks => tasks }
end
```

2) Go to your `index.erb` view and remove the `@` from `@tasks`. It should now just say `tasks.each do...`. Does it work? Can you think of pros and cons for this versus the way we originally had it? 

### Notes: Locals vs. Instance Variables

With Sinatra, we're allowed to pass variables to rendered views with the `:locals` option. This is handy, but adds more overhead than is necessary.

Sinatra allows us to access instance variables defined in a particular route within that route's corresponding rendered view. Not only does this save us a little bit of code to write, this is very in line with how things work in Rails! For that reason alone, let's get into this habit, rather than use `:locals`.

To test out how well you understand what pieces were affected by our changes, go ahead and switch back to using the instance variable instead of the locals hash. 

## Views

Let's always save our views to a `views/` directory within project root. This is where Sinatra loads them from by default. [It is possible to change where Sinatra looks for the views](http://www.sinatrarb.com/configuration.html). 

In Sinatra, we're rendering views using `erb` files. This stands for Embedded Ruby. Essentially, we've got all the freedom we need to write HTML, but are able to interpolate Ruby when needed.

`<%= %>` allows us to interpolate variables.

We can also embed blocks with `erb`. Here's an example using `if`/`else`:

```ruby
<% if @tasks %>
  # do something
<% end %>
```

### Experiment: View Templating

1) Comment out your `erb :index` in your `/tasks` route and add `"Hello, world!" instead. It should look like this now:

```ruby
get '/tasks' do
  @tasks = Task.all
  # erb :index
  "Hello, world!"
end
```

Spin up the server, then refresh `/tasks`. 

With a partner, discuss these questions: 

1) Did this experiment work? What can you assume about the type of data a route needs to return? *Not a trick question :)* Once you've tried it out, take out `"Hello, world!"` and uncomment `erb :index`. 
2) Once you've determined the type of data that needs to be returned, discuss what you think must be happening step-by-step when `erb :index` is called in your controller. 
3) Check out a popular alternative to ERB: [HAML](http://haml.info/) and look at the box that compares erb to haml. What might be the pros and cons of using HAML instead of ERB? 

Want to go into depth with ERB? Read [this article](http://www.stuartellis.name/articles/erb/) on your own time. 

## Params

Sinatra is able to collect information from the client to pass to the server.

This information gets bundled up in a hash for us called `params`. Another thing Rails also does!

This `params` hash is typically populated in one of the following ways:

### Experiment: URL Query Params

Inside of your `get '/tasks' do...` route, add a pry like this:

```
get '/tasks' do
  require 'pry'; binding.pry
  @tasks = Task.all
  erb :index
end
```

Then navigate to this URL: `localhost:9393/tasks?location=Denver&institution=Turing%20School`. Go back to the terminal and type `params` to check out your parameters. 

With a partner, discuss these questions:

1) Where did these params come from, and what can you assume about the rules concerning params in a URL? 
2) How are spaces represented in a URL? 
3) Modify your `index.erb` to dynamically display the location from the URL. For example, if I visit the URL with `location=Denver`, then the top of my tasks page should say "You are located in Denver" and then show all of the tasks. Try changing the URL's location parameter a few times to make sure it's dynamic. 

### Notes: URL Query Params

The `?` signals that everything coming after it are params.

Keys are separated from their values by a `=`. 

Key/value pairs are separated by a `&`.

Therefore, our original URL would yield these params:

```ruby
params = {
  location: "Denver",
  institution: "Turing School"
}
```

Param keys can be accessed either by string (`params["institution"]`) or by symbol (`params[:institution]`). 

### Forms

Creating an HTML form with a `POST` request as its action delievers params as well. The difference, however, is that these params are nested within the body of the request, whereas the params from the URL are, well, in the URL. 

The keys are defined by the `name` attribute of the form, values coming from what the user enters in each field.

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

### No experiment, but discuss with a partner:

1) What would need to change in this form in order to produce these parameters (non-nested): 

```ruby
params = {
  title: "Whatever title user enters",
  description: "Whatever description user enters"
}
```

1) Why might you *want* to nest parameters? 

## Dynamic Parameters through the URL

### Experiment: Dynamic Params

Put a pry into your `get '/tasks/:id' do...` route like this:

```ruby
get '/tasks/:id' do
  require 'pry'; binding.pry
  @task = Task.find(params[:id])
  erb :show
end
```

1) Navigate to `/tasks/marshmallow`. Go back to the terminal. What do you expect to see when you type `params`? Go ahead and test it out. Then exit out of pry. 
2) Change `get '/tasks/:id'` to `get '/tasks/:name'`. Navigate to `/tasks/marshmallow`. What do you need to type into pry in order to get "marshmallow" back? 
3) With a partner, share your observations from these two experiments. What worked? What failed? What can you assume about the `:something` notation in a route? 
4) Put everything back to the way it was (see above code snippet for help, or test your own understanding by doing it by yourself). 

### Notes: Dynamic Parameters

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
