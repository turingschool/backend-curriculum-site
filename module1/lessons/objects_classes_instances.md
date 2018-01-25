---
title: Classes, Instances, Attributes, Methods
length: 120
tags: ruby, object-oriented programming
---

# Learning Goals

* understand the difference between classes and instances
* be able to define a class and create instances of that class
* understand the initialize method, and when it is called.
* identify and explain the role of attributes in an instance
* explain and use return values
* be able to write methods with and without parameters

## Classes and Instances

### Classes and Instances in Real Life

**TRY IT**: With your pair, brainstorm a **type** of object and **specific** instances of that object that are at Turing. For example:

#### Type of object: Refrigerator

Specific instances:

* Small staff refrigerator
* Student refrigerator near Classroom A
* White refrigerator in the big workspace
* Black refrigerator in the big workspace

**TRY IT**: For your type of object, list three different attributes and three different methods (a.k.a. actions). For example:

#### Refrigerator Attributes
* color
* size
* food items

#### Refrigerator Methods
* add food
* remove food
* change temperature


### Classes and Instances in Programming

In programming, a *Class* is something that models:
1. State
1. Behavior

State is what something *is*. Behavior is what something *does*. In the previous activity, our *Class* was refrigerator. We modeled the state of a refrigerator by defining the attributes "color", "size", and "food items". We modeled the behavior of a refrigerator by defining the methods "add food", "remove food", and "change temperature".

An *Instance* or *Object* is a concrete representation of a *Class*. In the previous activity, "small staff refrigerator" is a specific *Instance* of the Refrigerator *Class*. We can also say that "small staff refrigerator" is a Refrigerator *Object*. Do not get confused by the terms *Instance* an *Object*. They mean the exact same thing (for now).

Think of a Class like a blueprint for a house and an Instance as an actual house. The blueprint is a just an idea of how the house should be built, and the house is the realization of that blueprint.

### Classes and Instances in Ruby

Let's take a look at a Ruby Class. In irb, we'll make a few new instances of a String:

```ruby
a = String.new("alpha")
=> ""
a.object_id
=> 70162531807580
a.end_with? "a"
=> true
b = String.new("beta")
=> ""
b.object_id
=> 70162535734120
b.upcase
=> "BETA"
```

We can say that `String` is the class, and `a` and `b` are `Instances` of the String Class, or `a` and `b` are String `Objects`.

The *States* that `a` and `b` hold are their respective values "alpha" and "beta".

The *Behaviors* of `a` and `b` are their methods, like "end_with?" and "upcase".

String is a built-in class in Ruby. We didn't have to define it; it already exists. Can you name some other built-in Classes?

These are useful, but we are limited in what we can do with the built-in classes. Ruby does not have other classes we might need, like `Refrigerator`. Let's go ahead and define it.

The syntax for defining a class, at its most bare-bones level, is this:

```
class NameOfClass
end
```

Notice that `class` is lowercase while `NameOfClass` is CamelCased.

```ruby
class Refrigerator
end

refrigerator_1 = Refrigerator.new
p refrigerator_1

refrigerator_2 = Refrigerator.new
p refrigerator_2

refrigerator_3 = Refrigerator.new
p refrigerator_3
```

Remember, p is a combination of the puts and inspect methods. Let's run this code and see what happens.

**TRY IT**: With your pair, define your Class that you brainstormed, create some instances of that Class, and use the `p` statement to print them out.

### Initialize

When we run Refrigerator.new in Ruby, what actually happens? We can see from the last example that three different Refrigerator objects (or instances) are created. Other than that, nothing happens. We need to tell Ruby what should happen when a new Refrigerator instance (or object) is created. We do this with the initialize method.

```ruby
class Refrigerator
  def initialize
    #Initialize code here
  end
end

...
```

This method is run once and only once during an Object's lifetime, when we call `new`.

**TRY IT**: Create an initialize method for your Class and put a print statement in it. Run your file and see what happens.

## Modeling State with Attributes

The instances of the classes we've defined so far are basically useless. Aside from their `object_id`, there is nothing unique about these instances.

Remember, a class models *State* and *Behavior*. Let's give our refrigerator some state.

In our playground file, we'll add some attributes to the `Refrigerator` class. The @ symbol before a variable name indicates that it is an *Attribute* or *Instance Variable*. These two terms mean the exact same thing.

```ruby
class Refrigerator
  def initialize
    @color       = "white"
    @size        = 12
    @food        = []    
  end
end

...
```

In English, this code is saying "When we create a new Refrigerator, it should have a `color` of "white", a `size` of 12, and an empty array of `food`."

**TRY IT**: With your pair, give your class some attributes. Do you see a difference in the `p` statements when you run the file now? Try creating an attribute without the @ symbol. What do you notice?

### Parameters

Our Refrigerators now have state, but they all have the same state! We want to be able to create different refrigerators. We'll do this by adding *Parameters* to our initialize method.

```ruby
class Refrigerator
  def initialize(color_param, size_param)
    @color       = color_param
    @size        = size_param
    @food        = []    
  end
end

refrigerator_1 = Refrigerator.new("white", 12)
p refrigerator_1

refrigerator_2 = Refrigerator.new("black", 34)
p refrigerator_2

refrigerator_3 = Refrigerator.new("hot pink", 100000)
p refrigerator_3
```

Notice that we didn't change `@food = []`. Why might this be?

**TRY IT**: Give your initialize method some parameters and create some instances with different attributes.

## Modeling Behavior with Methods

Our class now models State in the form of Attributes, but what about *Behavior*?

