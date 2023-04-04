---
title: Cookies, Sessions and Authorization
length: 120
tags: cookies, session, auth, authorization
---
# Sessions, Cookies, Authorization

## What Are You Allowed to Do Here?

The idea of Authentication in our previous lesson was "Who are you?". Now that you're here, and logged in, we need to explore the idea if "What are you allowed to do?"

## Learning Goals

- Review of the Session object in Rails, and how it's actually stored
- Learn how cookies are transmitted to/from Rails
- Explore different kinds of Cookies
- Examine different ways of tracking Authorization
- Load an object to be used throughout the app using a `before_action` filter in the ApplicationController

## Warm Up

- What is in an HTTP request?
- What is in an HTTP response?
- What do you already know about browser Cookies?
- (optional) What's your favorite kind of cookie?

## Intro

Now that we're logged in, how is Rails actually storing our session? Is that something our user can manipulate?

How can we have different *kinds* of users in our application, such as a "regular" user, an "admin" user, etc.?

### Picking up where we left off

In our previous lesson, we built a login form, had a user log in, but what is the `session` object all about? How does it get built, managed, stored, etc.? (You can start off with this repo [here](https://github.com/turingschool-examples/authentication-7/tree/authentication-complete). You want to use the `authentication-complete` branch).

## Session Management, Configuration

**By default, Rails stores sessions in a client-side cookie**, and the configuration setting isn't even specified anywhere as a default for Rails 7.

We CAN override this by implementing `config.session_store` in `config/application.rb` but we don't have to for what we're building. You can read more about deeper configurations at this URL: [https://guides.rubyonrails.org/configuring.html](https://guides.rubyonrails.org/configuring.html)

## Is that really secure?

Let's try it out. Go ahead and log into the application that we started in our previous lesson, and look at your cookies in Chrome:

Go into the Inspect tool (Cmd-Option-i), click on the Application tab along the top, click on Cookies in the left pane to expand the list of cookies, and we should see an option there for `http://localhost:3000`

When we select the `localhost` option under our cookies, we should see a set of key/value pairs like `_authentication7_session` and a `Value` that we can't easily read.

The `name` of the piece of data is named after our application, plus `_session` at the end of it.

The `value` is unreadable. In our application, all we set in our session was our `user_id` value.

This is an **encrypted** cookie. Only our Rails application can decrypt this. In fact, if we were to change something in our Chrome browser about this value, we should be immediately logged out when we refresh the page.

Rails protects itself from tampered cookies.

## Session cookies are short-lived

Your browser will clean up any cookies that it sees which are too "old". We call this an "expired" cookie.

By default, session cookies in Rails are set to expire whenever the browser is completely closed. Having a browser open somewhere else isn't enough. If you *completely* close Chrome, for example (Cmd-Q) then any Rails-based session cookies you have in your browser will be cleaned up.

### How can we make these last longer?

Many web sites may have a "remember me for 7 days" or "remember me for 30 days" or sometimes just a "remember me" checkbox when you're logging in on a web site.

How do THOSE work?

That's what we're going to build today.

But to do that, we need to build a "regular" cookie, not a "session" cookie.

And there are different kinds of cookies.

## Cookies in Rails

Rails 7 Documentation on Cookies:

- [https://guides.rubyonrails.org/action_controller_overview.html#cookies](https://guides.rubyonrails.org/action_controller_overview.html#cookies)

Cookies are handled by ActionDispatch, but readable by ActionController. Since ActionController is inherited by our other controllers, we have access to cookies in any of our controller code.

Cookies are effectively treated like a hash. It's a key/value storage mechanism. But cookies also have additional configuration around things like an expiration date, which "domain name" it's linked to (ie, "localhost" or "[my-awesome-app.com](http://my-awesome-app.com/)"), whether the cookie should only work for SSL/TLS enabled sites, and more.

## Basic Cookie Usage

`cookies` is the name of our storage, which as mentioned previously, is similar to a hash.

We will generally use this code within our Controllers, but we may be able to access them elsewhere in our code as well, such as in our Views.

`cookies[:user_id] = "12"` is all we need to set a cookie with a key of `:user_id` and a value of `"12"`.

It's important to note that keys and values in cookies are always going to be treated as `String` object types.

If you REALLY want to store a different type of object as a value, you will need to use `JSON.generate` like this:

`cookies[:favorite_colors] = JSON.generate(['blue', 'red'])`

We will need to use `JSON.parse` to read this value back into an array in our code:

`fav_colors = JSON.parse(cookies[:favorite_colors])`

Because our `cookies` object isn't JUST a hash, we can set additional settings in this way:

`cookies[:site_theme] = {value: 'dark-mode', expires: 1.day}`

Whoa, cool, we can set a value AND an expiration at the same time!

## Expiration Times

If we do NOT specify an expiration, then the cookie becomes "session" based, and deleted when the browser is closed, just like our `session` cookie.

We can use Ruby's date helpers to set our expirations in a very easy way, such as `1.day` or `3.years` etc..

Rails also has a special setting for "permanent" cookies, which will set an expiration date of "20 years from now", which we can set using this syntax:

`cookies.permanent[:greeting] = 'Howdy!'`

## Deleting a Cookie

Deleting a cookie can be helpful if we log out, for example:

```ruby
cookies.delete :greeting
cookies.delete :favorite_colors
```

## Wait, we never really talked about security here!

When we set a cookie in our code, and look at it in our Inspect tool in Chrome, what do we see now?

Let's add some code to a view that prints what's in our cookies:

In our controller:

```ruby
def index
    unless cookies[:greeting]
      cookies[:greeting] = 'Howdy!'
    end
  end
```

In a view:

```html
<%= cookies[:greeting] %>
```

When we load the page for the first time, we'll see our "Howdy!" greeting. If we manipulate our cookie value in our browser, and reload the page, we'll see that the greeting changes to whatever we've found in our cookie.

THIS is why our typical session cookie is ENCRYPTED. It cannot be tampered with, because we wouldn't want our user to try to become some other user, or access a setting that we don't want them to access.

## Plain, Signed, and Encrypted Cookies

By default, cookies are generated with no security at all. Users can view them, manipulate them etc..

It ALSO means that malicious software (eg "malware" and viruses) can sometimes scrape our cookies from our browser and inspect their keys/values, possibly even tamper with the data.

We can "sign" a cookie, which acts as a type of "trust" that Rails will verify, so if data is manipulated in some way we can have Rails take some sort of action.

We'll need to delete our old 'greeting' cookie first!

```ruby
cookies.signed[:greeting] = 'Hello there!'
```

We also need to update our View to use the `.signed` property to read the value as well:

```ruby
<%= cookies.signed[:greeting] %>
```

## **Wait, can't really read this anyway so what's the difference between Signed and Encrypted??**

Well, the "signed" text is still readable with a little extra work.

At the time of writing this lesson, a signed greeting of 'Howdy!' was signed like the following cookie value:

`Ikhvd2R5ISI=--d12208b183689c5f30379f30d149b481d23f1cd2`

If we grab the first portion of the string:

`Ikhvd2R5ISI=`

We can use "base64 decoding" to turn this back into plaintext.

Visit [https://www.base64decode.org/](https://www.base64decode.org/) and paste that text above, and it should turn that string into `"Howdy!"` which is our string. The remaining portion after the `--` which included `d12208b...` is the "signature" that our Rails application added to the value which verifies that the data has not been tampered with.

If we use that same site to base64 encode "Howdy" without the exclamation point, we would see it generate this string:

`Ikhvd2R5Ig==`

If we alter our browser cookie so our value is this instead, but keeping the same signature portion:

`Ikhvd2R5Ig==--d12208b183689c5f30379f30d149b481d23f1cd2`

If we reload the page, our cookie greeting is now blank!

This, again, is Rails protecting itself from using tampered data.

But malicious software can still detect that these cookies are "signed" and that a portion of it is still base64 encoded, and still be able to read that data!

## Encrypted Cookies

If we really want these cookie values to be as secure as possible, we can encrypt the data, and only our Rails application can decrypt it.

In our controller.

```ruby
cookies.encrypted[:greeting] = 'Hello there!'
```

We also need to update our View to use the encrypted property to read the value as well:

```ruby
<%= cookies.encrypted[:greeting] %>
```

## Lessons Learned (so far)

Cookies are a great way to store some data, settings, etc, on the user's browser.

We've looked at plain cookies, signed cookies, and encrypted cookies, and their benefits, and interesting things like expiration dates.

One thing to note, though:

The NAME of the cookie key (ie "greeting") is ALWAYS plaintext-readable in the browser. If you set this to something like "password" or "user_id" it's more likely that malicious software (or users) will attempt to view/tamper with that data. Try to use generic-sounding key names to avoid this problem!

Our "session" cookie just has a name of "appname_session" which malicious users/malware may still try to examine, but since it's encrypted they don't know what's in there anyway.

## Remember Me

Okay, so now that we've looked at cookies in-depth, what would be the best way to implement a "Remember Me" cookie that will automatically log in a user when they visit our site, even if the browser is closed?

For starters, we know that setting our own expiration date will be a good way to ensure we don't lose the cookie when we close our browser.

At a high level, we need steps that look like this in our controller:

```markdown
- when a user logs in, make a 'remember me' cookie with a long expiration date

- if there is a session cookie, use that
- if not, check if we have a remember-me cookie
  - if so, check if that value is valid (not tampered with)
    - if so, look up that user, and set a new session cookie
```

Note that for strong security practices, if a long-term "remember me" cookie exists, and when you look up that user, they appear to be an 'admin' user, you should probably destroy the cookie and force the user to log in again. In other words, admin users should not get to use a "remember me" cookie and always have to log in to enforce good security.

One other consideration: if our "remember me" is set for, say, 24 hours, do we reset that timer every time the user takes an action within that 24 hours to give them ANOTHER 24 hours? or do we automatically log them out after 24 hours regardless?

## Check for Understanding

- what should we store in a session cookie versus a regular cookie?
- how much data can we store in each cookie?
- how do cookies even get set in the browser?
- how does the browser get that cookie information back to Rails?

## Authorization - Are you ALLOWED to do that?

At a high level, we sometimes want to have different "kinds" of users in our application like an "admin" user versus a "regular" user, maybe a "management" user.

We can very specific in our permissions, ie, maybe a regular user can view information, a manager can add new data but not delete things, maybe an admin user can have full CRUD functionality.

At a very high level, the following steps will be needed:

- we need to add a "role" to our user model
- we need to have different controller code based on the user's role
    - this means that we need additional routing
    - this introduces extra "name spacing" in our application
    

## User Role

We generally would make the user role an integer value so we're not storing a string over and over, and we can tell Ruby to use a lookup table called an "enum" (short for enumerable) to convert that number to a string later.

How we order these values doesn't really matter, but it's important to note that we generally only add to the END of our enumerable list. If we add something in the middle of the list, we might accidentally change other roles, and that can get really confusing.

Rails also has some neat "magic" about using these enum strings to build validation routines that we'll see in a moment.

## Add a new `role` field

Make a migration to add a `role` field for a user, which is an integer field:

```bash
$ rails g migration AddRoleToUsers role:integer
```

The migration should look something like this down below. Be sure to set the default to 0, which we will set to be a “default” user, like a regular user that has no special access.

```ruby
class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 0
  end
end
```

And let us go ahead and apply this change.

```bash
$ rails db:migrate
```

Now, in our `User` model, we need to specify our list of enumerable strings for the Roles that we have created.

*app/models/user.rb*

```ruby
class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password

  has_secure_password

  enum role: %w(default manager admin)
end
```

What this does is that it will give us access to some really useful helper methods, like this:

```ruby
# look up user 1
user = User.find(1)

# is user a default user?
if user.default?
  # default user!
elsif user.manager?
  # user is a manager
elsif user.admin?
  # user is an admin
else
  # we don't know what kind of user they are?!
end
```

Remember that earlier, we had made it in our migration that our database would set the role to `0` if we didn’t set the role explicitly on our site, so we REALLY want to make sure that we are using strong params when we are creating users to make sure that we are NOT letting the `role` property to be transferred in as a form parameter.

## Logging In Differently

Setting up roles like this allows us to redirect users to different places based on their role. We can do something like this inside our `users_controller.rb`:

```ruby
def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      if user.admin?
        redirect_to admin_dashboard_path
      elsif user.manager?
        redirect_to root_path
      elsif
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end
```

Then, of course, we would need to build the correct dashboards. Note that we are just redirecting the manager and default users to the root path because we have not built out other dashboards.

## What’s in a name(space)?

From here, we can route to a new dashboard path, like `/admin/dashboard` where only our admin users can access the controller.

*config/routes.rb*

```ruby
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"

  resources :users, only: [:new, :create]

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"

  namespace :admin do
    get "/dashboard", to: "dashboard#index"
  end
end
```

Now we need to add an additional folder and put our new controller in there.

```bash
$ mkdir app/controllers/admin
$ touch app/controllers/admin/dashboard_controller.rb
```

And let’s set up the controller itself.

*app/controllers/admin/dashboard_controller.rb*

```ruby
class Admin::DashboardController < ApplicationController
#     ^^^^^^^
#     this is where we note the namespace
#     this will come up again when we build APIs later
end
```

Note how we are namespacing Admin here.

Our next step is to write a little test to make sure that when we have an admin user log in, they get to the right dashboard. And we should also add a test to make sure that a regular user can’t get there either.

```bash
$ mkdir spec/features/admin/
$ touch spec/features/admin/login_spec.rb
```

*spec/features/admin/login_spec.rb*

```ruby
require "rails_helper"

describe "Admin login" do
  describe "happy path" do
    it "I can log in as an admin and get to my dashboard" do
	    admin = User.create(username: "superuser@awesome-site.com",
                        password: "super_secret_passw0rd",
                        role: 2)

      visit login_path
      fill_in :username, with admin.username
      fill_in :password, with admin.password
      click_button 'log in'

      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end

describe "as default user" do
  it 'does not allow default user to see admin dashboard index' do
    user = User.create(username: "fern@gully.com",
                       password: "password",
                       role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
```

To make this all work, we need a filter in our admin dashboard controller to make sure that BEFORE we run any actions that we check and make sure that the user is an admin user.

*app/controllers/admin/dashboard_controller.rb*

```ruby
class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
  end

  private
    def require_admin
      render file: "/public/404.html" unless current_admin?
    end
end
```

## Hol’ Up, what’s `current_admin`?

We need to make another helper method in our application controller.

*app/controllers/application_controller.rb*

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
```

This is going to re-use our `current_user` method and if that is truthy, it will check the `admin?` method that we get from using our `enum` to make sure that the user is also an admin user.

But having to build this `before_action` into each admin controller is going to be a nuisance, so we can make this reusable by making an equivalent "application controller" for our admin namespace. Typically you'll see this called a "base controller", like this:

`/app/controllers/application_controller.rb`

- defines `current_user`, `current_admin?` etc

`/app/controllers/admin/base_controller.rb`

- inherits application_controller
- uses our `before_action` and defines `require_admin`

`/app/controllers/admin/dashboard_controller.rb`

- inherits our new `admin/base_controller.rb`

## Wrap-Up

- what are the main differences between authentication and authorization?
- how can we use both to secure our application?
- what does `before_action` do?
- what are good/bad things about using an `enum` for our role?
- what does `allow_any_instance_of` do?

Completed code for this lesson plan available on this branch [here](https://github.com/turingschool-examples/authentication-7/tree/authorization-complete).
