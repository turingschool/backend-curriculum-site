---
layout: page
title: Intro to OOP
length: 60
tags: ruby, classes, objects
---

## Learning Goals

* Define classes with instance variables in Ruby
* Explain 'state' and 'behavior' in the context of Ruby/OOP
* Explain Abstraction in the context of Ruby Objects
* Identify that you can iterate over Ruby Objects to accomplish a goal

## Vocabulary
* Object Oriented Programming (OOP) 
* Object
* Abstraction 
* Encapsulation

## Slides

Available [here](../slides/intro_to_oop)

## Warmup

* Write down two classes of things (e.g. `Classroom`), and for each class write down two instances of that class (e.g. `bem1_classroom`)
* For each class of thing, write down some attributes that might distinguish one instance from another (e.g. `tables`, `chairs`, `length`, `width`, `height` `pairing_stations`)

## Lesson

#### Using Related Methods

Let's start with our `Classroom` class from yesterday. Remember a class is an abstract representation of a real world thing/concept.

Now, if we want to create a method `#volume`, we can use the `#area` method as a starting point. Let's do that. 
In our runner file:

```ruby
# classroom_runner.rb
require './classroom'

classroom_a = Classroom.new(10, 5, 20)
puts classroom_a.area
puts classroom_a.length
puts classroom_a.volume
```
We get a no method error for volume, let's build that: 

```ruby
# classroom.rb
class Classroom
  attr_reader :length,
              :width,
              :height

  def initialize(length, width, height)
    @length = length
    @width  = width
    @height = height
  end

  def area
    length * width
  end

  def volume
    area * height
  end

  def add_length(feet)
    @length += feet
  end
end
```

In the `volume` method, `area` refers to the `area` method that is sitting in our class. We can refer to these methods much the same way we would variables.

Notice in the runner file we call this method just as we would any other.

#### Setting Default Values

Let's say that we knew that generally the ceilings in the basement were 20 feet, and that we would only want to define a height on the ceiling if we were creating a classroom that was an exception to that rule. We can set a default value for our `height` parameter using the syntax below:

Add the following lines to the bottom of your runner file:

```ruby
# classroom_runner.rb
standard_room = Classroom.new(15, 15)
short_room    = Classroom.new(15, 15, 10)

puts "Standard Heights: #{standard_room.height}"
puts "Short Height: #{short_room.height}"
```
We want to pass our Classroom class either two or three arguments when we initialize.

```ruby
# classroom.rb
class Classroom
  attr_accessor :length,
                :width,
                :height

  def initialize(length, width, height = 20)
    @length = length
    @width  = width
    @height = height
  end

  def area
    length * width
  end

  def volume
    area * height
  end

  def add_length(feet)
    @length += feet
  end
end
```

We should see that our standard room height is still 20, but our short room height is now the 10 that we passed to it.

#### Setting Initial State Without Parameters

One thing that's important to note is that we're making a decision here as programmers that we want someone to be able to pass a height, but if they don't we want to keep moving without a hiccup. We can also define instance variables that don't allow for user input. For example, let's assume we wanted to allow our classrooms to store the students that are in a classroom at any one time. Let's further assume that we want to have all of our classrooms start empty. We could indicate that in our code by updating our `Classroom` class as follows:
In our runner file:
```ruby
# classroom_runner.rb
standard_room = Classroom.new(15, 15)
short_room    = Classroom.new(15, 15, 10)

puts "Standard Room: #{standard_room.students}"
puts "Short Room: #{short_room.students}"
```

```ruby
# classroom.rb
class Classroom
  attr_accessor :length,
                :width,
                :height,
                :students

  def initialize(length, width, height = 20)
    @length   = length
    @width    = width
    @height   = height
    @students = []
  end

  def area
    length * width
  end

  def volume
    area * @height
  end

  def add_length(feet)
    @length += feet
  end
end
```

Now each classroom we create will be created with an empty array of students. 

**Turn & Talk**
What are the two methods of setting default values? 
How should you decide which method to use? 

How do we get students into this array? With a method!

Let's add that now.

