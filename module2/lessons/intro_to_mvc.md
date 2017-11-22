---
layout: page
title: Introduction to MVC
---

## Learning Goals

* Identify the elements of the MVC pattern
* Describe the single responsibility of the each of the Model, View, and Controller
* Describe how data is passed through the MVC pattern

## Vocabulary 
* MVC
* Model 
* View
* Controller
* DSL(Domain Specific Language)

## Warmup

* In your own words, what are the primary responsibilities of the models, views, and controllers in Task Manager?

## Lecture

### Overview

* Controllers - Coordinate the response to an HTTP request. It is common to have multiple controllers. In Task Manager, we only utilized one controller.
* Models - Interact with the database. Holds other methods related to a particular resource (e.g. a `task`)
* Views - Templates for pages that we will display to our user. Frequently contain placeholders for data, making them dynamic.

### Controller

Look at your Task Manager controller.

* Routes in Sinatra are defined as part of its DSL (Domain Specific Language).
* These routes should look similar to other `do`/`end` blocks you're used to from Ruby.
* The first keyword, a predefined method, of these routes corresponds with the **HTTP verb** the request is making to the route.
* The argument this method takes is a string version of the **path** the request is being made to.
* Inside the block, we tell Sinatra how to handle the request.

### Model

Look at your Task model.

* Includes methods to interact with the database
    * `::all`
    * `::find(id)`
    * `::update(id, task_params)`
    * `::destroy(id)`
    * `#save`
* Every controller within the controllers directory will have access to EVERY model in the database.
* The file naming conventions for models is singular.
* We will be replacing these methods with ActiveRecord tomorrow

### View

Look at a view from Task Manager

* By default, Sinatra looks for our views in a `/views` directory.
* Use ERB (embedded ruby) to describe how data should be used to create HTML
    * `<%= %>` renders the return value of the enclosed statement
    * `<% %>` does not render the return value

We can also embed blocks with erb. Here’s an example using if/else:

```erb
<% if @tasks %>
  # do something
<% end %>
```

### Putting it All Together

* Sinatra determines the method to call by inspecting the verb/URI of the request
* Within that method, we:
    1. Perform any data manipulation we need using our model
    1. Collect any data we need to use in our view (using a model as a go-between)
    1. Render a view or redirect (using `erb` or `redirect`)

Let's draw a diagram to represent this process. 

![mvc diagram](https://docs.google.com/drawings/d/e/2PACX-1vRrocz01rjJXxrIYnECmpzzVsUzIOrGL5psEFaIeZbMIrqsoU2WVQ-Sd-ZJCzy03VvoQL-KaTbHZd2F/pub?w=474&h=369)

### Experiment

1) Add a new route and view so that the user can successfully visit “localhost:9393/easteregg” and see a new view of your choice.
2) Add a new route so that the user can go to “localhost:9393/showmethetasks” and be redirected to all of the tasks. NOTE: You should not have to create a new view, nor should you use the erb method.

Let’s also quickly talk about why the 2nd path isn’t a good idea.

### Recap
* What does MVC stand for? 
* What are the responsibilities for each part of the MVC pattern?
* How is data passed through the MVC pattern?
* What is the difference between `<%= %>` and `<% %>`?
