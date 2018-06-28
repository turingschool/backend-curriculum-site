# Methods & Return Values

---

# Warmup

Below "casey" is an instance of the String class, `#upcase` is a method, and "CASEY" is the value that is returned.

```ruby
"casey".upcase
#=> "CASEY"
```

* What is a method?
* What is a return value?
* What is an instance?
* How do you think the computer knows what to do when we call `#upcase`?

---

# Methods

* Sets of instructions
* Allow us to DRY up our code
* Allow us to work at different layers of abstraction

---

# Input/Output

* Methods take input and give us back some output based on the set of instructions they include.
* In this context:
    * Another word for `input`is `arguments`
    * Another word for `output` is `return value`
* All methods return something (even if we don't use it)
* Not all methods take input

---

# Methods: Syntax

```
def method_name(arguments)
  # instructions
end
```

---

# Methods: Syntax Example

```
def greeting(name)
  "Hello, #{name}!"
end

greeting("Sal")
#=> Hello, Sal!
```

---

# Practice

Define two methods in IRB (`signature` and `body`) that will allow us to call them and get the results below:

```ruby
body
#=> "Hope you're having a good day!"
signature("Sal")
#=> "Sincerely, Sal"
```

---

# Multiple Arguments

* Methods can take more than one argument
* Arguments are separated by commas
* Arguments can be any kind of object (including Arrays, Hashes, etc.)

---

# Methods in Methods

* You can call methods inside other methods
* This helps allow us to think of things at different layers of abstraction

```
def bake_cake(cake_recipe)
  instructions  = cake_recipe.instructions
  shopping_list = cake_recipe.ingredients
  ingredients   = purchase(shopping_list)
  bake(ingredients, instructions)
end
```

---

# Practice

Create a method `letter` that uses the methods we've already defined that would produce the results below:

```
letter("Sal", "Ilana")
#=> "Hello, Sal! Hope you're having a good day! Sincerely, Ilana"
```

---

# `puts` vs. Return

```
def greeting(name)
  "Hello, #{name}!"
end

greeting("Brian")
```

* Enter the code above in IRB. What happens?
* Enter the code above into a file called `greeting.rb` and run it with `ruby greeting.rb`. What happens?
* How can we make our greeting print out when we run our file?

---

# Practice

Create a method `print_letter` that will print our letter to the terminal.

```
print_letter("Sal", "Ilana")
Hello, Sal! Hope you're having a good day! Sincerely, Ilana
#=> nil
```

* What do you notice is the difference between the return value of our `letter` and our `print_letter` methods?

---

# Built In Methods

* Ruby has a lot of built-in methods that we can use without having to define them
* You are already familiar with many of them
* These can be found in the Ruby docs online and other resources

---

## WrapUp

* How do we define methods in Ruby?
* What is the difference in how we define a method that takes arguments from one that does not?
* How do you call one method from within another method?
* Why do we use methods?
