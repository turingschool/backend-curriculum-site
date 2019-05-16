---
layout: page
title: Auth Exploration - Iteration 1
---

# Implement User Registration

The first feature that we're going to add to our application is user registration; when users visit our site, they should be able to create accounts.

Users will need to provide us with some information.  We'll keep things simple and only require some basics:

- full name
- email address
- password

When a user registers with our site, we'll need to persist the information that they provide to us in our database (i.e., save the new user in the database).  What data should we keep in our database?  How should we store it?  Remember, we're going to store our user's password in plaintext for now to practice the concepts before using an algorithm to hash the passwords later in the week. What constraints should we have in our database and validations in our models?  What would happen if two users registered with the same e-mail address?  Or, if a user did not supply an e-mail address?

*Note:*  When users later return to our site and attempt to login, they will submit an email address and password.

The following user story (and the test we build around it) will help guide us through this user registration:

```
As a Visitor
When I visit the user index
And click on 'Register as User'
I am taken to a new user form
When I fill out that form and click 'Create User'
I am redirected back to user index
And see the new user
```

Use TDD to complete this user story.

[Next to Iteration 2](./auth_exp_it2)
