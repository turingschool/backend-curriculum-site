# Intro to TDD

---
<!-- Archived because uses minitest -->

# Warmup

Assume that you have a `Person` and a `Dog` class.
Assume all dogs have owners.

* How might you represent the idea of a dog having an owner in code?
* Write an `initialize` method for `Dog`
* What do you need to put in a runner file to access both classes?

---

# Background

* What is testing?
* What are some of the advantages of testing?

---

# Pitfalls

* What makes testing difficult?
    * Domain Specific Language
    * Planning
    * Taking bite sized chunks

---

# Setup

* `gem install minitest`

---

# Creating a Test

```ruby
# car_test.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class CarTest < Minitest::Test
  # test it exists
  # test its initial speed is 0
  # test it can speed up
end
```

---

# Unicorns

Complete tasks outlined in the linked lesson

