---
title: Class Methods
length: 60min
tags: ruby, class methods, OOP
---

## Learning Goals

* Explain the difference between class and instance methods.
* Use a class method to create instances of that class.
* Distinguish between class and instance methods with the same name.

## Agenda



## Vocabulary

* Instance Method
* Class Method

## Lesson

### Warm Up

```ruby
> sam = User.new("Sam")
# => #<User:0x007f94e3ab6218 @name="Sam">
> sam.say_hello("Jay")
# => "Hello, Jay!"
```

* What do we call the method `#say_hello` on? What do we call the method `::new` on?
* In the method list in the Ruby docs page for Array, what is the difference between methods with a `#` prefix and those with a `::` prefix?

### Discussion

Up to this point we have primarily used classes as factories for instances of that class. We define methods in our class, we store some state in our instance variables, we call `.new`, and then we can use them. In Ruby, classes are also objects themselves. We can call methods on classes the same way that we call methods on instances of that class (think about `.new`), the difference is how we define those methods.

### Exploration/Hedgehog Time

Using the following Hedgehog class, you'll be asked to work with your partner to make some predictions and record them on your worksheet.

```Ruby
class Hedgehog

  def initialize(name, age, allergies)
    @name = name
    @age = age
    @allergies = allergies
  end

  def invite_to_party
     "#{@name} is invited to the party!"
  end

  def self.confirm_attendee
    "Another hedgie is coming to the party!"
  end

  def check_for_allergies
    "Make sure to not serve any #{@allergies}."
  end

end
```

Once you have made your predictions, run the code and verify your predictions! If you finish before the class is brought back together, write your answers to the questions that are printed on the back of your worksheet.

#### Syntax & Uses

In order to define a class method, we prepend the method name with `self.`. So, for example, if we wanted to define a method called `say_hello` as a class method, we could do something like the following:

```ruby
class User
  def self.say_hello
    puts "Hello!"
  end
end
```

Then, in order to call that method we could use `User.say_hello`. Note that we don't have to create an instance of this class to do this.

Why would we do this? There are a number of pieces of functionality that we might want to ascribe to a Class over a specific instance of a class. We could use the class to track information about all instances of a class, or make it so that a class is in charge of creating instances of itself in those cases where creation is not as straightforward as calling `new` and passing some variables.

### Demo

For example, let's say that we wanted to create not just one instance of a User, but a collection of Users. We could certainly iterate over a collection of attributes and create a new instance of an object each time, but who's responsibility is it to do that work? We could do it in a runner file or in a class that was specifically responsible for setting up this collection of objects, *or* now that we have the syntax for a class method, we could assign that responsibility to the class itself and then return a collection of User objects.

```ruby
# user.rb
class User
  def initialize(name)
    @name = name
  end

  def self.create_multiple(users)
    users.map do |user|
      User.new(user[:name])
    end
  end
end

# runner.rb
users = [
    {name: "Sal"},
    {name: "Brian"},
    {name: "Megan"},
  ]

User.create_multiple(users)
```

### Practice

With your neighbor, see if you can create a House class that will return a collection of Houses when passed an array of hashes.

### Exploration

* What happens if you create a class method and an instance method with the same name?
* What happens if you call an instance method from within a class method?
* What about a class method from within another class method?
* How would you explain the difference between class and instance methods to someone else?
* Can you think of a metaphor for classes that includes a description of class and instance methods?

## Post It CFU

* Answer both questions assigned to your group
* Add your sticky to the chart of the board

## Additional Resources

[Class Methods Review w/ Launch School](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2)
[Dig Deeper On Class Methods w/ ThoughtBot](https://robots.thoughtbot.com/meditations-on-a-class-method)
