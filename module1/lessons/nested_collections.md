---
title: Nested Collections
length: 60
tags: ruby, hashes, data structures
---

## Learning Goals

* Use multiple types of collections intermingled  
* Describe a mental model that represents nested hashes and arrays
* Apply common hash and array methods  

## Structure  
10min - WarmUp  
20min - Nested Data Sets   
20min - Practice with Hashes and Nesting  
5min - WrapUp

## Vocabulary 
* Collection
* Data Structure
* Nested Array
* Nested Hash

## WarmUp   
By yourself or with a partner find answers to the following.  
Try to answer without using irb or pry.  
animals = {"dogs" => 3, "cats" => 5, "iguanas" => 2}   
* Using the above animals hash, how would you do the following  
   * return the amount of dogs  
   * add 3 parakeets  
   * increase the amount of cats by 2   

pet_names = ["Fela", "Spot", "Patch", "Willy"]  
* Using the above pet_names array, how would you do the following  
   * add "Claude"  
   * access which name is first in the list  
   * access which name is last in the list  
   * remove "Fela" from the list

### Hash and Array Nesting

As our programs get more complex, we'll sometimes encounter more sophisticated combinations of these structures. Consider the following scenarios:

#### Array within an Array

```ruby
a = [[1, 2, 3], [4, 5, 6]]
```
**Agree/Disagree**
* what is `a.count`
* what is `a.first.count`
* how can I access the element `5`

#### Hashes within an Array

```
a = [{:pizza => "tasty"}, {:calzone => "also tasty"}]
```
**Agree/Disagree**
* what is `a.count`
* what is `a.first.count`
* how can I access the element `"also tasty"`

#### Hash within a Hash

```
h = {:dog => {:name => "Chance", :weight => "45 pounds"},  
     :cat => {:name => "Sassy", :weight => "15 pounds"}}
```
**Agree/Disagree**
* what is `h.count`
* what is `h.keys`
* what is `h.values`
* how can I access the element `"15 pounds"`

### Practicing with Hashes and Nesting  

### 1: State Capitals

You have 2 hashes, one which maps state names to state abbreviations,
and one which maps state abbreviations to their capital:

```
states = {"Oregon" => "OR",
          "Alabama" => "AL",
          "New Jersey" => "NJ",
          "Colorado" => "CO"}

capitals = {"OR" => "Salem",
            "AL" => "Montgomery",
            "NJ" => "Trenton",
            "CO" => "Denver"}
```

* Level 1: Write some code which given a state name ("Alabama") outputs the state abbreviation  
* Level 2: Write some code which given a state name ("Oregon") outputs
  its capital ("Salem")
* Level 3: Handle the case when a state's information is not known by
  returning "Unknown"
* Level 4: Let's go the other way. Given a capital name ("Denver"),
  return the state name for which it is the capital ("Colorado") 
* Levle 5: Write some code to turn these two hashes into one nested hash which looks like this: 
    ```
    state_info = { "Oregon" => {abbreviation: "OR", capital: "Salem"},
       "Alabama" => {abbreviation: "AL", capital: "Montgomery"},
       "New Jersey" => {abbreviation: "NJ", capital: "Trenton"},
       "Colorado" => {abbreviation: "CO", capital: "Denver"}
      }
    ```

### 2: Age Ordering

You have age data for a group of people:

```
data = [
  ['Frank', 33],
  ['Stacy', 15],
  ['Juan', 24],
  ['Dom', 32],
  ['Steve', 24],
  ['Jill', 24]
]
```

* Level 1: Write code that'll output the ages (and only the ages) for the data set   
* Level 2: Write code that'll output the names (and only the names) in order by
ascending age  
* Level 3: Output the name with the age, like `Juan (24)`  
* Level 4: Write code to automatically build a hash with the age as the key and
an array of names as the value (all the people who are that age).   
e.g. `{24 => ['Juan', 'Steve', 'Jill']...}`  


### From the Top

Now you've got a decent understanding of hashes. Let's go at it from the
beginning and try to fill a few of the gaps: work through the [Hashes section of Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#8.-hashes) to pickup a bit more.

### WrapUp  
*  What are three array methods and what do they do?  
*  What are three hash methods and what do they do? 
*  Describe a mental model for nested collections
