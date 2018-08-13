---
title: Objects, Classes, and Instances
length: 180
tags: ruby, object-oriented programming
---

## Learning Goals

* Describe the difference between a class and an instance of that class
* Define a class
* Store state in instance variables defined in `initialize`
* Provide access to state using `attr_reader`s
* Use methods to provide behaviors to instances of a class
* Create a new instance of a class and call methods on that instance

## Slides

Available [here](../slides/objects_classes_instances)

## Warmup

In your notebook brainstorm five **types** of objects and **specific** instances of that object that are at Turing.

For example:

* Type of object: Cubby
* Specific instances:
    * Ali's cubby
    * Mike's cubby
    * Sal's cubby

## Classes in Ruby

### Overview

In programming, a *Class* is something that models:

1. State
1. Behavior

State is what something *is*. Behavior is what something *does*. In the previous activity, our *Class* was refrigerator. We modeled the state of a refrigerator by defining the attributes "color", "size", and "food items". We modeled the behavior of a refrigerator by defining the methods "add food", "remove food", and "change temperature".

An *Instance* or *Object* is a concrete representation of a *Class*. In the previous activity, "small staff refrigerator" is a specific *Instance* of the Fridge *Class*. We can also say that "small staff refrigerator" is a Fridge *Object*. Do not get confused by the terms *Instance* an *Object*. They mean the exact same thing (for now).

Think of a Class like a blueprint for a house and an Instance as an actual house. The blueprint is a just an idea of how the house should be built, and the house is the realization of that blueprint.

### Syntax

The syntax for defining a class is as follows:

```ruby
class NameOfClass
end
```

So, for example, if we wanted to create a Dog class, we could do the following:


```ruby
class Dog
end
```

Generally we will want to put more information in our classes to make them useful to us, but those two lines (even with no other information) will create a class.

### Practice

Let's practice together with a Fridge class. Create a directory in your classwork directory called `objects_classes_and_instances`. Within that directory create a `fridge.rb` file, and put the folling information into that file.

```ruby
# ~/turing/1module/classwork/objects_classes_and_instances/fridge.rb
# Notice that `class` is lowercase while `NameOfClass` is CamelCased.

class Fridge
end
```

In the same `objects_instances_and_classes` directory create a `runner.rb` file and put the code below into that.

```ruby
# ~/turing/1module/classwork/objects_classes_and_instances/runner.rb
require './fridge'
fridge_1  = Fridge.new
puts "Number 1: #{fridge_1}"

fridge_2   = Fridge.new
puts "Number 2: #{fridge_2}"

require 'pry'; binding.pry
```

We can run the `runner.rb` file from the command line if we are inside of our `objects_classes_and_instances` directory by typing the following: `ruby runner.rb`. Do that now.

Your computer should open up a pry session. Inside of that pry session type `fridge_1` and hit return to see what the variable `fridge_1` is holding. Then type `fridge_2` to see what that variable is holding. How are those two things the same? How are they different?

### Independent Practice

**TRY IT**: With your pair, define a Person class in your `objects_classes_and_instances` directory and create instances of that class in your runner file.

## Attributes in Ruby Classes

Above we created a Fridge class and then also created specific intsnaces of the fridge class that we held in the variables `fridge_1` and `fridge_2`. Generally the objects we create will come from the same template, but each instance will be different in some way.

Think about the refrigerators here in the Turing basement.

* M1 BE refrigerator
* M1 FE refrigerator
* Staff refrigerator

Each one is different in important ways. For example, each one has its own:

* brand
* color
* temperature
* plugged_in
* contents

We can model these attributes in code by using *instance variables*. Generally we define these instance variables in a special method called `initialize` that is run every time a new instance of a class is created.

### Initialize

When we run Fridge.new in Ruby, what actually happens? We can see from the last example that different Fridge objects (or instances) are created. Other than that, nothing happens. If we want some specific code to run when we first create a new Fridge, we need to tell Ruby what should happen when a new Fridge instance (or object) is created. We do this with the initialize method.

```ruby
class Fridge
  def initialize
    #Initialize code here
  end
end

...
```

This method is run once and only once during an Object's lifetime, when we call `new`.

### Modeling State with Attributes

The instances of the classes we've defined so far are basically useless. Aside from their `object_id`, there is nothing unique about these instances.

Remember, a class models *State* and *Behavior*. Let's give our refrigerator some state.

### Practice

In our playground file, we'll add some attributes to the `Fridge` class. The @ symbol before a variable name indicates that it is an *Attribute* or *Instance Variable*. These two terms mean the exact same thing.

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

we have now created a method class that will allow us to create many different instances of Fridge, each one slightly different from the last. How do we do that in practice? Update your runner file so that it includes the following:

```
fridge_1  = Fridge.new("Maytag", "white", 36, true, ["leftover pizza", "yogurt", "soylent"])
puts "Number 1: #{fridge_1}"

fridge_2   = Fridge.new("", "black", 40, true, [])
puts "Number 2: #{fridge_2}"

require 'pry'; binding.pry
```

Note that the arguments that we pass to `new` are order dependent. So, in the first example when we pass `"Maytag"` as the first argument, we are saying that the brand of the Fridge we are creating is Maytag. When we pass an empty string (`""`) the second time we call `new` we are saying that the Fridge that we created doesn't have a name brand.

### Independent Practice

**TRY IT**: With your pair, give your Person class some attributes and create some instances of Person.

## Accessing Attributes

That's all well and good, but what can we do with all these attributes that we've created? They're no good to us if we can't use them.

Generally, the way that we access information stored in a class is by *sending it messages* or *calling methods* on that class. We do that using `.` syntax.

Run your runner file again and check to see what this returns:

```ruby
fridge_1.brand
```

