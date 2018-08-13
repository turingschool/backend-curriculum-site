# Callbacks

---

# Learning Goals

* Understand how callbacks work
* Know some common callbacks
* Use callbacks to your advantage

---

# Warmup

Using the internet:

* In your own words, what is a Rails callback?
* Why do people seem to hate them so much?
* Why might we teach you about them even though people seem to hate them?

---

# Callbacks

Methods that get called at certain moments of an object's life cycle. With callbacks it is possible to write code that will run whenever an Active Record object is created, saved, updated, deleted, validated, or loaded from the database.

---

# Examples: Creating an Object

  * `before_validation`
  * `after_validation`
  * `before_save`
  * `around_save`
  * `before_create`
  * `after_create`
  * `after_save`
  * `after_commit`/`after_rollback`

---

# Examples: Updating an Object

  * `before_validation`
  * `after_validation`
  * `before_save`
  * `around_save`
  * `before_update`
  * `after_update`
  * `after_save`
  * `after_commit`/`after_rollback`

**Note:** Some of these are called both when an object is created and when it is updated since in both cases the object is saved.

---

# Examples: Destroying an Object

  * `before_destroy`
  * `after_destroy`
  * `after_commit`/`after_rollback`

---

# When to Use a Callback

- Almost never.
- After callbacks can get messy.
- A PORO is a better option, most of the time.

---

# Callbacks Can Present Issues

---

# Callbacks in Models. A use case.

- We want to access our songs by title in the url. for example `/songs/my-hear-will-go-on`. Right now, we have access to our song show page by `/songs/:id`. How do we create this new url?
- What changes will we need to make to make this work?
- How might a callback help us in this case?

---

# Overview

* Write a test.
* Add a column.
* Use a callback to populate that column.
* Adjust our controller.

---

# Try It!

See lesson plan.

---

# WrapUp

* What is a callback? Name 5 of them.
* When should you use a callback?
