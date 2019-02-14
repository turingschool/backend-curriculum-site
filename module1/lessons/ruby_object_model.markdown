---
layout: page
title: Ruby Object Model
length: 90 min
tags: ruby, OOP, CS, inheritance
---

## Learning Goals

- Develop a mental model for how Ruby manages instances, classes, superclasses, and modules
- Understand Ruby's Lookup Chain for methods

## Vocabulary

* Inheritance
* Superclass
* Module
* Object Model
* Look Up Chain


## Slides

* Available [here](../slides/ruby_object_model)

## WarmUp

- What is class inheritance and how is it implemented?
- What is a module and how is it implemented?
- How do you know what variables, methods and classes you have available at any given time?

# The Ruby Object Model

## Investigative Methods

These three methods can help you investigate the relationships between classes and modules. All methods are run on the class (i.e. `String`, `Hash`)

* `.ancestors`: lists all classes along the inheritance chain, and any modules included by those classes. See [docs](https://ruby-doc.org/core-2.4.1/Module.html#method-i-ancestors).
* `.included_modules`: returns a list of all modules included by any class along the inheritance chain. See [docs](https://ruby-doc.org/core-2.4.1/Module.html#method-i-included_modules).
* `.superclass`: returns the superclass of the class. See [docs](https://ruby-doc.org/core-2.4.1/Class.html#method-i-superclass).

## Mapping Ruby's Object Model

### Superclasses

We are going to create a `Dog` class. That `Dog` class is going to inherit from another class called `Animal`. That `Animal` class is going to include a module called `AnimalBehavior`:

```ruby
# dog.rb
require './animal'

class Dog < Animal
end

dog = Dog.new
require 'pry'; binding.pry
```

```ruby
# animal.rb
require './animal_behavior'

class Animal
  include AnimalBehavior
end
```

```ruby
# animal_behavior.rb
module AnimalBehavior
end
```

Notice that we haven't actually included any methods in these classes/modules. We don't need them to map Ruby's Object Model.

When we run the `dog.rb` file, we create a new instance of `Dog` and then hit a pry. Using the investigative methods we defined above, we can learn about that dog instance's ancestors:

```ruby
pry(main)> dog
# => #<Dog:0x007ff414932eb0>

pry(main)> dog.class
# => Dog

pry(main)> Dog.ancestors
# => [Dog, Animal, AnimalBehavior, Object, PP::ObjectMixin, Kernel, BasicObject]

pry(main)> Dog.superclass
# => Animal

pry(main)> Animal.superclass
# => Object

pry(main)> Object.superclass
# => BasicObject

pry(main)> BasicObject.superclass
# => nil
```

Calling `.class` on the Dog object leads us to the `Dog` class. Calling `.superclass` on the `Dog` class leads us to `Object`, and calling `superclass` on `Object` leads us to `BasicObject`. `BasicObject` has no superclass, so the inheritance chain ends there. We can summarize this information in a diagram:

![Dog Inheritance](https://i.imgur.com/6IwoHvk.png)

Notice how we have included two instances of Dog in this diagram. This is to illustrate that there can be many instances of a class, and they all have a `.class` pointer to their Class. In this example, there can be many instances of Dog that all have the same `Dog` class.

Also notice that we call `.superclass` on the `Dog` class, not the dog instance. What happens if we call `.superclass` on a dog instance? Try it to find out.

Because our class inherits from `Object`, which inherits from `BasicObject`, we know that any class we create will have those two ancestors. This is where `:new` comes from. Look in the [Ruby Docs BasicObject Page](https://ruby-doc.org/core-2.4.1/BasicObject.html) and you'll see the `:new` defined there.

### Modules

We've mapped out the inheritance chain for our dog, but what about the modules? What happens if we call `included_modules` on our `Dog` class.

```ruby
pry(main)> Dog.included_modules
#=> [AnimalBehavior, PP::ObjectMixin, Kernel]
```

We can see our `AnimalBehavior` module (along with some others), but we included that in `Animal`, not in `Dog`, so why is it showing up here? `included_modules` shows all modules that were included in *any* superclass, so it won't tell us **where** that module was included. In this case, we get more information if we start at the top of the inheritance chain to figure out where modules first appear (you may get slightly different results depending on what Ruby version you are running):

```ruby
pry(main)> BasicObject.included_modules
# => []

pry(main)> Object.included_modules
# => [PP::ObjectMixin, Kernel]

pry(main)> Animal.included_modules
# => [AnimalBehavior, PP::ObjectMixin, Kernel]

pry(main)> Dog.included_modules
# => [AnimalBehavior, PP::ObjectMixin, Kernel]
```

From this information, we can deduce that `BasicObject` doesn't include any modules, `Object` includes `PP:ObjectMixin` and `Kernel` (you don't need to worry about what those are), and `Animal` includes `AnimalBehavior`.

Our updated diagram:

![Imgur](https://i.imgur.com/f4pszOG.png)

## Chart Paper Exercise

Break into small groups. Grab a chart paper and markers.

Using `.class`, `.ancestors`, `.included_modules`, and `.superclass`, diagram the Object Model of these several commonly-used Ruby classes: Hash, Array, String, Integer, and Float.

# The Lookup Chain

We now have a mental model for how Ruby manages classes, instances, superclasses, and modules, but why does it matter? The biggest implication of the Object Model is the **Lookup Chain**. We know that we can store methods in several places (class, superclass, module), but what is the exact order that Ruby looks for things? If a method is defined in several places, which one will Ruby use?


## Lookup Chain Exercise

Complete [this activity](https://github.com/turingschool-examples/lookup_chain_exercise). In the first part of the activity, you will map the Object Model for a `Chair` instance, just as we did above. Then you will alter the code to explore the order of the Lookup Chain.

Once you have finished the activity, write out the order of the Lookup Chain as concisely as possible.

## Other Definitions and Rules

* `Classes`: store instance methods, have a superclass pointer
* `Instances`: store instance variables, have a class pointer
* `Classes` are also instances (of Class)
* `Classes` can only inherit from one other class (its 'superclass')
* `Classes` can include multiple Modules.
* `Modules` can be mixed-in to multiple classes (mixins)

## WrapUp

* How does Ruby's look up chain work? What is the order it checks things?
* What are three methods you can use to learn about where a built in Ruby method gets its components?
* Draw a diagram of where Ruby would look for the method `::new`

## Additional Resources

* Test your understanding of this material with this quiz: [http://quiz-ruby-object-model.herokuapp.com/](http://quiz-ruby-object-model.herokuapp.com/).
* Read Camilo Reyes' ["Understanding the Object Model."](https://www.sitepoint.com/understanding-object-model/)
* [Ruby Object Model Video](https://vimeo.com/160952993)