```ruby
# classroom.rb
class Classroom
  attr_accessor :length,
                :width,
                :height,
                :students

  def initialize(length, width, height = 20)
    @length   = length
    @width    = width
    @height   = height
    @students = []
  end

  def area
    length * width
  end

  def volume
    area * @height
  end

  def add_length(feet)
    @length += feet
  end

  def add_student(student)
    @students << student
  end
end
```

What's this do? We use the shovel method to add a student that someone passes us into the `@students` array. Great!

#### Passing Objects to Other Objects

That seems great, but what can we do with it? And what is a student? Is a student just a name? ARE YOU JUST A NAME!? No!

Let's make our students into objects, a more fleshed out version of this abstract idea. To do that we create a student class to represent our students. For now it'll be pretty small since there's not much we need our student class to do.
In our runner:

```ruby
# classroom runner
require './classroom'
require './student'

classroom_a = Classroom.new(10, 5, 20)
puts classroom_a.area
puts classroom_a.length
puts classroom_a.volume

standard_room = Classroom.new(15, 15)
short_room    = Classroom.new(15, 15, 10)

puts "Standard Heights: #{standard_room.height}"
puts "Short Height: #{short_room.height}"

sal = Student.new("Sal")
ali = Student.new("Ali")
classroom_a.add_student(sal)
classroom_a.add_student(ali)
puts classroom_a.students
```
We get an uninitialized constant for Student error, which tells us that our program can't find the class we told it to look for. This may be because we haven't required the student.rb file, or perhaps we haven't build one yet. Here it's because we haven't built it yet. 

Let's go build that. `touch student.rb`

```ruby
#student.rb

class Student
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
```
Note we have explicitly decided to expose the @name instance variable by including an attr_reader. This is an example of Encapsulation at work, only exposing what needs to be accessed from the outside. 

Run the runner file again, and we shouldn't get any more errors.
That's fun, but how do we use these students in our new class?

#### Using Objects in Other Objects

Let's create a new method in our Classroom class that allows us to print a roster. Now we don't want to print those full Student objects, we just want to print their names. 

** Turn & Talk **  
How can we use the functionality we've already built on Student to print a roster of student names in Classroom?

And update our runner:

```ruby
# classroom runner
require './classroom'
require './student'

classroom_a = Classroom.new(10, 5, 20)
puts classroom_a.area
puts classroom_a.length
puts classroom_a.volume

standard_room = Classroom.new(15, 15)
short_room    = Classroom.new(15, 15, 10)

puts "Standard Heights: #{standard_room.height}"
puts "Short Height: #{short_room.height}"

sal = Student.new("Sal")
ali = Student.new("Ali")
classroom_a.add_student(sal)
classroom_a.add_student(ali)
puts classroom_a.students
classroom_a.print_roster
```
Let's build a print_roster method to satisfy the no method error:

```ruby
# classroom.rb
class Classroom
  attr_accessor :length,
                :width,
                :height,
                :students

  def initialize(length, width, height = 20)
    @length   = length
    @width    = width
    @height   = height
    @students = []
  end

  def area
    length * width
  end

  def volume
    area * @height
  end

  def add_length(feet)
    @length += feet
  end

  def add_student(student)
    @students << student
  end

  def print_roster
    @students.each do |student|
      puts student.name
    end
  end
end
```
Run our runner file, and... a list of student names!

## Practice

Start with your `Lunchbox` class from yesterday. Create an `add_snack` method that takes a snack as an argument and adds it to the contents of your lunchbox.

Create a snack class. Create a runner file that adds snacks to your lunchbox.

Create a method on your lunchbox class that will list its contents.

Feeling fancy? Update your Snack class to have a volume. Update the `add_snack` class of your Lunchbox class to monitor the remaining capacity of your lunchbox and reject any snack that would push the lunchbox beyond capacity.

## Summary

* What are some examples of classes and instances from everyday life?
* How would you define a `Person` class that had height, weight, and age attributes in Ruby?
* What are the two main responsibilities of an instance of an object in Ruby?
* How did we apply Abstraction and Encapsulation today? 
