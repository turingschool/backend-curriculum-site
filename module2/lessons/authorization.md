---
layout: page
title: Authorization in Rails
tags: rails, authorization
---

### Learning Goals

* Authorize users based on roles
* Write a feature test that usees a stubbing library
* Implement namespacing for routes
* Use a `before_action` to protect admin controllers

## Slides

Available [here](../slides/authorization)

## Warmup

* How did you handle the secret page in Thursday's assignment?
* Have you tried to implement any authorization in the mini-project? If so, how?
* Any thoughts on how we might use namespacing to help us organize our authorization strategy?

## Repo

Continue working in your MovieMania application, or clone down the most recent version. A sample repo can be found [here](https://github.com/turingschool-examples/movie_mania_1803).

## Code Along

### Adding Authentication to our Application

Let's first add a validation on the User model to ensure that `username` is present and unique. We wouldn't want two users to have the same username if that's what we are using to uniquely identify users when they login. First, let's write a test.

```ruby
#spec/models/user_spec.rb
require "rails_helper"

describe User, type: :model do
  describe "validates" do
    it "presence of username" do
      user = User.new(password: "Password")

      expect(user).to_not be_valid
    end
    
    it "uniqueness of username" do
      orig = User.create(username: "user", password: "Password")
      copy_cat = User.new(username: "user", password: "Password")

      expect(copy_cat).to_not be_valid
    end

  end
end
```
Our error should read:

```
Failures:

  1) User validates presence of username
     Failure/Error: expect(user).to_not be_valid
       expected #<User id: 1, username: nil, password_digest: "$2a$04$iN35iTt4QVssodVTPDls7uSrSYSZnP7Vl2lwoZ6nfSC..."> not to be valid
     # ./spec/models/user_spec.rb:8:in `block (3 levels) in <top (required)>'
```

```ruby
validates :username, presence: true,
                    uniqueness: true
```

Next, let's create a test for the admin functionality we want to create. Our client has asked for categories in this application, and only an admin should be able to access the categories index.

We'll need to create a new test file in the `spec/features` folder.

```bash
$ touch spec/features/admin_sees_categories_index_spec.rb
```

Let's write our test.

```ruby
require "rails_helper"

describe "User visits categories index page" do
  context "as admin" do
    it "allows admin to see all categories" do
	   admin = User.create(username: "penelope",
                        password: "boom",
                        role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_categories_path
      expect(page).to have_content("Admin Categories")
    end
  end
end
```

Meanwhile, what's going on with that `role` field? Basically, we'll need that in order to determine what level of authorization a user has within the scope of our application. We know this is a distinction that we're going to want to be able to make. Let's drop down into a model test to see if we can develop this behavior.

```ruby
# spec/models/user_spec.rb
require 'rails_helper'

describe User do
  describe "roles" do
    it "can be created as an admin" do
      user = User.create(username: "penelope",
                         password: "boom",
                         role: 1)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end

    it "can be created as a default user" do
      user = User.create(username: "sammy",
                         password: "pass",
                         role: 0)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
  end
end
```

Our error should read something like this:

```
An error occurred while loading ./spec/features/admin_seed_categories_index_spec.rb.
Failure/Error: admin = User.create(username: "penelope", password: "boom", role: 1)

ActiveModel::UnknownAttributeError:
  unknown attribute 'role' for User.
```

This might seem a little bit crazy at first. The tests only have two lines, and those two lines don't even seem to go together very well. We create a `User` with a `role` of 1 and then proceed to assert that the user's role is `"admin"`. And that last line feels a little redundant? What's happening?

The behavior that we're describing is going to be achieved using an `enum`. For more information [check out the docs](http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html). To start, let's add a migration that will create `role` on our `User`.

```
$ rails g migration AddRoleToUsers role:integer
```

That should give us a starting point. Edit the new migration to include a default value of 0.

```ruby
class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, default: 0
  end
end
```

Don't forget to run `rake db:migrate` to run this migration! Check your `db/schema.rb` to ensure that our schema reflects these changes.

We're halfway there! We've added a role, but we'll still get a fairly useless error. 

```
Failures:

  1) User roles can be created as an admin
     Failure/Error: expect(user.role).to eq("admin")

       expected: "admin"
            got: 1

       (compared using ==)
     # ./spec/models/user_spec.rb:25:in `block (3 levels) in <top (required)>'

  2) User roles can be created as a default user
     Failure/Error: expect(user.role).to eq("default")

       expected: "default"
            got: 0

       (compared using ==)
     # ./spec/models/user_spec.rb:34:in `block (3 levels) in <top (required)>'
```
At this point, let's add our `enum` to our `User` model.

```ruby
class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true,
                    uniqueness: true

  enum role: %w(default admin)
end
```

Let's check, and... a passing model test! With that out of the way, let's go back and tackle our the error that our integration test is throwing our way.

```ruby
NameError:
       undefined local variable or method 'admin_categories_path' for #<RSpec::ExampleGroups::AdminVisitsCategoriesIndexPage:0x007faa6e7f2b08>
```

We want admin functionality when it comes to `categories`. Only admins should be able to see the index view of all the categories.

Do you think we should we use nested resources here or namespace?

Since `admin` is never going to be its own entity (resource) within our application, we can use `namespace`.

Add this `namespace` and the route for only the `index` to your routes (we may need to add other actions later, but for now, let's only create what we need).

```ruby
namespace :admin do
  resources :categories, only: [:index]
