---
title: Passing Data with Sinatra
length: 60
tags: parameters, sinatra
---

## Learning Goals

* Access dynamic parameters in a controller
* Access query string parameters in a controller.
* Access form parameters in a controller.

## Vocab

* parameters
* params
* dynamic parameters
* query string parameters

## WarmUp

* Today we're going to add the ability for a user to visit `/songs/1` and see the information for a Song with the id of 1

## Passing Data with Sinatra

- What are ways that we can pass parameters in Sinatra?
  - URL
  		- dynamic parameters
  		- query string parameters
  - Input Form

- In this workshop, you'll practice passing data between a client and a Sinatra server.

- There are a few different ways to pass data: through dynamic parameters in the URL, through the query string parameters in the URL, and through forms. We'll focus on passing data via dynamic params and via forms.

## Passing Data from Client to Server

### Dynamic Parameters

- In the [set-list](https://github.com/turingschool-examples/set-list) repo, create a route to get the first song populated on the page `/songs/1`.

```ruby
get '/songs/1' do
  @song = Song.find(1)
  erb :"songs/show"
end
```

- Let's talk about how to make this dynamic.

```ruby
get '/songs/:id' do
  @song = Song.find(params[:id])
  erb :"songs/show"
end
```

- We often refer to the `:id` part as a wildcard. It doesn't have to say `:id` instead you could put in `:bananas`. In which case we'd see `{"bananas" => 1}` in our `params` hash. We typically use `:id` though, as it is more descriptive of what information is coming through.


### Query String Parameters
  - add `gem 'pry'` in your Gemfile within the development/test block, and run `bundle install` again.
  - Put a pry in your above method:

  ```ruby
  get '/songs/:id' do
    require 'pry' ; binding.pry
    @songs = Song.find(params[:id])
    erb :"songs/show"
  end
  ```
  - Go back to your browser and visit `/songs/1?term=apples`
  - What is that `?term=apples` part? This is a **query string parameter**. You can string as many key value pairs together without spaces using an `&` to separate the pairs. (i.e. `?term=apples&count=4`)
  - Switch to terminal and check out what we have in params in our pry session

 **Turn & Talk**

 How might this be useful?


### Form Parameters
  - create a new 'get' operation in our controller somewhere ABOVE the `get '/songs/:id' do` code:
  ```ruby
  get '/songs/new' do
    erb :"songs/new"
  end
  ```
  - create `views/songs/new` file:

  ```html
<form class="new-song" action="/songs" method="post">
  <input type="text" name="song[title]" value="Title">
  <input type="text" name="song[length]" value="Length">
  <input type="text" name="song[play_count]" value="Play Count">
  <input type="submit" value="Submit">
</form>
  ```

- What resource are we trying to create?
- Based on REST:
  - What verb should we use?
  - What route should we send it to?

- let's add a 'post' operation and a binding pry
```ruby
post "/songs" do
  require 'pry'; binding.pry
end
```

- Let's shotgun. Navigate to `/songs/new` to see our form and fill it in. Click Submit.
- Clicking submit stops our program and allows us to utilize our favorite tool, PRY!
- Now that we are here, we can see the output of `params`
- Nesting our parameters with `song[title]` will help us if we ever have multiple resources' inputs on our page

**Partner Practice**  
Test your knowledge by finishing the exercise so that your new song shows on the "songs/index"

## Passing Data From Controller to View

### Locals vs. Instance Variables

Try this out:

1) Go to your controller, and change your `get '/songs' do...` route to say this:

```ruby
get '/songs' do
  songs = Song.all
  erb :"songs/index", :locals => { :song_list => songs }
end
```

2) Go to your `index.erb` view and `@songs.each` to `song_list.each`. It should now just say `song_list.each do...`. Does it work? Can you think of pros and cons for this versus the way we originally had it?

### Notes: Locals vs. Instance Variables

With Sinatra, we *can* pass variables to rendered views with the `:locals` option. This is handy, but adds more overhead than is necessary.

Sinatra allows us to access *instance* variables defined in a particular route within that route's corresponding rendered view. Not only does this save us a little bit of code to write, this is how things work in Rails! For that reason alone, let's get into this habit, rather than use `:locals`.

To test out how well you understand what pieces were affected by our changes, go ahead and switch back to using the instance variable `@songs` instead of the locals hash.


## Workshop/Homework

1) Clone this app: [http://github.com/turingschool/shopping](http://github.com/turingschool/shopping)

2) This application doesn't use ActiveRecord so create and migrate the database by running the two migration files:

```bash
$ ruby db/migrations/001_create_items.rb
=> Items table created and seeded.
$ ruby db/migrations/002_create_users.rb
=> Users table created.
```

Running these migrations will also create five items for your shop.

## Query String Parameters

#### Activity 1

You'll see a route defined in `shopping_app.rb` that handles requests to the index of all items (`/items`). Start up your server and check that five items appear.

For this task, you will *not* need to add or change any code. Instead, take a look at the route, then modify only the URL in order to filter these items by a word in their description.

For example, type a URL that will:

* show only the items made by Apple
* show only the items made by Samsung
* show only the year 2016 items
* show only the year 2017 items

If you're stuck, research query string parameters.

Confused about the use of LIKE in the SQL in the `.find_by` method? Check out [this explanation of the LIKE operator](https://www.tutorialspoint.com/sqlite/sqlite_like_clause.htm).

#### Activity 2

Imagine that the company whose website you're building no longer wants to use "term", but instead wants to use "filter". What do you need to modify in your code? Make the change(s), then test out this URL to make sure it works: `localhost:9393/items?filter=Samsung`.

#### Activity 3

Modify the URL, controller, and view to make this message appear when a user looks at the items index.

`Note: Contact your local stores in Denver to check item availability.`

or

`Note: Contact your local stores in Los Angeles to check item availability.`

...etc...

The value of the city should be able to be modified based on my URL query params.

#### Questions to Consider

* What are some common use cases for query strings on the internet?
* What are some of the limitations of passing data through query strings?

## Form Parameters

#### Activity 1

Take a look in `views/new_item.erb`. You'll see an existing form, but something is wrong with it! Use your debugging skills and tools to fix *just the form*.

#### Activity 2

You'll see a route in your `shopping_app.rb` to `get '/users/new'`. It renders a view template that is currently blank. Create a form in this file that will accept two attributes: a name and an email address. Use the `<label>` HTML tag to differentiate between the name and email address input fields.

Create a route that handles the submission of this form (follow the conventions from our CRUD chart) and ultimately brings the user back to the list of all users.

# Done?

If you're finished, here are some ideas:

* Build out full CRUD functionality for Users.
* Use Bootstrap to style your views.


## WrapUp
* What are dynamic parameters and why would you use them?
* What are query string parameters and why would you use them?
* How do you get access in your controller to information submitted in a form?
* How do you pass local variables to a view? Should we use them? Why? Why not?
