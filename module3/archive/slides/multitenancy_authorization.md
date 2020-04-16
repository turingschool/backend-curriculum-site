# Multi-tenancy Authorization

---

# Warmup

* Describe the authorization strategy that you used in your Little Shop project?
* Was there anything that frustrated you about this strategy?
* What would you need to do if you added another level of access to that application?

---

# Alternative Strategy

* Allow users to have more than one role.
* Tie user abilities to controller actions.

---

# Setup

* Clone [Storedom](https://github.com/turingschool-examples/storedom)
* Check out `multitenancy_authorization`
* `bundle`
* `bundle exec rake db:drop db:setup`

---

# Multiple Roles

* Create a `roles` table that has a name for each role
* Create a `user_roles` table
* `rake db:migrate`
* Create a Role model
* Create a UserRole model
* Add relationships between Role, UserRole, and User

---

# Populate

```sh
$ rails c
> registered = Role.create(name: "registered_user")
> registered.users.create(name: "Name")
```

---

# Restrict Access to Controller Actions

*Overview*

* Add method to User model to check user permissions
* Create a Permission service that relates that user's permissions to controller actions
* Add methods to the ApplicationController to redirect if a user is not authorized

---

# User Model

```ruby
# app/models/user.rb

def registered_user?
  roles.exists?(name: "registered_user")
end
```

---

# Permission Service

```ruby
class Permission
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action

    case
    when user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  def guest_user_permissions
    return true if controller == "sessions"
  end
end
```

---

# ApplicationController

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize!
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize!
    unless authorized?
      redirect_to login_path, flash: {danger: "You are not authorized to visit that page."}
    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end
end
```

---

# Helpers

* If you want to use in your views:

```ruby
# app/helpers/ApplicationHelper.rb
module ApplicationHelper
  def registered_user?
    current_user && current_user.registered_user?
  end
end

```

---

# Registered User Permissions

```ruby
# app/services/permission.rb

  def guest_user_permissions
    return true if controller == "sessions"
    return true if controller == "stores" && action.in?(["index"])
    return true if controller == "items" && action.in?(["index", "show"])
  end

```

---

# Still Missing

* Nothing in our permissions tying a user to a store
* Nothing allowing a user to be an admin of multiple stores
* Want to make sure that a user authorized for Store A can't manipulate Store B

---

# New Item View

```html
<!-- app/views/items/new.html.erb -->
<h1>REGISTERED USERS ONLY</h1>
```

```ruby
# app/controllers/items_controller.rb
def new
  @item = Item.new
end
```

```ruby
# config/routes
resources :items, only: ["index", "show", "new"]
```
---

# Scoping Permissions by Store

Modify the existing authorization model to account for store-based as well as user-based authorization:

1. Create a role for `store_admin`
1. Add a `store_id` column to the UserRoles table
1. Add a test to verify that a user authorized for one store can't edit items of another store
1. Modify the `Permissions` object to account for this additional logic. You may need to modify its existing APIs. Don't forget to add unit tests for this step.

---

# Review Final Implementation

* Check out the `multitenancy_authorization_final` branch
* Review final implementation

