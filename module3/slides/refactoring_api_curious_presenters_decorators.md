# Presenters & Decorators

---

# Warmup

* What new uses of Rails were you exposed to during API Curious?
  * What specifically was beyond the traditional scope of MVC?
* Did any of our controllers or models have more than one responsibility?
* How many instance variables were we using to send information to our views?

---

# Setup

See lesson plan

---

# Presenters

* Pattern for abstracting complexity in our view/presentation layer
* Presenters combine functionality across _multiple objects_ into a single interface
* No library needed -- just POROs!

---

# Review of Sandi's Rules

1. Your class can be no longer than 100 lines of code.
2. Your methods can be no longer than five lines of code.
3. You can pass no more than four parameters and you can't just make it one big hash.
4. When a call comes into your Rails controller, you can only instantiate one
   object to do whatever it is that needs to be done. And your view can only know about one instance variable.

---

# Workshop

* Implement a presenter on a branch
* *End Goal:* one instance variable in our controller method whose value points to an instance of `DashboardPresenter`.

---

# Decorators

* Pattern for applying object-oriented techniques to handling application presentation logic
* Will create an object that provides the desired behavior
* Most implementations of the Decorator pattern are built around "wrapping" and "delegation"
* Good demonstration of the [Open/Closed Principle](https://en.wikipedia.org/wiki/Open/closed_principle)
* Exploit Ruby's use of duck typing

---

# Tools: SimpleDelegator

* Wraps another object.
* Pass an existing object.
* Add methods to that object.
* Still have access to methods on the original object.

---

# Workshop

* Create a GitHubUser class that inherits from SimpleDelegator.
* Pass it `current_user` in our controller.
* Implement additional methods providing access to information from the API.

