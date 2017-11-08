# Authentication
### If you are who you say you are...

---

# Warm Up

## In your authentication practice project from the other day...

* What attributes did you give a user?
* What controller actions did you have for user?
* How did you handle logging a user in?
* What questions do you have?

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

## Setting up the Root Page

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

```erb
#views/welcome/index.html.erb

<%= link_to "Sign Up to Be a User" %>

```

But where do we want this link to go? We want to create a new user resource. Notice we are treating this resource as any other resource.

```erb
#views/welcome/index.html.erb

<%= link_to "Sign Up to Be a User", new_user_path %>

```

We still need to define this routes in our `routes.rb` file.

```ruby
#routes.rb
root "welcome#index"

resources :users, only: [:new]
```

---

# BCrypt

---

# Why bother?

## [fit] *DO NOT STORE PASSWORDS IN YOUR DATABASE AS PLAIN TEXT*

---

# DON'T DO IT

---

# Setup

* Add gem ‘bcrypt’ to Gemfile
* Add `has_secure_password` in User model[^1]
* Generate `User` with `username` and `password` fields
[^1]: Adds methods to set and authenticate against a BCrypt password

---

# Live Coding
## Adding BCrypt

---

# Logging In

---

# Tools

* Sessions
* More BCrypt
* Helper methods

---

# Sessions

* Set using `session[key] = value`
* Clear using `session.clear`

---

# More BCrypt

```ruby
@user = User.find_by(email: params[:email])
if @user.authenticate(password)
  # do user logged in stuff
else
  # try again
end
```

---

# Helper Methods

* Set in a controller as `helper_method :method_name`
* Allows us to use the method in our views

---

# Live Coding
## Logging In

```ruby
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
```

---

# Live Coding
## Logging Out

---

# Takeaways

* Encrypt passwords in your database when you store them
* Use *ApplicationController* to hold methods you'll be using across controllers
* Use `helper_method :method_name` for methods you want to use in the views
* Don't hesitate to use  *custom routes* when appropriate
* Use a *session* to store a logged in user id
* Use *form_tag* when creating a form without an associated model
