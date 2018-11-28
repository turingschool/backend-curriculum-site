# Testing Strategies Revisited

---

# Warmup

* Why do we write tests?
* What are the benefits of having a test suite?
* How do you decide what to test?
* What is your process for writing test?
* What has been the most difficult part of testing so far?

---

# Why Write Tests?

* Refactor with confidence
* Add new features with confidence

---

# Why Write Tests First?

* Integrate writing tests into our process
* Figure out what you want
* Break down problems
* Only write the code you need

---

# Types of Tests: Integration

* Check to see how methods work together.

---

# Types of Tests: Unit

* Check to see that methods work in isolation.

---

# Hierarchy of Tests

![TestPyramid](https://goo.gl/NYQcSd)

---

# Sad-Path Testing

* Allows us to test what happens when someone gives us a value we don't want
    * Does our application error out?
    * Does it handle the unexpected values nicely?
    * How do we want it to behave?

---

# Interaction Patterns: Watch Me Write a Test

```
> car = Car.new("Toyota", "Camry")
=> #<Node:0x007fa2e9acd738>
car.make
=> "Toyota"
car.model
=> "Camry"
car.color
=> "white"
```

---

# Interaction Patterns: With a Partner

```
car = Car.new("Toyota", "Camry")
car.color
#=> "white"
car.paint("blue")
car.color
#=> "blue"
car.odometer
#=> 0
car.odometer.class
#=> Integer
```

---

# Interactions in Pry

* Can use our interaction patterns in `pry`
* *Try it!*
* Require the class that you built in `pry` and then see if you can run the methods you created based on what you saw in the interaction pattern

---

# Testing Without Interaction Patterns

* Sometimes we don't have an interaction pattern
* On us to determine things like method names

---

# Descriptions: With a Partner

Create a `Mechanic` class. The primary responsibility of a mechanic is to takea  list of cars and determine which of those cars is due for an oil change (greater than 3,000 miles).

* Write a series of tests and create a Mechanic class.

---

# Wrap Up

* How does letting tests drive your development lead you to stronger code?
* What tradeoffs do you face when working with unit vs integration tests?
