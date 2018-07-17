# Programming with Values

---

# Warmup

* What does 'single responsibility' mean in a programming context?
* How does programming with an eye towards the single responsibility principle help us as programmers?
* In past projects, what have you decided to test? What have you decided not to test?
* Why?

---

# Coding for Yourself

* Create classes that you want to use.
* Create classes that you want to test.
* Create classes that allow you to reuse them.
* Create classes that allow you to use the tools you're most comfortable with.

---

# Creating Interfaces/Adaptors

* An interface is a way to interact with the outside world.
* If your program were a video game, the interface would be the controller.
* We need interfaces to interact with people.
* We want to design programs for people.
* We also want to make our program easy to work with.
* Creating isolated interfaces allow us to deal with the messiness of people and data without letting it infect our code.

---

# Values vs. Locations

* Using locations in your code is a sign that you could create an interface.
* Instead, use the things you like:
    * hashes
    * arrays
    * strings

---

# Exercise: Pizza Parlor

Link [here](https://github.com/turingschool-examples/pizza_parlor)

---

# Share

* What did you test?
* What didn't you test?
* Can you test more if you refactored your code?

---

# Review Potential Refactors

* Can we isolate the file I/O?
* Can we extract it to a class?
