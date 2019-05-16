---
layout: page
title: Auth Exploration - Iteration 0
---

# Setup

First, we'll need a new Rails application. Feel free to name it whatever you'd like, but be sure to create the new application with a postgresql database. Our app will have a `users` table, and each user must have a name, email and password (all strings)

Use TDD to implement the following user story

```
As a visitor
I visit the users index
Then I see a list of all users in the database
For each user, I see their name and email address.
```

[Next to Iteration 1](./auth_exp_it1)
