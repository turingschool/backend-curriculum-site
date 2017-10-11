---
title: Hashes
length: 90
tags: ruby, hashes, data structures
---

## Learning Goals

* Understand that there are multiple types of data collections
* Explain a mental model to describe hashes
* Describe some common hash methods

## Structure

* 5 - WarmUp
* 25 - Together - Building a Hash
* 5 - Break
* 15 - Group Exercise
* 5 - WrapUp

## Vocabulary 
* Data Structure 
* Hash
* Key
* Value
* Reference 
* Assignment

## WarmUp
Make a T-Chart of the collections you are familiar with. Fill in what you know about each collection type you listed.

## Hashes

### Supplies

For this section, we'll walk through performing some common Hash operations both in code using IRB and in a physical model using some basic supplies.

You'll need these supplies:

1. 1 Black Velvet Bag
2. Piece of paper
3. 6 Beads
4. 6 Bead Labels  
   You'll need the following labels: blue, green, purple, red, orange, warm  
   Attach your labels to your beads

### Intro - Hash Properties

Hashes are the second most important data structure in Ruby. Like an Array, a Hash is a data structure used for representing a _collection_ of things. But whereas an Array generally represents a **list** of things (ordered, identified by numeric position), we use a Hash to represent a collection of *named* key-value pairs. Both keys and values can be any object type. In a Hash, we can insert data by assigning it to a key name and later retrieving it using the same key name.

Ruby stringifies `keys`, then uses a hashing algorithm to map the string to a data address where the `value` data is stored (data can be stored wherever memory is free; all `values` do not need to be in a contiguous block of memory). Look ups are more efficient for hashes than arrays because they only need to look at one memory location to get the `value` data. Iterating through a hash is less efficient than an array because the hashing algorithm is not efficient to reverse the hash back to the original stringified `key`, so it stores the string and the hash result and needs to use both for iteration.

Some languages call their Hashes *hash maps, maps, dictionaries, associative arrays, or symbol tables* because you look up a key to retrieve its definition (the data or value with which the label was associated). 

Key ideas:

* Ordered vs. Unordered
* Pairs
* Determinism and uniqueness
* Choosing a hash vs an array
* Performance characteristics

### Working a Hash

Now let's model some of the common hash operations in the physical space alongside an IRB session. As we go, we'll look at these common methods:

* `[]`     element reference
* `[]=`    element assignment
* `keys`   returns an array of all the keys
* `values` returns an array of all the values 

Follow along with the instructor as you walk through the following operations:

Create a bead class: 

```ruby
class Bead
  
  def initialize
  end
  
end
```

1. Create a new hash `beads = {}` or 'beads = Hash.new`
   * Write `beads` on your paper, this is your variable assigned to the hash we are making. Put your bag on your paper, this is your hash.  
2. Assign the key `blue`: `beads["blue"] = Bead.new`
   * Using your blue tag, attach it to a bead. Put the bead into the bag leaving the blue tag/key hanging out.   
3. Read the value: `beads["blue"]`
   * Pull the 'blue' tag. The blue tag is your key, bead is your value.
4. Store a second pair: `beads["green"] = Bead.new`
   * Using your "green" tag, attach it to a bead. Put the bead into your hash/bag, leaving they key/tag hanging out.
5. Reuse a key: `beads["blue"] = Bead.new`
   * Change what kind of blue bead you want. Take the blue tag off and re-attach it to a new bead.   
   * Note in IRB that the object ID is different for the first blue bead and the second blue bead.   
6. Create a key for nothing: `beads["purple"] = nil`
   * Hang a purple tag/key from your bag/hash, with no bead attached. 
7. I can everything in my bag/hash by calling `beads`; this returns the whole hash.
   * Grab all the tags, pull them all out
8. What if I want to do something with my keys, maybe I just want to see what keys are there. You can retrieve an array (a list) of keys by entering `beads.keys`.
   * Spread out your keys/tags and look at what keys you have. 
8. Retrieving an array (list) of `values` from the hash: `beads.values`
   * Spread out your values/beads and look at what values you have 
9. Get a little weird: We said you can have any object type as a value, perhaps an array - `beads["red"] = [Bead.new, Bead.new]` perhaps a collection of all my red beads. 
10. Get more weird: You can also have a hash as a value (nested hashes) `beads["warm"] = {"orange" => Bead.new, "red" => Bead.new}`  
    * This would be if you have a tag/key that is attached to your neighbor's hash/bag which had a orange and red bead in it.
11. Consider the key `"red"` and how it does and doesn't exist twice. What is different about the ways I need to access each of these reds?
12. Mess up your brain: `beads["spinning top"] = beads`

## Group Exercise

For this exercise you'll work in threes.

* Person `A` is in charge of reading the instructions
* Person `B` is in charge of the physical model - you'll need 3 more tags
* Person `C` is in charge of working in IRB (in such a way that the others can see!)

Start with an empty `beads` hash in both the physical space and in `pry`.

For the pry person, recall that you can create a simple `Bead` model like this:

```ruby
class Bead 
  def initialize(color)
     @color = color
  end
end
```

### Steps

1. Insert a "blue" bead `beads["blue"] = Bead.new("blue")`
2. Find the value attached to the key `"blue"`
3. Find the value attached to the key `"green"`
4. Add a new bead referenced by the key `"green"`
5. Add a new bead referenced by the key `"purple"`
6. What are the `keys`? What kind of object does that method return?
7. What are the `values`? What kind of object does that method return?
8. What's interesting about the order of the return value of both `keys` and `values`?
9. Add a new bead referenced by the key `"green"`
10. How has `keys` changed after the last step? How has `values` changed? What was lost?
11. As a group, update your data collection T-Chart to include new Hash info.


## WrapUp  
Create a Venn Diagram of Arrays and Hashes

## Additional Resources

Now you've got a decent understanding of hashes. Let's go at it from the
beginning and try to fill a few of the gaps: work through the [Hashes section of Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#8.-hashes) to pick up a bit more.
