# Testing Strategies Revisited

---

# Warmup

* What are the benefits of having a test suite?
* How do you feel about test-driven development? Has it worked for you?
* What is the purpose of an individual test?
* What has been the most difficult part of testing so far?

---

# Individual Tests

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
  input           = value1
  expected_output = value2
  some_instance   = SomeClass.new

  actual_output   = some_instance.some_method(input)

  assert_equal expected_output, actual_output
end
```

---

# Example

```ruby
def test_it_can_double_numbers
  input           = 2
  expected_output = 4
  doubler         = Doubler.new

  actual_output   = doubler.double(input)

  assert_equal expected_output, actual_output
end
```

---

# Interaction Patterns: Watch Me Write a Test

```
> game = Scrabble.new
=> ...
> game.score("hello")
=> 8
```

---

# Interaction Patterns: With a Partner

```
> game = Scrabble.new
=> ...
> game.score("")
=> 0
```

---

# Interaction Patterns: Independent

```
> game = Scrabble.new
=> ...
> game.score(nil)
=> 0
```

---

# Descriptions: Independent

* Scoring a word is insensitive to case

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

# Pseudocode: With a Partner

* Using existing test, implement functionality until it's time to write a unit test
* Write a unit test

```
> game = Scrabble.new
=> ...
> game.score("hello")
=> 8
```

---

# Unit Test

Write a unit test for the first step in your pseudocode

---

# Share

---

# Unit Tests

Continue writing unit tests and making them pass until you've implemented Scrabble functionality
