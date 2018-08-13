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

## As A Group

### Updating CreditCheck

With your partner, update your CreditCheck project using the following directions.

Create a CreditCard class based on the following criteria:

* A CreditCard is passed two arguments upon initialization
    * The first argument is a String representing the card number
    * The second argument is an Integer representing the CreditCard’s limit
* A CreditCard can access the called card_number and limit from outside the class with `attr_reader`s
* A CreditCard has a method called is_valid? that takes no arguments and returns either true or false based on whether or not the card number is valid.
* A CreditCard has a method called last_four that returns a String of the last four digits of the card number

If the previous criteria are met, you should be able to interact with the CreditCard class from a Pry session like so:

```ruby
pry(main)> require './lib/credit_card'
#=> true

pry(main)> credit_card = CreditCard.new("5541808923795240", 15000)
#=> #<CreditCard:0x00007fbb1ca5f698 @card_number="5541808923795240", @limit=15000>

pry(main)> credit_card.card_number
#=> "5541808923795240"

pry(main)> credit_card.limit
#=> 15000

pry(main)> credit_card.last_four
#=> "5240"

pry(main)> credit_card.is_valid?
#=> true
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
