# Ruby Object Model

---

# WarmUp

- What's the difference between a class and an instance from Ruby's perspective?
- How are modules used as "mix-ins"?
- How do you know what variables, methods and classes you have available at any given time?

---

# Investigative Methods

* `.ancestors`
* `.included_modules`
* `.superclass`

---

# Mapping Ruby's Object Model

---

# Definitions and Rules

* `Classes`: store instance methods, have a superclass pointer
* `Instances`: store instance variables, have a class pointer
* `Classes` are also instances (of Class)
* `Classes` can only inherit from one other class (its 'superclass')
* `Classes` can include multiple Modules.
* `Modules` can be mixed-in to multiple classes (mixins)

---

# Exercises

Use `.class`, `.ancestors`, `.included_modules`, and `.superclass` to diagram the lookup chain of the following Ruby classes:

* Hash
* Array
* String
* Integer
* Float

---

# Share

---

![Ruby Inheritance Diagram](https://docs.google.com/drawings/d/e/2PACX-1vSh1z2yb089aMCD1pp5idcFcfvZdQt5vJH3cOAas22hI5mrIO83WrrrXdGZy6sWZuu9UALMEJeXX_JX/pub?w=952&h=728)

---

# Scope with Variables & Methods

* See lesson plan for code

---

# Practice

When I call `Chair.new.chair_type` what will be my output?
How could I get it to print module?
How could I get `Chair.new.chair_type` to print `method`?
How could I get `Chair.new.chair_type` to print `superclass`?
How could I get `Chair.new.chair_type` to print `superclass's superclass`?

---

# Lookup Chain

* Start by looking for a local variable
* Check its class for a method
* Look to that class's included_modules
* Until it finds the method, go to the superclass
* Once you find it, create a scope for that object

---

# Bindings

* When a scope is created, it's called a `Binding`.
* [Binding](https://ruby-doc.org/core-2.4.1/Binding.html): a Ruby class that captures the context in which code is executed.
* The binding retains the context for future use, including
    * relevant variables
    * methods
    * the value of self
    * some other contextual details

---

# Explore

* See lesson plan.

---

# WrapUp
* How does Ruby's look up chain work? What is the order it checks things?
* What are three methods you can use to learn about where a built in Ruby method gets its components?
* Draw a diagram of where Ruby would look for the method `::new`
* What is a binding?
