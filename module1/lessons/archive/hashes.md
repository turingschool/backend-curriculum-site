---
layout: page
title: Hashes
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
* Accessing Values
* Assigning Values


## Hashes

## WarmUp
* What do you know about different data structures? When and how do you use them? 

### Intro - Hash Properties

Hashes are the second most important data structure in Ruby. Like an Array, a Hash is a data structure used for representing a _collection_ of things. But whereas an Array generally represents a **list** of things (ordered, identified by numeric position), we use a Hash to represent a collection of *named* values. These names are often called `keys` or `attributes`. In a Hash, we can insert data by assigning it to a name and later retrieving it using the same name.

Some languages call their Hashes *dictionaries* for this reason -- you look up a word (the label) to retrieve its definition (the data or value with which the label was associated).

Key ideas:

*   Ordered vs. Unordered
*   Pairs
*   Determinism and uniqueness
*   Choosing a hash vs an array
*   Performance characteristics

### Working with a Hash

Hashes boil down simply to a collection of key/value pairs.

Keys must be unique.

Values can be any data type (including arrays and hashes).

#### Creating a Hash

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

#### Hash Keys

Let's imagine needing to store the specifications of different television models as a hash. Each individual tv's specifications, or values, will be unique to it, but all televisions share the same attributes.

Let's imagine all of our tv hashes will store information for their `screen_size`, `price`, and `brand`.

A simple example of a television modeled as a hash:

```ruby
new_tv = {
  "screen_size" => 50,
  "price" => 300,
  "brand" => "Samsung"
}
```

Take a note of the syntax there. You'll likely come across it down the road.

How does that differ from the following syntax?

```ruby
new_tv = {
  screen_size: 50,
  price: 300,
  brand: "Samsung"
}
```

There are a variety of ways to structure your hash's syntax, but the above is the most preferred.

Rather than using strings as keys, we're using **symbols**.

A symbol, on its own, looks like this: `:symbol`.

In Ruby, strings are compared character by character, but symbols are compared by their `object_id`.
Thus, symbols help your code run faster.

#### Accessing Hash Values

What did we use to access the values in an array?

The information contained within a hash is unordered, so we cannot rely on the value's position to access it.

While we don't have indexes, we do have keys!

__.keys__

Ah, `.keys`. Our first hash method.

Within our same pry session, let's run `new_tv.keys`. What do we get? What data type is this returned value?

__.values__

Just like we used `.keys`, let's try out `.values`. Wow, what useful information!

__Getting by Key: `[]`__

In theory, if we know the keys we've set in our hash, accessing their values is quite simple.

Let's access the `screen_size` of our `new_tv`.

What happens if we access `screen_size` as a string instead of a symbol?

What happens if we retrieve a value from a key that does not exist?

__Setting by Key: `[]=`__

Let's change our `new_tv`'s `screen_size` to 60.

Let's add a new attribute to our tv, `resolution` and set that equal to "720p".

## Pair Exercise

For this exercise you'll work in pairs.

* Person `A` is in charge of reading the instructions
* Person `B` is in charge of working in pry (in such a way that their partner can see!)

Start with an empty `beads` hash in space and pry. You'll be storing new instances of a `Bead` to this hash.

For the pry person, recall that you can create a simple `Bead` model like this:

```ruby
class Bead
end
```

### Steps

1. Insert a "blue" bead `beads[:blue] = Bead.new`
2. Find the value attached to the key `:blue`
3. Find the value attached to the key `:green`
4. Add a new bead referenced by the key `:green`
5. Add a new bead referenced by the key `:purple`
6. What are the `keys`? What kind of object does that method return?
7. What are the `values`? What kind of object does that method return?
8. What's interesting about the order of the return value of both `keys` and `values`?
9. Add a new bead referenced by the key `:green`
10. How has `keys` changed after the last step? How has `values` changed? What
was lost?

## Independent Work

Finally let's break up for some independent work with Hashes and Arrays.

### Hash and Array Nesting

As our programs get more complex, we'll sometimes encounter more sophisticated combinations of these structures. Consider the following scenarios:

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
* how can I access the valued `"15 pounds"`?

## WrapUp
* Create a Venn Diagram of Arrays & Hashes. Think about how their structured, when you would use each one, and nuances to how you interact with each one. 


## Further Practice

### Ruby Docs

Get familiar with the Ruby Docs on [Hashes](https://ruby-doc.org/core-2.4.0/Hash.html)

### Practicing with Hashes and Nesting

Now that we've worked through the basics, complete [Challenge 2 from the Collections Challenges](https://github.com/turingschool/challenges/blob/master/collections.markdown#2-state-capitals)

### From the Top

Now you've got a decent understanding of hashes. Let's go at it from the
beginning and try to fill a few of the gaps: work through the [Hashes section of Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#8.-hashes) to pickup a bit more.
