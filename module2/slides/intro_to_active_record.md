# Intro to ActiveRecord

---

# Warmup

* What do you know about ActiveRecord?
* Name two ActiveRecord methods you explored yesterday.

---

# Relational Databases

* Store data
* In tables
* Provide relationships between tables (more tomorrow)

---

# Object Relational Mappers

![inline](http://wiki.expertiza.ncsu.edu/images/2/2c/ORM_Flowchart.jpg)

---

# Tables & Classes

* the table represents the collection of instances
* a row represents one specific instance
* the columns represent the attributes of an instance

---

# Tutorial

See lesson plan

---

# Check for Understanding

* What does a migration do?
* What's the syntax to create a migration from the command line using ActiveRecord?
* How do our models relate to our database?
* What do our models inherit from when we're using ActiveRecord?
* What are some methods that we have available to us when we inherit from ActiveRecord?

---

# Food for thought

* What happens if you try to create an object when you have a model but not a table?
* What happens if you try to create an object when you have a table but not a model?
* What does `has_many` allow? What does `belongs_to` allow? Are both necessary?
