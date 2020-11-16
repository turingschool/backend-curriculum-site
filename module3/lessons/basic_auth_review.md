---
layout: page
title: "Review: Authentication and Authorization in Rails"
tags: review, rails, authentication, authorization
---

## Learning Goals

* review the use of Authentication using BCrypt
* review the use of 'roles' for permissions using enums
* review the use of sessions in Rails
* introducing cookies


## Authentication vs Authorization

- Authentication: who are you?
- Authorization: what are you allowed to do?


## Authentication patterns

Generally we want to avoid storing passwords for users, but if we must, we
should use a tool like [BCrypt](https://github.com/codahale/bcrypt-ruby) to do a one-way encryption on the user's password
so that it cannot be reversed back into "plaintext" format.

If a user attempts to view a page and they have not authenticated, we will
typically return a 401 status code.


### Implementing a Login Page

In Rails 5.x, we will typically build a login page using `form_tag`, which is
being replaced with `form_with`:

```ruby
<%= form_with url: sessions_path, local: true do |form| %>
  <%= form.label :username %>
  <%= form.text_field :username %>

  <%= form.label :password %>
  <%= form.password_field :password %>

  <%= form.submit 'Log in' %>
<% end %>
```

(The `local: true` flag will stop our form from using JavaScript to send our
form as an AJAX call to our endpoint.)

We will continue to use "strong parameters" to ensure we only permit certain
attributes to be sent with our form data.

### SessionsController

Our sessions controller be responsible for looking up our user to determine
that they were previously registered. If that succeeds, we will will store a
hash of data into a cookie, which is also encrypted so it cannot be tampered
with. We should never expect that this encryption is fool-proof, and we should
not store anything sensitive about the user in the session other than their
user_id and other attributes which do not have any opportunity to compromise
our system.


## Authorization patterns

Most modern web applications have different kinds of users. These users will
generally be allowed to do different things. In Mod2, we introduced the use of
an "enum" type in ActiveRecord to store a simple integer representing our user's
"role" in a system. These roles might have included setting a 0 for "anonymous"
user browsing our site, "1" for "regular user" who has registered, "2" for a
"merchant" and maybe "3" for an "admin" user of some sort.

In more complex systems, permissions are handled on a more granular basis.
Perhaps a registered user has permission to do a few things on the site, but
maybe a user who pays a membership fee is allowed to do additional things.
Maybe a merchant user could be split into several roles: maybe one kind of
merchant user who can add/edit items for sale, but not allowed to access
invoice data. Another merchant could be in charge of our finances and needs to
see customer invoices, but shouldn't have access to add additional items for
sale, etc..

In this case, a simple "enum" isn't enough, and we would need a more complex
"permissions" system put in place.

### User Model

We would generally store this 'role' as an attribute on our User model, and
use this with our SessionsController to determine what the user is allowed to
do on our site.

The most basic form of authorization is a simple "enum" data type, which is
stored as an integer in the database, but can be mapped to a string within our
application. The benefit of using the enum type is that Rails generates some
methods for us about the User model.

For example, if we define our enum like this:

```ruby
# app/models/user.rb

enum role: %w(default admin)
```

... then Rails will make additional methods for us like this:

```ruby
user = User.find_by_username('marty')
if user.authenticate('mcfly')
  session[:user_id] = user.id
  redirect_to admin_dashboard if user.admin?  # <-- check this out!!
  redirect_to user_dashboard if user.default?
else
  flash[:error] = "Your credentials are bad, and you should feel bad."
end
```

## ApplicationController and helper methods

In our ApplicationController, where our other Controllers will inherit
properties and methods, we can make a helper method to use elsewhere in our
controllers and views (but not within models) to check whether we have a user
who has logged in or not, and from that, determine their role.

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
```

Now, within any controller or view we can call `current_user`, and from there
determine whether the user has permission to do other things.

## Mmm, cookies ...

Hold up there, my snack-minded friend. Let's talk a little more about cookies.
This is NEW CONTENT.

As discussed above, our session data is stored in a cookie, which is a small
file stored via the client's browser, sent back and forth in our HTTP headers.

Cookies are generally limited to about 4kb of total content, and we can make our
own cookies.

Important to note: We must send a response to the user in order to set or update
a cookie. These cookies are generally deleted from your browser whenever you
fully close your browser.

In our controllers, we can utilize code like this:

```
cookies[:css_mode] = {
  'dark mode': true,
  expires: 30.days
}
```

This is a "plain" cookie, but we've set the value to expire after 30 days. A
user can go into their browser and see these cookie values in "plaintext", and
could potentially change them as well.

We can make "signed" cookies, which prevents users from tampering with the value
but still makes them viewable:

```ruby
cookies.signed[:read_only] = {
  settings: {
    'discount': '10%'
  },
  expires: 7.days
}
```

We can also encrypt cookies so the user can't even read them:

```ruby
cookies.encrypted[:super_secret] = {
  settings: {
    'last_coupon_code': 'abc123'
  },
  expires: 7.days
}
```

You can read more about cookies in [the Rails documentation](https://api.rubyonrails.org/v5.2.4.3/classes/ActionDispatch/Cookies.html)
