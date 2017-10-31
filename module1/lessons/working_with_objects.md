---
title: Working with Objects
length: 60 min
tags: ruby, objects, oop
---

## Learning Goals  
* describe an object 
* access information from one object in another object  

## Structure  
5 min - Warm Up  
20 min - What is an object?
5 min - Break  
20 min - Objects upon Objects upon Objects
5 min - Wrap Up

## Vocabulary  
* Object
* Instance Methods

## Warm Up  
* What is an object?  
* How do you access the state of an object?  
* How do you access an object from within another object?  

## What is an Object
#### Abstraction  
How we represent real world things and processes using code.  

#### Classes  
We build objects by using classes. A class can be thought of as an object blueprint.   

### Independent Practice  
Make a table class that takes two arguments - type & material 
Create 3 different table objects

```ruby 
dining_table = Table.new("dining", "wood")
``` 
Make a seat class that takes two arguments - type & material  
Create 3 different table objects 

```ruby 
armchair = Seat.new("stool", "metal")
```
#### Turn & Talk  
How did you make objects? What charactertistics does your table object have? What characteristics does your seat object have? 

** break **

## Objects upon Objects upon Objects 
### Sets of Objects  
You've made table and seat classes. How do we interact with them? Let's build out a furniture class.  

```ruby
furniture = Furniture.new
```  

Now I want to make it so my furniture holds a collection of table objects and can give us information about them.     

*  What are our options for holding collections?   
*  How can we add a table to that collection?   
*  What if we want to return a collection of types of tables?  

### Independent Practice  
Lets add the same functionality from above using seats. 

We want our furniture to hold a collection of seat objects.   

*  Create a collector to hold your seats  
*  Build a method that adds a seat to that collection   
*  Build a method that returns a collection of the materials of our seats. 

Extra Challenges:  

*  Make it so our material collection returns without any duplicates  
*  Build a method that returns the most common type of seat  
*  Build a method that sorts the seat materials alphabetically 

#### Turn & Talk  
Code Share: Share your implementation.   

*  What methods did you build?  
  *  What were they named?  
  *  How did they work? 

## Wrap Up  
* What is an object? 
* How do you access an object from within another object? 
* Why might you want to access an object from within another object?

