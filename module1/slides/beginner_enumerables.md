# Beginner Enumerables

---

# `#map` and `#collect`

* Iterates over an array
* Returns a new array
* Elements in the new array are based on the code in the block

```ruby
numbers =* 1..4

doubled = numbers.map do |num|
  num * 2
end

doubled
# => [2, 4, 6, 8]
```

---

# `#find` and `#detect`

* Iterates over an array
* Returns the first match it finds

```ruby
numbers =* 1..4

first_even = numbers.detect do |number|
  number.even?
end

first_even
# => 2
```

---

# `#find_all` and `#select`

* Iterates over an array
* Returns *all* matches it finds

```ruby
numbers =* 1..4

all_evens = numbers.select do |number|
  number.even?
end

all_evens
# => [2, 4]
```

---

# With a Pair

* Complete [this](https://github.com/turingschool-examples/beginner_enums/) exercise.
* Work on the `#find`, `#select`, and `#map` files in the exercises directory of [this](https://github.com/turingschool/enums-exercises) repo.
