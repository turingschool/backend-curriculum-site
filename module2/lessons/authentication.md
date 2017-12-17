---
layout: page
title: Authentication
tags: rails, authentication, bcrypt, ruby
---

### If you are who you say you are...

---
## Learning Goals
* 

## Vocabulary
* authentication
* session
* hash

## Warm Up

## In your authentication practice project from the other day...

* What questions do you have?
* What is the purpose of authentication? When might you use it?
* What attributes did you give a user?
* What controller actions did you have for user?
* How did you handle logging a user in?

---

# Overview

* Creating a user in our database
* Using *BCrypt* to hash passwords that we save
* Creating *custom routes* to login/logout
* Creating and destroying a *session*
* Using a *helper_method* to access *current_user* in views
* Using *form_tag* and a Controller with no associated model

---

## What is Authentication?

- Authentication is the client proving to the application that they are who they say they are. Usually this is done through a username/email and password combination. We handle this interaction a little differently than we handle a traditional user creation because we need to provide a way for our application to remember our user.

# Live Coding

- In `movie_mania`, our goal is to create a user that will eventually be able to check out movies from our application. This will require a way for a user to login to our application and our application to remember them.

## Creating a User Test

```ruby
  visit '/'

  click_on "Sign Up to Be a User"

  expect(current_path).to eq(new_user_path)

  fill_in :username, with: "funbucket13"
  fill_in :password, with: "test"

  click_on "Create User"

  expect(page).to have_content("Welcome, funbucket13!")
```

- At this point, we do not have a root page that supports this interaction. When we open our app, we want a page that directs the user to either create a new account or sign in with their existing credentials.

- When we run our test, we get a failure because we do not have a root path defined in our `routes.rb` file.

```ruby
  #routes.rb

  root "welcome#index"
```

- According to this root path, we are directing our root path to a `WelcomeController` and an `index` action in that controller.

- When we run our test, we get this error:

```bash
ActionController::RoutingError:
       uninitialized constant WelcomeController
```

- Let's create the `WelcomeController` and the action `index` as well. We are going to be rendering some basic content so we don't need to pass anything as an instance method.

```ruby
#controllers/welcome_controller.rb
class WelcomeController < ApplicationController
  def index
  end
end
```

- Now when we run our test, we get a template error. Add the template to `views/welcome/index.html.erb` (naming is based on the controller and action)

- We get a new error if we run our test:

```bash
Capybara::ElementNotFound:
       Unable to find visible link or button "Sign Up to Be a User"
```

- Let's add the link to sign up in the `welcome/index.html.erb` file

```html
<!-- /*views/welcome/index.html.erb*/ -->

<%= link_to "Sign Up to Be a User" %>

```

- But where do we want this link to go? We want to create a new user resource. Notice we are treating this resource as any other resource.

```html
<!-- views/welcome/index.html.erb -->

<%= link_to "Sign Up to Be a User", new_user_path %>

```

- We still need to define this routes in our `routes.rb` file.

```ruby
#routes.rb
root "welcome#index"

resources :users, only: [:new]
```

- Let's define the action and template that go along with our new user path.


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

- We have our form set up to take in the information that we want to create our user object with (username and password).

- Our tests will now complain because we have set up an object called `@user = User.new` but that object does not exist in our database. If we follow this error, we can add our `user` model and then run the tests again.

```ruby
#models/user.rb
class User < ApplicationRecord

end
```

- We still have to make the database connection but it doesn't feel right to store our passwords as plain text. IT ISN'T!!! DON'T DO IT. Use a password encryption tool (such as BCrypt) to store encrypted passwords in the database

```bash
rails g migration CreateUser username:string password_digest:string
```

- Why `password_digest`?

---

## BCrypt

- Requires that the object have a `password_digest` attribute that will recognize both `password` and `password_confirmation` as attributes even though the attribute is called `password_digest`.
- Built into rails, comes out of the box in the gem file but it is commented out. Must uncomment to use it.
- Takes password and password_confirmation (if necessary) and encrypts it to a very long, hard to decrypt, string.
- Takes care of matching the password and password_confirmation (if necessary).

- Find the `gem 'bcrypt'` in the `Gemfile` and uncomment it. Bundle again to complete the process.

- We now need to tell our model that it will be expecting a field `password` (and `password_confirmation` if needed).