We can define the behavior of our class by creating methods. The simplest method we can create is called a "getter". This is a method that gives us back an attribute. For instance, if we create a new Refrigerator with the color "white" like this...

```ruby
refrigerator_1  = Refrigerator.new("white", 12)
```

refrigerator_1 should be able to tell us what its color is like this...

```ruby
refrigerator_1.color
```

Let's add this to our code.
```ruby
...

refrigerator_1  = Refrigerator.new("white", 12)
puts refrigerator_1.color
...
```

What happens? Why? Let's look at the error message:

```
undefined method `color' for #<Refrigerator:0x007fa3e6922a98> (NoMethodError)
```

This error tells us exactly what we need to do: define a method `color` for the `Refrigerator`.

```ruby
class Refrigerator
  def initialize(color_param, size_param)
    @color       = color_param
    @size        = size_param
    @food        = []    
  end

  def color
  end
end

refrigerator_1 = Refrigerator.new("white", 12)
puts refrigerator_1.color
...
```

Run the file and try it again. This time, we get nil back. Why?

### Return Values

When we call a method on an object, we expect something to be returned to us. For example, if I ask some "What is your name?", I would expect for them to respond with a name.

Right now, when we call `refrigerator_1.color`, we get `nil`, which in Ruby means nothingness. This is because our method is empty. This is what an empty method looks like:

```ruby
def my_method
end
```

An empty method will always return `nil`. We need to return something else.

**The last evaluated line of code will always be the return value unless the return statement is used**

What will be returned by each of the following methods?

```ruby
def my_method
  x = 1+1
  ["piglet", "kitten", "baby gorilla"]
  99
end
```

```ruby
def my_method
  return 1+1
  ["piglet", "kitten", "baby gorilla"]
  99
end
```

```ruby
def my_method
  x = 1+1
  y = ["piglet", "kitten", "baby gorilla"]
  return x
end
```

### Back to the Code

What should the `color` method return?

```ruby
class Refrigerator
  def initialize(color_param, size_param)
    @color       = color_param
    @size        = size_param
    @food        = []    
  end

  def color
    @color
  end
end

...
```

**TRY IT**: With your pair, create getter methods for the attributes of your class. Use these getter methods to print out the attributes of one of your instances.

### More Interesting Methods

We want to be able to add food to our fridge. Let's create a new method.

```ruby
class Refrigerator
  def initialize(color_param, size_param)
    @color       = color_param
    @size        = size_param
    @food        = []    
  end

  def add_food
  end

  ...
```

When we call this add_food method, we want to add the new food to the `@food` array. But where does this new food come from? We need a parameter.

```ruby
def add_food(new_food)
end
```

Next, we need to add this new food to the `@food` array.

```ruby
def add_food(new_food)
  @food << new_food
end
```

Finally, we need to call this method.

```ruby
  refrigerator_1.add_food("apples")
```

What if we only wanted to add food up to our refrigerator's size?

```ruby
def add_food(new_food)
  if(@food.length < @size)
    @food << new_food
  end
end
```

This is what the code looks like so far:

```ruby
class Refrigerator

  def initialize(color_param, size_param)
    @color       = color_param
    @size        = size_param
    @food        = []    
  end

  def add_food(new_food)
    if(@food.length < @size)
      @food << new_food
    end
  end

  def color
    @color
  end

end

refrigerator_1 = Refrigerator.new("white", 12)
puts refrigerator_1.color
refrigerator_1.add_food("apples")
p refrigerator_1

refrigerator_2 = Refrigerator.new("black", 34)
p refrigerator_2

refrigerator_3 = Refrigerator.new("hot pink", 100000)
p refrigerator_3
```

We can see from the print statements that the `@food` array of refrigerator_1 is now populated with "apples".

**TRY IT**: With your pair, create a new method for your Class. This method should change one of your Class's attributes.

## Pair Work

Let's think about modeling cars in code. Work through the following steps. Remeber to check your work as you complete each step.

1. Create a `Car` class and save it in `car.rb`. At the bottom of the file, outside the class definition, create a new Car instance.
1. A Car should have `make`, `model`, and `color` attributes. When a new car is created, we need to be able to specify its make and model as parameters. However, a new Car always has a "white" color.
1. Create getter methods for your Car class's attributes.
1. Add a `paint` method to your Car class to change its color. It should take a `new_color` parameter.
1. Give your Car an attribute `odometer`. What should the odometer value be when the Car is first created? Create a getter method for this attribute.
1. Add a method to the class named `horn`. In that method return the String `"BEEEEEP!"`.
1. Add a method to your class named `drive` which takes an argument named `distance`. When the method is called, have it return the a string like `I'm driving 12 miles` where `12` is the value passed in for `distance`. Also, when a car drives, its odometer should be updated.
1. This one is tricky. Add a method named `start`. If the car has not yet been started, when the method is called it should return `"Starting up!"`. But if the car has previously been started, it should return `"BZZT! Nice try, though."`. You'll need to create an instance variable, a method, use an if statement, and return a value.

## Be a badass:

If you get done with the above exercise, then follow along with [this](https://vimeo.com/137837005) video.
It will go through [this](https://github.com/JoshCheek/1508/blob/0facae943f7785e5133ea506595534c1b00b3025/katas/blowing_bubbles_part2.rb) coding exercise.
It builds on bubble sort, but you don't have to understand the algorithm to follow along with it
It only plays with swapping representations, not changing behaviour.
We'll take a piece of toplevel procedural code and turn it into a beautilful namespaced object,
and then back again.
