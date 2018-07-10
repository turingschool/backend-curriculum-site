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

* Figure out what you want
* Only write the code you need
* Break down problems

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

# How to Write Tests

* Test **methods**
    * Even integration tests test methods
    * Does this method do what I expect when I call it?
* Require us to make decisions
    * How to name methods/classes
    * What input methods will take
    * What methods will return
    * Sometimes what side effects methods will have

---

# Instance Methods

* Most of the methods you've seen up to this point
* Call methods on an instance of a class
* Take input in the form of arguments
* Provide output in the form of return values

```ruby
cw = CaseWorker.new
cw.cases
# => []
```

---

# Steps to Test an Instance Method

* Decide what the input will be
* Decide what the output will be
* Create an instance
* Call the instance method on that instance
* With the given input
* Save the result to a variable
* Assert that result is equal to the expected output

---

# Template

```ruby
def test_it_can_do_something
  instance = SomeClass.new

  expected = expected_output
  actual   = instance.method_name(input)

  assert_equal expected, actual
end
```

---

# Example

```ruby
def test_it_can_double_numbers
  doubler = Doubler.new

  expected = 4
  actual   = dobuler.double(2)

  assert_equal expected, actual
end
```

---

# Interaction Patterns: Paired

```
car = Car.new("Toyota", "Camry")
car.horn
#=> "BEEEEEEEEP"
car.drive(12)
#=> "I'm driving 12 miles"
car.drive(6)
#=> "I'm driving 6 miles"
car.odometer
#=> 18
```

---

# Interactions in Pry

* Can use our interaction patterns in `pry`

---

# Testing Without Interaction Patterns

* Sometimes we don't have an interaction pattern
* On us to determine things like method names

---

# Descriptions: With a Partner

* When you start a car it returns a string that says "Starting up!"
* If you try to start the car when it's already running it returns the string "BZZZT!"
* If you stop a car that's running it returns the string "Stopping."

---

# Integration vs. Unit Tests

* Tests up to this point would likely be integration tests
* How do we test at the unit level?
    * Write a high level test
    * Recognize it as the ultimate goal
    * Begin to implement (is everything connected?)
    * Get to `expected: x, got: nil`
    * Skip it
    * Pseudocode solution
    * Write new test for first step of solution

---

# Unit Tests

* Still tests methods
* Use same pattern
    * Input
    * Expected output
    * Create instance
    * Actual output
    * Assertion

---

# Share

