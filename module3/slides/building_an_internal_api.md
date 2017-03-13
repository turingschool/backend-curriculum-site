# Building an API

---

# Warmup

* What is an API in the context of web development?
* Why might we decide to expose information in a database we control through an API?
* Why might we create an API *not* to be consumed by others?
* What do we need to test in an API?
* How will our tests be different from feature tests we have implemented in the past?

---

# Overview

* Review of New Tools
* Creating Our First Test and Factory
* Api::V1::ItemsController#index
* Api::V1::ItemsController#show
* Api::V1::ItemsController#create
* Api::V1::ItemsController#update
* Api::V1::ItemsController#destroy

---

# New Tools

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

# Code Along
