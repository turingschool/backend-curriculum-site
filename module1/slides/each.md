# Each

---

# Warmup

* What do you notice about the code below?
* What issues could potentially crop up?
* Is there any alternative you could propose?

```ruby
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
puts students[0]
puts students[1]
puts students[2]
```

---

# \#each

```ruby
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
students.each do |student_name|
  puts student_name
end
```

---

# Generalized Pattern

```ruby
collection.each do |block_variable|
  # Code here runs for each element
end
```

---

# Transform a Collection

What will the code below print out?

```ruby
#playground.rb
names = ['megan', 'brian', 'sal']

names.each do |name|
  name.capitalize
end

puts names
```

---

# Each Doesn't Change the Original Array

---

# Transform a Collection (really)

```ruby
names = ['megan', 'brian', 'sal']

capitalized_names = []

names.each do |name|
  capitalized_names << name
end

puts capitazed_names
```

---

# Each is Versatile

---

# Get a Subset of a Collection

Walk through the code below with your partner.

```ruby
#playground.rb
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

odd_numbers = []

numbers.each do |number|
  if number.odd?
    odd_numbers << number
  end
end

puts odd_numbers

```

---

# Create Something New

Walk through the code below with your partner.

```ruby
#playground.rb
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

total = 0

numbers.each do |number|
  total += number
end

puts total
```

---

# with_index

Walk through the code below with your partner.

```ruby
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

doubled = []

numbers.each.with_index do |number, index|
  if index.odd?
    doubled << number * 2
  else
    doubled << number
  end
end

p doubled
```

---

# Single-Line Syntax

```ruby
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
students.each {|student_name| puts student_name }
```

---

# Practice

See lesson plan.
