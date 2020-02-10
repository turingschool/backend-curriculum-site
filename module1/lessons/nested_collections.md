---
title: Nested Collections
length: 60
tags: ruby, hashes, data structures
---

## Learning Goals

* Use multiple types of collections intermingled
* Apply common hash and array methods
* Describe strategies for navigating nested collections

## Vocabulary
* Key & Value: a paired combination of pieces of data that exist in a hash (think dictionary)
* Element/Item: a piece of data within an array
* Collection: a container for 0 or more pieces of data
* Data Structure: a data organization/storage format that allows for efficient retrieval and modification of pieces of data
* Nested Array: an array that exists as an element within another (outer) array
* Nested Hash: a hash that exists as either an element in an array OR the value of a key within another hash

## Slides

Available [here](../slides/nested_collections)

## WarmUp

With a partner find answers to the following.
First, try to answer without using pry, then use pry to verify.

`animals = {"dogs" => 3, "cats" => 5, "iguanas" => 2}`
* Using the above animals hash, how would you do the following
   * return the amount of dogs
   * add 3 parakeets
   * increase the amount of cats by 2

`pet_names = ["Fela", "Spot", "Patch", "Willy"]`
* Using the above pet_names array, how would you do the following
   * add "Claude"
   * access which name is first in the list
   * access which name is last in the list
   * remove "Fela" from the list

### Hash and Array Nesting

As our programs get more complex, we'll sometimes encounter more sophisticated combinations of these structures. Consider the following scenarios:

#### Array within an Array

```ruby
numbers = [[1, 2, 3], [4, 5, 6]]
```
**Turn and Talk**
* what is `numbers.count`
* what is `numbers.first.count`
* how can I access the element `5`
* how can I add `[7,8,9]` to the numbers array

#### Hashes within an Array

```
food_feelings = [{:pizza => "tasty"}, {:calzone => "also tasty"}]
```
**Turn and Talk**
* what is `food_feelings.count`
* what is `food_feelings.first.count`
* how can I access the element `"also tasty"`
* how can I change `also tasty` to `super delicious`

#### Hash within a Hash

```
pets = {:dog => {:name => "Chance", :weight => "45 pounds"},
        :cat => {:name => "Sassy", :weight => "15 pounds"}}
```
**Turn and Talk**
* what is `pets.count`
* what is `pets.keys`
* what is `pets.values`
* how can I access the element `"15 pounds"`
* how can I add `:age => 3` to the value of the key `:dog`

#### Array within a Hash
```
pizza_toppings = {veggies: ["green peppers", "jalapeño", "mushrooms"],
                  protein: ["pepperoni", "sausage", "sardines"],
                  fruit: ["pineapple"]}
```

**Turn and Talk**
* What is `pizza_toppings.count`
* What is `pizza_toppings.values`
* How can I access the element `"pineapple"`
* How can I add the element `"olives"` to the key `"veggies"`

## Practice

### 1: State Capitals

You have 2 hashes, one which maps state names to state abbreviations,
and one which maps state abbreviations to their capital:

```ruby
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
* Level 5: Write some code to turn these two hashes into one nested hash which looks like this:

    ```ruby
    state_info = {
       "Oregon" => {abbreviation: "OR", capital: "Salem"},
       "Alabama" => {abbreviation: "AL", capital: "Montgomery"},
       "New Jersey" => {abbreviation: "NJ", capital: "Trenton"},
       "Colorado" => {abbreviation: "CO", capital: "Denver"}
      }
    ```

### 2: Age Ordering

You have age data for a group of people:

```ruby
ages = [
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

## More Practice

Break into small groups based on how far you've worked on the "collections" exercises from the [ruby-exercises](https://github.com/turingschool/ruby-exercises):

1. Finished all exercises
1. Finished "nested_collections"
1. Finished "arrays" and "hashes"
1. Working on "arrays" and "hashes"

Find a partner in your group and work on the exercises.


## Homework

* Complete the `data-types/collections` exercises in [ruby-exercises](https://github.com/turingschool/ruby-exercises)
