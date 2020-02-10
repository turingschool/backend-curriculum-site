---
layout: page
title: Introducing Hashes
length: 120
tags: ruby, hashes, data structures, key, value
---

## Learning Goals

*   Explain the difference between arrays and hashes, and determine when to use which
*   Use common hash methods to access and update data in a hash

## Slides

Available [here](../slides/introducing_hashes)

## Vocabulary

* Hash
* Key
* Value
* Symbol
* Accessing Values
* Assigning Values

## Warm Up

What's problematic about using `fridge_items_1` as a grocery list? How would you prefer to structure a grocery list? Discuss with your partner.

```
fridge_items_1 = ["milk", "eggs", "eggs", "eggs", "eggs", "eggs", "eggs", "avocado", "avocado", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla", "tortilla"]
```

## Intro - Hash Properties

Like an Array, a Hash is a data structure used for representing a _collection_ of things. But whereas an Array generally represents a list of ordered, indexed values, **a Hash represents a collection of *named* values**. These names are called **keys**, and each key has a corresponding **value**. In a Hash, we can insert data by assigning it to a name and later retrieving it using the same name.

Some languages call their Hashes *dictionaries* for this reason -- you look up a word (the label) to retrieve its definition (the data or value with which the label was associated).

## Working with a Hash

- A hash is enclosed in curly braces { }, key/value pairs are separated by commas, and keys and values are separated by either a rocket or a colon.
- Each key in a hash must be unique
	- If you attempt to have duplicate keys when you first create a hash, you will get a `warning: key :key_name is duplicated and overwritten on line X` error
	- If you try to add a new key/value pair using a key that already exists, that new key/value pair will overwrite the previous one - dangerous.
- Keys and values can be any type of object:
	```
	example = {
		"string_value" => "this value is a string",
		"array_value" => ["this", "value", "is", "an", "array"],
		3 => "this values' key is an integer",
		"boolean_value" => true
	}
	```
- Values can be accessed with bracket notation:
	- given ``` shih_tzu = { "name" => "Sodie" } ```
	- ``` shih_tzu["name"]``` _returns_```"Sodie" ```

Let's say we are making a list of items to pack for a trip. Why is a hash a good choice for storing this information?

**THINK ABOUT IT**: With your partner, brainstorm another collection of data that could be stored in a hash. Be able to justify why a hash is a better option than an array.

**WRITE:** What is **your** definition of a hash?

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

In the above declaration, the default value of any key created for `new_hash` has a default value of 0. Keep this in mind for the future - you may find it helpful down the road🍕.

We can also create a hash with some initial key/value pairs. Let's use this syntax to create our stew hash:

```ruby
suitcase = {
  "socks" => 4,
  "jeans" => 1,
}
```

The `=>` is called a hash rocket.

### Hashes vs. Arrays

Let's take a few minutes to document the similarities and differences between arrays and hashes.

### Explore

With your partner, explore the following challenges. One partner should be typing _in a file_ (make sure the other can see the screen) and the other should talk. This is a paired programming technique called driver/navigator.

* Start with the hash: suitcase = { "socks" => 4, "jeans" => 1 }
* Add 3 shirts to your suitcase
* Add a key value pair of swimsuit/true to your suitcase
* Take the socks out of your suitcase
* Check for how many jackets you have in your suitcase
* Check how many shirts (and only shirts) are in your suitcase
* Call `.keys` and `.values` on your hash - what is returned? Why might this be useful?


### Accessing the Hash

We use brackets `[]` to access the hash just like arrays, only we don't use indexes, we use keys.

```ruby
suitcase["socks"]
=> 4
```

We can create a new key/value pair like this:

```ruby
suitcase["shirts"] = 3
```

```ruby
suitcase["swimsuit"] = true
```

Did we put any jackets on our list? Let's check:

```ruby
suitcase["jackets"]
=> nil
```

Oops, we forget that we added one day to our trip, so should probably bring an extra shirt.

```ruby
suitcase["shirts"] = suitcase["shirts"] + 1
```
or
```ruby
suitcase["shirts"] += 1
```

Remember, keys/values can be any type of object.

```ruby
suitcase[8] = "this value is a string"
=> "this value is a string"
suitcase[true] = 1.5
=> 1.5
suitcase
=> {
  "socks"=>4,
  "jeans"=>1,
  "shirts"=>4,
  8=>"this value is a string",
  true=>1.5
}
```

In this code, we created a key with the Integer 8 with a value of the String "this value is a string". We also created a key with `true` with a value of the Float 1.5.

We don't want these pairs in our hash, so let's get rid of them:

```ruby
suitcase.delete(8)
=> "this value is a string"
suitcase.delete(true)
=> 1.5
suitcase
=> {
  "socks"=>4,
  "jeans"=>1,
  "shirts"=>4,
}
```

Access all the keys or all the values from a hash:

```ruby
suitcase.keys
=> ["socks", "jeans", "shirts"]

suitcase.values
=> [4, 1, 4]
```

The `.keys` and `.values` methods return an array of all the keys and values, respectively, of the hash.

