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

Hashes are the second most important data structure in Ruby. Like an Array, a Hash is a data structure used for representing a _collection_ of things. But whereas an Array generally represents a **list** of things (ordered, identified by numeric position), we use a Hash to represent a collection of *named* values. These names are often called `keys` or `attributes`. In a Hash, we can insert data by assigning it to a name and later retrieving it using the same name.

Some languages call their Hashes *dictionaries* for this reason -- you look up a word (the label) to retrieve its definition (the data or value with which the label was associated).

Key ideas:

*   Ordered vs. Unordered
*   Pairs
*   Determinism and uniqueness
*   Choosing a hash vs an array
*   Performance characteristics

## Working with a Hash

Hashes boil down simply to a collection of key/value pairs.

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
new_hash= Hash.new
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

**TRY IT**: With your partner, create a hash. Give it some initial key/value pairs, then add a new pair, and then change one of the values.

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

These two definitions for our ingredients hash produce the exact same hash, however the second is the preferred syntax.

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

What type of Object do these methods return?

**TRY IT**: With your partner, recreate your hash using symbols.

## Pair Exercise

For this exercise you'll work in pairs.

* Person `A` is in charge of reading the instructions
* Person `B` is in charge of working in pry (in such a way that their partner can see!)

### Steps

1. Create a hash called `new_band`.
2. Add a bassist to your `new_band` hash.
3. Find the name of your bassist by accessing the `:bassist` key in the `new_band` hash.
4. Find the value attached to `:vocalist` in your hash.
5. Add a vocalist to your hash.
6. Add a drummer to your hash.
7. What are the keys of your hash? What kind of object does that method return?
8. What are the values of your hash? What kind of object does that method return?
9. Assign a new value to the `:vocalist` key of your hash.
10. How has `keys` changed after the last step? How has `values` changed? What

## Independent Work

Finally let's break up for some independent work with Hashes and Arrays.

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
