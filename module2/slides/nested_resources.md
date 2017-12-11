# Nested Resources

## Learning Goals

- How do you use nested resources in Rails?
- When should you use Nested Resources?

## Warm Up

Create a table containing all 8 http-verbs, URI-patterns, and controller actions that Rails gives you when you have the following:

```ruby
# config/routes.rb

resources :muffins
```

## Background

Read [this](http://guides.rubyonrails.org/routing.html#nested-resources) section of the Rails routing documentation and discuss with someone close to you.

## Examples

```
GET  /directors/1/movies
GET  /directors/1/movies/new
POST /directors/1/movies
```

## How do we Create Nested Routes?

```
# config/routes.rb
resources :directors do
  resources :movies
end
```

* Run `rake routes`

## Shallow Nesting

```ruby
# config/routes.rb
resources :directors shallow: true do
  resources :movies
end
```

* Run `rake routes` again.
* How does this differ from what was generated without `shallow: true`?

## `form_for` Arguments

`form_for` uses the object it receives as an argument to determine:

* Whether to render a new form or an update form
* Whether the fields in the form correspond to attributes on the object
* What route to use when sending the information when a user hits submit

## `form_for` with Nested Resources

* Need to pass both the existing director and new movie
* Will provide them in an array as an argument
* Need to update both our controller and our view

## Let's code along:

- You should have a test already to see the form for a new movie. Now let's create a new movie with a director. Based on what we know about nested routes, let's start here:

```ruby
  #spec/features/user_can_create_a_new_movie_spec.rb
  director = Director.create(name: "Ilana")
  visit "/directors/#{director.id}/movies/new"

  fill_in :title, with: "Finding Nemo"
  fill_in :description, with: "A sad fish story"

  click_on "Create Movie"

  expect(current_path).to eq("/movies/#{Movie.last.id}")
  expect(page).to have_content("Finding Nemo")
  expect(page).to have_content("A sad fish story")
  expect(page).to have_content(director.name)
```

- What is in your controller? What is in your view?
- Last week, we wrote a test to see a new form for a new movie but did not create a new movie.

- Our controller should look like this:

```ruby
#app/controllers/movies_controller.rb
def new
end
```

- And our view like this:

```html
<form action="/movies" method="post">
  <input type="text" name="movie[title]" value="Title">
  <input type="text" name="movie[description]" value="Description">
  <input type="submit" value="Create Movie">
</form>
```

- This should take us all the way to a failing test:

```bash
Failure/Error: click_on "Create Movie"

     ActionController::RoutingError:
       No route matches [POST] "/movies"
```

- Hmmmm, but we have opened the routes for making a new movie for a director. Let's check out `rake routes` output to see what route we are actually trying to hit. What are we looking for? A route that creates our new movie. What HTTP verb do we use when we create a new resource?

```bash
  POST   /directors/:director_id/movies(.:format)     movies#create
```

- Based on the route above, we need our form to post to a specific directors movies. How can we do that? Through the controller and form! Let's make those adjustments.

```ruby
# app/controllers/movies_controller.rb
def new
  @director = Director.find(params[:director_id])
  @movie    = Movie.new
end
```

- Lets update our view for the movie to use the form_helper that rails gives us to build a form.

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

Let's run RSpec and adjust our Movies Controller to point the form to  `create`

```ruby
def create
  director = Director.find(params[:director_id])
  movie = director.movies.create(movie_params)
  redirect_to "/movies/#{movie.id}"
end
```

- LAST: Adjust your view to show the director of the movie!
- We should have a passing test!!!

Creating a New Movie via localhost

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
