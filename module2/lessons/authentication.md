---
layout: page
title: Authentication
length: 120min
tags: rails, authentication, bcrypt, ruby, sessions, helper_methods
---

### If you are who you say you are...

## Learning Goals
* explain the use of Authentication and why it's important
* implement Authentication using BCrypt
* utilize Sessions in a Rails app
* Utilize `helper_method` in ApplicationController for use in views and controllers

## Vocabulary
* authentication
* session
* hash
* helper_method

## Warm Up

* What is a cookie? What is a session?
* How could we use sessions to implement authentication?


## Overview

* Creating a user in our database
* Using *BCrypt* to hash passwords that we save
* Creating *custom routes* to login/logout
* Creating and destroying a *session*
* Using a *helper_method* to access *current_user* in views

## What is Authentication?

Authentication is the client proving to the application that they are who they say they are. Usually this is done through a username/email and password combination. We handle this interaction a little differently than we handle a traditional user creation because we need to provide a way for our application to remember our user.

## Registering Users

In SetList, our next goal is to create users who can reserve songs in our application. This will require a way for a user to log in to our application, and for our application to "remember" that user.

```
As a visitor
When I visit '/'
and I can click a link that says "Sign Up to Be a User"
and I can enter registration details in a form
and submit that form
Then I should see a welcome message with my username
and my user details have been saved in the database.
```

```ruby
require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit "/"

    click_on "Register as a User"

    expect(current_path).to eq("/users/new")

    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Create User"

    expect(page).to have_content("Welcome, #{username}!")
  end
end
```

When we run our test, we get a failure because we do not have a root path defined in our `routes.rb` file.

```bash
Failure/Error: visit "/"

     ActionController::RoutingError:
       No route matches [GET] "/"
```

We can handroll this route like so:

```ruby
  #routes.rb

  get "/", to: "welcome#index"
```

Or we can use the handy `root` method that Rails gives us to create a route for the root path ("/"):

```ruby
  #routes.rb

  root "welcome#index"
```

According to this `root` path, we are directing our root path to a `WelcomeController` and an `index` action in that controller.

When we run our test, we get this error:

```bash
ActionController::RoutingError:
       uninitialized constant WelcomeController
```

Let's create the `WelcomeController` and a method for the `index` action as well. We are going to be rendering some basic content so we don't need to fetch any data or build any instance variables in our controller.

```ruby
# app/controllers/welcome_controller.rb

class WelcomeController < ApplicationController
  def index
  end
end
```

Now when we run our test, we get a missing template error. Add the template to `views/welcome/index.html.erb` (remember, filenames and folder names are based on the controller and action names)

We get a new error if we run our test:

```bash
Capybara::ElementNotFound:
       Unable to find visible link or button "Register as a User"
```

Let's add the link to sign up in the `app/views/welcome/index.html.erb` file

```html
<%= link_to "Register as a User" %>
```

But which URI path should we send a user to who clicks on this link?

Our goal here is to create a "new user" resource.

**Notice we are treating this resource as any other resource.**

```html
<%= link_to "Register as a User", "/users/new" %>
```

When we run our tests we get this error:

```bash
ActionController::RoutingError:
       No route matches [GET] "/users/new"
```

We still need to define this routes in our `routes.rb` file:

```ruby
get "/users/new", to: "users#new"
```

If we run our test again we'll get this succession of errors:

```bash
ActionController::RoutingError:
 uninitialized constant UsersController
```

```bash
AbstractController::ActionNotFound:
 The action 'new' could not be found for UsersController
```

```bash
 ActionController::UnknownFormat:
   UsersController#new is missing a template for this request format and variant.
```

Let's define the action and template that go along with our new user path.


```ruby
# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def new
  end
end
```

```html
<!-- views/users/new.html.erb -->

<%= form_tag '/users', method: :post do %>
  <%= label_tag :username %>
  <%= text_field_tag :username %>
  <%= label_tag :password %>
  <%= password_field_tag :password %>
  <%= submit_tag "Create User" %>
<% end %>
```

We have our form set up to take in the information that we want to create our user object with (username and password).

Run the tests again and the error is

```
ActionController::RoutingError:
       No route matches [POST] "/users"
```

Let's add this route to our `routes.rb`:

```ruby
post "/users", to: "users#create"
```

Now we get:

```
AbstractController::ActionNotFound:
  The action 'create' could not be found for UsersController
```

Add the create action to the UsersController:

