# Fixtures, Stubs, and Mocks

---

# Warmup

* What makes testing easy?
* What makes testing hard?
* What challenges are you finding in testing Black Thursday?
* What might be some disadvantages to testing with a large dataset?
* What might be some alternatives?

---

# Fixtures

* Dataset created specifically for our test suite
* Can be difficult to maintain

---

# Fixtures in Practice

* Create a new `learning_fixtures` directory
* Create lib, test, and data directories
* Download [this](https://gist.github.com/laurenfazah/3390b8417274f11dee87eef02ea3c4db) dataset, and save it in `data`

---

# Detour: Create a Test Helper

```ruby
# test/test_helper.rb

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
```

---

# Create a Test

```ruby
require './test/test_helper'
require './lib/bob'

class BobTest < Minitest::Test
  def test_it_exists
    assert_instance_of Bob, Bob.new('./data/bob_elements.csv')
  end

  def test_pointless_iteration
    bob = Bob.new('./data/bob_elements.csv')

    assert_equal "S31E13", bob.final_episode
  end
end
```

---

# Create a Class

```ruby
require 'csv'
require 'pry'

class Bob
  def initialize(filename)
    @filename = filename
  end

  def final_episode
    episode = {}

    CSV.foreach(@filename, headers: true) do |row|
      episode["EPISODE"] = row["EPISODE"]
    end

    episode["EPISODE"]
  end
end
```

---

# Run our Test

* How long does this take?
* Why?
* How can we speed it up?
* Let's do it!

---

# Advantages? Disadvantages?

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

* What is a fixture? a stub? a mock?
* How might you use a fixture in Black Thursday?
* What about a stub?
