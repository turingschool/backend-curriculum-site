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

  def describe_yourself
    "I'm a user! My name is #{@name}"
  end

  def self.describe_yourself
    "I'm the user class! I don't have a name."
  end
end
```

---

# Practical Use

```ruby
class Museum
  def self.all
    @@museums
  end

  def self.count
    @@museums.count
  end

  attr_reader :name

  def initialize(arguments)
    @name = arguments[:name]
    @@museums ||= []
    @id = @@museums.count + 1
    @@museums << self
  end
end
```

---

# Practice

* Create a Photograph class that has class methods to store the number of Photographs created.
* Create an Artist class that has class methods to store the number of Artists created.

