# Forms in Rails

---

# Warmup

* Complete Setup from lesson plan

---

# Exercise

Visit `/books/new` and view the page source

* Why do we need a new instance of Book in our controller?
* What happens when we set @book to `Category.new`?
* What happens when we set @book to `Book.find(1)`?
* Change the price field in this form to amount. What error do you get?
* How does this form know where to submit?
* What is `form_for`?

---

# `form_for` and `form_tag`

Research `form_tag` with your neighbor.

* When would you use `form_for` vs `form_tag`?

---

# Code Along

Visit `/books/new` and try to submit the form.

* What error do you get?
* How can we fix this?

---

# Exercise

* Add the functionality to add a new category.
