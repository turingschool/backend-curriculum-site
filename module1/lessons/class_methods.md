---
title: Class Methods
length: 60min
tags: ruby, class methods, OOP
---  


## Learning Goals  
*  explain the syntactic difference between class an instance methods 
*  explain when a developer might use a class method 
*  use a class method to create an instance 

## Structure  
5 min - Warm Up  
10 min - Class Methods as we know them
10 min - Class vs Instance Methods
5 min - Break  
10 min - Use of Class Methods  
10 min - Independent Practice 
5 min - Wrap Up

## Vocabulary  
* Class Methods 
* Class Variables

## Warm Up  
```ruby
> sam = User.new("Sam")
# => #<User:0x007f94e3ab6218 @name="Sam">
> sam.say_hello("Jay")
# => "Hello, Jay!"
```

* What do we call the method `#say_hello` on? What do we call the method `::new` on?
* In the method list in the Ruby docs page for Array, what is the difference between methods with a `#` prefix and those with a `::` prefix?

## Classes as we Know Them

**Turn & Talk**  
Turn to a partner and define what a class is. Explain how you use one and why. Try to incorporate as much of the technical language as you can. 

#### Uses for Classes 
* Factories for instances of a thing, creates the objects
* Hold blueprints.
    * Instance Variables (State)
    * Methods (Behavior)

#### Classes are Objects Too  
Imagine you are building out a database of users of your program.

```
# user.rb

class User 
   
end 


# pry
require "./user"

User 
=> User

User.object_id
=> 70334065129900 

users = User
=> User

users.object_id 
=> 70334065129900

tanya = User.new
tanya.object_id
=> 70334063539260
```

## Class Methods 
Okay, so classes are objects too. But what does this mean in practice? How do you use a Class object? 

### Class Methods vs Instance Methods
```ruby
# user.rb

class User

  def self.description
    "I'm the User class! I don't have a name."
  end

  def initialize(name)
    @name = name
  end

  def description
    "I'm a User! My name is #{@name}"
  end
  
end

# pry 
reqiure "./user.rb"

User.description
=> "I'm the User class! I don't have a name." 

tanya = User.new("Tanya")
tanya.description
=> "I'm a User! My name is #{@name}"
```

** break **

**Turn & Talk** 
How do you define a class method? How do you call a class method? 

### Use of Class Methods 
What if we are getting user data from disparate sources. Maybe some users are being ported in though a CSV of user data, others are coming in as JSON (think hash format), others are being created by signign up from an account and therefore our program is creating users directly. 
 

```ruby
# user.rb

class User

  def self.load_from_hash(user_info)	
  	name = user_info["name"]
  	email = user_info["email"]
  	address = user_info["address"]
	User.new(name, email, address)
  end
  
  def self.load_from_csv(user_info)
  	name = user_info[:name]
  	email = user_info[:email]
  	address = user_info[:address]
	User.new(name, email, address)
  end 

  def initialize(name, email, address)
    @name = name
    @email = email 
    @address = address
  end
  
end

# pry 
reqiure "./user.rb"

users = []

users << User.load_from_hash({"name" => "Ariana", "email" => "ariana@email.com", "address" => "1874 Market St, Denver CO 80203"})

CSV.foreach('./users.csv', headers: true, header_converters: :symbol) do |row|
   users << User.load_from_csv(row)
end 

users << User.new("Tanya","tanya@email.com", "8293 Colorado Blvd, Denver, CO 89374")

puts users

```

### Independent Practice
Suppose you are collecting Jokes for a joke telling application. Create a Joke class so that you can load information via .new, .from_hash, & .from_csv. Expect jokes to have an id, a question, and an answer as their state.  


## Wrap Up  
* What is the difference syntactic between class methods & instance methods? 
* Why might you use a class method instead of an instance method? 


## Additional Resources

[Class Methods Review w/ Launch School](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2)  
[Dig Deeper On Class Methods w/ ThoughtBot] (https://robots.thoughtbot.com/meditations-on-a-class-method)