```ruby
#models/user.rb
class User < ApplicationRecord
  has_secure_password
end
```

- Now we can create the user as we would with standard CRUD functionality, with one exception. The overall goal is to hold onto this users information so that when they login, our application can remember them. Functionality-wise, it doesn't make a whole lot of sense if when a user signs up, they have to log in again to access their information. When a new user signs up, we want them to be logged in. So how do we do that? What tool in rails might we be able to use to store information about our user as they are visiting our application?

---

## Sessions

- HTTP is a stateless protocol. Sessions make it stateful. Without the idea of sessions, the user would have to identify, and probably authenticate, on every request

* Set using `session[key] = value`
* Clear using `session.clear`

---

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

- By creating this key/value pair, we have created a way to get this information back easily.

BUT WE DON'T HAVE A SHOW VIEW!

Let's open that route, update our controller and create a view:

```ruby
  #routes.rb

  resources :users, only: [:new, :show]
```

```ruby
# app/controllers/users_controller.rb
  def show
    @user = User.find(params[:id])
  end
```

```html
  <h1>Welcome, <%= @user.username %>!</h1>
```
- Now when we run our tests, all should pass.

## New Test - Account Already Exists

- On our root page, we should also have the option to log in if our account already exists.
- Let's add a new test for this functionality

```ruby
  user = User.create(username: "funbucket13", password: "test")

  visit '/'

  click_on "I already have an account"

  expect(current_path).to eq(login_path)
  fill_in "user[username]", with: user.username
  fill_in "user[password]", with: user.password

  click_on "Log In"

  expect(current_path).to eq(user_path(user))

  expect(page).to have_content("Welcome, funbucket13!")
  expect(page).to have_content("Logout")
```

We are dream driving! We want to click on "I already have an account" and be taken to a form to fill in with my already existing username and password.

Our html should have a link like this:

```html
  <%= link_to "I already have an account", login_path %>
```

When running our tests, our test gets tripped up because `login_path` has not been defined in our routes. But where should we send the user to to log in?

Lets send them to a sessions controller that will handle information related to the session.

The `login_path` is just a form where our user can enter their credentials.

```ruby
#routes.rb

  get '/login', as: 'login', to: 'sessions#new'
```

And we will need a controller to handle this information:

```ruby
# app/controllers/sessions_controller.rb

class SessionsController
  def new
  end
end
```

And a view to render the form (this is a great use case for form_tag!)

```html
<!-- app/views/sessions/new.html.erb -->

<%= form_tag login_path do %>
  <%= label_tag :username %>
  <%= text_field_tag :username %>

  <%= label_tag :password %>
  <%= password_field_tag :password %>

  <%= submit_tag "Log In", class: "btn btn-large btn-primary" %>
<% end %>
```

Now that we have our form, when we run RSpec, we get a new error complaining about not having a post to `/login`:

```ruby
#routes.rb  
  post '/login', as: 'login', to: 'sessions#create'
```

Now we get a error when we click the "Log In" button!

We need an action in our controller that handles the post request:

```ruby
# app/controllers/sessions_controller.rb

def create
  user = User.find_by(username: params[:session][:username])
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    redirect_to user_path(user)
  else
    render :new
  end
end
```

 `.authenticate` is a method for BCrypt. From the source docs on GitHub:

 ```ruby
 def authenticate(unencrypted_password)
   BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
 end
 ```

 So if we find the user and their password entered matches the one in our database, we can add our session key of `user_id` to our sessions hash.

# Helper Methods

Lets update our views to use a helper method:

```html
<h1>Welcome, <%= current_user.username %>!</h1>
```

If we run our tests, they will fail because we have not defined `current_user`

* Set in a controller as `helper_method :method_name`
* Allows us to use the method in our views

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActiveRecord::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
```

## Workshop

- Create a test that logs out a currently logged in user. This will require you to create a new route and send it to a new action that will destroy the session. 

# Takeaways

* Encrypt passwords in your database when you store them
* Use *ApplicationController* to hold methods you'll be using across controllers
* Use `helper_method :method_name` for methods you want to use in the views
* Don't hesitate to use  *custom routes* when appropriate
* Use a *session* to store a logged in user id
* Use *form_tag* when creating a form without an associated model
