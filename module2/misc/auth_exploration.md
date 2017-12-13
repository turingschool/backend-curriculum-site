---
title: Auth Exploration
subheading: Guided Tutorial
---

# User Registration and Authentication

## Summary
We're going to build a tiny application that explores user registration, authentication, and authorization.  To begin, our application will be limited to allowing users to register for our site and afterward login and logout.  Once our application has this functionality, we'll look at authorization - allowing logged in users access to content that guests cannot access.


### Working with Sessions
In the vanilla world of HTTP, our web applications don't recognize when two requests come from the same browser; they treat each request the same way.  In this exercise, we'll learn to use sessions in Rails, which store
data using HTTP cookies.  We use cookies to retain state across web requests—in this challenge, we'll use them so that our application recognizes that a user is logged in.


### Protecting User Data
When users sign up to use our application, they will be trusting us with their data:  names, e-mail addresses, passwords.  We want to do everything we can to protect our users in case our database is compromised.  We should never store a user's plain-text password in our database, but for this exercise, we are going to stick with plain-text passwords for now. We'll have a class later this week that explores hashing passwords using [bcrypt](https://en.wikipedia.org/wiki/Bcrypt).


### Application Description
Our application will have only one model: `User`.  We'll work with our user model to build an application that supports a few core actions:

- User registration (i.e., creating an account)
- Login
- Logout

Once this functionality is built, we'll begin to restrict access to our application to logged in users.  In other words, when a user attempts to see a page in our application, they will be redirected to the login page, unless they have already been logged in.

As we build our application, we'll need to make decisions about the routes that we need and the types of requests the browser should make (e.g., get, post, etc.).

### Iteration 0: Setup

First, we'll need a new Rails application. Feel free to name it whatever you'd like, but be sure to create the new application with a postgres database. Create your `users` table and corresponding model. A `User` will have a name, email, and password (all strings).

### Iteration 1:  Implement User Registration
The first feature that we're going to add to our application is user registration; when users visit our site, they should be able to create accounts.

Users will need to provide us with some information.  We'll keep things simple and only require some basics:

- full name
- email address
- password

When a user registers with our site, we'll need to persist the information that they provide to us in our database (i.e., save the new user in the database).  What data should we keep in our database?  How should we store it?  Remember, we're going to store our user's password in plaintext for now to practice the concepts before using an algorithm to hash the passwords later in the week. What constraints should we have in our database and validations in our models?  What would happen if two users registered with the same e-mail address?  Or, if a user did not supply an e-mail address?

*Note:*  When users later return to our site and attempt to login, they will submit an email address and password.


### Iteration 2:  Implement User Login
When users register for our site, we'll want them to be able to later return to our site and login using the details that they provided when registering—specifically, the e-mail address and password.  How will our application determine whether or not the user supplied a correct e-mail and password combination?

```ruby
class User < ActiveRecord::Base
  # e.g., User.authenticate('penelope@turing.com', 'boom')
  def self.authenticate(email, password)
    # if email and password correspond to a valid user, return that user
    # otherwise, return nil
  end
end
```
*Figure 1*.  Shell code for an authenticate method.

We'll add an `.authenticate` method to our `User` model to make this determination.  Figure 1 provides some shell code and pseudocode for our method.

Now, let's actually implement logging in by allowing users to submit their login credentials as a post request to a `/login` URL.  If the user sends a valid email and password combination, we'll log the user in.  We'll "remember" that the user is logged in by storing data in the `session` hash.

If the `session` hash and/or how to use it is unclear, revisit this [reading](http://www.theodinproject.com/courses/ruby-on-rails/lessons/sessions-cookies-and-authentication).  If it is still unclear after reading the documentation, ask for help from a cohortmate or staff member.

*Note*: there's not many agreed upon RESTful routing conventions for logging in/logging out. I suggest having a `UsersController` that handles registering a new user (so `new` and `create` actions) and a `SessionsController` to handle logging in and logging out.


### Release 3:  Implement Logging Out
If users can login, we'll also want to allow them to logout.  Implement a controller method that will log a user out when they visit it.  This will most likely involve deleting some content from the `session` hash.


### Release 4:  Implement Authorization
To this point, we've been dealing with *authentication*:  answering the question, "Who are you?"  Now we're going to handle *authorization*:  answering the question, "What do you have permission to do?"

In applications there are different use cases for authorization.  For example, an application might have a group of administrators with special privileges.  Perhaps they can edit content, delete posts, etc., while other users cannot.  In our application, we'll authorize all logged in users to view the content of our site.  If users have not logged in, they will not be authorized to view the content.

What is our content?  We're practicing authorization, so let's just create a "secret" page.  Users should be authorized to see the secret page only if they're logged in.  If users try to access the secret page when they're not logged in, they should be redirected to the login page.

One way to restrict access to authorized users is a [filter](http://guides.rubyonrails.org/action_controller_overview.html#filters).  This not the only way to accomplish this and not necessarily the best way in this case.  But it's one tool to implement this kind of pre-route logic.  For an application this simple, it's ok to put the authorization logic in the route handler itself.


## Conclusion
Think about the apps we use everyday:  Twitter, Instagram, GitHub, etc.  User registration, authentication, and authorization are key aspects in these applications.  These are skills that we must have.  We've gotten an introduction to these concepts in this challenge.  Moving forward, we'll receive more practice with them as we'll continue building user authentication into our applications.

## Extensions


Remember how we talked about not ever storing passwords in plain text? How do we securely store users' passwords while allowing users to sign in with their plain-text passwords?  One option is to use a [hashing algorithm](https://en.wikipedia.org/wiki/Cryptographic_hash_function) and store the hashed versions of users' passwords in our database.  One such hashing algorithm is [bcrypt](https://en.wikipedia.org/wiki/Bcrypt), for which there is a [Ruby gem](https://github.com/codahale/bcrypt-ruby). Implement hashing your passwords!
