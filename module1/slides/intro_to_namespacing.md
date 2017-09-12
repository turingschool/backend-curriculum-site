# Namespacing

---

# Warmup

* What are some defining characteristics of modules?
* Name one type of module we've already discussed.

---

# Slytherin Type 1

`touch slytherin_1.rb`

```ruby
class Slytherin
  def initialize(name)
  	 @name = name
  	 @teachers = []
  end
end
```

---

# Slytherin Type 2

`touch slytherin_2.rb`

```ruby
class Slytherin
  def initialize
    @teachers = []
    @students = []
  end

  def add_student(student)
     @students << student
  end

  def add_teacher(teacher)
     @teachers << teacher
  end
end
```

---

# Discuss

What is the same/different about these two classes?

---

# Runner

`touch slytherin_runner.rb`

```ruby
require "./slytherin_1.rb"
require "./slytherin_2.rb"

house   = Slytherin.new
student = Slytherin.new("Malfoy")

house.add_student(student)
```

If I run this, what will I get? Why?

---

# Student Namespace

```ruby
# student/slytherin.rb
module Student
  class Slytherin

    def initialize(name)
  	   @name = name
  	   @teachers = []
    end

  end
end
```

---

# House Namespace

```ruby
# house/slytherin.rb
module House
  class Slytherin

  	attr_reader :students

    def initialize
      @teachers = []
      @students = []
    end

    def add_student(student)
       @students << student
    end

    def add_teacher(teacher)
       @teachers << teacher
    end

  end
end
```

---

# Runner

```ruby
require './student/slytherin.rb'
require './house/slytherin.rb'

student = Student::Slytherin.new("Malfoy")
house = House::Hufflepuff.new
```

When I run this, what will I get? Why?

---

# Discuss

Have we seen a double colon like that before? What have you seen it do?

---

# Scope Resolution Operator (::)

* Allows you to change/direct your scope.
* It allows access to items in modules or class level items in classes.

---

# Exercise: Namespacing

* See lesson plan.

---

# WrapUp

* What is the syntax of namespacing? How do you define it? How do you call it?
* What are some scenarios where you have seen it? Where might you use it?
