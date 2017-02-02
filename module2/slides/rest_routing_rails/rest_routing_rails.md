# REST, Routing, and Controllers in Rails

---

# Goal: Explore a new Rails project and tie it to our experience in Sinatra.

---

# Warmup

* What is the purpose of the controller in your Sinatra app?
* Rails separates routes/controllers. What might this look like?
* What are the seven restful routes/verb combinations if you were CRUDing a `horse`?
* When might you *not* use restful routes?

---

# `rails new`

From the terminal, run `rails new first_project`

* Optional flags
    * `-T`
    * `--database=postgresql`
    * `--skip-spring`
    * `--skip-turbolinks`

---

# Activity

* Explore your new directory.
* What looks familar from your time working in Sinatra?

---

# Routes

In your `/config/routes.rb` file, add the following line:

`get '/tasks', to: 'tasks#index'`

Run the following line from your command line:

`rake routes`

---

# Controllers

`touch/app/controllers/tasks_controller.rb`

In a `/app/controllers/tasks_controller.rb` file:

```
class TasksController < ApplicationController
  def index
    render :text => "hello world"
  end
end
```

From the command line: `rails server`

---

# Workshop

1. Can you create a route that would bring the user to a form where they can enter a new task?
2. Can you create a route that would allow a user to see one task? Just like in Sinatra, the route will need a changeable /:id.
3. Can you create a route that would allow a user to get to the edit page for a task? Again, the route will need a changeable /:id.
4. For the previous two routes (show and edit), can you get the params[:id] to display in the text that you render?

---

# Resources

* `resources :tasks`
* `rake routes`

---

# Routes to Root

```
root 'tasks#index'
```

---

# Takeaways

* New commands!
    * `rails new project_name`
    * `rake routes`
    * `rails server`
* Rails uses MVC, but also uses a routes file
* In Rails we have multiple controllers
