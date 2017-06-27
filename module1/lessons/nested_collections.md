---
title: Hashes
length: 90
tags: ruby, hashes, data structures
---

## Learning Goals

* Understand that there are multiple types of collections
* Develop a mental model to understand nested hashes and arrays
* Use common hash methods

## Structure  
5min - WarmUp  
20min - Nested Data Sets   
5min - break
20min - Practice with Hashes and Nesting  
5min - WrapUp

### WarmUp  
animals = {"dogs" => 3, "cats" => 5, "iguanas" => 2} 
*  Using the above animals hash, how would you do the following
  *  

### Hash and Array Nesting

As our programs get more complex, we'll sometimes encounter more sophisticated combinations of these structures. Consider the following scenarios:

#### Array within an Array

```
a = [[1, 2, 3], [4, 5, 6]]
```

* what is `a.count`
* what is `a.first.count`
* how can I access the element `5`

#### Hash within an Array

```
a = [{:pizza => "tasty"}, {:calzone => "also tasty"}]
```

* what is `a.count`
* what is `a.first.count`
* how can I access the element `"also tasty"`

#### Hash within a Hash

```
h = {:dog => {:name => "Chance", :weight => "45 pounds"},  
     :cat => {:name => "Sassy", :weight => "15 pounds"}}
```

* what is `h.count`
* what is `h.keys`
* what is `h.values`
* how can I access the element `"15 pounds"`

### Practicing with Hashes and Nesting

Now that we've worked through the basics, complete [Challenge 2 from the Collections Challenges](https://github.com/turingschool/challenges/blob/master/collections.markdown#2-state-capitals)

### From the Top

Now you've got a decent understanding of hashes. Let's go at it from the
beginning and try to fill a few of the gaps: work through the [Hashes section of Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#8.-hashes) to pickup a bit more.