end
```

Whenever we add something to our `routes.rb`, verify that your output via `rails routes` is what you expect. Whoa, our routes are getting long and hard to read. Let's run `rails routes | grep admin` to see just our admin routes.

Routes are looking good. What about our specs?

```ruby
ActionController::RoutingError:
 uninitialized constant Admin
```

Remember when we want to use namespace, we'll need all the controllers that are namespaced within that namespace folder.

```
$ mkdir app/controllers/admin
```

Run our test, and we'll see that we're getting closer, but still not quite there.

```ruby
ActionController::RoutingError:
 uninitialized constant Admin::CategoriesController
```

The big piece of news in this error is that we don't have an `Admin::CategoriesController`. Let's go ahead and build that now.

```ruby
$ touch app/controllers/admin/categories_controller.rb
```

And run our test suite to see what error we're getting now:

```ruby
LoadError:
 Unable to autoload constant Admin::CategoriesController, expected /app/controllers/admin/categories_controller.rb to define it
```

Errors like this are great. They reiterate to me that I've created the file that I wanted to, Rails is looking in that file, and it's just not finding what it expects. Let's populate that file now and help it out.

```ruby
class Admin::CategoriesController < ApplicationController

end
```

And our new error:

```ruby
AbstractController::ActionNotFound:
 The action 'index' could not be found for Admin::CategoriesController
```

So, let's add an `index` method to our controller.

```ruby
class Admin::CategoriesController < ApplicationController

  def index
  end
end
```

Running the test gives us the `Missing template` error that we'd expect. Let's add that view.

```bash
$ mkdir app/views/admin
$ mkdir app/views/admin/categories
$ touch app/views/admin/categories/index.html.erb
```

If we look back at our test we can start to figure out what might be happening. We need to add some text to our new page in order to make it pass.

In `app/views/admin/categories/index.html.erb`:

```html
<h1>Admin Categories</h1>
```

Let's run our test... And it passes! Great! We're done here, right? I mean, passing test!

Question: have we done anything up to this point that's really new? Anything that would give us any confidence that we've actually authorized a user? We've gone through the trouble of creating a place to put some of our admin functionality, but I don't see anywhere that we're actually limiting access to that space. Let's create a test to make sure a default user can't get to all this sweet admin goodness. If we can make that pass I'll start to feel a little bit better about our authentication.

In our `admin_sees_categories_index_spec.rb` file let's add the following:

```ruby
context "as default user" do
  it 'does not allow default user to see admin categories index' do
    user = User.create(username: "fern@gully.com",
                       password: "password",
                       role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit admin_categories_path
    expect(page).to_not have_content("Admin Categories")
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
```

Run that, and sure enough we have a failing test. Our regular old users can get to everything that our admin can. Let's change that.

Inside of our `Admin::CategoriesController`, let's add a `before_action` to check to see if a user is an admin before they access any of the `Category` functionality.

```ruby
class Admin::CategoriesController < ApplicationController
  before_action :require_admin
  
  private
    def require_admin
      render file: "/public/404" unless current_admin?
    end
end
```

So, at a high level this makes sense: we've created a `before_action` to check to see if a user is a current admin, but if we run the test we now have two errors. (The second is the same as the first)

```
Failures:

  1) admin sees categories index as admin they are allowed to see all categories
     Failure/Error: render file: "/public/404" unless current_admin?

     NoMethodError:
       undefined method `current_admin?' for #<Admin::CategoriesController:0x007fabfb9dfc70>
       Did you mean?  current_user
```

We haven't defined `current_admin?`. Let's define that the same place that we define `current_user` in our `ApplicationController`.

```ruby
# application_controller.rb

def current_admin?
  current_user && current_user.admin?
end
```

What gives us access to `current_user.admin?`? Our enum!

Our test should be passing at this point. And we're happy. We have some confidence that our regular old user can't access the categories functionality that we've namespaced to `admin`. How can we make this better?

Let's refactor so that we're not limiting this functionality to just our `categories` controller. Then we should be able to stuff some more controllers into our namespace and give them the same level of protection.

Create a new `BaseController` in our admin folder.

```bash
$ touch app/controllers/admin/base_controller.rb
```

Inside of `base_controller.rb`, copy in the `before_action` that we had previously put directly on our `Admin::CategoriesController`.

```ruby
class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404" unless current_admin?
  end
end
```
Now, delete that from our `Admin::CategoriesController`, and instead have it inherit from our newly created `Admin::BaseController`. When you're finished, your categories controller should look like this:

```ruby
class Admin::CategoriesController < Admin::BaseController
  def index
  end
end
```

## WrapUp 

*   What's the difference between Authentication and Authorization?
*   Why are both necessary for securing our applications?
*   What's a `before_action` filter in Rails?
*   How can we scope a filter down to only work with specific actions?
*   What's an `enum` attribute in ActiveRecord? Why would we ever want to use this?
*   When thinking about Authorization, why might we want to namespace a resource?
*   What does `allow_any_instance_of` in RSpec do?

## Work Time

Add admin functionality to your Rails Mini-Project and be sure to authorize an admin correctly.
