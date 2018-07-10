# Introducing Hashes

---

# Warmup

[Ruby Doc](http://ruby-doc.org/core-2.4.2/Hash.html) defines a hash as "a dictionary-like collection of unique keys and their values. Also called associative arrays, they are similar to Arrays, but where an Array uses integers as its index, a Hash allows you to use any object type."

* What information can you tease from this definition?
* What else do you know about hashes?

---

# Dictionary-Like/Keys & Values

* Hashes allow us to store/look up values by keys of our choosing.
* In a dictionary the keys would be words and the values definitions.
* A hash would allow us to store all of those words out of order and still be able to find their definitions.

---

# Key Value Pairs

* Collection of key/value pairs
* Key must be unique
* Values can be any object (including other arrays and hashes)

---

# Syntax

```ruby
new_hash = {}
# Different syntax
new_hash = Hash.new
# Different syntax with default value
new_hash = Hash.new(0)
```

---

# Key Syntax: Hash Rockets

```ruby
old_tv = {
  "screen size" => 50,
  "price" => 300,
  "brand" => "Samsung"
}
```

---

# Key Syntax: Symbols

```ruby
new_tv = {
  screen_size: 50,
  price: 300,
  brand: "Samsung"
}
```

---

# Advantages of Using Symbols

* Strings are compared character by character
* Symbols are compared by their `object_id`
* Symbols help your code run faster

---

# Accessing Attributes by Keys

* Symbols by themselves (outside a key/value pair) look like this: `:brand`

```ruby
old_tv.keys
old_tv.values
old_tv["screen size"]
old_tv["brand"]

new_tv.keys
new_tv[:screen_size]
new_tv[:price]
```

---

# Adding Key/Value Pairs

```ruby
new_tv[:resolution] = "720p"
new_tv
```

---

# Pair Exercise

* See instructions in lesson plan

---

# Wrap Up

* What is a symbol? How is it different than a String?
* What is the advantage of using a String? What is the advantage of using a Symbol? Which is better for Hashes?
* What is different about using symbols in Hashes?
* Describe some useful Hash methods. Where can you look to find more Hash methods?


