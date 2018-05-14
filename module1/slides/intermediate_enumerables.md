# Intermediate Enumerables

---

# Warmup

* What's the difference between `#each` and `#map`?
* What do the following enumerables do? What do they return?
    * find/select
    * find_all/detect

---

# Max

```ruby
[1,3,9,2,5].max
=> 9
```

---

# Min

```ruby
[1,3,9,2,5].min
=> 1
```

---

# Max/Min with Letters

```ruby
  ["Brian", "Mike", "Amy"].min
  => "Amy"
```

---

# `#sort_by`

```ruby
people = [["Sofia", 4], ["Scarlett", 9], ["Stella", 8]]

sorted_people = people.sort_by do |person|
  person[1]
end

sorted_people
=> [["Sofie", 4], ["Stella", 8], ["Scarlett", 9]]
```

---

# `#max_by`/`#min_by` (setup)

```ruby
class Person
  attr_reader :name,
              :age

  def initialize(name, age)
    @name = name
    @age  = age
  end
end

kardashians = []

kardashians << Person.new("Kourtney", 39)
kardashians << Person.new("Kim", 37)
kardashians << Person.new("Kris", 62)
kardashians << Person.new("Khloe", 33)
```

---

# `#max_by`/`#min_by`

```ruby
  oldest_kard = kardashians.max_by do |person|
    person.age
  end

  oldest_kard
  => <Person:0x007fecd21740a0 @name="Kris", @age=62>
```

---

# `#all?`/`#any?`

```ruby
all_adults = people.all? do |person|
  person.age > 21
end

=> true

any_kims = people.any? do |person|
  person.name == "Kim"
end

=> true

one_kylie = people.one? do |person|
  person.name == "Kylie"
end

=> false

no_minors = people.none? do |person|
  person.age < 18
end

=> true
```

---

# Summary

What do the following methods do? What do they return?

* max/min
* max_by/min_by
* sort_by
* any?
* all?
* one?
* none?
