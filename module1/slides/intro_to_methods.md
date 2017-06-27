# Intro to Methods

---

# Warmup

* What do you know about methods from your prework?
* How have you organized your code up to this point?
* What tools have you used if you wanted to perform actions multiple times?

---

# Defining Methods without Parameters

```ruby
# converter.rb
def print_welcome
  puts 'Welcome to Converter!'
end

print_welcome
print_welcome
print_welcome
```

---

# Try it!

Create a method `print_welcome` in a new file `doubler.rb` that prints the message `Welcome to Doubler!`

---

# Defining Methods with Parameters

* Input: temperature in Fahrenheit
* Output: temperature in Celsius

```ruby
# converter.rb
# ... print_welcome

def convert_to_celsius(temperature)
  ((temperature) - 32) * 5.0 / 9.0).round(2)
end

print_welcome
convert_to_celsius(32)
```

---

# Return Values

* What a method **returns**
* What a variable would capture if set equal to the results of this method
* Separate from what a method **does**
* In Ruby, methods return the last line

---

# Printing Values that are Returned

```ruby
# converter.rb
# ... print_welcome

def convert_to_celsius(temperature)
  ((temperature) - 32) * 5.0 / 9.0).round(2)
end

print_welcome
convert_to_celsius(32)
```

---

# Try It!

* Define a method `doubler` that takes a single argument and doubles it.
* Call that method three times and save the returns to variables.
* Print those values held in those variables to the screen.

---

# Calling Methods from Other Methods

```ruby
# converter.rb
# ... print_welcome, convert_to_celsius

def print_converted(temperature)
  converted = convert_to_celsius(temperature)
  puts "#{temperature} degrees Farenheit is equal to #{converted} degrees Celsius."
end

print_converted(32)
print_converted(35)
```

---

# Try it!

* Add a method `print_double` which accepts an argument and prints a phrase in the form `3 doubled is 6`.
* If you have time, see if you can determine what `print_double` **returns**. Why might that be?

---

# Layers of Abstraction

```ruby
# converter.rb

def convert(first, second, third)
  print_welcome
  print_converted(first)
  print_converted(second)
  print_converted(third)
end

# print_welcome, convert_to_celsius, etc.

convert(32, 35, 100)
convert(12, 45, 65)
```

---

# Try It!

* Create a high level method for your `doubler.rb` file that wraps these other methods into one.

---

# Basic Classes

```ruby
class NameOfClass
  # stuff
end
```

---

# Converter Class

```ruby
# converter.rb

class Converter
  # convert, print_welcome, convert_to_celsius, print_converted
end

converter = Converter.new
converter.convert(32, 35, 100)
converter.convert(12, 45, 65)
```

---

# Things to Notice

* We create a new **instance** of a class
* We call our methods on that instance

---

# Try It!

* Wrap your existing methods from `double.rb` in a `Doubler` class
* Adjust your code so that the output when you run `ruby doubler.rb` is the same as it was before you created the class

---

# Summary

* How do we define methods in Ruby?
* What is the difference in how we define a method that takes arguments from one that does not.
* Why do we use methods?
* How do we define a simple class in Ruby?
