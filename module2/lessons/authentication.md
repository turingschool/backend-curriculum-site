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
* implement a helper_method for use in views and controllers

## Vocabulary
* authentication
* session
* hash
* helper_method
* current_user

## Warm Up

* What questions do you have about authentication?
* What is the purpose of authentication? When might you use it?
* What is a session? How do you use one in Rails?
* What attributes did you give a user?
* What controller actions did you have for User?
* How did you handle logging a user in?

## Overview

* Creating a user in our database
* Using *BCrypt* to hash passwords that we save
* Creating *custom routes* to login/logout
* Creating and destroying a *session*
* Using a *helper_method* to access *current_user* in views
* Using *form_tag* and a Controller with no associated model

## What is Authentication?

Authentication is the client proving to the application that they are who they say they are. Usually this is done through a username/email and password combination. We handle this interaction a little differently than we handle a traditional user creation because we need to provide a way for our application to remember our user.

## Code Along

In `movie_mania`, our goal is to create a user that will eventually be able to check out movies from our application. This will require a way for a user to login to our application and our application to remember them.

### Creating a User Test

```ruby
  visit '/'

  click_on "Sign Up to Be a User"

  expect(current_path).to eq(new_user_path)

  fill_in "user[username]", with: "funbucket13"
  fill_in "user[password]", with: "test"

  click_on "Create User"

  expect(page).to have_content("Welcome, funbucket13!")
```

At this point, we do not have a root page that supports this interaction. When we open our app, we want a page that directs the user to either create a new account or sign in with their existing credentials.

When we run our test, we get a failure because we do not have a root path defined in our `routes.rb` file.

```bash
Failure/Error: visit "/"

     ActionController::RoutingError:
       No route matches [GET] "/"
```

```ruby
  #routes.rb

  root "welcome#index"
```

According to this root path, we are directing our root path to a `WelcomeController` and an `index` action in that controller.

When we run our test, we get this error:

```bash
ActionController::RoutingError:
       uninitialized constant WelcomeController
```

Let's create the `WelcomeController` and the action `index` as well. We are going to be rendering some basic content so we don't need to pass anything as an instance method.

```ruby
#controllers/welcome_controller.rb
class WelcomeController < ApplicationController
  def index
  end
end
```

Now when we run our test, we get a template error. Add the template to `views/welcome/index.html.erb` (naming is based on the controller and action)

We get a new error if we run our test:

```bash
Capybara::ElementNotFound:
       Unable to find visible link or button "Sign Up to Be a User"
```

Let's add the link to sign up in the `welcome/index.html.erb` file

```html
<!-- /*views/welcome/index.html.erb*/ -->

<%= link_to "Sign Up to Be a User" %>

```

But where do we want this link to go? We want to create a new user resource. Notice we are treating this resource as any other resource.

```html
<!-- views/welcome/index.html.erb -->

<%= link_to "Sign Up to Be a User", new_user_path %>

```
When we run our tests we get this error: 

```bash
Failure/Error: <%= link_to "Sign Up to Be a User", new_user_path %>

     ActionView::Template::Error:
       undefined local variable or method `new_user_path' for #<#<Class:0x007ffe993dc530>:0x007ffe993e7458>
       Did you mean?  new_movie_path
```

We still need to define this routes in our `routes.rb` file.

```ruby
#routes.rb
root "welcome#index"

resources :users, only: [:new]
```

If we run our test again we'll get this succession of errors:

```bash
Failure/Error: click_on "Sign Up to Be a User"

     ActionController::RoutingError:
       uninitialized constant UsersController
```

```bash
Failure/Error: click_on "Sign Up to Be a User"

     AbstractController::ActionNotFound:
       The action 'new' could not be found for UsersController
```

```bash
Failure/Error: click_on "Sign Up to Be a User"

     ActionController::UnknownFormat:
       UsersController#new is missing a template for this request format and variant.
...
```

Let's define the action and template that go along with our new user path.


```ruby
# controllers/users_controller.rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end
end
```

```html
<!-- views/users/new.html.erb -->

<%= form_for @user do |f| %>
  <%= f.label :username %>
  <%= f.text_field :username %>
  <%= f.label :password %>
  <%= f.password_field :password %>
  <%= f.submit %>