## Iterating Over a Hash

Turn and talk to the person next to you, if we had the following array - `clothes = ['jeans', 'socks', 'shirts']`, how would you print each value to the terminal?  Would your answer change if this array had 100 items of clothing in it?

Often we will want to iterate over a Hash to do something with each key/value pair.  This works a lot like iterating over an Array, with one small exception.  Take a look at the code snippet below and see if you can identify the difference between iterating over a Hash vs over an Array:

```ruby
suitcase.each do |clothing_item, quantity|
	p "I need #{quantity} #{clothing_item}"
end
```

Now, instead of having one block variable to work with, we have 2!  The first represents the key, and the second represents the value.


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

So if symbols are faster and more efficient than strings, why would we use strings? Because a string's value can change, making them useful as variables. Strings are *mutable*, whereas symbols are *immutable*.

Don't worry if this doesn't quite make sense yet. The important thing to understand is that strings are useful as variables. Symbols are useful as names. **This makes symbols perfect for keys in hashes.**

## Working with Hashes and Symbols

Let's recreate our suitcase hash using symbols instead of strings.

```ruby
suitcase = {
  :socks => 4,
  :jeans => 1,
}
```

Ruby gives us a handy shortcut for creating a hash with symbol keys:

```ruby
suitcase = {
  socks: 4,
  jeans: 1,
}
```

These two definitions for our suitcase hash produce the exact same hash, however the second is the preferred syntax. Be careful... The colon must _immediately_ follow the name of the key without any spaces in between.

### Solidify

Switch driver/navigator and complete the following (same as our last pairing exploration) using this hash: `suitcase = { socks: 4, jeans: 1 }`

For each bullet point, pay close attention to the _return value_ as well as the impact on the original hash (ie be ready to share out with the class!)

* Add 3 shirts to your suitcase
* Add a key value pair of swimsuit/true to your suitcase
* Take the socks out of your suitcase
* Check for how many jackets you have in your suitcase
* Check how many shirts (and only shirts) are in your suitcase
* Call `.keys` and `.values` on your hash - what is returned? Why might this be useful?

Add new key/value pair:

```ruby
suitcase[:shirts] = 3
suitcase[:swimsuit] = true
```

Remove key/value pair:

```ruby
suitcase.delete(:socks)
```

Access value of a specific key:

```ruby
suitcase[:jackets]
suitcase[:shirts]
```

Check keys/values:

```ruby
suitcase.keys
suitcase.values
```

#### Check for Understanding

* What is a symbol? How is it different than a String?
* What is the advantage of using a String? What is the advantage of using a Symbol? Which is better for Hashes?
* What is different about using symbols in Hashes?
* Describe some useful Hash methods. Where can you look to find more Hash methods?

## Pair Exercise

* Person `A` is in charge of reading the instructions
* Person `B` is in charge of working in a file (in such a way that their partner can see)
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
10. How has `keys` changed after the last step? How has `values` changed?

## Extension Practice

Finally let's break up for some independent work with Hashes and Arrays.

### Hash and Array Nesting

Remember, keys/values can be any type of object, including Hashes and Arrays!

As our programs get more complex, we'll encounter more sophisticated combinations of these structures. Make a prediction about each scenario, then run in a pry session to verify:

#### Array within an Array

```ruby
a = [[1, 2, 3], [4, 5, 6]]
```

* what is `a.count`?
* what is `a.first.count`?
* how can I access the element `5`?

#### Hash within an Array

```ruby
italian = [{ pizza: "tasty" }, { calzone: "also tasty" }]
```

* what is `italian.count`?
* what is `italian.first.count`?
* how can I access the value `"also tasty"`?

#### Hash within a Hash

```ruby
pets = {
  dog: {
    name: "Sodie",
    weight: "10 pounds"
  },
  cat: {
    name: "Sunshine",
    weight: "15 pounds"
  }
}
```

* what is `pets.count`?
* what is `pets.keys`?
* what is `pets.values`?
* how can I access the value `"15 pounds"`?

## Exit Ticket

You'll have 10 minutes to complete the exit ticket independently.

<!-- print out to ensure this is closed book
- In your own words, define a hash
- Venn Diagram of arrays and hashes
- Write a hash with 3 key/value pairs (assign to a new variable)
- Access the value of the first key/value pair
- Show how you would add a new key/value pair
- Delete any key/value pair of your choosing
- What is a symbol?
- for all of your examples, did you use symbols? If you did - re-write your original hash without symbols. If you didn't, re-write your original hash with symbols.
-  -->

## Further Practice/Resources

### Ruby Docs

Get familiar with the Ruby Docs on [Hashes](https://ruby-doc.org/core-2.4.0/Hash.html)

### Practicing with Hashes and Nesting

Now that we've worked through the basics, complete [Challenge 2 from the Collections Challenges](https://github.com/turingschool/challenges/blob/master/collections.markdown#2-state-capitals)

### From the Top

Now you've got a decent understanding of hashes. Let's go at it from the
beginning and try to fill a few of the gaps: work through the [Hashes section of Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#8.-hashes) to pick up a bit more.
