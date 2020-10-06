# Intro to MVC

---

# Warmup

* In your own words, what are the primary responsibilities of the models, views, and controllers in Task Manager?

---

# Overview

* Controllers - Coordinate the response to an HTTP request
* Models - Interact with the database. Holds other methods related to a particular resource (e.g. a `task`)
* Views - Templates for pages that we will display to our user

---

# Controller

Review Task Manager controller

* Routes in Sinatra are defined as part of its DSL
* Similar to other `do`/`end` blocks you're used to from Ruby
* **HTTP verb** the request is making to the route
* **path** the request is being made to
* Inside the block, we tell Sinatra how to handle the request

---

# Model

Look at your Task model

* Includes methods to interact with the database
* Controllers can access our models
* File naming conventions for models is singular
* Will be replacing these methods with ActiveRecord tomorrow

---

# View

Look at a view from Task Manager

* Sinatra looks for our views in a `/views` directory
* Use embedded ruby to describe how data should be used to create HTML
    * `<%= %>` renders the return value of the enclosed statement
    * `<% %>` does not render the return value

---

# View Continued

Can also embed blocks with erb

```erb
<% if @tasks %>
  # do something
<% end %>
```

OR

```erb
<% @tasks.each do |task| %>
  <p><%= task.name %></p>
<% end %>
```

---

# Putting it All Together

* Sinatra determines the method to call by inspecting the verb/URI of the request
* Within that method, we:
    1. Perform any data manipulation
    1. Collect any data we need
    1. Render a view or redirect (using `erb` or `redirect`)

Let's draw a diagram to represent this process.

---

# Experiment

1) Add a new route and view so that the user can successfully visit “localhost:9393/easteregg” and see a new view of your choice.

2) Add a new route so that the user can go to “localhost:9393/showmethetasks” and be redirected to all of the tasks. NOTE: You should not have to create a new view, nor should you use the erb method.

---

# Recap

* What are the responsibilities for models, views, and controllers in the MVC pattern?
* What is the difference between `<%= %>` and `<% %>`?
