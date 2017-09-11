---
title: Class Methods
length: 60min
tags: ruby, class methods, OOP
---  


## Learning Goals  
*   
*  
* 

## Structure  
5 min - Warm Up  
20 min -   
5 min - Break  
20 min -  
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

## Classes 

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

** break **

## Class Methods 
Okay, so classes are objects too. But what does this mean in practice? How do you use a Class object? 

### Class Methods vs Instance Methods
```ruby
# user.rb

class User

  def self.describe_yourself
    "I'm the User class! I don't have a name."
  end

  def initialize(name)
    @name = name
  end

  def describe_yourself
    "I'm a User! My name is #{@name}"
  end
  
end

# pry 
reqiure "./user.rb"

User.describe_yourself
=> "I'm the User class! I don't have a name." 

tanya = User.new("Tanya")
tanya.describe_yourself
=> "I'm a User! My name is #{@name}"
```

**Turn & Talk** 
How do you define a class method? How do you call a class method? 

### Uses of Class Methods  

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
   users << User.from_csv(row)
end 

users << User.new("Tanya","tanya@email.com", "8293 Colorado Blvd, Denver, CO 89374")

puts users

```

### Independent Practice
Suppose you are collecting Jokes for a joke telling app. Create a Joke class so that you can load information via .new, .from_hash, & .from_csv. Expect jokes to use an id, a question, and an answer  


## Wrap Up  
* What is the difference syntactic between class methods & instance methods? 
* Why might you use a class method instead of an instance method? 


## Additional Resources

[Class Methods Review w/ Launch School](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2)  
[Dig Deeper On Class Methods w/ ThoughtBot] (https://robots.thoughtbot.com/meditations-on-a-class-method)