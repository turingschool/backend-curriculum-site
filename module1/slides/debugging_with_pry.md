# Debugging with Pry using `.each`

---

# Warmup

* In your homework, did you ever have to redo a script that wasn't working?
* How did you know what to change?

---

# Debuggers

* Tool to help me know what my code is doing at a given moment
* Help me to ask my code what's happening rather than try to guess
* Get into the most trouble when I *think* I know that something is working

---

# Setup

```bash
gem install pry
```

---

# Watch Then Implement

```ruby
# ~/turing/1module/classroom_exercises/exploring_each.rb
require 'pry'

favorite_things = ["whiskers", "packages", "strings"]
binding.pry
```

---

# Exploring Each

* Array method: see documentation
* Enumerable: method we can call on something we can count
* Base for other enumerable methods: other enums offer more compact syntax
* Returns the original array

---

# Example

Given the `favorite_things` array, how can I display each thing aligned to the right?

* Pseudocode
* Draft code
* Use debugger

---

# With a Partner

Draft pseudocode that explains how to display each of your favorite things aligned to the right.

---

# Draft Code/Use Debugger

```ruby
# ~/turing/1module/classroom_exercises/exploring_each.rb
# Use pry to determine how I can display my three favorite things aligned right
# Check the docs!
require 'pry'

favorite_things = ["whiskers", "packages", "strings"]

favorite_things.each do |thing|
  binding.pry
end
```

---

# More Debugging

```ruby
# ~/turing/1module/classroom_exercises/exploring_each.rb
require 'pry'

favorite_things = ["whiskers", "packages", "strings"]

favorite_things.each do |thing|
  formatted_thing = thing.rjust(40)
  binding.pry
  puts formatted_thing
end
```

---

# Blocks

* `do` and `end` surround/define a Block
* Can also use `{}` for single-line blocks

```ruby
favorite_things.each { puts thing.rjust(40) }
```

---

# Helpful Pry Commands

* `!!!` will get you back to the command line.
* `exit` will get out of the current pry
* `exit` will result in you hitting the next pry if one exists

---

# Each is a Method

* `#each` is a method that you can call on an instance of an array
* What does `#each` **return**?
* Try it

---

# Together

* If you had an array of numbers, [1,2,3,4,5,6], how do you print out the doubles of each number? Triples?
* If you had the same array, how would you only print out the even numbers? What about the odd numbers?

---

# With a Partner

See [lesson plan](http://backend.turing.edu/module1/lessons/primer_on_each)
