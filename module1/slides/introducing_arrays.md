# Introducing Arrays

---

# Warmup

[Ruby Doc](https://ruby-doc.org/core-2.4.2/Array.html) defines an array as "ordered, integer-indexed collections of any object."

* What information can you pull out of that definition?
* Looking at the other information on that page, what can you tell about arrays?

---

# Ordered

* Arrays store information in a particular order.
* Concepts like "first," "last," "fifth" apply to them.

---

# Integer-Indexed

* Because they are ordered, we can access items in an array by their position in the array.
* We use the term `index` to refer to this position.
* Arrays use integers to identify these positions.
* Arrays do not store values at an index of `2.5`, only at 2 or 3.

---

# Collection of Any Object

* Arrays are a way to store groups of things.
* Ruby does not care what types of things we store in Arrays.

---

# Overview: Fundamental Array Methods

* `[]`
* `count`
* `<<` / `push`
* `unshift`
* `insert`
* `pop`
* `shift`
* `shuffle`

---

# In IRB

```ruby
name_1 = "Josh"
name_2 = "Mike"
name_3 = "Lauren"

names = []
```

---

# Count

```ruby
names.count
```

---

# << / Push

```ruby
names << name_1
names.count
names
names.push(name_2)
name.count
names
```

Pick a way to add the third name to the names array.
Add your own name to the array without storing it to a varible beforehand.

---

# Unshift

```ruby
name_4 = "Jeff"
names.unshift(name_4)
names.unshift("Sal")
names.count
names
```

---

# []

```ruby
names[0]
names[3]
names[-1]
names.first
names.last
```

---

# []=

```ruby
names[2] = "Ilana"
names
names[1] = "Sal"
names
```

---

# Insert

```ruby
names.insert(2, "Victoria")
names
```

---

# Pop

```ruby
names
popped_name = names.pop
popped_name
names
```

---

# Shift

```ruby
names
shifted_name = names.shift
shifted_name
names
```

---

# Shuffle

```ruby
shuffled = names.shuffle
names
shuffled
```

---

# Each

```ruby
first_initial = []
names.each do |name|
  first_initial << name[0]
end

names
first_initial
```

---

# Summary

See lesson
