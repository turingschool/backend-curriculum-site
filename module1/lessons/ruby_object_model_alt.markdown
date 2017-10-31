---
layout: page
title: Ruby Object Model
length: 90 min
tags: ruby, OOP, CS 
---

## Learning Goals

- Understand how Ruby manages scope
- Understand how Ruby manages inheritance
- Understand how Ruby manages instances

## Vocabulary

- Binding
- Scope
- Pointer

## Warmup

- What's the difference between a class and an instance from Ruby's perspective?
- How are modules used as "mix-ins"?
- How do you know what variables, methods and classes you have available at any given time?

## Investigative Methods

These three methods can help you investigate the relationships between classes and modules. All methods are run on the class (i.e. `String`, `Hash`)

* `.ancestors`: returns a list of modules included/prepended in mod (including mod itself). See [docs](https://ruby-doc.org/core-2.4.1/Module.html#method-i-ancestors).
* `.included_modules`: returns a list of the modules included in mod. See [docs](https://ruby-doc.org/core-2.4.1/Module.html#method-i-included_modules).
* `.superclass`: returns the superclass of the class. See [docs](https://ruby-doc.org/core-2.4.1/Class.html#method-i-superclass).

## Mapping Ruby's Object Model
### Definitions and Rules
* `Classes`: store instance methods, have a superclass pointer
* `Instances`: store instance variables, have a class pointer
* `Classes` are also instances (of Class)
* `Classes` can only inherit from one other class (its 'superclass')
* `Classes` can include multiple Modules.
* `Modules` can be mixed-in to multiple classes (mixins)

#### Exercises
Using `.class`, `.ancestors`, `.included_modules`, and `.superclass`, diagram the ancestors and superclasses of Modules and Classes of these several commonly-used Ruby classes: Hash, Array, String, Integer, and Float.

![Ruby Inheritance Diagram](hhttps://docs.google.com/drawings/d/e/2PACX-1vSh1z2yb089aMCD1pp5idcFcfvZdQt5vJH3cOAas22hI5mrIO83WrrrXdGZy6sWZuu9UALMEJeXX_JX/pub?w=952&h=728)

Now check out some Ruby classes and Modules you don't interface with often, but use all the time. Try using `.class`, `.ancestors`, `.included_modules`, and `.superclass` to diagram `Object`, `Kernal`, and `BasicObject`.

#### Extension
Read Camilo Reyes' ["Understanding the Object Model."](https://www.sitepoint.com/understanding-object-model/)

## Variables

Let's quickly review the types of variables, and talk about a couple you may not have much experience with.

* 'Instance variables' (`@name`) begin with @. Uninitialized instance variables have the value nil and produce warnings with the -w option.
* 'Local variables' (`name`) begin with a lowercase letter or `_`. The scope of a local variable ranges from class, module, def, or do to the corresponding end or from a block's opening brace to its close brace {}.
* 'Global Variables' (`$important_name`) begin with a `$`. These variables are accessible from anywhere.
* 'Constants' (`BIBLICAL_NAMES`) begin with an uppercase letter. Constants defined within a class or module can be accessed from within that class or module, and those defined outside a class or module can be accessed globally.

## Bindings
When you invoke a method on an instance, Ruby follows a pattern for locating the definition of that method.

* Start by looking for a local variable
* Check its class for a method
* Look to that class's included_modules
* Until it finds the method, go to the superclass
* Once you find it, create a scope for that object

After Ruby traverses modules and superclasses and locates the source of a method, a scope is created called a `Binding`. [Binding](https://ruby-doc.org/core-2.4.1/Binding.html) is an actual Ruby class that captures the context in which code is executed. The binding retains the context for future use, including relevant variables, methods, the value of self (the instance in which they are operating), and some other contextual details.

``` ruby
class Person
  def get_name
    @name
  end

  def get_binding
    binding
  end
end

class Employee < Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_first_initial
    get_name[0]
  end
end

joshs_name = "Josh"
josh = Person.new(joshs_name)
josh.get_name                 # => "Josh"
josh.get_first_initial              # => "J"
josh.get_binding              # => #<Binding:0x007f879cc62250>
josh.get_binding.eval('self') # => #<Person:0x007fe6348454f0 @name="Josh">
```

As this example shows, you can access the binding by calling `binding`.

#### Paired exercise

* Create a superclass for Person and a new method in that class that returns its binding. Make sure it is accessible from an instance of Employee.
* Experiment with bindings and articulate two new things you've learned about how they work. You can use [the docs](https://ruby-doc.org/core-2.4.1/Binding.html), or just type `binding.methods` to see what you _can_ do.

#### Check for Understanding
* How does Ruby's look up chain work? What is the order it checks things?
* What are three methods you can use to learn about where a built in Ruby method gets its components? 
* Draw a diagram of where Ruby would look for the method 

## Formative Assessment

Test your understanding of this material with this quiz: [http://quiz-ruby-object-model.herokuapp.com/](http://quiz-ruby-object-model.herokuapp.com/).
