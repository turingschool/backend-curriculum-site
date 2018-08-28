---
layout: page
title: Object-Oriented Programming
length: 90
tags: ruby, object-oriented programming
---

## Learning Goals

* Understand the distinction between a variable and what it references
* Understand how objects can interact
* Understand the process Ruby use to look up an instance method
* Understand self

## Vocabulary

* Variable
* Object
* Reference
* Pointer
* Self

# Object Oriented Programming

## Variables and Objects

There is an important distinction between variables and what that variable holds. Take a look at this example:

```ruby
class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

dog_variable = Dog.new("Fido")
other_dog_variable = dog_variable
```

**Turn and Talk**: How many `Dog` objects are there in this example?

There is only one `Dog` object in this example. Ruby creates an Object when it does `.new`. The line `other_dog_variable = dog_variable` DOES NOT create another `Dog` object, it creates another variable.

Variables are not Objects themselves. They merely **reference** the Object. You will also hear this as, variables **point** to objects. We can diagram this like so:

```
dog_variable--->    #<Dog:0xA007F...>    <---other_dog_variable
```

In this case, two variables reference the same object. We can demonstrate this like so:

```ruby
class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

dog_variable = Dog.new("Fido")
other_dog_variable = dog_variable
dog_variable.name = "Lassie"
puts other_dog_variable.name
```

**Turn and Talk**: What will be printed to the screen?

Let's look at another example

```ruby
class Owner
  attr_reader :pet

  def initialize(pet)
    @pet = pet
  end
end

class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

dog = Dog.new("Fido")
owner = Owner.new(dog)
```

**Turn and Talk**: How many `Dog` objects are there in this example? For each `Dog` object, which variables reference that object?

*Bonus*: What is the scope of those variables?

## Method Look Up

We can think of methods as messages. Just like messages they have receivers. When you type the code `some_object.method_name`, you are sending the `method_name` message to the `some_object` object. Another way to say this is that methods run on objects. When the Object receives that message, it looks in its *Class* to find that method.

Let's look at this example:

```ruby
class Owner
  attr_reader :name,
              :pet

  def initialize(name, pet)
    @name = name
    @pet = pet
  end
end

class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

dog = Dog.new("Fido")
owner = Owner.new("Jeff", dog)
puts owner.name
```

Both these Objects have a method called `name`, so if we call `.name`, how does Ruby know which one to call? The key here is that methods run on Objects. In this example, we are calling `.name` on an `Owner` object (remember, the variable `owner` is storing an Owner object), so Ruby will execute the `name` method in the `Owner` Class.

## self

Let's add to this example:

```ruby
class Owner
  attr_reader :name,
              :pet

  def initialize(name, pet)
    @name = name
    @pet = pet
  end

  def introduction
    introduce_self + " and " + introduce_pet
  end

  def introduce_self
    "Hello, my name is #{@name}"
  end

  def introduce_pet
    "My pet's name is #{@pet.name}"
  end
end

class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

dog = Dog.new("Fido")
owner = Owner.new("Jeff", dog)
puts owner.introduction
```

**Turn and Talk**: With your partner, walk through this code and explain to each other what it is doing.

The `introduction` method calls two other methods: `introduce_self` and `introduce_pet`. We just said that methods run on objects, so what objects are these methods running on? The answer is `self`. Whenever we call methods without the dot notation, there is an implied receiver of `self`. Change the example to use self:

```ruby
class Owner
  attr_reader :name,
              :pet

  def initialize(name, pet)
    @name = name
    @pet = pet
  end

  def introduction
    self.introduce_self + " and " + self.introduce_pet
  end

  def introduce_self
    "Hello, my name is #{@name}"
  end

  def introduce_pet
    "My pet's name is #{@pet.name}"
  end
end

class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

dog = Dog.new("Fido")
owner = Owner.new("Jeff", dog)
puts owner.introduction
```

If we run this code, it will still work exactly the same. `self` means "the current object", so when Ruby sees `self` inside the `introduction` method, it is referring to the `Owner` object that we called `introduction` on, i.e. the Owner named "Jeff". Ruby then knows to look in the `Owner` class for the `introduce_self` and `introduce_pet` methods.

You've run across the error `undefined local variable or method`. Now we can see how Ruby can treat something as a local variable *or* a method. In this case, it first looks for a local variable named `introduce_self` and `introduce_pet`. When it can't find them, it then looks for a method. We can illustrate this by changing the example to:

```ruby
class Owner
  attr_reader :name,
              :pet

  def initialize(name, pet)
    @name = name
    @pet = pet
  end

  def introduction
    introduce_self = "Hello"
    introduce_pet = "goodbye."
    introduce_self + " and " + introduce_pet
  end

  def introduce_self
    "Hello, my name is #{@name}"
  end

  def introduce_pet
    "My pet's name is #{@pet.name}"
  end
end

class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

dog = Dog.new("Fido")
owner = Owner.new("Jeff", dog)
puts owner.introduction
```

**Practice**: With your partner, look at the following code example.

* For each `binding.pry`, try to predict what the value of `self` will be on that line of code. Check your answers by running the code and typing `self` into the pry session:
* For each `puts`, try to predict what will be output to the screen.

```ruby
require 'pry'

class Owner
  attr_reader :name,
              :pet

  def initialize(name, pet)
    @name = name
    @pet = pet
    binding.pry
  end

  def introduction
    self.introduce_self + " and " + self.introduce_pet
    binding.pry
  end

  def introduce_self
    "Hello, my name is #{@name}"
  end

  def introduce_pet
    "My pet's name is #{@pet.name}"
  end
end

class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
    binding.pry
  end
end

binding.pry
dog = Dog.new("Fido")
owner_1 = Owner.new("Dan", dog)
owner_2 = Owner.new("Terry", dog)
puts owner_2.introduction
dog.name = "Lassie"
puts owner_1.introduction
puts "owner_1 pet name is #{owner_2.pet.name}"
```
