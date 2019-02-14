# Inheritance

---

# Warmup

* What have you done up to this point when you noticed duplication in your code?
* What do you think of when you hear the word inheritance?
* Where do you think we get the ability to call the method `assert_equal` or `assert_instance_of`, etc?

---

# Share with a Partner/Share with the Class

---

# Inheritance in Ruby

* Allows us to use code defined in one class in multiple classes
* Reduces duplication
* Useful when we have an 'is-a' relationship (e.g. a dog **is a** mammal)
* Can only inherit from one class

---

# Inheritance rules:

- When a class inherits from another, it receives all methods from other class
- The inheriting class is called the *child* or *subclass*
- The class being inherited from is called the *parent* or *superclass*
- A class can only inherit from one parent
- Any number of classes can inherit from a single superclass

---

# Diagram

---

# With a Partner

* Create a `SalesManager` class that inherits from `Employee`, and takes `base_salary`, and `estimated_annual_sales` as arguments when you initialize.
* Create a `bonus` method on `SalesManager` that returns 10% of `estimated_annual_sales`
* Create a new `SalesManager` in your runner file and print their total compensation to the terminal
* Be ready to airplay your code and share with the class!

---

# Share

---

# Super

* `super` allows us to execute methods with the same name in our parent class
    * `super` passes all of the arguments in the current method
    * `super()` passes no arguments
    * `super(argument1, argument2)` passes argument1 and argument2 specifically

---

# Adding Super to Initialize: Employee

```ruby
# employee.rb
class Employee
  attr_reader :name,
              :id

  def initialize(name, id)
    @name = name
    @id   = id
  end
end
```

---

# Adding Super to Initialize: Ceo

```ruby
# ceo.rb
require './employee'

class Ceo < Employee
  attr_reader :base_salary,
              :bonus

  def initialize(base_salary, bonus, name, id)
    @base_salary = base_salary
    @bonus       = bonus
    super(name, id)
  end
end
```

---

# Runner

```ruby
require './ceo'
require './sales_manager'

ali = Ceo.new(15, 20, "Ali", 1)
sal = SalesManager.new(15, 400)

puts "CEO Total Comp"
puts ali.total_compensation
puts "\n"
puts "SalesManager Total Comp"
puts sal.total_compensation
```

---

# Overriding Methods

* Defining methods with the same name as a method on the parent class will override that method

---

# Intern

```ruby
require './employee'

class Intern < Employee
  attr_reader :hourly_rate

  def initialize(hourly_rate, name, id)
    @hourly_rate = hourly_rate
    super(name, id)
  end

  def total_compensation
    hourly_rate * 2000
  end
end
```

---

# Practice with a Partner

Using either `super` or overriding a method, make it so that when you call `#total_compensation` on `Ceo` it adds a dollar to their `base_salary` before returning the total compensation

---

# Share

---

# Summary

* Why might we decide to use inheritance?
* What is the syntax for creating a class that inherits from another class?
* What does `super`, do and what are the differences between the three different ways you can call it?
* What does it mean to override a method in Ruby?
