# How Testing Works

---
<!-- Archive uses minitest -->

# Warm Up

Assume that you have a `Person` and a `Dog` class.
Assume all dogs have owners.

* How might you represent the idea of a dog having an owner in code?
* Write an `initialize` method for `Dog`
* What do you need to put in a runner file to access both classes?
* Up to now, how have you identified if your programs were working correctly? What are the downsides to this approach?

---

# Minitest

* [Minitest](http://docs.seattlerb.org/minitest/)
    * Framework used for automated testing.
    * Used on many of the homework exercises you've been assigned.
    * Ruby Gem (code written by others that we can use)

```
gem install minitest
```

---

# High Level Steps

* Create directory for tests.
* Create test file.
* Setup test file.
* Write tests.

---

# Create Directory/Create Test File

* Tests live in `test` directory
* Implementation code lives in `lib`
* Test files end in `_test.rb`
* Name corresponds to a file in the `lib` directory.

---

# Example

```
.
├── lib
|   └── dog.rb
└── test
    └── dog_test.rb
```

---

# Minitest File Setup

```
require 'minitest/autorun'
require 'minitest/pride'

class DogTest < Minitest::Test

end
```

---

# Writing a Test

```
require 'minitest/autorun'
require 'minitest/pride'

class DogTest < Minitest::Test
  def test_it_exists
    dog = Dog.new

    assert_instance_of Dog, dog
  end
end
```

---

# Code-Along

* Students have names.
* Students have laptops.
* The laptop is usually an Apple, but it can be any brand.
* Students can bring various flavors of cookies to their instructors.
* Double-chocolate brownie chunk flavor can never be wrong.

---

# Turn & Talk

What do you think the following assertion methods do?

* `assert_instance_of`
* `assert_equal`
* `assert`
* `assert_nil`
* `refute`
* `refute_equal`

---

# Additional Test Intricacies

* Tests must have different names.
* Each test run independent of the next.
* Try to write in order of complexity.
* Output
    * `E`: error
    * `F`: failure
    * `.`: passing

---

# Setup Method

```ruby
class StudentTest < Minitest::Test
  attr_reader :student

  def setup
    @student = Student.new
  end

  # Include other tests here that use @student.
end
```

---

# Other Things to Test

* Methods can handle different cases (not hard coding values)
* Edge cases

---

# Different Cases

```ruby
# student_test.rb
class StudentTest < Minitest::Test
  def test_student_has_a_name
    student = Student.new("Penelope")
    assert_equal "Penelope", student.name
  end

  def test_student_can_have_a_different_name
    student = Student.new("Hermione")
    assert_equal "Hermione", student.name
  end
end
```

---

# Testing Edge Cases

```ruby
# student_test.rb
class StudentTest < Minitest::Test
  def test_student_has_a_name
    student = Student.new("Penelope")
    assert_equal "Penelope", student.name
  end

  def test_student_cant_be_created_with_integer_name
    student = Student.new(13)
    assert_equal "Name not Provided", student.name
  end
end
```

---

# Practice

See lesson plan.

---

# Wrap-Up

* What 2 directories should we have within our project directory?
* `minitest` setup
    * What do you have to require in a test file?
    * What does your test class inherit from?
    * What is the syntax for a minitest test? What's the best name for a test?
    * Do tests need unique names? Should they be written in a particular order? Do they necessarily run in that order?
* Name 3 assertion methods you learned about today & describe their syntax.
