---
layout: page
title: Authentication and Authorization Exploration
subheading: Guided Tutorial
---

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

## Iterations

[Iteration 0: Setup](./auth_exp_it0)
[Iteration 1: User Registration](./auth_exp_it1)
[Iteration 2: User Login](./auth_exp_it2)
[Iteration 3: User Logout](./auth_exp_it3)
[Iteration 4: Authorization](./auth_exp_it4)


## Conclusion

Think about the apps we use everyday:  Twitter, Instagram, GitHub, etc.  User registration, authentication, and authorization are key aspects in these applications.  These are skills that we must have.  We've gotten an introduction to these concepts in this challenge.  Moving forward, we'll receive more practice with them as we'll continue building user authentication into our applications.


# Questions for Hand-in:

Use the Google Form provided by your instructors for the following questions:

1. Please submit your repo for the work above.
1. What are the primary use cases for authentication and authorization within an application?
1. What are some ways you could implement different authorization patterns if you wanted some users to have read/write access to different resources? (ie, you can see an index or show page but not allowed to create/edit/delete)
