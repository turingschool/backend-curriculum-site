# Nested Resources

---

# Learning Goals

- How do you use nested resources in Rails?
- When should you use Nested Resources?

---

# Warm Up

Create a table containing all 8 prefixes, http-verbs, URI-patterns, and controller actions that Rails gives you when you have the following:

```ruby
# config/routes.rb

resources :muffins
```

---

# Background

Read [this](http://guides.rubyonrails.org/routing.html#nested-resources) section of the Rails routing documentation and discuss with someone close to you.

---

# Examples

```
GET  /directors/1/movies
GET  /directors/1/movies/new
POST /directors/1/movies
```

---

# How do we Create Nested Routes?

```
# config/routes.rb
resources :directors do
  resources :movies
end
```

* Run `rake routes`

---

# Shallow Nesting

```ruby
# config/routes.rb
resources :directors shallow: true do
  resources :movies
end
```

* Run `rake routes` again.
* How does this differ from what was generated without `shallow: true`?

---

# `form_for` Arguments

`form_for` uses the object it receives as an argument to determine:

* Whether to render a new form or an update form
* Whether the fields in the form correspond to attributes on the object
* What route to use when sending the information when a user hits submit

---

# `form_for` with Nested Resources

* Need to pass both the existing director and new movie
* Will provide them in an array as an argument
* Need to update both our controller and our view

---

# Movies Controller: `new`

```
# app/controllers/movies_controller.rb
def new
  @director = Director.find(params[:director_id])
  @movie    = Movie.new
end
```

---

# New Movie View

```
# app/views/movies/new.html.erb
<h1>Create a New Movie</h1>

<%= form_for [@director, @movie] do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :description %>
  <%= f.text_area :title %>
  <%= f.submit %>
<% end %>
```

---

# Movies Controller: `create`

```ruby
def create
  director = Director.find(params[:director_id])
  director.movies.create(movie_params)
  redirect_to "/directors/#{director.id}/movies"
end
```

---

# Creating a New Movie

* Be sure you have at least one director in your database
* Run `rails s`
* Visit `/directors/1/movies/new`

---

# Mixing Nested and Non-Nested Routes

* What if we want to see a list of all movies?

```ruby
# config/routes.rb
resources :directors, shallow: true do
  resources :movies
end

resources :movies, only: [:index]
```

Visit `/movies` and you should see all movies.

---

# Checks for Understanding

Turn and talk to your neighbor and discuss:

* When would you use a nested resource?
* How do you nest a resource in your routes file?
* How does that change your routes?
* What does it mean to use shallow nesting? Why would you do this?
* What changes do you need to make in your controller when you nest a resource?

