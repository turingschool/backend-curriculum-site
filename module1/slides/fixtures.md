# Fixtures

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

# Build Fixtures

With remaining time, review your Black Thursday project to see if it would benefit from creating fixtures.

---

# Summary

* What is a fixture?
* How might you use a fixture in Black Thursday?
