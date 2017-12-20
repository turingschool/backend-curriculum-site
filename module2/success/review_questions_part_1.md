---
layout: page
title: Review Questions Weeks 1-3
---

### MVC & Rails
* Diagram and explain the MVC model
* What is the role of the model?
* When would you want to use a class method rather than an instance method?
* What is the role of a view? What language(s) would you use in a view?
* What is the role of the controller?
* What are the 7 RESTful CRUD actions?
* Create a chart for Users with columns for path_helpers, HTTP Verb, URI, ActiveRecord, Redirect/Render, View

### HTTP
* What are the 5 HTTP Verbs?
* Diagram and explain the HTTP request/response cycle

### HTML/CSS
* What HTML tags would you use for the following?
  * section header
  * general content
  * bullet points
  * numbered list
  * image
  * link
  * form & its pieces  
* How do you target the following in CSS?
  * a class
  * an id
  * an element

### Testing
* How would you set up a test to check that a User has an email address and that only one user can have that email address?
* How would you set up a test to check that a specific User is listed on a page?

### Databases
* What is the SQL to pull the record for every User?
* What is the SQL to pull the record for how many Users are in the database?
* Diagram the tables of a database where a User has_many Assignments, an Assignment belongs_to a User, a Course has_many Assignments, and an Assignment belongs_to a Course.

### ActiveRecord
* When would I use a find, vs a find_by, vs a where
* What ActiveRecord methods would I use in each of the 7 CRUD actions?
* How do I make it so I can call user.assignments? What about assignment.users?
