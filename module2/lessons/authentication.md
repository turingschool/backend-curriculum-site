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

## Code Along

In SetList, our next goal is to create users who can reserve songs in our application. This will require a way for a user to log in to our application, and for our application to "remember" that user.

### Creating a User Test

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

```ruby
# models/user.rb
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true
end
```

## Why `password_digest`?

### BCrypt

[BCrypt Docs](https://github.com/codahale/bcrypt-ruby) [Rails built-in SecurePassword module](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password)
-  Secure Password Requires that the object have a `password_digest` attribute that will recognize both `password` and `password_confirmation` as attributes even though the attribute is called `password_digest`.
- Built into Rails, comes out of the box in the gem file but it is commented out by default. Must uncomment to use it.
- Takes password and password_confirmation (if necessary) and encrypts it to a very long string which is hard to decrypt; this is referred to as **hashing**.
- Takes care of matching the `password` and `password_confirmation` fields (if used).

- Find the `gem 'bcrypt'` in the `Gemfile` and uncomment it. Run `bundle` again to complete the process.

We now need to tell our model that it will be expecting a field `password` (and `password_confirmation` if needed) with the `has_secure_password` entry below.

```ruby
# models/user.rb
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password
end
```

Now we can create the user as we would with standard CRUD functionality, with one exception. The overall goal is to hold onto this user's information so that when they log in, our application can remember them on future requests.

From a User Experience perspective, it feels weird to make a user sign up, but then they have to log in again after registering. A better User Experience is this: When a new user signs up, we want them to be logged in automatically. So how do we do that? What tool in Rails might we be able to use to store information about our user as they are visiting our application?

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

### Sessions

Except we don't **WANT** them to pass just yet. We need to add our user's information to a session so our user doesn't have to log in for each page they want to visit.

HTTP is a stateless protocol, which means there is no connection between each request sent. Nothing is being "remembered" by the server from one request to another. Sessions make it seem stateful. Without the idea of sessions, the user may have to probably authenticate on every request.

#### Adding/Removing things from a session:

* Set data for our user using hash key/values: `session[key] = value`
* Clear the ENTIRE session data for that user using `session.clear`

```ruby
#controllers/users_controller.rb

def create
  @user = User.create(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  else
    render :new
  end
end

private

  def user_params
    params.require(:user).permit(:username, :password)
  end
```

By creating this key/value pair, we have created a way to get this information back easily.


### New Test - Account Already Exists

- On our root page, we should also have the option to log in if our account already exists.
- Let's add a new test for this functionality

```
As a registered user
When I visit '/'
and I click on a link that says "I already have an account"
Then I should see a login form
and I can enter my username and password
and submit the form
and see a welcome message with my username
and my user ID is stored in a session
and I should no longer see the link that says "I already have an account"
and I should see a link that says "Log out"
```

```ruby
  user = User.create(username: "funbucket13", password: "test")

  visit "/"

  click_on "I already have an account"

  expect(current_path).to eq(login_path)
  fill_in "username", with: user.username
  fill_in "password", with: user.password

  click_on "Log In"

  expect(current_path).to eq(user_path(user))

  expect(page).to have_content("Welcome, #{user.username}")
  expect(page).to have_content("Log out")
```

We are dream driving! We want to click on "I already have an account" and be taken to a form to fill in with my already existing username and password. Our error should look something like this:

```bash
Failure/Error: click_on "I already have an account"

     Capybara::ElementNotFound:
       Unable to find visible link or button "I already have an account"
```

The html in our root view should have a link like this:

```html
  <%= link_to "I already have an account", login_path %>
```

When running our tests, our test gets tripped up because `login_path` has not been defined in our routes.

```bash
Failure/Error: expect(current_path).to eq(login_path)

     NameError:
       undefined local variable or method `login_path' for #<RSpec::ExampleGroups::RegisteredUserLogsIn::TheyVisitLoginPath:0x007fd1c596aea8>
```

But where should we send the user to to log in? Lets send them to a sessions controller that will handle information related to the session.

The `login_path` is just a form where our user can enter their credentials.

```ruby
#routes.rb

  get '/login', to: 'sessions#new'
```
Which brings us to an `uninitialized constant SessionsController` error. And then `The action 'new' could not be found for SessionsController`. We will need a controller and a new action to handle this information:

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

And a view to render the form (this is a great use case for form_tag since we're not creating a form associated with the DB!)

```html
<!-- app/views/sessions/new.html.erb -->

<%= form_tag login_path do %>
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

Now we get a error when we click the "Log In" button!

```bash
Failure/Error: click_on "Log In"

     AbstractController::ActionNotFound:
       The action 'create' could not be found for SessionsController
```

We need an action in our controller that handles the post request. You'll want to find a user by the username they've passed in. Then we use the ActiveModel:SecurePassword method `#authenticate` which is called on an instance of a user and requires an argument of the user's password. Next we save the user_id into sessions to be referenced later:

```ruby
# app/controllers/sessions_controller.rb

def create
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to user_path(user)
  else
    render :new
  end
end
```

### Helper Method - Current User

Lets update our views to use a [helper method](https://apidock.com/rails/AbstractController/Helpers/ClassMethods/helper_method):

```html
<h1>Welcome, <%= current_user.username %>!</h1>
```

If we run our tests, they will fail because we have not defined `current_user`.  

```bash
Failure/Error: <h1>Welcome, <%= current_user.username %></h1>

     ActionView::Template::Error:
       undefined local variable or method `current_user' for #<#<Class:0x007f8402a80678>:0x007f8403af9928>
       Did you mean?  current_page?
```

* We set this in ApplicationController as `helper_method :method_name`
* Allows us to use the `current_user` method anywhere else within our views and controllers.

```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActiveRecord::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
```

`helper_method` is an ActiveRecord method which we pass a symbol by the same name as our method.
Let's deconstruct the current_user method.  

* `||=` is [memoization](http://gavinmiller.io/2013/basics-of-ruby-memoization/). Ruby will look to see if the variable on the left exists, if it does it uses that value. If it doesn't exist it preforms the opperation on the right.
* You'll want that guard clause in there for the instance where session[:user_id] hasn't been set yet. If it's not set yet you'll error out without that guard clause.

If you run your tests again, you should get passing tests. However, I want to implement one more refactor. In your `UsersController` `show` action, you can delete User.find since you're view now uses current_user. This implementation is more DRY but it is also more secure. Think about other ways you might use current_user in your controllers and views.

### Workshop

- Create a test that logs out a currently logged in user. This will require you to create a new route and send it to a new action that will destroy the session. Think about how you will show whether a user is logged in on the page? How will you deal with whether there should be a "Log In" link or a "Log Out" link showing.

### Takeaways

* Encrypt passwords in your database when you store them
* Use *ApplicationController* to hold methods you'll be using across controllers
* Use `helper_method :method_name` for methods you want to use in the views
* Don't hesitate to use  *custom routes* when appropriate
* Use a *session* to store a logged in user id
* Use *form_tag* when creating a form without an associated model

## WrapUp
* What does Authentication mean? Why do we use it and when?
* What are the steps to implementing Authentication in a Rails app? I counted 5 main steps. How many do you come up with?
* How might you use Sessions to help with Authentication? Why is this an important piece?
* What is a helper_method? Why might we use them?
