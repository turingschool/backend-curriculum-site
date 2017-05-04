# Classes & Instance Methods

---

# Warmup

* With the person next to you, brainstorm five **types** of objects and **specific** instances of that object that are at Turing.

For example:

* Type of object: Cubby
* Specific instances:
    * Ali's cubby
    * Mike's cubby
    * Sal's cubby

---

# Classes & Instances

In Ruby:

* a "type of object" is called a `Class`
* "specific objects" are called `instances`

---

# Classes and Objects in Code

```ruby
# in pry
a = String.new
=> ""
a.object_id
=> 70162531807580
b = String.new
=> ""
b.object_id
=> 70162535734120
```

* `String` is the class
* `a` and `b` are instances of that class

---

# Defining Classes

* Ruby has built in classes (String, Array, Hash, etc.)
* Built in classes have built-in methods
* We can define our own classes (e.g. Ruby doesn't have a `Cubby` class)

---

# Defining a Class: Syntax

```ruby
class NameOfClass
end
```

---

# Defining a Class: Practice

```ruby
# ~/turing/1module/classwork/classes_and_instances_playground.rb
# Notice that `class` is lowercase while `NameOfClass` is CamelCased.

class Fridge
end

fridge_1  = Fridge.new
puts "Number 1: #{fridge_1}"

fridge_2   = Fridge.new
puts "Number 2: #{fridge_2}"

require 'pry'; binding.pry
```

---

# Defining a Class: More Practice

**TRY IT**: With your pair, define two of the classes that you brainstormed and create instances of those classes. Paste your code in your Slack channel.

---

# Attributes IRL

In Object-Oriented Programming (OOP), **objects need to be able to model state**.

* What are the attributes (states) that may vary among cubbies?

* Color
* Contents
* Label

---

# Attributes: Practice

**TRY IT**: With your pair, brainstorm the things that make a `Person` unique.

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

fridge_1  = Fridge.new("Maytag", "white", 36, true, ["leftover pizza", "yogurt", "soylent"])
puts "Number 1: #{fridge_1}"

fridge_2   = Fridge.new("", "black", 40, true, [])
puts "Number 2: #{fridge_2}"

require 'pry'; binding.pry
```

---

# Attributes in Code: Practice

**TRY IT**: With your pair, create a class `Person` that has the attributes `name`, `birth_year`, `language`, and `alive` (which will be a true/false value). Make three instances of the `Person` class. Paste your code in Slack.

---

# Accessing Attribute Values

```ruby
# in pry, what does this return?
refrigerator.brand
```

This error tells us exactly what we need to do: define a method `brand` for the `Fridge`.

---

# Accessing Attribute Values with Methods

```ruby
class Fridge
# ... initialize method

  def brand
  end
end

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

# Return Values

The last evaluated line of code will always be the return value. For example:

```ruby
def my_method
  1+1
  ["piglet", "kitten", "baby gorilla"]
  99
end
```

**What should the `brand` method return?**

---

# Back to the Code


```ruby
class Fridge
  # ... initialize method

  def brand
    @brand
  end
end

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

# Return Values: Practice

**TRY IT**: With your pair, create getter methods for the `color`, `contents`, `temperature`, and `contents`. Next, create getter methods for `name`, `birth_year`, and `language`. Paste your code **only for Person** in Slack.

---

# Simplifying Getter Methods

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

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

# Getter Methods: Practice

**TRY IT**: With your pair, replace your getter methods for `name`, `birth_year`, and `language` with `attr_reader`s. Paste your code **only for Person** in Slack.

---

# Defining Custom Methods

Define a `temperature_in_celsius` method (formula: (F - 32) * 5/9)

```ruby
class Fridge
# ... attr_readers & initialize method

  def temperature_in_celsius
    (@temperature - 32) * 5.0/9.0
  end
end

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

# Methods: Practice

**TRY IT**: With your pair, define a `age` method for `Person`.

---

# Methods with Arguments

We've seen methods that accept parameters before:

```ruby
message = "Hello, world!"
message.start_with?("H")
=> true
message.index("e")
=> 1
```

---

# Defining Custom Methods with Arguments

```ruby
class Fridge
# ... attr_readers, initialize, and temperature_in_celsius

  def add_item(item)
    @contents << item
  end
end

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

# Defining Custom Methods with Arguments: Practice

**TRY IT**: With your pair, define a `greet(name)` method that accepts a person's name and then greets that person by returning a string like "Hi, Joanne! Nice to meet you."

---

# Redefining Attribute Values

Want to be able to do this:

```ruby
fridge_1.color = "red"
# => <Fridge:0x007fe30a2e8bd8 @brand="Maytag", ...>
```

Right now when we try this, we get an error:

```
undefined method `color= for #<Fridge:0x007fe30a2e8bd8>'
```

---

# Defining `setter` Methods

```ruby
class Fridge
  # ... attr_readers, initizlize, temperature_in_celsius, and add_item

  def color=(new_color)
    @color = new_color
  end
end

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

# `attr_writer`

```ruby
class Fridge
  attr_reader :brand,
              :color,
              :temperature,
              :contents

  attr_writer :color

  def initialize(brand, color, temperature, plugged_in, contents)
    @brand       = brand
    @color       = color
    @temperature = temperature
    @plugged_in  = plugged_in
    @contents    = contents
  end

  # ... temperature_in_celsius, add_item
end

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

# `attr_accessor`

```ruby
class Fridge
  attr_reader :brand,
              :temperature,
              :contents

  attr_accessor :color

  def initialize(brand, color, temperature, plugged_in, contents)
    @brand       = brand
    @color       = color
    @temperature = temperature
    @plugged_in  = plugged_in
    @contents    = contents
  end

  # ... temperature_in_celsius, add_item
end

# ... fridge_1 and fridge_2

require 'pry'; binding.pry
```

---

## Pair Work

See lesson plan.
