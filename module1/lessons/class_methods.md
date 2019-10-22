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

* What do we call the method `say_hello` on? What do we call the method `new` on?

### Discussion

Up to this point we have primarily used classes as blueprints for instances of that class.

We define methods in our class, we store some state in our instance variables, we call `.new`, and then we can use them.

In Ruby, classes are also objects themselves. We can call methods on full classes the same way that we call methods on instances of that class (think about `.new`), the difference is how we define those methods.

### Exploration

Using the following SocialMediaUser class, think about what you expect each method to return and why. If you have time, pseudocode what you think you'd do (in words/logic, not in code) to get that return value.

```ruby
class SocialMediaUser
  def initialize(id, rating)
    @id = id
    @rating = rating 
  end
  
  def rating
  end

  def self.most_popular
  end

  def add_post(post)
  end

  def self.find(id)
  end
end
```

What is the difference between these methods? 

#### Syntax & Uses

In order to define a class method, we prepend the method name with `self.`. So, for example, if we wanted to define a method called `say_hello` as a class method, we could do something like the following:

```ruby
class Greeter
  def self.say_hello
    puts "Hello!"
  end
end
```

Then, in order to call that method we could use `Greeter.say_hello`. Note that we don't have to create an instance of this class to do this.

Why would we do this? There are a number of pieces of functionality that we might want to ascribe to a Class over a specific instance of a class. We could use the class to track information about all instances of a class, or make it so that a class is in charge of creating instances of itself in those cases where creation is not as straightforward as calling `new` and passing some variables.


Look above at our SocialMediaUser class-- why do you think we defined `most_popular` and `find` as class methods and not instance methods? 

### Demo

For example, let's say that we wanted to create not just one instance of a User, but a collection of Users. We could certainly iterate over a collection of attributes and create a new instance of an object each time, but whose responsibility is it to do that work? We could do it in a runner file or in a class that was specifically responsible for setting up this collection of objects, *or* now that we have the syntax for a class method, we could assign that responsibility to the class itself and then return a collection of User objects.

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


### Exploration / CFU

* What happens if you create a class method and an instance method with the same name?
* What happens if you call an instance method from within a class method?
* What about a class method from within another class method?
* How would you explain the difference between class and instance methods to someone else?

## Practical Use, Experimentation

In Module 2, you will learn about databases and use a library to fetch things from a database. The following exercises will allow you to explore these ideas further to give you a better understanding of what's happening within your classes that interact with the database.

### Getting Started

Download the following CSV of popular baby names:

https://data.cityofnewyork.us/api/views/25th-nujf/rows.csv?accessType=DOWNLOAD

Place this CSV file in the same folder as a new Ruby script you'll call "name.rb"

In that name.rb, start with the following code:

```ruby
require 'csv'
require 'pry'

class Name
  attr_reader :year, :bio_gender, :ethnicity, :name, :count, :rank
  @@filename = 'Popular_Baby_Names.csv'

  def initialize(data)
    @year = 
    @bio_gender = 
    @ethnicity = 
    @name = 
    @count = 
    @rank = 
  end

  def self.find_by_name(name)
    rows = CSV.read(@@filename, headers: true)
    result = []
    
    # new code goes here
    
    result
  end

```

1. Add code to the `self.find_by_name` method, which builds an array of `Name` objects that match the name column from our CSV data.
  1. how many rows of data can you find for the following names:
    1. Ian, MEGAN, Sal, Omar, Riley, HUNTER
1. Build ONE alternative copy of `seld.find_by_name` for findind things specifically by another field, like `count`, `rank`, and `year`. These would be called, for instance, `self.find_by_year` etc.
1. Create a new class method called `self.where` which takes a hash of details, and builds an array of `Name` objects that match the CSV data. This method will need to copy the `CSV.read` line from our `self.find_by_name` method.
  1. The 'key' of the hash will be a symbol that matches the name of the column in the CSV file.
  1. For example, we might call `results = Name.where( { rank: "15" } )`
  1. how many rows of data can you find for:
    1. Rows with a rank of 25
    1. Rows with a bio_gender of male? of female?
    1. Rows with an ethnicity of "BLACK NON HISPANIC"?
1. Create a new class method called `self.order` which will allow us to sort data based on a hash of input.
  1. A use-case will look like `results = Name.order( { year: :asc } )`
    1. This would sort our CSV file by year in ascending order.
    1. What is the first row of data that comes back?
  1. A use-case will look like `results = Name.order( { name: :desc } )`
    1. This would sort our CSV file by name in descending order.
    1. What is the first row of data that comes back?
    
Extensions

1. How would you adapt your `.where` method to take multiple fields of data to match?
  1. For example, we might call `results = Name.where( { name: "Ian", rank: "15" } )`
1. How would you adapt your `.order` method to take multiple fields of data to sort?
  1. For example, we might call `results = Name.order( { ethnicity: :asc, name: :descending } )`

There are other methods that our database library would build for us including the following. Discuss with your partner how you would build these:

- select: takes a list of fields, and only populates Name objects with the fields you choose
  - example:
```ruby
result = Name.select(["name", "rank"])
p result.first
#<Name:0x00007fa22cfe7dd0 @year=nil, @bio_gender=nil, @ethnicity=nil, @name="Ian", @count=nil, @rank="24">
```
- limit: takes an integer parameter and returns only that many objects, eg `Name.limit(10)`
- average: takes a field name to average, returns a float, eg `Name.average("rank")`

**The `ActiveRecord` library will also build methods on-the-fly based on the attribute names.** If there is a field called "name" it will build a method called "find_by_name". If there is a field called "ethnicity", it will build a method called "find_by_ethnicity" and so on.

## Additional Resources

[Class Methods Review w/ Launch School](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2)
[Dig Deeper On Class Methods w/ ThoughtBot](https://robots.thoughtbot.com/meditations-on-a-class-method)
