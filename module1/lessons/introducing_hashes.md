---
layout: page
title: Introducing Hashes
length: 90
tags: ruby, hashes, data structures
---

## Learning Goals

*   Understand that there are multiple types of collections
*   Develop a mental model to understand hashes
*   Gain some familiarity with common hash methods

## Vocabulary

* Hash
* Key
* Value
* Symbol
* Mutable/Immutable
* Accessing Values
* Assigning Values

## WarmUp

[Ruby Doc](http://ruby-doc.org/core-2.4.2/Hash.html) defines a hash as "a dictionary-like collection of unique keys and their values. Also called associative arrays, they are similar to Arrays, but where an Array uses integers as its index, a Hash allows you to use any object type."

* What information can you tease from this definition?

## Intro - Hash Properties

Hashes are the second most important data structure in Ruby. Like an Array, a Hash is a data structure used for representing a _collection_ of things. But whereas an Array generally represents a list of ordered, indexed values, **a Hash represents a collection of *named* values**. These names are called **keys**, and each key has a corresponding **value**. In a Hash, we can insert data by assigning it to a name and later retrieving it using the same name.

Some languages call their Hashes *dictionaries* for this reason -- you look up a word (the label) to retrieve its definition (the data or value with which the label was associated).

Key ideas:

*   Ordered vs. Unordered
*   Pairs
*   Determinism and uniqueness
*   Choosing a hash vs an array
*   Performance characteristics

## Working with a Hash

Hashes boil down simply to a collection of **key/value** pairs.

Keys must be unique.

Keys and Values can be any data type (including arrays and hashes).

Let's say we are making a stew. The ingredients for our stew are:

* 2 Onions
* 5 Carrots
* 1 Chicken

Why is a hash a good choice for storing this information?

**TRY IT**: With your partner, brainstorm another collection of data that could be stored in a hash.

### Creating a Hash

```ruby
new_hash = {}
```

_or_

```ruby
new_hash = Hash.new
```

When using the `Hash.new`, syntax, we're able to pass a default hash value in as a parameter to `new`.

```ruby
new_hash = Hash.new(0)
```

In the above declaration, the default value of any key created for `new_hash` has a default value of 0. Keep this in mind for the future - you may find it helpful down the road.

We can also create a hash with some initial key/value pairs. Let's use this syntax to create our ingredients hash:

```ruby
ingredients = {
  "onions" => 2,
  "carrots" => 5,
  "chicken" => 1
}
```

The `=>` is called a hash rocket.

### Accessing the Hash

We use brackets `[]` to access the hash just like arrays, only we don't use indexes, we use keys. 

```ruby
ingredients["onions"]
=> 2
```

We can create a new key/value pair like this:

```ruby
ingredients["potatoes"] = 2
```

Do we need any peppers for the stew? Let's check:

```ruby
ingredients["peppers"]
=> nil
```

Oops, we forget Jeff is coming to dinner tonight and he doesn't like onions too much. Let's decrease the amount of onions by 1.

```ruby
ingredients["onions"] = ingredients["onions"] - 1
```
or
```ruby
ingredients["onions"] -= 1
```

Remember, keys/values can be any type of object.

```ruby
ingredients[8] = "this value is a string"
=> "this value is a string"
ingredients[true] = 1.5
=> 1.5
ingredients
=> {
  "onions"=>2, 
  "carrots"=>5, 
  "chicken"=>1, 
  "potatoes"=>2, 
  8=>"this value is a string", 
  true=>1.5
}
```

In this code, we created a key with the Integer 8 with a value of the String "this value is a string". We also created a key with `true` with a value of the Float 1.5. 

We don't want these pairs in our hash, so let's get rid of them:

```ruby
ingredients.delete(8)
=> "this value is a string"
ingredients.delete(true)
=> 1.5
ingredients
=> {
  "onions"=>2, 
  "carrots"=>5, 
  "chicken"=>1, 
  "potatoes"=>2
}
```

**TRY IT**: Using pry, create a hash.  Give it some initial key/value pairs, add a new pair, change one of the values, and delete one of the key/value pairs.

#### Check for Understanding

* What is a Hash?
* What type of Objects can Hashes hold?
* How can you create a Hash?
* How can you add/change/remove a key/value pair?

## Symbols

In Ruby, symbols are basically Strings that can't change. You can recognize a symbol because it starts with a colon `:`. All of the following are symbols:

```ruby
:name   
:symbols_can_have_underscores
:"symbols can be in quotes"
```

Symbols are more efficient than strings because Ruby creates only one Object for each unique symbol. Two strings with the same value are still two separate Objects. This is illustrated in the following pry session:

```ruby
sym_1 = :this_is_a_symbol
=> :this_is_a_symbol
sym_2 = :this_is_a_symbol
=> :this_is_a_symbol
sym_1.object_id
=> 2166748
sym_2.object_id
=> 2166748
string_1 = "this is a string"
=> "this is a string"
string_2 = "this is a string"
=> "this is a string"
string_1.object_id
=> 70099504860860
string_2.object_id
=> 70099508726060
```

Symbols are also faster than strings because Ruby can determine if two symbols are equal by checking their object_id. Strings have to be compared character by character.

So if symbols are faster and more efficient than strings, why would we use strings? First of all, a string's value can change. Strings are *mutable*, whereas symbols are *immutable*. Second, symbol's have far fewer methods than strings.

Don't worry if this doesn't quite make sense yet. The important thing to understand is that strings are useful as variables. Symbols are useful as names. This makes symbols perfect for keys in hashes.

## Working with Hashes and Symbols

Let's recreate our ingredients hash using symbols instead of strings.

```ruby
ingredients = {
  :onions => 2,
  :carrots => 5,
  :chicken => 1  
}
```

Ruby gives us a handy shortcut for creating a hash with symbol keys:

```ruby
ingredients = {
  onions: 2,
  carrots: 5,
  chicken: 1  
}
```

These two definitions for our ingredients hash produce the exact same hash, however the second is the preferred syntax. Be careful... The colon must immediately follow the name of the key without any spaces in between.

Let's again add 2 potatoes:

```ruby
ingredients[:potatoes] = 2
```

Get the number of onions:

```ruby
ingredients[:onions]
=> 2
```

Check if we need peppers:

```ruby
ingredients[:peppers]
=> nil
```

And decrease the amount of onions by 1:

```ruby
ingredients[:onions] = ingredients[:onions] - 1
```
or
```ruby
ingredients[:onions] -= 1
```

If we want to see all of our keys/values...
```ruby
ingredients.keys
=> [:onions, :carrots, :chicken, :potatoes]
ingredients.values
=> [1, 5, 1, 2]
```

What type of Objects do these methods return?

#### Check for Understanding

* What is a symbol? How is it different than a String?
* What is the advantage of using a String? What is the advantage of using a Symbol? Which is better for Hashes?
* What is different about using symbols in Hashes?
* Describe some useful Hash methods. Where can you look to find more Hash methods?

## Pair Exercise

* Person `A` is in charge of reading the instructions
* Person `B` is in charge of working in pry (in such a way that their partner can see)
* You should be using symbols for the keys in this exercise

### Steps

1. Create a hash called `new_band`.
2. Add a bassist to your `new_band` hash.
3. Find the name of your bassist by accessing the `:bassist` key in the `new_band` hash.
4. Find the value attached to `:vocalist` in your hash.
5. Add a vocalist to your hash.
6. Add a drummer to your hash.
7. Get all the keys in your Hash. What kind of object does that method return?
8. Get all the values in your Hash. What kind of object does that method return?
9. Assign a new value to the `:vocalist` key of your hash.
10. How has `keys` changed after the last step? How has `values` changed? What

## Independent Work

Finally let's break up for some independent work with Hashes and Arrays.

### Hash and Array Nesting

Remember, keys/values can be any type of object, including Hashes and Arrays!

As our programs get more complex, we'll encounter more sophisticated combinations of these structures. Consider the following scenarios:

#### Array within an Array

```ruby
a = [[1, 2, 3], [4, 5, 6]]
```

* what is `a.count`?
* what is `a.first.count`?
* how can I access the element `5`?

#### Hash within an Array

```ruby
a = [{pizza: "tasty"}, {calzone: "also tasty"}]
```

* what is `a.count`
* what is `a.first.count`
* how can I access the value `"also tasty"`

#### Hash within a Hash

```ruby
h = {
  dog: {
    name: "Chance",
    weight: "45 pounds"
  },
  cat: {
    name: "Sassy",
    weight: "15 pounds"
  }
}
```

* what is `h.count`?
* what is `h.keys`?
* what is `h.values`?
* how can I access the value `"15 pounds"`?

## Wrap Up

* Create a Venn Diagram of Arrays & Hashes. Think about how they're structured, when you would use each one, and nuances to how you interact with each one.

## Further Practice

### Ruby Docs

Get familiar with the Ruby Docs on [Hashes](https://ruby-doc.org/core-2.4.0/Hash.html)

### Practicing with Hashes and Nesting

Now that we've worked through the basics, complete [Challenge 2 from the Collections Challenges](https://github.com/turingschool/challenges/blob/master/collections.markdown#2-state-capitals)

### From the Top

Now you've got a decent understanding of hashes. Let's go at it from the
beginning and try to fill a few of the gaps: work through the [Hashes section of Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#8.-hashes) to pickup a bit more.