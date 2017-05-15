---
layout: page
title: Forms in Rails
---

## Learning Goals

* Explain why we use/need forms
* Understand the role of `form_for`
* Construct a basic form with the help of documentation/references
* Practice building a small CRUD application with a form

### Setup

* Clone [BookShelf](https://github.com/turingschool-examples/book_shelf)
* Checkout the `pre-form-lesson` branch
* `bundle`, `rake db:setup`
* `rails server`
* **Get familiar with the app.** What functionality is there?

## Route Helpers

### Exercise: Clean Up Hardcoded Routes

In your `views/books/index.html.erb`, we have a few "hardcoded" routes. Can you use route helpers to clean these up?

### Exercise: `form_for`

* Check out `views/books/new.html.erb`.
* What is `form_for`?
* Why do we need a new `Book` object defined at our route?
* What happens when `@book` is set to something different?
* Can you change the `price` field in this form to `amount`? What happens? What error do you get?
* How does this form know where to submit to?

### `form_for` vs `form_tag`

Turn and talk with your neighbor to discuss the following.

*   What is `form_for`? How is this different from a `form_tag`?
*   When would we want to use one over the other?

### Code Along

Let's submit this form. Why do we need another route to handle the submission of this form? What is the naming convention for this route?

### Exercise: Create Categories

We also have categories. We have only have the functionality to view all categories currently. Add the functionality for a user to add a new category. Don't forget - you'll need two routes for this!
