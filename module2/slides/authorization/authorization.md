![](pass.gif)

# Authorization

---

# Warmup

* How did you handle the secret page in Thursday's assignment?
* Have you tried to implement any authorization in the mini-project? If so, how?
* Any thoughts on how we might use namespacing to help us organize our authorization strategy?

---

# Overview

* Using `allow_any_instance_of` to stub a method
* Using *enum* for some additional methods/readability
* Using a *namespace* to organize things
* Using *before_action* to check a user's status
* Using *inheritance* to help refactor

```

```ruby
# within tests
allow_any_instance_of(Object).to receive(:method).and_return("return value")
```

---

# Live Coding
## Stubbing a method

---

# Enum

* Defined in the model
* Takes a hash as an argument
* Translates integers to words when we call an attribute
* Give methods to set and query based on the words used

---

# Enum Example

```ruby
# in User model assuming `role` is an integer in our users table
enum role: [:default, :admin]

# elsewhere in the application...
user = User.find(1)
user.admin! # sets the user role to 1
user.admin? # returns true
user.role   # returns 'admin' even though the value is 1 in the db
```

---

# Live Coding
## Adding `role` as an Enum

---

# Namespacing

* Adds prefix to URL
* Requires prefix on controller
* Provides path helpers with the prefix

---

# Live Coding
## Namespaced Admin Categories Controller

---

# Before Actions

* Defined in our controllers
* Occur before other actions in the controller
* Can be limited to only certain actions

---

# Live Coding
## Before Actions

```ruby
def require_admin
  render file: '/public/404' unless current_admin?
end

def current_admin?
  current_user && current_user.admin?
end
```
---

# Live Coding
## Refactoring

`ApplicationController`
`Admin::BaseController`
