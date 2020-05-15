---
layout: page
title: Multitenancy Authorization
length: 180
tags: rails, controllers, models, routes, multitenancy, security
---

## Learning Goals

* Recognize the limitations of single role / column-based authorization strategies
* Discuss patterns for implementing more sophisticated authorization strategies
* Practice using ActiveRecord models to implement an authorization strategy from scratch

## Slides

Available [here](../slides/multitenancy_authorization)

## Warmup

* Describe the authorization strategy that you used in your Little Shop project?
* Was there anything that frustrated you about this strategy?
* What would you need to do if you added another level of access to that application?

## Limitations of Column-Based role modeling

There's a good chance your previous attempts used some sort of column on the users table
to track whether a given user was an "admin" and maybe also a "platform admin".

This strategy has few moving parts, making it simple. But what are the limitations?

What did you have to do when a new role was needed?

Alternatively, we could have had a second table -- "admins" -- and inserted
simple records for each user that we want to mark as an admin (with "id" and "user_id" as the only columns).

But we still run into the same fundamental problems -- adding more roles requires modifications
to our schema since we need to add more tables or columns to represent the new information.

## A more flexible approach to modeling application roles

This is actually a very common problem in larger applications. Just about any
sophisticated business will need to track various "roles" within their organization.
Additionally, you'll frequently need to create these on the fly, perhaps even
letting non-technical users do this through a web interface of some sort.

So let's talk about what it would look like. What are the concepts we're dealing with?

* "Roles" or "Permissions" - Some notion of multiple levels of access within the app
and the need to store these independently
* "Users" - Existing idea of user accounts. Remember that an account largely
handles the problem of authentication rather than authorization.
* "User-Roles" - Once we've come up with a separate way of modeling the roles
themselves, we need a way to flexibly associate multiple users to multiple roles.

Hopefully this shape is starting to make sense as a normal many-to-many relationship
using a join table to connect betwen the 2 record types. Modeling roles in this way
will allow us to re-use a handful of roles for a large number of user accounts.

## Implementing Role-based Authorization

Let's walk through the process of implementing role-based authorization.

Here's a short list of goals we'd like to enable

1. Add a separate Roles table to track the existing roles
1. Add a capability to grant a user a role (at least in `rails c`)
1. Add methods to users to let us inquire about their permissions
1. Make it so that guest users have to check in
1. Add a route to create items that can only be accessed by store admins
1. Add a route to edit and update items that can be accessed by either "admins" or "inventory managers"

__Setup__

For this workshop, let's use a branch of storedom that already has basic store-based
multitenancy set up:

```
git clone -b multitenancy_authorization https://github.com/turingschool-examples/storedom.git multitenancy_authorization
cd multitenancy_authorization
bundle
bundle exec rake db:drop db:setup
```

## Scoping Permissions by Store

### Discussion

So we've added a flexible permissions model and refactored it to better encapsulate
the logic within a dedicated object.

But something is still missing. We haven't yet tackled the problem of authorizing users
across multiple stores. That is, we need a way to ensure that a user who's
authorized as an admin for Store A can't manipulate the items of Store B.

Can we boil down the main component missing from our authorization system?

* How can we modify the relationship so that roles can be connected to users
as well as to specific stores?
* What changes in our authorization logic are needed to account for this new information?

### Workshop

With a partner, modify the existing authorization model to account
for store-based as well as user-based authorization:

1. Add a `store_id` column to the UserRoles table
1. Add a test to verify that a user authorized for one store can't
edit items of another store
1. Modify the `Permissions` object to account for this additional logic. You
may need to modify its existing APIs. Don't forget to add unit tests for this step.

*Specific Functionality*

1. The store admin will have access to the stores, sessions, items, and orders controllers.
1. However, he won’t have access to the users controller.
1. Can you create a helper that will hide that functionality from the navbar?

## Implementation Overview

### Initial Repository

git clone -b multitenancy_authorization https://github.com/turingschool-examples/storedom.git multitenancy_authorization

### Final Repository

git checkout —track https://github.com/turingschool-examples/storedom.git multitenancy_authorization_final

### Procedure

* `rails g model Role name:string`
* `rails g model UserRole user:references role:references`
* Add UserRole relationship in Role
* Add UserRole relationship in User
* rake db:migrate
* Create three roles
  1. platform_admin
  1. store_admin
  1. registered_user
* Add Permission methods in user model
  1. platform_admin?
  1. store_admin?
  1. registered_user?
* Create services folder
* Create Permission service
* initialize the object with a user
* implement #allow? method
* Only allow users to visit the stores controller
* Add additional permissions
* Add guest_user and add conditional
* Abstract permissions into private methods
* Add Permission methods in ApplicationController
  1. current_permission
  1. authorize!
  1. before_action :authorize!
  1. private method :authorize?
* Add helpers in ApplicationHelpers
  1. platform_admin?
  1. store_admin?
  1. registered_user?

#### Implementation

app/model/user.rb

```ruby
class User < ActiveRecord::Base
  has_secure_password

  has_many :user_roles
  has_many :roles, through: :user_roles

  belongs_to :store
  has_many :orders

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def store_admin?
    roles.exists?(name: "store_admin")
  end

  def registered_user?
    roles.exists?(name: “registered_user”)
  end
end
```

app/model/user_role.rb

```ruby
class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
```

app/model/role.rb

```ruby
class Role < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :user_roles
  has_many :users, through: :user_roles
end
```

app/services/permission.rb

```ruby
class Permission
  extend Forwardable

  attr_reader :user, :controller, :action

  def_delegators :user, :platform_admin?,
                        :store_admin?,
                        :registered_user?

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action

    case
    when platform_admin?
      platform_admin_permissions
    when store_admin?
      store_admin_permissions
    when registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private

  def platform_admin_permissions
    return true if controller == "sessions"
    return true if controller == "items"  && action.in?(%w(index show))
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "orders" && action.in?(%w(index show))
    return true if controller == "users"  && action.in?(%w(index show))
  end

  def store_admin_permissions
    return true if controller == "sessions"
    return true if controller == "items"  && action.in?(%w(index show))
    return true if controller == "stores" && action.in?(%w(index show))
    return true if controller == "orders" && action.in?(%w(index show))
  end

  def registered_user_permissions
    return true if controller == "sessions"
    return true if controller == "items"  && action.in?(%w(index show))
    return true if controller == "stores" && action.in?(%w(index show))
  end

  def guest_user_permissions
    return true if controller == "sessions"
    return true if controller == "items"  && action.in?(%w(index show))
    return true if controller == "stores" && action.in?(%w(index))
  end
end
```

app/controllers/application_controller.rb

```ruby
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_action :authorize!

  add_flash_types :success,
                  :info,
                  :warning,
                  :danger

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize!
    unless authorized?
      redirect_to root_url, danger: "You are not authorized to visit this page"

    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end
end
```

app/helpers/application_helper.rb

```ruby
module ApplicationHelper
  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def store_admin?
    current_user && current_user.store_admin?
  end

  def registered_user?
    current_user && current_user.registered_user?
  end
end
```

## Supporting Materials

* [Video 1502](https://vimeo.com/128915494)
* [Video 1505](https://vimeo.com/137451107)
* [Repo from 1503 Session](https://github.com/NYDrewReynolds/multitenancy_auth)
