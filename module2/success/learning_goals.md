---
layout: page
title: Module 2
subheading: Learning Goals
---

## Skills and Topics

### Skill Proficiencies

In addition to our [guidlines and expectations](./guidelines_and_expectations), academic success in Module 2 means that students demonstrate proficiency and comfort with the concepts below.

The expected mastery level can be understood with the following scale:

* **Mastery**: student is able to explain and implement the concept independently or with light reference
* **Functional**: student recognizes when to use the concept and can implement it with the support of documentation and/or a collaborator
* **Familiarity**: student can recognize and describe the concept when needed/appropriate, but is not able to implement the technology/technique

# Mastery

## Web Applications

* Describe the HTTP request/response cycle
* Describe the different parts of HTTP requests and responses
* Describe and implement ReSTful routing
* Identify the different components of URLs(protocol, domain, path, query params)

## Rails Application Development

* Implement CRUD functionality for a resource using forms (form_tag or form_for), buttons, and links
* Describe the MVC design pattern
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Create routes for
  * standalone resources
  * nested resources
  * namespaced routes
* Describe use cases for a model that inherits from ApplicationRecord vs. a PORO
* Template a view in Rails using a templating language (eg, `erb`)
* Use path helpers

## ActiveRecord

* Create instance methods on a Rails model that use ActiveRecord associations
* Use built-in ActiveRecord methods to create queries that calculate, select, filter, and order data from a single table
* Use built-in ActiveRecord methods to create, update, and delete records in a database
* Use built-in ActiveRecord methods to create records with relationships to other records in a database

## Databases

* Describe Database Relationships, including the following terms:
  * Primary Key
  * Foreign Key
  * One to Many
  * Many to Many
  * Join Table
* Write migrations to create tables and relationships between tables

## Testing & Debugging

* Write feature tests utilizing:
  * RSpec and Capybara
  * CSS selectors to target specific areas of a page
  * Sad Path Testing
* Write model tests with RSpec including validations, and class and instance methods
* Use Pry or Byebug in Rails files to get more information about an error
* Use `save_and_open_page` to view the HTML generated when visiting a path in a feature test
* Utilize the Rails console as a tool to get more information about the current state of a development database
* Use `rails routes` to get additional information about the routes that exists in a Rails application

# Functional

## Web Applications

* Explain how Cookies/Sessions are used to create and maintain application state

## Rails Application Development

* Implement partials to break a page into reusable components
* Make use of flash messages
* Implement CRUD functionality for nested resources
* Use Sessions to store information about a user and implement login/logout functionality
* Use filters (e.g. `before_action`) in a Rails controller
* Use Inheritance from ApplicationController or a student created controller to store methods that will be used in multiple controllers
* Limit functionality to authorized users
* Use BCrypt to hash user passwords before storing in the database
* Use POROs to logically organize code for objects not stored in the database

## Databases

* Write queries to join multiple tables of data, calculate statistics and build collections of data grouped by one or more attributes
* Design and diagram a Database Schema
* Describe ORMs and their advantages and use cases
* Write migrations to alter existing database tables

## Styling

* Create basic Web Pages using the following tags
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
* Select HTML elements using classes and ids

# Familiar

## Web Applications

* Describe how DNS works

## Databases

* Describe database normalization

## Styling

* Basic use and understanding of modern CSS grid systems
