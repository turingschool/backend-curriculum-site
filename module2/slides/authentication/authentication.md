# Authentication
### If you are who you say you are...

---

# Warm Up

## In your authentication practice project from Monday...

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

# Live Coding
## Creating a User Test

```ruby
  visit '/'

  click_on "Sign Up to Be a User"

  expect(path).to eq(new_user_path)

  fill_in :username, with: "funbucket13"
  fill_in :password, with: "test"

  click_on "Create User"

  expect(page).to have_content("Welcome, funbucket13!")
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
