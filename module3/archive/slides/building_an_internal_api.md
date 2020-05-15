# Building an API

---

# Warmup

Use the internet to answer the following questions.

* What is an API in the context of web development?
* Why might we decide to expose information in a database we control through an API?
* What do we need to test in an API?
* How will our tests be different from feature tests we have implemented in the past?

---

# Overview

* API Basics
* Review of New Tools
* Tutorial
* Share

---

# API Basics

---

# Why create an API

* Avoid full-page refresh
* Allow other developers to use our service
* Break our application into smaller applications

---

# JSON

Review the examples linked in the lesson with a partner.

---

# Big Idea

* JSON is a machine/human readable way to transmit data.
* String representation of data.
* Most languages have libraries to create/parse JSON (basically langauge neutral).
* Rarely work with JSON directly. Instead, use familiar datatypes and then encode as JSON.

---

# New Tools

---

# Creating and Parsing

* `JSON.generate(some_ruby_hash)`
* `JSON.parse(some_json_string)`

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

