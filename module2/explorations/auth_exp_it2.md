---
layout: page
title: Auth Exploration - Iteration 2
---

# Implement User Login
When users register for our site, we'll want them to be able to later return to our site and login using the details that they provided when registering—specifically, the e-mail address and password.  How will our application determine whether or not the user supplied a correct e-mail and password combination?

```ruby
class User < ApplicationRecord
  # e.g., User.authenticate('penelope@turing.com', 'boom')
  def self.authenticate(email, password)
    # if email and password correspond to a valid user, return that user
    # otherwise, return nil
  end
end
```
*Figure 1*.  Shell code for an authenticate method.

We'll add an `.authenticate` method to our `User` model to make this determination.  Figure 1 provides some shell code and pseudocode for our method.

Now, let's actually implement logging in by allowing users to submit their login credentials as a post request to a `/login` URL.  If the user sends a valid email and password combination, we'll log the user in.  We'll "remember" that the user is logged in by storing data in the `session` hash. Use the following user story to help guide this implementation:

```
As a visitor
I visit the users index
and click on 'Log In'
Then my current path is '/login'
```

```
As a visitor
I visit '/login'
When I fill in a form with an existing user's email and password
And click 'Log Me In!'
I am redirected to the users index
And I see a message saying 'Welcome <user name>, you are logged in!'
And I do not see a link to 'Log In'
```

If the `session` hash and/or how to use it is unclear, remember that you have access to the session information in the view, if you need it (hint hint). If it is still unclear after reading the documentation, ask for help from a cohortmate or staff member.

Also, the form that you will use to 'log in' will not deal with creating or editing resources in our database as we have done previously with `form_with`, so you will need a new tool - `form_tag`.  Explore how to use `form_tag` on the [rails guides](https://guides.rubyonrails.org/form_helpers.html#dealing-with-basic-forms).

*Note*: there's not many agreed upon RESTful routing conventions for logging in/logging out. I suggest having a `UsersController` that handles registering a new user (so `new` and `create` actions) and a `SessionsController` to handle logging in and logging out.

[Next to Iteration 3](./auth_exp_it3)
