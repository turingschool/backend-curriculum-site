---
layout: page
title: Passing Instances
length: 60
tags: ruby, objects, instances
---

## Learning Objectives

* Create multiple instances of a new class.
* Create methods that take arguments.
* Use parameters inside of methods.
* Call methods on objects that are passed as parameters.

## Overview

* Warmup
* Create a Dog class.
* Create a person class
* Add methods to allow a person to buy/own dogs.
* Create methods to allow a person to feed their dogs.

## Warm-up

Assume that you have a `Person` and a `Dog` class.

* What might some attributes of a dog be?
* Write a sample `initialize` method for the `Dog` class.
* What might some attributes of a person be?
* Write a sample `initialize` method for the `Person` class.
* How would you create an instance of `Dog`?
* How would you create an instance of `Person`?

## Share

Discuss your answers with a partner then share with the larger group.

## Create a Dog Class

### Let's Start with Some Attributes

Let's assume that we want instances of our `Dog` class to have a name, age, breed, and breed. Additionally we want to track whether the dog is hungry or not (all dogs start as hungry). As a group let's create a `Dog` class that does these things.

```ruby
# lib/dog.rb
class Dog
  attr_reader :name,
              :age,
              :breed,
              :hungry

  def initialize(name, age, breed)
    @name   = name
    @age    = age
    @breed  = breed
    @hungry = true
  end
end
```

Let's check briefly to see if this class does what we expect. For now, we'll use a runner file to check to to see what we can do with this class that we built.

```ruby
# runner.rb
require './dog'

fido = Dog.new("Fido", 4, "Poodle")
puts dog.name
puts dog.age
puts dog.breed
puts dog.hungry
```

Run this file by typing `ruby runner.rb` at your terminal. Does it do what you expect? Great! We're on our way!

### Add Some Behaviors

In addition to the attributes that our dog has, we want to see if we can add some behaviors. In this particular case, let's see if we can make it so that our dogs can bark and eat. `#bark` will print a message to the terminal, while `#eat` will make it so that our dog is no longer hungry. We might implement it by adding the following methods to our `Dog` class.

```ruby
# lib/dog.rb
class Dog
  # Existing attr_readers and initialize.

  def bark
    puts "Woof!"
  end

  def eat
    @hungry = false
  end
end
```

Let's add to our existing runner file to see how these new methods work.

```ruby
# runner.rb
require './dog'

fido = Dog.new("Fido", 4, "Poodle")
puts dog.name
puts dog.age
puts dog.breed
puts dog.hungry
dog.bark
dog.eat
puts dog.hungry
```

Is our output what we expected? Yes? Great!

## Create a Person Class

Now, let's try to get our `Person` class started. Update the runner file to include the following code:

```ruby
# runner.rb
require './lib/dog'
require './lib/person'

# existing dog method calls

jonah = Person.new("Jonah", 34)
puts jonah.name
puts jonah.age
jonah.say("Hello!")
```

What happens now when you run your runner file? Everything still good? No? Well, let's go create that `Person` class!

With a partner, create a `Person` class.

```ruby
# lib/person.rb

# YOUR CODE HERE!
```

How did it go? Let's share!

## Allow People to Own Dogs

Let's add to our runner file to make it so that a person can own some dogs.

```ruby
# runner.rb
require './lib/dog'
require './lib/person'

# Existing `Dog` and `Person` method calls.

jonah.buy(fido)
puts jonah.dogs
```

As a whole group, let's walk through what we need to change in our code to allow this to happen.

1) Add a collection of dogs to our `Person` class. Add a method `#buy` that takes an *instance* of dog as an argument and adds that dog to the collection of dogs.

```ruby
# lib/person.rb
class Person
  attr_reader :name,
              :age,
              :dogs

  def initialize(name, age)
    @name = name
    @age  = age
    @dogs = []
  end

  def say(phrase)
    puts phrase
  end

  def buy(dog)
    @dogs << dog
  end
end
```

## Allow People to Feed their Dogs

Now let's see if we can make it so that people can feed their dogs.

Add the following lines to your runner file.

```ruby
# runner.rb
require './lib/dog'
require './lib/person'

# Existing dog and person method calls.

jonah.dogs.each do |dog|
  puts "#{dog.name} is hungry? #{dog.hungry}"
end

jonah.feed_dogs
puts "Fed the dogs."

jonah.dogs.each do |dog|
  puts "#{dog.name} is hungry? #{dog.hungry}"
end
```

With a partner, see if you can implement the code to make the runner file run successfully with the output you would expect.


## Change Runner File to Test File (if time allows)

Isn't it a pain to keep running this file to make sure it's outputting what we expect? What could we do instead? That's right, test!

### Minitest Setup

```ruby
# test/dog_test.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/dog'

class DogTest < Minitest::Test
  def test_it_exists
    dog = Dog.new("Missy", 14, "Chihuahua")

    assert_instance_of Dog, dog
  end

  def test_it_has_a_name
    dog = Dog.new("Missy", 14, "Chihuahua")

    assert_equal "Missy", Dog.name
  end

  def test_it_has_an_age
    dog = Dog.new("Missy", 14, "Chihuahua")

    assert_equal 14, Dog.age
  end

  def test_it_has_a_breed
    dog = Dog.new("Missy", 14, "Chihuahua")

    assert_equal "Chihuahua", Dog.breed
  end
end
```

Can you implement tests for our Person class?

## Share