```ruby
class UsersController < ApplicationController
  def new
  end

  def create
  end
end
```

Our error is now:

```
Capybara::ElementNotFound:
  Unable to find xpath "/html"
```

We haven't rendered a view, so let's redirect back to the home page:

```ruby
def create
  redirect_to "/"
end
```

Now our test can't find the username, so let's try to create the User. We are "dream driving" at this point. I really wish I had a user class that I could use to create users:


```ruby
def create
  User.create(user_params)
  redirect_to "/"
end

private
def user_params
  params.permit(:username, :password)
end
```

Our tests will now complain about an `uninitialized constant UsersController::User`. Let's create a User model:

```ruby
# app/models/user.rb
class User < ApplicationRecord

end
```

Next we get this whopper of an error:

```bash
     ActiveRecord::StatementInvalid:
       PG::UndefinedTable: ERROR:  relation "users" does not exist
       LINE 8:                WHERE a.attrelid = '"users"'::regclass
                                                 ^
       :               SELECT a.attname, format_type(a.atttypid, a.atttypmod),
                            pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod,
                    (SELECT c.collname FROM pg_collation c, pg_type t
                      WHERE c.oid = a.attcollation AND t.oid = a.atttypid AND a.attcollation <> t.typcollation),
                            col_description(a.attrelid, a.attnum) AS comment
                       FROM pg_attribute a LEFT JOIN pg_attrdef d
                         ON a.attrelid = d.adrelid AND a.attnum = d.adnum
                      WHERE a.attrelid = '"users"'::regclass
                        AND a.attnum > 0 AND NOT a.attisdropped
                      ORDER BY a.attnum
```

The `PG::UndefinedTable: ERROR:  relation "users" does not exist` tells us that PostgreSQL can't find a `users` table.

We still have to make the database portions (migration, etc) but it doesn't feel right to store our passwords as plain text. **IT ISN'T!!! DON'T DO IT. Use a password encryption tool (such as BCrypt) to store encrypted passwords in the database**.

```bash
rails g migration CreateUsers username:string password_digest:string
```

Apply that migration (`rake db:migrate`).

We'll get back to why we called the field `password_digest` in a moment -- we should also make sure that our User model requires that the username and password fields be populated by adding validations.

Let's start with a test in `spec/models/user_spec.rb` that looks like this:

```ruby
require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_presence_of(:password)}
  end
end
```

Let's try to make these tests pass with this User model:

```ruby
# models/user.rb
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true
end
```

Our model test is complaining that we don't have an attribute called `password`, and it's right! Look at the migration and the schema. We have a field called `password_digest`.

## Why `password_digest`?

### BCrypt

