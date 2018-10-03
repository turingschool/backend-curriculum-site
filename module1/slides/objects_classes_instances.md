# Objects, Classes & Instances

---

# Warmup & Syntax

---

# Warmup

* In your notebook brainstorm five **types** of objects and **specific** instances of that object that are at Turing.

For example:

* Type of object: Cubby
* Specific instances:
    * Brian's cubby
    * Megan's cubby
    * Sal's cubby

---

# Classes & Instances

In Ruby:

* a "type of object" is called a `Class`
* "specific objects" are called `instances`

---

# Defining a Class: Syntax

```ruby
class NameOfClass
end
```

---

# Defining a Class: Practice

```ruby
# ~/turing/1module/classwork/objects_classes_and_instances/fridge.rb
# Notice that `class` is lowercase while `NameOfClass` is CamelCased.

class Fridge
end
```

```ruby
# ~/turing/1module/classwork/objects_classes_and_instances/runner.rb
require './fridge'
fridge_1  = Fridge.new
puts "Number 1: #{fridge_1}"

fridge_2   = Fridge.new
puts "Number 2: #{fridge_2}"

require 'pry'; binding.pry
```

---

# Defining a Class: More Practice

**TRY IT**: With your pair, define two of the classes that you brainstormed and create instances of those classes.

---

# Attributes & Instance Variables

---

# Attributes in Life

In Object-Oriented Programming (OOP), **objects need to be able to model state**.

* What are the attributes that may vary among cubbies?

---

# Attributes in Code

```ruby
class Fridge
  def initialize(brand, color, temperature, plugged_in, contents)
    @brand       = brand
    @color       = color
    @temperature = temperature
    @plugged_in  = plugged_in
    @contents    = contents
  end
end
```

```
fridge_1  = Fridge.new("Maytag", "white", 36, true, ["leftover pizza", "yogurt", "soylent"])
puts "Number 1: #{fridge_1}"

fridge_2   = Fridge.new("", "black", 40, true, [])
puts "Number 2: #{fridge_2}"

require 'pry'; binding.pry
```

---

# Attributes in Code: Practice

**TRY IT**: With your pair, create a class `Person` that has the attributes `name`, `birth_year`, `language`, and `alive` (which will be a true/false value). Make three instances of the `Person` class.

---

# Accessing Attributes

---

# Accessing Attribute Values

```ruby
# in pry, what does this return?
fridge_1.brand
```

This error tells us exactly what we need to do: define a method `brand` for the `Fridge`. However, there's a shortcut!

---

# Using `attr_reader` to Access State

```ruby
class Fridge
  attr_reader :brand,
              :color,
              :temperature,
              :contents

  def initialize(brand, color, temperature, plugged_in, contents)
    @brand       = brand
    @color       = color
    @temperature = temperature
    @plugged_in  = plugged_in
    @contents    = contents
  end
end
```

* Run your runner file using `ruby runner.rb` and see the `attr_reader`s in action

---

# Getter Methods: Practice

**TRY IT**: With your pair, create `attr_reader`s for the attributes in your `Person` class.

---

# Defining Methods

---

# Defining Methods in Our Class

Define an `add_food` method that allows you to put foods in your fridge.

```ruby
class Fridge
# ... attr_readers & initialize method

  def add_food(food)
    @contents << food
  end
end
```

---

# Methods: Practice

**TRY IT**: With your pair, define an `age` method for `Person`.

---

# Practice: Library

* See lesson plan.

---

# Share