<% end %>
```

We have our form set up to take in the information that we want to create our user object with (username and password).

Our tests will now complain about an `uninitialized constant UsersController::User`. Remember this means this class can't be found whether through routing or because it doesn't exist yet. 

Why are we getting this error? We have set up an object called `@user = User.new` but that object does not exist in our database! If we follow this error, we can add our `user` model and then run the tests again.

```ruby
#models/user.rb
class User < ApplicationRecord

end
```

Next we get this whopper of an error:

```bash
Failure/Error: @user = User.new

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

The `PG::UndefinedTable: ERROR:  relation "users" does not exist` tells us that postgres can't find a `users` table. We still have to make the database connection but it doesn't feel right to store our passwords as plain text. IT ISN'T!!! DON'T DO IT. Use a password encryption tool (such as BCrypt) to store encrypted passwords in the database

```bash
rails g migration CreateUsers username:string password_digest:string
```

Apply that migration (`rake db:{drop,create,migrate,seed}`).

Let's get back to `password_digest` in a moment -- we should also make sure that our User model requires that the username and password fields be populated.

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

Why `password_digest`?

### BCrypt

[BCrypt Docs](https://github.com/codahale/bcrypt-ruby) [Rails built-in SecurePassword module](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password)
-  Secure Password Requires that the object have a `password_digest` attribute that will recognize both `password` and `password_confirmation` as attributes even though the attribute is called `password_digest`.
- Built into rails, comes out of the box in the gem file but it is commented out. Must uncomment to use it.
- Takes password and password_confirmation (if necessary) and encrypts it to a very long, hard to decrypt, string this is referred to as **hashing**.
- Takes care of matching the password and password_confirmation (if necessary).

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

Now we can create the user as we would with standard CRUD functionality, with one exception. The overall goal is to hold onto this user's information so that when they login, our application can remember them. UX-wise, it doesn't make a whole lot of sense if when a user signs up, they have to log in again to access their information. When a new user signs up, we want them to be logged in. So how do we do that? What tool in Rails might we be able to use to store information about our user as they are visiting our application?

When we run our test again we get this error:

```bash
Failure/Error: <%= form_for @user do |f| %>

     ActionView::Template::Error:
       undefined method `users_path' for #<#<Class:0x007fc37ffabb68>:0x007fc37ffaa8f8>
```

When reading this error, `undefined method users_path` sticks out to me as the important part. However I have to use a bit of my background knowledge to know what to do with it.  `users_path` is a path helper. I know that `users_path` can be used for an index or a create. I know I want to make a create route because I'm trying to `POST` from my form to the DB. 

### Independent Practice 
Go ahead and create the user :create route and the associated action in the `UsersController` as well as the associated show pieces.


You should end up with something like this: 

```ruby
  #routes.rb

  resources :users, only: [:new, :create :show]
```

```ruby
# app/controllers/users_controller.rb
  def show
    @user = User.find(params[:id])
  end
  
  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end
```

```html
  <h1>Welcome, <%= @user.username %>!</h1>
```
Now when we run our tests, all should pass. 

### Sessions
Except we don't want them to pass just yet. We need to add our user's information to sessions so our user doesn't have to log in for each page they want to visit. 

HTTP is a stateless protocol, which means there is no connection between each request sent. Nothing is being remembered. Sessions make it stateful. Without the idea of sessions, the user would have to identify, and probably authenticate, on every request.

* Set using `session[key] = value`
* Clear using `session.clear`

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

```ruby
  user = User.create(username: "funbucket13", password: "test")

  visit '/'

  click_on "I already have an account"

  expect(current_path).to eq(login_path)
  fill_in "username", with: user.username
  fill_in "password", with: user.password

  click_on "Log In"

  expect(current_path).to eq(user_path(user))

  expect(page).to have_content("Welcome, #{user.username}")
  expect(page).to have_content("Logout")
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

* Set in ApplicationController as `helper_method :method_name`
* Allows us to use the method in our views and controllers.

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
* ||= is [memoization](http://gavinmiller.io/2013/basics-of-ruby-memoization/). Ruby will look to see if the variable on the left exists, if it does it uses that value. If it doesn't exist it preforms the opperation on the right. 
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

