# Intro to Scope

---

# Warmup

What will the following code snippet output?

```ruby
def print_vars(x, y)
  x = 12
  puts "x: " + x.to_s
  puts "y: " + y.to_s
end

x = 1
y = 5

print_vars(x, y)
print_vars(y, x)

x = 14

print_vars(x, y)

while x < 16
  puts x + y
  x += 1
end

puts x
```

---

# Global Scope

```ruby
# global_scope.rb
x = 10
puts "x is #{x}"
x += 20
puts "x is #{x}"
```

---

# Global Scope (continued)

```ruby
# global_scope.rb
x = 10
puts "x is #{x}"
x += 20
puts "x is #{x}"

def print_doubled_value(x)
  puts "double the value #{x} is #{x * 2}"
end

print_doubled_value(x)

y = 27
print_doubled_value(y)
```

---

# Global Scope (continued)

```ruby
# global_scope.rb

def print_doubled_value(x)
  orig = x
  x = x * 2
  puts "double the value #{orig} is #{x}"
  puts "inner x is now: #{x}"
end

print_doubled_value(x)
puts "outer x is still: #{x}"
```

---

# Global Scope (continued)

```ruby
a = 4
b = 12
def combine_variables(x)
  puts "inner x is: #{x}"
  puts "and outer b is: #{b}"
end
combine_variables(a)
```

---

# Blocks

```ruby
ingredients = ["flour", "water", "yeast", "salt"]
method = "measure"

def unit
  ["teaspoon", "cup", "pinch"].sample
end

ingredients.each do |ingredient|
  puts "#{method} one #{unit} #{ingredient}"
end
```

---

# Blocks with Overlapping Inner/Outer Variables

```ruby
new_ingredients = ["banana", "chocolate chips"]
temperature = 375
method = "bake"

new_ingredients.each do |ingredient|
  method = "mix"
  puts "#{method} the #{ingredient} at #{temperature} degrees"
end

puts method
```

---

## Summary

* Define scope in your own words
* What are some of the benefits of scope?
* What will the following code snippet output?

```ruby
def doubler(x)
  doubled = x * y
  puts doubled
end

def y
  2
end

x = 4

doubler(x)
```