You should get an error that says something about the method `.brand` not existing (a `no method` error). The syntax here is correct, but we haven't told our `Fridge` class how to respond when it receives the message `brand`.

We can do that with methods like the ones we've seen before, but attributes stored as instance variables are special. We can tell our class to provide access to them using attribute readers. Let's do that now.

### Practice

Update your Fridge class to include the lines below.

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

Run your runner file again and now see if you can call `fridge_1.brand`. Try to see if you can access other attributes as well.

### Independent Practice

**TRY IT**: With your pair, create `attr_reader`s for the attributes in your `Person` class.

## Other Methods

We can also create other methods that will allow us to send other messages to our Fridge class. For example, let's say we wanted to add eggs to our Fridge. We currently have a way to see what the `contents` of the Fridge are, but we don't have any way to add to it. Let's do that by creating a method called `add_food` that will add a food to the `contents` array.

### Practice

Define an `add_food` method that allows you to put foods in your fridge. Note that we can access the `@contents` instance variable from anywhere within the class just by using the `@` symbol.

```ruby
class Fridge
# ... attr_readers & initialize method

  def add_food(food)
    @contents << food
  end
end
```

Update your runner file so that you:

1. Create a new instance of Fridge.
1. Print the contents of that Fridge.
1. Add something to the contents of the Fridge.
1. Print the new contents of the Fridge.

### Independent Practice

**TRY IT**: With your pair, create a `have_birthday` method for your Person class. This should increase the age of that person by 1.

## Pair Work

### Updating CreditCheck

With your partner, update your CreditCheck project using the following directions:

1. Create new file called `credit_card.rb` inside of your `./lib` directory
1. Define CreditCard class inside of that file
1. Take the methods that you previously had in `credit_check.rb` into the new `CreditCard` class
1. Create a file called `runner.rb`
1. Inside of that file:
    * Require your `credit_card.rb` file.
    * Create a new instance of `credit_card.rb`
    * Call `is_valid?` on that instance of `CreditCard` with **a valid** credit card and `puts` the result to the terminal.
    * Call `is_valid?` on that instance of `CreditCard` with **an invalid** credit card and `puts` the result to the terminal.
1. Create initialize method that takes `card_number` and `credit_limit` as arguments
* Refactor your `is_valid?` method to use the `card_number` instance variable instead of taking an argument
* Revise your `runner.rb` file so that it works with this new version of CreditCard
* Update your runner file so that you print:
    * The card number
    * Its credit limit
    * If it is a valid card or not
* Add `current_balance` as an instance variable that holds the total amount charged to date. The `current_balance` should initially be set to 0.
* Create an `available_credit` method that returns the remaining credit that the CreditCard has.
* Update your class so that it has a `charge` method that takes an argument of an amount. This method should *increase* the value being held by `current_balance`.
* Update your runner file to use the `charge` method and check that it correctly increases `current_balance`. This should also **decrease** the `available_credit`

By the end of this exercise, you should be able to run the following code in a `pry` session and get results similar to those below.

```ruby
require './lib/credit_card'
#=> true
cc = CreditCard.new("4024007106512380", 15000)
#<CreditCard:0x007fac20a366e0>
cc.is_valid?
#=>true
cc.credit_limit
#=>15000
cc.current_balance
#=>0
cc.available_credit
#=>15000
cc.charge(1000)
#=> 1000
cc.current_balance
#=>1000
cc.available_credit
#=> 14000
```

### Check for Understanding

With your partner, answer the questions below.

* Classes, instances, objects
    * What is a Class?
    * What is an Instance?
    * What is an Object?
    * How are these three things alike/different?
    * What code do you have to write to create a Class? What code do you have to write to create an instance?
    * What happens when a new instance is created?
* Attributes & Methods
    * What is an attribute? How can we recognize an attribute?
    * What is a method? How do we write methods?
    * What are parameters? How do we add parameters to methods?
    * What is a return value? How do you know what the return value of a method is? Do all methods have return values?


### Crafting Cars

If you have additional time, work through the exercise below. We want to model cars in code. Work through the following steps. Remember to check your work as you complete each step.

1. Create a `Car` class and save it in `car.rb`. At the bottom of the file, outside the class definition, create a new Car instance.
1. A Car should have `make`, `model`, and `color` attributes. When a new car is created, we need to be able to specify its make and model as parameters. However, a new Car always has a "white" color.
1. Create `attr_reader`s for your Car class's attributes.
1. Add a `paint` method to your Car class to change its color. It should take a `new_color` parameter.
1. Give your Car an attribute `odometer`. What should the odometer value be when the Car is first created? Create a getter method for this attribute.
1. Add a method to the class named `horn`. In that method return the String `"BEEEEEP!"`.
1. Add a method to your class named `drive` which takes an argument named `distance`. When the method is called, have it return the a string like `I'm driving 12 miles` where `12` is the value passed in for `distance`. Also, when a car drives, its odometer should be updated.
1. This one is tricky. Add a method named `start`. If the car has not yet been started, when the method is called it should return `"Starting up!"`. But if the car has previously been started, it should return `"BZZT! Nice try, though."`. You'll need to create an instance variable, a method, use an if statement, and return a value.

### Additional Exercises

If you get done with the above exercise, then follow along with [this](https://vimeo.com/137837005) video.
It will go through [this](https://github.com/JoshCheek/1508/blob/0facae943f7785e5133ea506595534c1b00b3025/katas/blowing_bubbles_part2.rb) coding exercise.
It builds on bubble sort, but you don't have to understand the algorithm to follow along with it
It only plays with swapping representations, not changing behaviour.
We'll take a piece of toplevel procedural code and turn it into a beautilful namespaced object, and then back again.
