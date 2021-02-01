---
layout: page
title: Authentication
length: 120min
tags: rails, authentication, bcrypt, ruby, sessions, helper_methods
---

## Who Are You?

## Learning Goals
* review migrations, model tests, feature tests
* review RESTful routing and non-RESTful routing
* explain the use of Authentication and why it's important
* implement Authentication using BCrypt
* use a `flash` to send temporary content to the view

## Vocabulary

* authentication
* hash
* helper_method
* "flash" message
  

## Overview

* Creating a user in our database
* Using *BCrypt* to hash passwords that we save

---

## What is Authentication?

Authentication is the client proving to the application that they are who they say they are.

First, we need a user to register, which is a "create" action on a "user" resource. We'll use a Rails form helper for the registration sequence.

From there, we want to make a "login" route, which is NOT a RESTful route so we can verify who they are.

The common pattern we see today is the use of an email address to identify a user, but a "username" can also be used. We also need a password for them. We handle this interaction a little differently than we handle a traditional user creation because we're setting the groundwork to remember our user in the sessions/cookie class coming up.


## Registering Users

We want to remember users who come to our application. This will require a way for a user to log in to our application, and for our application to "remember" that user.

```
As a visitor
When I visit '/'
and I can click a link that says "Sign Up to Be a User"
and I can enter registration details in a form
and submit that form
Then I should see a welcome message with my username
and my user details have been saved in the database.
```

Let's start with a test.

If you want to add this to an existing application, you can, or you can set up a new Rails application to follow along in class.


```ruby
require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq(new_user_path)

    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Create User"

    expect(page).to have_content("Welcome, #{username}!")
  end
end
```

Running the test will give us errors to follow about routing and creating a controller.

```ruby
  #routes.rb

  get "/", to: "welcome#index"
```

Or we can use the handy `root` method that Rails gives us to create a route for the root path ("/"):

```ruby
  #routes.rb

  root "welcome#index"
```

Next, let's create the `WelcomeController` and a method for the `index` action as well. We are going to be rendering some basic content so we don't need to fetch any data or build any instance variables in our controller.

Now when we run our test, we get a missing template error, so let's create an empty view template. This will cause a new error in our test about a missing link.

Let's add the link to sign up in the `app/views/welcome/index.html.erb` file

```html
<%= link_to "Register as a User" %>
```

But which URI path should we send a user to who clicks on this link?

Since this is a new "user" resource, we'll name this as we have in other Rails applications.

```html
<%= link_to "Register as a User", new_user_path %>
```

* Be sure to use path helpers everywhere you can!

We can continue to follow our errors to create a new resources route for our users to point to a controller. We need a "new" path to display the form, and a "create" path to save the form data.

For the "new" page, once we create the route, and the UsersController, and the correct action method, we'll need to create a form.

```ruby
# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def new
  end
end
```

```html
<!-- views/users/new.html.erb -->

<%= form_with model: @user do |form| %>
  <%= form.label :username, 'Username:' %>
  <%= form.text_field :username %>
  <%= form.label :password, 'Password:' %>
  <%= form.password_field :password %>
  <%= form.submit 'Create User' %>
<% end %>
```

Run the tests again and the error is

```
ActionController::RoutingError:
       No route matches [POST] "/users/new"
```

Our form doesn't know where to send the information!

Let's add this route to our `routes.rb` 

But now we're getting an error that the POST route still doesn't exist!

That's because form_with is using a model of `@user` which hasn't been set, we need to build a blank `User` object first.


```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end
```

Our tests will now complain about an `uninitialized constant UsersController::User`. Let's create a User model, so we'll start with an ActiveRecord database migration.

`rails g migration CreateUsers username:string password_digest:string`

WAIT -- "password_digest" ?? We were calling it "password" a minute ago.

More on that in a moment...

Apply that migration (`rake db:migrate`).

We should also make sure that our User model requires that the username and password fields be populated by adding validations.

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

Our model test is blowing up because we don't have `shoulda-matchers` installed or set up, let's go do that really quickly.

## Shoulda-Matchers

Add this to our development/test block:

```ruby
gem 'shoulda-matchers'
```

Then run `bundle` to install that gem.

And add this at the bottom of our `rails_helper.rb`:

```ruby
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
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


## We now return you to your regularly-scheduled TDD

Now that we're past the error about our missing User model, our form is complaining about a missing 'username' field.

If you add the `launchy` gem to your Gemfile (and run `bundle`) then you'll be able to add `save_and_open_page` as a command in your feature test, at some point before the failing line.

If we examine the HTML on the page in our browser, we see that the form fields aren't called `username` and `password`, they're called `user_username` and `user_password`.

This is because the "form helper" called `form_with` that we're using is taking a User model and prefixing the names of the fields, so we can adjust our test, and carry on.

(be sure to remove the `save_and_open_page` commend)


## Whew, done.

Now our test is telling us to make our `create` method in our `UsersController`:

```ruby
  def create
  end
