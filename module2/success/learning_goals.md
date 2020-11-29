---
layout: page
title: Module 2
subheading: Learning Goals
---

Academic success in Module 2 means that students demonstrate proficiency and comfort with the concepts below.

The expected mastery level can be understood with the following scale:

* **Mastery**: student is able to explain and implement the concept independently or with light reference
* **Functional**: student recognizes when to use the concept and can implement it with the support of documentation and/or a collaborator
* **Familiarity**: student can recognize and describe the concept when needed/appropriate, but is not able to implement the technology/technique

# Mastery

### Rails Application Development

* Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
* Implement CRUD functionality for nested resources
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Create routes for
    * standalone resources
    * nested resources
    * non-ReSTful actions
    * namespaced routes
* Interpret the output of `rails routes` to get information about existing routes    
* Use the Rails console to interact with a development database
* Describe use cases for a model that inherits from ApplicationRecord vs. a PORO
* Template a view in Rails using `erb`
* Use path helpers

### ActiveRecord

* Create class and instance methods on a Rails Model to perform ActiveRecord queries
* Create instance methods on a Rails model that use ActiveRecord associations
* Use built-in ActiveRecord methods to:
    * create queries that calculate, select, filter, and order data from a single table
    * create, read, update, and destroy records in a database
    * create records with relationships to other records in a database
    * join multiple tables of data
    * make calculations and build collections of data grouped by one or more attributes from multiple tables

### Databases

* Describe Database Relationships, including the following terms:
  * Primary Key
  * Foreign Key
  * One to Many
  * Many to Many
  * Join Table
* Write migrations to create tables and relationships between tables

### Testing & Debugging

* Write feature tests in RSpec that:
    * Use Capybara to mimic the behavior of users
    * Use CSS selectors to target specific elements of a page
    * Test for Sad Paths
* Write model tests in RSpec that:
    * Use Shouldamatchers to test relationships and validations
    * fully test custom-built model methods including edge cases
* Use Pry or Byebug in Rails files to get more information about an error
* Use `save_and_open_page` and Chrome Developer Tools to debug HTML

### Web Applications

* Describe and implement ReSTful routing
* Identify the different components of URLs (protocol, domain, path, query params)
* Deploy an application to Heroku

### Project Management

* Use GitHub Projects to create and track User Stories

# Functional

### Web Applications

* Describe the HTTP request/response cycle
* Describe the different parts of HTTP requests and responses
* Describe web APIs

### Rails Application Development

* Implement partials to break a view into reusable components
* Use flash messages
* Use Inheritance to share behavior across classes
* Use POROs to logically organize code for objects not stored in the database
* Use `Faraday` to consume an API

### Databases

* Write raw SQL queries
* Design and diagram a Database Schema
* Describe ORMs and their advantages and use cases
* Write migrations to alter existing database tables

### Testing & Debugging

* Use WebMock to mock API calls

### Styling

* Create basic Web Pages using the following HTML tags
    * `<h1>`, `<h2>`, etc.
    * `<p>`
    * `<body>`
    * `<a>` and the `href` attribute
    * `<img>` and the `src` attribute
    * `<div>`
    * `<section>`
    * `<ul>`, `<ol>`, and `<li>`
    * `<form>`
    * `<input>`
* Select and style HTML elements using their `class` or `id` attribute

# Familiar

### Web Applications

* Describe how DNS works

### Databases

* Describe database normalization

### Styling

* Describe modern CSS grid systems
