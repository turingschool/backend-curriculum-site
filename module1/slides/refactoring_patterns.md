# Refactoring Patterns

---

# Warmup

* Why do we refactor?
* What’s the difference between “refactoring” and “changing shit”?
* Does refactoring always make code better?

---

# Red, Green, Refactor

---

# Changing Internals of Code

---

# Technical Debt

---

# Software/Design Patterns

* Common solutions to common problems
* Gang of Four - Design Patterns
* Russ Olsen - Design Patterns in Ruby

---

# Refactoring Patterns

* Common *transformations*, not *improvements*
* Refactoring: Ruby Edition
* Related Concept: Code Smells
    * [Sandi Metz at RailsConf KC](https://www.youtube.com/watch?v=PJjHfa5yxlU) (you should watch this)
    * Not: I don't like your code and I can't tell you why

---

# 3 Common Refactoring Patterns

* Move Method
* Extract Class
* Hide Delegate

---

# Move Method

* Start: Method that seems to know a lot about a related class
* Refactor: Move it to that class

---

# Extract Class

* Start: Subset of related functionality in a given class
* Refactor: Make it into its own class

---

# Hide Delegate

* Start: Class calling to another class through another class
* Refactor: Implement methods on the intermediary that can respond to those requests

---

# Station Work

* 10 Minutes: Independent
* 5 Minutes: Review code together

---

# Summary

Explain to a person near you

* Move Method
* Extract Class
* Hide Delegate

---

# Enigma Refactoring Exercises

* Pair
* Refactor sample Enigma project
