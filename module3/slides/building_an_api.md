# Building an API
---

# Warmup

Take 5 minutes to use the internet to answer the following questions.

* What is an API in the context of web development?
* Why would we want to expose information in a database we control through an API?

---

# Overview

* API Basics
* Review of New Tools
* Tutorial
* Share

---

# API Basics

---

# What is an API

* A way for applications to communicate with each other
* Code that governs the access points to the server
* Writing and Retrieving data are handled through HTTP requests to a server and don't require a frontend.

---

# Why create an API

* Single Page Applications - avoid full-page refresh
* Allow other developers to use our service
* Break our application into smaller applications

---

# JSON

Review the examples linked in the lesson with a partner.

* Share your observations

---

# Big Idea

* JSON is a machine/human readable way to transmit data.
* String representation of data.
* Most languages have libraries to create/parse JSON (basically langauge neutral).
* Rarely work with JSON directly. Instead, use familiar datatypes (hashes) and then encode as JSON.

---

# New Tools

---

# Creating and Parsing

* `JSON.generate(some_ruby_hash)`
* `JSON.parse(some_json_string)`

---

# Creating a new application

* `rails new my_api --api`


* Configures your application to start with a more limited set of middleware than normal.
* ApplicationController inherit from ActionController::API instead of ActionController::Base.
* Configure the generators to skip generating views, helpers and assets.

---

Take 5 minutes to use the internet to answer the following questions. Then discuss with the person next to you.

* What areas of our codebase do we need to test in an API?
* How will our tests be different from feature tests we have implemented in the past?

---

# Versioning APIs

* APIs will need to be updated and improved over time
* We version APIs by namespacing the API endpoints (routes)
* For consumers the api endpoint has minimal changes and they have time to change their code to handle the new response.

* `get 'api/v1/items', to: 'items#index'`
* `get 'api/v2/items', to: 'items#index'`

---

# Testing

* `get 'api/v1/items'`
* `response`
* `JSON.parse(response)`

---

# Controller

* `render`
* `json: Item.all`

---

# Try It!

---

# Questions?

---

# Checks for Understanding

* What are some reasons you'd want to create an API?
* At its core, what is JSON?
* What are the main differences between creating a traditional Rails application and creating an API?