* [BCrypt Docs](https://github.com/codahale/bcrypt-ruby)
* [Rails built-in SecurePassword module](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password)
*  Secure Password Requires that the object have a `password_digest` attribute that will recognize both `password` and `password_confirmation` as attributes even though the attribute is called `password_digest`.
* Built into Rails, comes out of the box in the gem file but it is commented out by default. Must uncomment to use it.
* Takes password and password_confirmation (if necessary) and encrypts it to a very long string which is hard to decrypt; this is referred to as **hashing**.
* Takes care of matching the `password` and `password_confirmation` fields (if used).

Find the `gem 'bcrypt'` in the `Gemfile` and uncomment it. Run `bundle` again to complete the process.

We now need to tell our model that it will be expecting a field `password` (and `password_confirmation` if needed) with the `has_secure_password` entry below.

```ruby
# models/user.rb
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password
end
```

Run the model tests again and they should be passing.

When we run our feature test again we get this error:

```bash
Failure/Error: expect(page).to have_content("Welcome, #{username}!")
  expected to find text "Welcome, funbucket13!" in "Register as a User"
```

Let's look back at the UsersController. It looks like the new user is being created, so let's add a flash message to show the welcome message:

```ruby
def create
  new_user = User.create(user_params)
  flash[:success] = "Welcome, #{new_user.username}!"
  redirect_to "/"
end
```

Our test should now be passing!

## Remembering Users

From a User Experience perspective, it feels weird to make a user sign up, but then they have to log in again after registering. A better User Experience is this: When a new user signs up, we want them to be logged in automatically. So how do we do that? What tool in Rails might we be able to use to store information about our user as they are visiting our application?

HTTP is a stateless protocol, which means there is no connection between each request sent. Nothing is being "remembered" by the server from one request to another. Whenever we need to remember something about a user's previous actions, a session will be a good tool. Sessions make http *seem* stateful. Without the idea of sessions, the user would have to authenticate on every request.

Let's add a test to capture this idea:

```ruby
RSpec.describe "User registration form" do
  it "creates new user" do
    ...
  end

  it "keeps a user logged in after registering" do
    visit "/"

    click_on "Register as a User"

    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Create User"

    visit '/profile'

    expect(page).to have_content("Hello, #{username}!")
  end
end
```

We are imagining that there is a profile page that shows the username. When we visit the profile path (`/profile`) after registering, it should remember our username.

Run the test and you should get:

```
ActionController::RoutingError:
  No route matches [GET] "/profile"
```

Add that route:

```
get '/profile', to: 'users#show'
```

Run the test again to get a missing action error. Add that action to the UsersController:

```ruby
def show
end
```

And a view:

```erb
# app/views/users/show.html.erb
<h1>Hello, <%= @user.username %>!</h1>
```

We're now getting `undefined method 'username' for nil:NilClass`. In our controller, we need to define which user's profile we're viewing.

Think about how this is different than other `show` actions you've implemented in the past for other resources. Usually, our route includes an id to indicate which resources we are viewing, for example `/songs/:id`. But in this case, our route doesn't include that id (`/profile`). This is because we don't want users to see the profile for other users.

What we want to do instead is show the user that is currently logged in. We will indicate who is logged in by storing a user id in the session. Since sessions are stored on the client, every different user who accesses our site will have a different user id stored in that session.

```ruby
def show
  @user = User.find(session[:user_id])
end
```

Run the test again and you should get `Couldn't find User with 'id'=`. Put a pry in that show action and check what `session[:user_id]` is. It's `nil`! Because we haven't actually added that user id to the session. We want to do this once a user registers, so go back to the UsersController create action and add it there:

```ruby
def create
  new_user = User.create(user_params)
  flash[:success] = "Welcome, #{new_user.username}!"
  session[:user_id] = new_user.id
  redirect_to "/"
end
```

Run the tests and they should pass. Our user is now logged in after they register.

## Logging In

* On our root page, we should also have the option to log in if our account already exists.
* Let's add a new test for this functionality

```
As a registered user
When I visit '/'
and I click on a link that says "I already have an account"
Then I should see a login form
When I enter my username and password
and submit the form
I am redirected to the home page
and I see a welcome message with my username
and I should no longer see the link that says "I already have an account"
and I should no longer see the link that says "Register as a User"
and I should see a link that says "Log out"
```

```ruby
require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(username: "funbucket13", password: "test")

    visit "/"

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq('/')

    expect(page).to have_content("Welcome, #{user.username}")
    expect(page).to have_link("Log out")
    expect(page).to_not have_link("Register as a User")
    expect(page).to_not have_link("I already have an account")
  end
end
```

Run this test and we get a missing link error. Add the link to the welcome/index view:

```erb
<%= link_to "I already have an account", "/login" %>
```

Next, we need to add the route. But where should we send the user to to log in? Lets send them to a sessions controller that will handle information related to the session:

```ruby
get '/login', to: 'sessions#new'
```

Notice that even though a "session" is not a resource in our Database, we still try to follow ReSTful conventions for what our routes should look like and Rails conventions for how those routes are handled.

Run the test and you should get an `uninitialized constant SessionsController` error. And then `The action 'new' could not be found for SessionsController`. We will need a controller and a new action to handle this information:

```ruby
# app/controllers/sessions_controller.rb

class SessionsController < ApplicationController
  def new
  end
end
```

Next we expect a no template errror:

```bash
 Failure/Error: click_on "I already have an account"

     ActionController::UnknownFormat:
       SessionsController#new is missing a template for this request format and variant.
```

And a view to render the form

```erb
<!-- app/views/sessions/new.html.erb -->

<%= form_tag '/login', method: :post do %>
  <%= label_tag :username %>
  <%= text_field_tag :username %>
  <%= label_tag :password %>
  <%= password_field_tag :password %>
  <%= submit_tag "Log In" %>
<% end %>
```

Now that we have our form, when we run RSpec, we get a new error complaining about not having a post to `/login`:

```bash
Failure/Error: click_on "Log In"

     ActionController::RoutingError:
       No route matches [POST] "/login"
```

```ruby
#routes.rb  
  post '/login', to: 'sessions#create'
```

Now we get an error when we click the "Log In" button!

```bash
Failure/Error: click_on "Log In"

     AbstractController::ActionNotFound:
       The action 'create' could not be found for SessionsController
```

We need an action in our controller that handles the post request. We want it to find the user by email, log them in, and show a welcome message:

```ruby
def create
  user = User.find_by(username: params[:username])
  session[:user_id] = user.id
  flash[:success] = "Welcome, #{user.username}!"
  redirect_to '/'
end
```

Next, our root page isn't showing the correct links, so let's add some if/else logic there:

```erb
<% if current_user %>
  <%= link_to "Log out" %>
<% else %>
  <%= link_to "Register as a User", "/users/new" %>
  <%= link_to "I already have an account", "/login" %>
<% end %>
```

If we run our tests, they will fail because we have not defined `current_user`.  

### Helper Method - Current User

We're dream driving this method called `current_user` that will tell us who (if anyone) is currently logged in. Because we'll want to be able to find the current user throughout the application, we will define it in `ApplicationController`. Because all controllers inherit from ApplicationController, every controller will have access to this method:

```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id])
  end
end
```

Run this test again, and we get the same error! We are calling this method in our view, and views don't have access to methods we define in our controllers by default. We can give views access to these methods by declaring them as [helper methods](https://apidock.com/rails/AbstractController/Helpers/ClassMethods/helper_method):

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    User.find(session[:user_id])
  end
end
```

Our next error is:

```
ActionView::Template::Error:
       Couldn't find User with 'id'=
```

This is happening when no one is logged in, and `session[:user_id]` is nil. Let's add an `if` statement to guard against this case:

```ruby
def current_user
  User.find(session[:user_id]) if session[:user_id]
end
```

Our test is now passing! Let's add one more improvement to our `current_user` method:

```ruby
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
```

`||=` is [memoization](http://gavinmiller.io/2013/basics-of-ruby-memoization/). Ruby will look to see if the variable on the left exists, if it does it uses that value. If it doesn't exist it preforms the operation on the right. This makes it so that if we need to check the current user multiple times over the course of one request, we don't have to go to the database to find the user multiple times.


If you run your tests again, you should get passing tests. However, I want to implement one more refactor. In your `UsersController#show` action, you can delete `User.find` and change your view to show `current_user` rather than `@user`. This implementation is more DRY but it is also more secure. Think about other ways you might use current_user in your controllers and views.

## Checking the User's Password

If you look at the `SessionsController#create` action, we aren't actually checking the user's password. We want to add a sad path test that users can't log in with bad credentials:

```ruby
it "can log in with valid credentials" do
  ...
end

it "cannot log in with bad credentials" do
  user = User.create(username: "funbucket13", password: "test")

  visit "/"

  click_on "I already have an account"

  fill_in :username, with: user.username
  fill_in :password, with: "incorrect password"

  click_on "Log In"

  expect(current_path).to eq('/login')

  expect(page).to have_content("Sorry, your credentials are bad.")
end
```

In the `SessionsController#create` action, we need to check the password and handle the case when it doesn't match. **Remember, we never store a user's password in the database!** So we can't do something like:

```ruby
user = User.find_by(username: params[:username])
if user.passsword == params[:password]
  # password matches
else
  #password doesn't match
end
```

What we're actuallly storing in the database is a **hash** or **digest** of the user's password, so we are going need to hash the given password and see if it matches what's in our database. Luckily, that `has_secure_password` line we added to our User model gives us a handy method to do this for us called `authenticate`. This method is called on a User object and takes a password as an argument:

```ruby
def create
  user = User.find_by(username: params[:username])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.username}!"
    redirect_to '/'
  else
    flash[:error] = "Sorry, your credentials are bad."
    render :new
  end
end
```

Our tests should now be passing.

### Workshop

- Create a test that logs out a currently logged in user. This will require you to create a new route and send it to a new action that will destroy the session. Think about how you will show whether a user is logged in on the page? How will you deal with whether there should be a "Log In" link or a "Log Out" link showing.

### Takeaways

* Encrypt passwords in your database when you store them
* Use *ApplicationController* to hold methods you'll be using across controllers
* Use `helper_method :method_name` for methods you want to use in the views
* Don't hesitate to use  *custom routes* when appropriate
* Use a *session* to store a logged in user id

## WrapUp
* What does Authentication mean? Why do we use it and when?
* What are the steps to implementing Authentication in a Rails app? I counted 5 main steps. How many do you come up with?
* How might you use Sessions to help with Authentication? Why is this an important piece?
* What is a helper_method? Why might we use them?
