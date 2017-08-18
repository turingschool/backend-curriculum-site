# Intro to OOP

---

# Warmup

* Write down to classes of things (e.g. Classroom) and for each write down two **instances** of that class (e.g. `bem1_classroom`)
* For each class of thing, write down some attributes that might distinguish one instance from another (e.g. `tables`, `chairs`, `length`, `width`, `height`, `pairing_stations`)

---

# Setting Default Values

```ruby
# classroom.rb
class Classroom
  # attr_readers

  def initialize(length, width, height = 20)
    @length = length
    @width  = width
    @height = height
  end

  # ... other methods
end
```

---

# Using Default Values

```ruby
# classroom_runner.rb
standard_room = Classroom.new(15, 15)
short_room    = Classroom.new(15, 15, 10)

puts "Standard Height: #{standard_room.height}"
puts "Short Height: #{short_room.height}"
```

---

# Setting Initial State Without Parameters

```ruby
# classroom.rb

class Classroom
  # ... attr_readers

  def initialize(length, width, height = 20)
    @length   = length
    @width    = width
    @height   = height
    @students = []
  end

  # ... other methods
end
```

---

# Adding to Our `@students` Array

```ruby
# classroom.rb

class Classroom
  attr_accessor :length,
                :width,
                :height,
                :students

  # ... initialize, area, volume, add_length

  def add_student(student)
    @students << student
  end
end
```

---

# Creating a Student Class

```ruby
# student.rb
class Student
  def initialize(name)
    @name = name
  end
end
```

---

# Passing Objects to Other Objects

```ruby
# classroom_runner.rb

require './classroom'
require './student'

classroom_a = Classroom.new(10, 5, 20)

sal = Student.new("Sal")
ali = Student.new("Ali")

classroom_a.add_student(sal)
classroom_a.add_student(ali)

puts classroom_a.students
```

---

# Using Objects in Other Objects

```ruby
# classroom.rb

class Classroom
  # attr_accessors, previously defined methods

  def print_roster
    @students.each do |student|
      puts student.name
    end
  end
end
```

---

# Summary

* What are some examples of classes and instances from everyday life?
* How would you define a `Person` class that had height, weight, and age attributes in Ruby?
* What are the two main responsibilities of an instance of an object in Ruby?

# Video

This is a 5 minute explanation of Object Oriented Programming. It's geared towards JavaScript developers, and they use the term "Object" where you should use "Instance", but otherwise, it does a good job of explaining the philosophy of OOP

<https://www.youtube.com/watch?v=SS-9y0H3Si8>
