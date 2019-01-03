---
layout: page
title: Ruby Object Model
length: 90 min
tags: ruby, OOP, CS, inheritance
---

## Learning Goals

- Understand how Ruby manages scope
- Understand how Ruby manages inheritance
- Understand how Ruby manages instances

## Vocabulary

* Scope
* Inheritance
* Look Up Chain
* Superclass

## Slides

* Available [here](../slides/ruby_object_model)

## WarmUp

- What is class inheritance and how is it implemented?
- What is a module and how is it implemented?
- How do you know what variables, methods and classes you have available at any given time?

## Investigative Methods

These three methods can help you investigate the relationships between classes and modules. All methods are run on the class (i.e. `String`, `Hash`)

* `.ancestors`: returns a list of modules included/prepended in mod (including mod itself). See [docs](https://ruby-doc.org/core-2.4.1/Module.html#method-i-ancestors).
* `.included_modules`: returns a list of the modules included in mod. See [docs](https://ruby-doc.org/core-2.4.1/Module.html#method-i-included_modules).
* `.superclass`: returns the superclass of the class. See [docs](https://ruby-doc.org/core-2.4.1/Class.html#method-i-superclass).

## Mapping Ruby's Object Model

### Exercise
Using `.class`, `.ancestors`, `.included_modules`, and `.superclass`, diagram the ancestors and superclasses of Modules and Classes of these several commonly-used Ruby classes: Hash, Array, String, Integer, and Float.

![Ruby Inheritance Diagram](https://docs.google.com/drawings/d/e/2PACX-1vSh1z2yb089aMCD1pp5idcFcfvZdQt5vJH3cOAas22hI5mrIO83WrrrXdGZy6sWZuu9UALMEJeXX_JX/pub?w=952&h=728)

Now check out some Ruby classes and Modules you don't interface with often, but use all the time. Try using `.class`, `.ancestors`, `.included_modules`, and `.superclass` to diagram `Object`, `Kernel`, and `BasicObject`.

#### Definitions and Rules
* `Classes`: store instance methods, have a superclass pointer
* `Instances`: store instance variables, have a class pointer
* `Classes` are also instances (of Class)
* `Classes` can only inherit from one other class (its 'superclass')
* `Classes` can include multiple Modules.
* `Modules` can be mixed-in to multiple classes (mixins)

## Scope with Variables & Methods

### The Lookup Chain

```ruby
class WoodThings

  def soft
    "superclass's superclass"
  end

end
```

```ruby
require "./wood_things"

class Furniture < WoodThings

  def soft
    "superclass"
  end

end
```

```ruby
module ChairModule

  def soft
    "module"
  end

end
```

```ruby
require "./chair_module"
require "./furniture"

class Chair < Furniture
  include ChairModule

  def initialize
    @motto = "I'm a chair!"
  end

  def chair_type
    short = "variable"
    puts short
    puts soft
  end

  def short
    "method"
  end

  def soft
    "class"
  end

end

Chair.new.chair_type
```

When I call `Chair.new.chair_type` what will be my output?
How could I get it to print module?

#### Independent Practice
How could I get `Chair.new.chair_type` to print `method`?
How could I get `Chair.new.chair_type` to print `superclass`?
How could I get `Chair.new.chair_type` to print `superclass's superclass`?


### WrapUp
* How does Ruby's look up chain work? What is the order it checks things?
* What are three methods you can use to learn about where a built in Ruby method gets its components?
* Draw a diagram of where Ruby would look for the method `::new`

### Additional Resources
* Test your understanding of this material with this quiz: [http://quiz-ruby-object-model.herokuapp.com/](http://quiz-ruby-object-model.herokuapp.com/).
* Read Camilo Reyes' ["Understanding the Object Model."](https://www.sitepoint.com/understanding-object-model/)
* [Ruby Object Model Video](https://vimeo.com/160952993)
