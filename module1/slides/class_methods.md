# Class Methods

---

# Warmup

```ruby
> sam = User.new("Sam")
# => #<User:0x007f94e3ab6218 @name="Sam">
> sam.say_hello("Jay")
# => "Hello, Jay!"
```

* What do we call the method `#say_hello` on? What do we call the method `::new` on?
* In the method list in the Ruby docs page for Array, what is the difference between methods with a `#` prefix and those with a `::` prefix?

---

# Classes

* Factories for instances of a thing.
* Hold blueprints.
    * Instance Variables (State)
    * Methods (Behavior)

---

# Classes (continued)

* Also objects themselves.
    * Class Variables (`@@var_name`)
    * Class Methods (`def self.method_name`)

---

# Syntax

```ruby
class User
  def initialize(name)
    @name = name
  end

  def self.describe_yourself
    "I'm the user class!"
  end
end
```

---

# Practical Use

* Track information about instances
* Create multiple instances at once

---

# Example

```ruby
# user.rb
class User
  def initialize(name)
    @name = name
  end

  def self.create_multiple(users)
    users.map do |user|
      User.new(user[:name])
    end
  end
end

# runner.rb
users = [
    {name: "Sal"}
    {name: "Brian"}
    {name: "Megan"}
  ]

User.create_multiple(users)
```

---

# Practice

* Create a House class that has a method that will return a collection of Houses when passed an array of hashes.

---

# Exploration

* What happens if you create a class method and an instance method with the same name?
* What happens if you call an instance method from within a class method?
* What about a class method from within another class method?
* How would you explain the difference between class and instance methods to someone else?
* Can you think of a metaphor for classes that includes a description of class and instance methods?

---

# Wrap Up

* What is the syntactic difference between class methods & instance methods?
* Why might you use a class method instead of an instance method?

