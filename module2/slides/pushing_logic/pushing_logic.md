# Pushing Logic Down the Stack

---

# Warmup

* What does 'pushing logic down the stack' mean to you?
* How do you decide where to build functionality?
* What makes you uneasy in a view/controller/model?
* What do you do to refactor?
* Are there patterns/tools that you use regularly?

---

# Why bother?

* Unit tests are easier to write than controller tests.
* Controllers are easier to read when skinny.
* Avoids code duplication across controllers.
* Keeps controllers from becoming too closely coupled with models.

---

# Tools

---

# Tools: Active Record

* Know your methods, and return values.
    * `.new`     => Object.
    * `#save`    => Object if successful, `false` if not.
    * `.create`  => Object, whether successful or not.
    * `#destroy` => Object if successful, `false` if not.

---

# Tools: Active Record

* Know your class vs instance methods and arguments.
    * `#update` on an instance will take a hash of attributes.
    * `.update` on a class will take an ID __and__ a hash of attributes.

---

# Tools: Other Strategies

* Class and instance methods on models.
* Plain Old Ruby Objects (POROs).
* Callbacks (`before_save`, `before_create`, `before_validation`, etc.).

---

# The 'Rules'

---

# The Controller

* View template rendering
* Flash messages
* Sessions
* Redirecting

Example: `UsersController#create`

---

# Models

* Queries
* Validations
* Associations
* Attributes
* Object behavior
* Scopes

Example: `Dashboard`

---

# Views

* Using data provided to generate HTML

---

# Summary