end
```

Whenever we "create" something, we generally want to redirect the user if everything worked, or re-render the "new" form if something failed. We won't worry about "sad path" right now, and just redirect back to our welcome page when we're finished.

* Remember to use path helpers as much as possible!

```ruby
def create
  redirect_to root_path
end
```

Now our test can't find the username on the resulting page, so let's try to create the User and figure out how to report that to the browser.

We are "dream driving" at this point: "I really wish I had a user object that I could use to create users"


```ruby
def create
  User.create(user_params)
  redirect_to root_path
end

private
def user_params
  params.require(:user).permit(:username, :password)
end
```

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
  redirect_to root_path
end
```

Next, we probably need to add those flash messages to our site. Since this is the kind of mechanism we'll want on all of our pages, let's add it to the main `application.html.erb` in our view layouts.

```ruby
<!DOCTYPE html>
<html>
<head>
  <%= stylesheet_link_tag    'application', media: 'all' => true %>
  <%= javascript_include_tag 'application' %>
  <%= csrf_meta_tags %>
</head>
<body>
  <% flash.each do |name, msg| %>
    <%= content_tag :div, msg, class: name %>
  <% end %>
<%= yield %>

</body>
</html>
```

## Improving user experience

If your username is an email address, you should always LOWERCASE your user's input before trying to save it or look it up in the database. If you want case-sensitive usernames where "Francine" is a different user than "francine" and "fRaNcInE" then you don't need to change anything.

If you're using email addresses, though, this is a better approach:
```ruby
    def create
        user = user_params
        user[:username] = user[:username].downcase
        new_user = User.create(user)
        flash[:success] = "Welcome, #{new_user.username}!"
        redirect_to root_path
    end
```


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

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.username}")
  end
end
```

Run this test and we get a missing link error. Add the link to the welcome/index view:

```erb
<%= link_to "I already have an account", login_path %>
```

Next, we need to add the route. But where should we send the user to to log in? Lets send them to a non-RESTful controller action that will relate to our process. We'll correct this in the sessions/cookies class later.

```ruby
# this is not RESTful, and that's OKAY
get '/login', to: 'users#login_form'
```

We'll need to create the "login_form" method in our UsersController, and an associated view template.

```ruby
<!-- app/views/users/login_form.html.erb -->

<%= form_with url: login_path, method: :post do |form| %>
  <%= form.label :username, "Username:" %>
  <%= form.text_field :username %>
  <%= form.label :password, "Password:" %>
  <%= form.text_field :password %>
  <%= form.submit "Log In" %>
<% end %>
```

Now that we have our form, when we run RSpec, we get a new error complaining about not having a POST route, so we'll add that to our routes next.

```ruby
  post '/login', to: 'users#login'
```

And we'll need to create the associated controller action method. This will be similar to our `create` method, but we'll do a `User.find_by` instead of a `User.create`

```ruby
def login
  user = User.find_by(username: params[:username])
  flash[:success] = "Welcome, #{user.username}!"
  redirect_to root_path
end
```

## Passing tests!

Yay, we're done, right?? Our tests are passing!


## Checking the User's Password

If you look at the `UsersController#login` action, we aren't actually checking the user's password. We want to add more testing to ensure that users can't log in with bad credentials:

```ruby
it "cannot log in with bad credentials" do
  user = User.create(username: "funbucket13", password: "test")

  # we don't have to go through root_path and click the "I have an account" link any more
  visit login_path

  fill_in :username, with: user.username
  fill_in :password, with: "incorrect password"

  click_on "Log In"

  expect(current_path).to eq(login_path)

  expect(page).to have_content("Sorry, your credentials are bad.")
end
```

If we run the test now, it's redirecting us back to the welcome page, but we want to remain on the login page and see a flash message.

In the `UsersController#login` action, we need to check the password and handle the case when it doesn't match. **Remember, we never store a user's actual plaintext password in the database!** So we can't do something like:

```ruby
user = User.find_by(username: params[:username])
if user.passsword == params[:password]
  # password matches
else
  #password doesn't match
end
```

What we're actually storing in the database is a **hash** or **digest** of the user's password, so we are going need to hash the given password and see if it matches what's in our database. Luckily, that `has_secure_password` line we added to our User model gives us a handy method to do this for us called `authenticate`. This method is called on a User object and takes a password as an argument:

```ruby
def login
  user = User.find_by(username: params[:username])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.username}!"
    redirect_to root_path
  else
    flash[:error] = "Sorry, your credentials are bad."
    render :login_form
  end
end
```

Our tests should now be passing.


### Takeaways

* Encrypt passwords in your database when you store them, using bcrypt
* Always lowercase usernames (especially email addresses) before storing/checking them
* Don't hesitate to use *non-RESTful routes* when appropriate

## WrapUp
* What does Authentication mean? Why do we use it and when?
* What are the steps to implementing Authentication in a Rails app?
