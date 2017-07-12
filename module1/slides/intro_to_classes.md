# Intro to Classes

---

# Warmup

* Define a method `sum` that takes two numbers as arguments and returns their sum
* Define a method `hello` that returns the string "Hello, and welcome!"
* Define a method `print_hello` that prints the string "Hello, and welcome!" to the screen
* Wrap these methods in a class called `Calculator`
* Create a new instance of our `Calculator` class and call the methods you defined

---

# Defining a Class

```ruby
class ClassName
end
```

---

# Converter Class

```ruby
# converter.rb
class Converter
  # convert, print_welcome, convert_to_celsius, print_converted
end
```

---

# Converter Runner File

```ruby
# converter_runner.rb (in the same directory as `converter`)

require './converter'

converter = Converter.new
converter.convert(32, 35, 100)
puts "This is our converter: #{converter}"
```

---

# Behavior and State

* Behavior: what an instance of our class **does**
* State: what it **is** or **has**: characteristics, status, and possessions

Car
* Behavior: start, stop, turn, speed up, slow down
* State: color, passengers, wheels, current speed, mileage

---

# Creating Class with State

State is stored in **instance variables**

```ruby
class Classroom
  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end
end
```

---

# Classroom Runner

```ruby
# classroom_runner.rb (same directory as `classroom.rb`)
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts classroom_a
```

---

# Pulling State

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts "Length: #{classroom_a.length}"
```

---

# Providing Means to Get State

```ruby
# classroom.rb
class Classroom
  attr_reader :length,
              :width,
              :height

  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end
end
```

---

# Adding Behavior

```ruby
# classroom.rb

class Classroom
  attr_reader :length,
              :width,
              :height

  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end

  def area
    length * width
  end
end
```

---

# Adding Behavior to Runner

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts "Length: #{classroom_a.length}"
puts "Width: #{classroom_a.width}"
puts "Area: #{classroom_a.area}"
```

---

# Changing State

* With a method
* Changing our `attr_reader` to `attr_accessor` (can be done selectively)

---

# Changing State in Classroom

```ruby
# classroom.rb
class Classroom
  attr_accessor :length,
                :width,
                :height

  # ... initialize, area

  def add_length(feet)
    @length += feet
  end
end
```

---

# Changing State from Our Runner

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts "Length: #{classroom_a.length}"
puts "Width: #{classroom_a.width}"
puts "Area: #{classroom_a.area}"

puts "Make length 1."
classroom_a.length = 1

puts "New Length: #{classroom_a.length}"
puts "New Area: #{classroom_a.area}"

puts "Add four to length"
classroom_a.add_length(4)

puts "New Length: #{classroom_a.length}"
puts "New Area: #{classroom_a.area}"
```

---

# Try It!

* Create a `Lunchbox` class that has a theme, height, width, and length attributes
* Allow users to access the theme
* Create a method `capacity` that returns the total volume the lunchbox can hold

---

# Summary

* How would you define a `Cubby` class in Ruby?
* What might be some of its attributes?
* What might be some of its methods?
