---
layout: page
title: Authentication
length: 120min
tags: rails, authentication, bcrypt, ruby, sessions, helper_methods
---
# Intro to Basic Authentication

## Who Are You?

## Learning Goals

- review migrations, model tests, feature tests
- review RESTful routing and non-RESTful routing
- explain the use of Authentication and why it's important
- implement Authentication using BCrypt
- use a `flash` to send temporary content to the view

## Vocabulary

- authentication
- hash
- helper_method
- "flash" message

## Overview

- Creating a user in our database
- Using `bcrypt` to hash passwords that we save

## What IS Authentication?

Authentication is the client proving to the application that they are who they say they are.

First, we need a user to register, which is a "create" action on a "user" resource. We'll use a Rails form helper for the registration sequence.

From there, we want to make a "login" route, which is NOT a RESTful route so we can verify who they are.

The common pattern we see today is the use of an email address to identify a user, but a "username" can also be used. We also need a password for them. **We are going to handle this interaction a little differently than we handle traditional user creation because we're setting the groundwork to remember our user in the sessions/cookie class coming up.**

## Registering Users

We want to remember users who come to our application. This will require a way for a user to log in to our application, and for our application to "remember" that user.

Let’s start with a user story and a test. You can add this code to an existing repo, or if you want, we have a blank one for you [here](https://github.com/turingschool-examples/authentication-7).

```markdown
As a visitor
When I visit '/'
and I can click a link that says "Sign Up to Be a User"
and I can enter registration details in a form
and submit that form
Then I should see a welcome message with my username
and my user details have been saved in the database.
```

*spec/features/users/user_can_be_created_spec.rb*

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

Running the test will give us errors concerning routing and creating a controller, so let’s start making these errors go away.

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
end
```

We first start by making a route.

This is the same as `get "/", to: "welcome#index"`, but now, we'll have the `root` prefix to use as a path helper. Try it! Run `rails routes` and see the routes that get generated for `"/"` when you write the path these two different ways.

Next, let's create the `WelcomeController` and a method for the `index` action as well. We are going to be rendering some basic content so we don't need to fetch any data or build any instance variables in our controller.

*app/controllers/welcome_controller.rb*

```ruby
class WelcomeController < ApplicationController
  def index
  end
end
```

Now, when we run our test, we get a missing template error, so let’s create an empty view template. 

```bash
$ mkdir app/views/welcome
$ touch app/views/welcome/index.html.erb
```

This will cause a new error in our test about a missing link.

Let’s add the link to sign up into our view.

*app/views/welcome/index.html.erb*

```html
<%= link_to "Register as a User" %>
```

But which URI path should we send a user to who clicks on this link?

Since this is a new "user" resource, we'll name this as we have in other Rails applications.

*app/views/welcome/index.html.erb*

```html
<%= link_to "Register as a User", new_user_path %>
```

Be sure to use path helpers wherever you can!

We can continue to follow our errors to create a new resources route for our users to point to a controller. We need a "new" path to display the form, and a "create" path to save the form data.

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  resources :users, only: [:new, :create]
end
```

For the "new" page, once we create the route, we will have to create the users controller and we will need to create a form.

```bash
$ touch app/controllers/users_controller.rb
$ mkdir app/views/users
$ touch app/views/users/new.html.erb
```

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
  end
end
```

*app/views/users/new.html.erb*

```html
<%= form_with model: @user do |form| %>
  <%= form.label :username, 'Username:' %>
  <%= form.text_field :username %>
  <%= form.label :password, 'Password:' %>
  <%= form.password_field :password %>
  <%= form.submit 'Create User' %>
<% end %>
```

When we run the tests again we now get a new error:

```bash
Failure/Error: click_on "Create User"

     ActionController::RoutingError:
       No route matches [POST] "/users/new"
```

Our form doesn’t know where we need to send the information, but we have the route in our `routes.rb`.  How does it not know where to send the stuff? We are using form_with with a model, `@user` which hasn’t been set so we have to make a blank `User` object first.

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end
end
```

Our tests will now complain about an `uninitialized constant UsersController::User`. Let's create a User model, so we'll start with an ActiveRecord database migration.

```bash
$ rails g migration CreateUsers username:string password_digest:string
```

WAIT -- "password_digest" ?? We were calling it "password" a minute ago.

More on that in a moment...

In the meantime, let’s run that migration.

```bash
$ rails db:migrate
```

We should also make sure that our User model requires that the username and password fields be populated by adding validations.

```bash
$ mkdir spec/models
$ touch spec/models/user_spec.rb
```

*spec/models/user_spec.rb*

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

And let’s make our test pass like so:

```bash
$ touch app/models/user.rb
```

*app/models/user.rb*

```ruby
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password
end
```

When we run our tests, our model test is complaining that we don't have an attribute called `password` and it's right! Look at the migration and the schema. We have a field called `password_digest` that we had created, but no `password`. 

## What’s a `password_digest`?

### BCrypt

- [BCrypt Docs](https://github.com/codahale/bcrypt-ruby)
- [Rails built-in SecurePassword module](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password)
- Secure Password Requires that the object have a `password_digest` attribute that will recognize both `password` and `password_confirmation` as attributes even though the attribute is called `password_digest`.
- Built into Rails, comes out of the box in the gem file but it is commented out by default. Must uncomment to use it.
- Takes password and password_confirmation (if necessary) and encrypts it to a very long string which is hard to decrypt; this is referred to as **hashing**.
- Takes care of matching the `password` and `password_confirmation` fields (if used).

So let’s get `bcrypt` set up. Find the `gem "bcrypt"` in your `Gemfile` and uncomment it. Run `bundle install` again to complete the process.

We now need to tell our model that it will be expecting a field, `password`, (and `password confirmation` if needed) with the `has_secure_password` entry like so:

*app/models/user.rb*

```ruby
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password

  has_secure_password
end
```

Run our model tests, and ONLY our model tests…

```bash
$ bundle exec rspec spec/models
```

And the model tests should be passing.

## We now return you to your regularly-scheduled TDD

Now that we're past the error about our missing User model, our form is complaining about a missing 'username' field.

The gem, `launchy` has been added to your Gemfile, which means now, you can add `save_and_open_page` as a command in your feature test, at some point before the failing line. This will open up a static page at the time the `save_and_open_page` method was executed.

Add `save_and_open_page` before the line in your test that's currently failing, and then run your test.

If we examine the HTML on the page in our browser, we see that the form fields aren't called `username` and `password`, they're called `user_username` and `user_password`.

This is because the "form helper" called `form_with` that we're using is taking a User model and prefixing the names of the fields, so we can adjust our test, and carry on.

(be sure to remove the `save_and_open_page` command)

*spec/features/users/user_can_be_created_spec.rb*

```ruby
require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq(new_user_path)

    username = "funbucket13"
    password = "test"

    fill_in :user_username, with: username
    fill_in :user_password, with: password

    click_on "Create User"

    expect(page).to have_content("Welcome, #{username}!")
  end
end
```

## Whew, done.

Now, when we run our tests, it’s going to complain about there not being a create action, so we need to make one.

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  end
end
```

Whenever we "create" something, we generally want to redirect the user if everything worked, or re-render the "new" form if something failed. We won't worry about "sad path" right now, and just redirect back to our welcome page when we're finished.

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    redirect_to root_path
  end
end
```

This is a friendly reminder that you should be using path helpers as much as you can!

So the issue now is that our test can’t find the username of the user that we’ve just created on the page, so now, we have to create a User, and report that to the browser.

We are "dream driving" at this point: "I really wish I had a user object that I could use to create users”

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    User.create(user_params)
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
```

When we run our feature test again we get this error:

```bash
Failure/Error: expect(page).to have_content("Welcome, #{username}!")
       expected to find text "Welcome, funbucket13!" in "Register as a User"
```

Let's look back at the UsersController. It looks like the new user is being created, so let's add a flash message to show the welcome message.

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)
		flash[:success] = "Welcome, #{new_user.username}!"
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
```

Next, we probably need to add those flash messages to our site. Since this is the kind of mechanism we'll want on all of our pages, let's add it to the main `application.html.erb` in our view layouts.

*app/views/layouts/application.html.erb*

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Authentication7</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <% flash.each do |name, msg| %>
      <%= content_tag :div, msg, class: name %>
    <% end %>
    <%= yield %>
  </body>
</html>
```

If we run our tests now they should all be passing. Congrats! You did it!

## Improving User Experience

If your username is an email address, you should always LOWERCASE your user's input before trying to save it or look it up in the database. If you want case-sensitive usernames where "Francine" is a different user than "francine" and "fRaNcInE" then you don't need to change anything.

If you’re using emaill addresses, though, this is a better approach:

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

On our root page, we should also be able to let people who have already created an account log in. Let’s start with a test.

```markdown
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

```bash
$ touch spec/features/users/user_can_log_in_spec.rb
```

*spec/features/users/user_can_log_in_spec.rb*

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

Run this test and we get a missing link error, so we add a link.

*app/views/welcome/index.html.erb*

```html
<%= link_to "Register as a User", new_user_path %>
<%= link_to "I already have an account", login_path %>
```

Next, we need to add the route. But where should we send the user to to log in? Lets send them to a non-RESTful controller action that will relate to our process. We'll correct this in the sessions/cookies class later.

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  resources :users, only: [:new, :create]

	# this is not RESTful, and that's OKAY
	get "/login", to: "users#login_form"
end
```

We'll need to create the "login_form" method in our UsersController, and an associated view template.

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)
    flash[:success] = "Welcome, #{new_user.username}!"
    redirect_to root_path
  end

  def login_form
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
```

```bash
$ touch app/views/users/login_form.html.erb
```

*app/views/users/login_form.html.erb*

```html
<%= form_with url: login_path, method: :post do |form| %>
  <%= form.label :username, "Username:" %>
  <%= form.text_field :username %>
  <%= form.label :password, "Password:" %>
  <%= form.text_field :password %>
  <%= form.submit "Log In" %>
<% end %>
```

Now that we have our form, when we run RSpec, we get a new error complaining about not having a POST route, so we'll add that to our routes next.

*config/routes.rb*

```html
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  resources :users, only: [:new, :create]
  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
end
```

And we’ll need to create the associated controller action. This will be similar to our `create` method, but we will do a `User.find_by` instead of a `User.create`.

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)
    flash[:success] = "Welcome, #{new_user.username}!"
    redirect_to root_path
  end

  def login_form
  end

  def login
    user = User.find_by(username: params[:username])
    flash[:success] = "Welcome, #{user.username}!"
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
```

## We did it!

Did we do it? Did we ever actually check password?

## Writing the code equivalent of a bouncer

If you look at the `UsersController#login` action, we aren't actually checking the user's password. We want to add more testing to ensure that users can't log in with bad credentials. Let’s add this it block to our current test file.

*spec/features/users/user_can_log_in_spec.rb*

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

In the `UsersController#login` action, we need to check the password and handle the case when it doesn't match. **Remember, we never store a user's actual plaintext password in the database!** So we can't do something like:

```ruby
user = User.find_by(username: params[:username])
if user.passsword == params[:password]
  # password matches
else
  #password doesn't match
end
```

What we're actually storing in the database is a **hash** or **digest** of the user's password, so we are going need to hash the given password and see if it matches what's in our database. Luckily, that `has_secure_password` line we added to our User model gives us a handy method to do this for us called `authenticate`. This method is called on a User object and takes a password as an argument:

*app/controllers/users_controller.rb*

```ruby
def login
  user = User.find_by(username: params[:username])
  if user.authenticate(params[:password])
    flash[:success] = "Welcome, #{user.username}!"
    redirect_to root_path
  else
    flash[:error] = "Sorry, your credentials are bad."
    render :login_form
  end
end
```

And with that our tests should be passing and everything should now work.

## Let’s Get Fancy With a Helper Method

The thing is that if we are logged in, we don’t necessarily want to see links to log in or create a user. When we think about a lot of the websites that we visit, if we are not logged in, we see links to either create a user or log in, and if we are logged in, we will see a link to log out.

Let’s dream drive a little bit.

*app/views/welcome/index.html.erb*

```html
<% if current_user %>
  <%= link_to "Log Out" %>
<% else %>
  <%= link_to "Register as a User", new_user_path %>
  <%= link_to "I already have an account", login_path %>
<% end %>
```

If we run our tests here, we’re going to get a failing test because we haven’t at all defined `current_user` here.

Our want here is that this method, `current_user`, will tell us who or if anyone is currently logged into the site. Because we will want to be able to do this throughout our application, we will define it in `ApplicationController`. Because all of our controllers inherit from it, every controller will have access to this method.

*app/controllers/application_controller.rb*

```ruby
class ApplicationController < ActionController::Base
  def current_user
    User.find(session[:user_id])
  end
end
```

The session is where we want to store whomever is logged in so we also need to modify our `UsersController` to put the user id in the session on either a user being created or a user logging in.

*app/controllers/users_controller.rb*

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)
    session[:user_id] = new_user.id
    flash[:success] = "Welcome, #{new_user.username}!"
    redirect_to root_path
  end

  def login_form
  end

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
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
```

Even with this code, nothing changes. We are calling this method in our view, and views don’t have access to methods we define in our controllers by default. We can give views access to methods by declaring them as helper methods.

*app/controllers/application_controller.rb*

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    User.find(session[:user_id])
  end
end
```

And now we get a new error.

```bash
ActionView::Template::Error:
       Couldn't find User with 'id'=
```

This is happening when no one is logged in, and `session[:user_id]` is nil. Let’s add an `if` statement to guard against this case.

*app/controllers/application_controller.rb*

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
end
```

Our test is now passing, but we can make just another improvement to our code.

*app/controllers/application_controller.rb*

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
```

`||=` is [memoization](http://gavinmiller.io/2013/basics-of-ruby-memoization/). Ruby will look to see if the variable on the left exists, if it does it uses that value. If it doesn’t exist it preforms the operation on the right. This makes it so that if we need to check the current user multiple times over the course of one request, we don’t have to go to the database to find the user multiple times.

## Takeaways

- Encrypt passwords in your database when you store them, using bcrypt
- Always lowercase usernames (especially email addresses) before storing/checking them
- Don't hesitate to use *non-RESTful routes* when appropriate

## Checks for Understanding

- What does Authentication mean? Why do we use it and when?
- What are the steps to implementing Authentication in a Rails app?

The completed code for this class can be found on this branch [here](https://github.com/turingschool-examples/authentication-7/tree/authentication-complete).
