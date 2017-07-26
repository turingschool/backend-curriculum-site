# Stubs, and Mocks

---

# Warmup

* In Black Thursday, what class is responsible for loading data from CSV?
* How many methods rely on that data being loaded?
* How many tests are loading that data?
* Are there methods that use the data in the CSVs that you could test without actually loading the CSVs? How would you do it?

---

# Tips on Building Applications

* You're the boss
* You're going to have to work with the things you build
* Build things so that they're easy for you to use
* Build things mostly using paradigms that feel comfortable
* Build interfaces to interact with things that are less familiar/subject to change

---

# Advantages to Building Interfaces with SRP

Allows you to:

* be flexible if sources change
* work mostly with datatypes/structures that are comfortable to you
* test with datatypes/structures that are comfortable to you

---

# How do we mirror this in our tests?

* Build some integration tests that deal with the interface
* Build unit tests that given some input provide a consistent output

---

# What about Interconnected Methods?

* Use *stubs* to isolate our tests from methods that rely on other methods

---

# Stubbing Library

* `gem install mocha`
* `require mocha/mini_test` in `test_helper.rb`

---

# Adding to Our Test

```ruby
def test_it_can_have_paint
  bob = Bob.new('./data/bob_elements.csv')
  paint_1 = Paint.new("Alizarin Crimson")
  paint_2 = Paint.new("Van Dyke Brown")

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  assert_equal [paint_1, paint_2], bob.paints
end
```

---

# Adding Functionality

* Create `Paint` class
* Create `add_paint` method

---

# Another Test

```ruby
def test_it_can_tell_the_amount_of_paint
  bob = Bob.new('./data/bob_elements.csv')
  paint_1 = Paint.new("Alizarin Crimson", 22)
  paint_2 = Paint.new("Van Dyke Brown", 40)

  bob.add_paint(paint_1)
  bob.add_paint(paint_2)

  paint_1.stubs(:amount).returns(22)
  paint_2.stubs(:amount).returns(40)

  assert_equal 62, bob.amount_of_paint
end
```

---

# Make It Pass

---

# Mocks

* Have shown we don't need methods on related classes
* *mocks* go one step further: don't actually need the classes themselves!
* In `test_it_can_have_paint`

```ruby
paint_1 = mock('paint')
paint_1.expects(:color).returns("Alizarin Crimson")
paint_2 = mock('paint')
paint_2.expects(:color).returns("Van Dyke Brown")
```

---

# Summary

* What is a stub? a mock?
* What about a stub?
