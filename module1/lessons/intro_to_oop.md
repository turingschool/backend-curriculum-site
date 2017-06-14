---
layout: page
title: Intro to OOP
length: 60
tags: ruby, classes, objects
---

## Learning Goals

* Define classes with instance variables in Ruby
* Explain 'state' and 'behavior' in the context of Ruby/OOP

## Warmup

* Define a class ``
* Write down two classes of things (e.g. `Laptops`), and for each class write down two instances of that class (e.g. `Sal's laptop`)
* For each class of thing, write down some attributes that might distinguish one instance from another (e.g. `brand`, `owner`, `size`)

## Lesson

Classes in Ruby are like factories/blueprints. We define classes, and then use the class to create specific instances of that class.
















For example, we can create a `Fridge` class, and then use that class to create new fridge instances as follows:

Notice that `class` is lowercase while `NameOfClass` is CamelCased.

```ruby
class Fridge
end

refrigerator_1  = Fridge.new
puts "Number 1: #{refrigerator_1}"

refrigerator_2   = Fridge.new
puts "Number 2: #{refrigerator_2}"

refrigerator_3 = Fridge.new
puts "Number 3: #{refrigerator_3}"
```

Let's run the file `ruby classes_and_instances_playground.rb` and see what happens.

Sometimes it's helpful to be able pause your file and look around. Let's throw `pry` in there to do so.

```ruby
class Fridge
end

refrigerator_1  = Fridge.new
puts "Number 1: #{refrigerator_1}"

refrigerator_2   = Fridge.new
puts "Number 2: #{refrigerator_2}"

refrigerator_3 = Fridge.new
puts "Number 3: #{refrigerator_3}"

require 'pry'; binding.pry
puts "-------"
```

**TRY IT**: With your pair, define two of the classes that you brainstormed and create instances of those classes. Paste your code in your Slack channel.



























### Attributes IRL

The instances of the classes we've defined so far are basically useless. Aside from their `object_id`, there is nothing unique about these instances.

In Object-Oriented Programming (OOP), **objects need to be able to model state**.

When we use the `Fridge` factory to create a new fridge instance, **state** refers to the specific characteristics of that fridge.

What are the attributes (states) that may vary among refrigerators?

* Brand
* Color
* Temperature
* Plugged In?
* Contents

**TRY IT**: With your pair, brainstorm the things that make a `Person` unique.

### Attributes in Code

Let's go back to our playground file and add some attributes to the `Fridge` class:

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

refrigerator_1  = Fridge.new("Maytag", "white", 36, true, ["leftover pizza", "yogurt", "soylent"])
puts "Number 1: #{refrigerator_1}"

refrigerator_2   = Fridge.new("", "black", 40, true, [])
puts "Number 2: #{refrigerator_2}"

refrigerator_3 = Fridge.new("", "black", 33, false, ["celery"])
puts "Number 3: #{refrigerator_3}"

require 'pry'; binding.pry
puts "-------"
```

Let's run the file `ruby classes_and_instances_playground.rb` and see what happens.

**TRY IT**: With your pair, create a class `Person` that has the attributes `name`, `birth_year`, `language`, and `alive` (which will be a true/false value). Make three instances of the `Person` class. Paste your code in Slack.

### Accessing Attribute Values

Our refrigerators now store their own attributes, but how do we access those values? Let's run the file again and try this:

```ruby
refrigerator_1.brand
```

What happens? Why? Let's look at the error message:

```
NoMethodError: undefined method `brand' for #<Fridge:0x007f8d42132c58>
from (pry):4:in `<main>'
```

Usually when we see this error it means that we need to create a method `brand` on our Fridge class so that our instance of fridge can respond to that method call. However, when we are simply accessing instance variables, there is a shorthand that we can use:

```ruby
class Fridge
  attr_reader :brand

  def initialize(brand, color, temperature, plugged_in, contents)
    @brand       = brand
    @color       = color
    @temperature = temperature
    @plugged_in  = plugged_in
    @contents    = contents
  end
end

refrigerator_1  = Fridge.new("Maytag", "white", 36, true, ["leftover pizza", "yogurt", "soylent"])
puts "Number 1: #{refrigerator_1}"

refrigerator_2   = Fridge.new("", "black", 40, true, [])
puts "Number 2: #{refrigerator_2}"

refrigerator_3 = Fridge.new("", "black", 33, false, ["celery"])
puts "Number 3: #{refrigerator_3}"

require 'pry'; binding.pry
puts "-------"
```

Run the file and try it again. Now we get "Maytag" back as we expected!

It's important to remember that in the background `attr_reader` is creating a method to access the

















### State and Behavior in Ruby Classes

The power in classes comes from their ability to package up what we will call **state** and **behavior**.

State is stored in classes using **instance variables**, and behavior is stored by defining **methods** that instances of our class can respond to.

Generally, we will define our instance variables when we initialize a new instance of our class.

```ruby
class Fridge
  def initialize(material, wheels)
    @material = material
    @wheels   = wheels
  end
end
```

In the example above






## Summary

* What are some examples of classes and instances from everyday life?
* How would you define a `Person` class that had height, weight, and age attributes in Ruby?
* What are the two main responsibilities of an instance of an object in Ruby?
