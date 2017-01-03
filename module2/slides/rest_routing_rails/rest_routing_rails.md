# REST, Routing, and Controllers in Rails

---

# Warmup

* What is the purpose of the controller in your Sinatra app?
* Rails separates routes/controllers. What might this look like?
* What are the seven restful routes/verb combinations if you were CRUDing a `horse`?
* When might you *not* use restful routes?

---

# `rails new`

* What does `rails new` give us?
* Flags
    * `-T`
    * `--skip-spring`
    * `--skip-turbolinks`
    * `--database=postgresql`

---

# Routes

* `get '/tasks', to: 'tasks#index'`
* `rake routes`

---

# Controllers

* `touch/app/controllers/tasks_controller.rb`

```
class TasksController < ApplicationController
  def index
    render :text => "hello world"
  end
end
```

* `rails server`

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

