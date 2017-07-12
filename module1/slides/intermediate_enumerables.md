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
[1, 2, 3, 4, 5].max
```

---

# Min

```ruby
[1, 2, 3, 4, 5].min
```

---

# Max/Min with Letters

```ruby
["ilana", "lauren", "beth"].min
```

---

# `#sort_by`

```ruby
people = [["Bob", 24], ["Dave", 26], ["Zayn", 30]]

people.sort_by do |person|
  person[1]
end
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

people = []
people << Person.new("Seema", 24)
people << Person.new("Faizah", 26)
people << Person.new("Zaahir", 30)
```

---

# `#max_by`/`#min_by` (setup)

```ruby
  people.max_by do |person|
    person.age
  end
```

---

# `#all?`/`#any?`

```ruby
all_adults = people.all? do |person|
  person.age > 21
end

any_zaahirs = people.any? do |person|
  person.name == "Zaahir"
end

one_seema = people.one? do |person|
  person.name == "Seema"
end

no_minors = people.none? do |person|
  person.age < 18
end
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
