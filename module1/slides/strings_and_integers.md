# Strings & Integers

---

# Warmup

* In your own words:
    * What's a string?
    * What's an integer?
    * What's a float?
* How/why do we use variables in Ruby?

---

# Share

---

# Strings

* Defined by quotations marks (single or double)
* Can be empty
* Like everything in Ruby, strings are objects

---

# Which of the following are valid strings? Why?

* ’’
* “123”
* 123
* ”@*#%&”
* hello, world!
* ‘welcome to Turing’
* ‘987654321.”
* “hot chocolate is the best”

---

# Substrings

* Access portions of a string using square brackets and indices

---

# Single Characters

Type the following examples in IRB and determine what they do:

* "hello, world"[0]
* "Turing"[0]
* "ruby"[2]
* "lunch"[-1]

---

# Ranges

Type the following examples in IRB and determine what they do:

* "hello, world"[0..4]
* "Turing"[0..1]
* "ruby"[1..-1]
* "lunch"[0..-2]

---

# String Methods

* Structure
* Sample methods
    * `#upcase`
    * `#capitalize`
    * `#center`
* Can also call the following on any Ruby object
    * `.methods` 
    * `.class`

---

# Documentation Review

|String Methods| |
|----|----|
|downcase|reverse |
|empty? |split |
|gsub|start_with? |
|include?|tr |
|index |upcase |
|length| |

---

# String Concatenation

* Can use `+` to concatenate strings
* If strings are saved to variables, can still use `+` to concatenate

---

# String Interpolation

* Can use curly braces inside a double quoted string to perform string interpolation.

```ruby
student = 'Carl'
"Welcome to class, " + student + "."
=> "Welcome to class, Carl."
"Welcome to class, #{student}"
=> "Welcome to class, Carl."
```

---

# Variable Assignment

```ruby
x = 10
=> 10
x
=> 10
```

---

# Assigment and Evaluating Expressions

```ruby
b = 10 + 5
=> 15
b
=> 15
```

---

# What is `c`

```ruby
c = 15
=> ?
c = "hello"
=> ?
c
=> ?
```

---

# Naming Local Variables

* Requirements
    * always start with a lowercase letter (underscore is permitted, though uncommon)
    * have no spaces
    * do not contain most special characters like $, @, and &

---

# Naming Local Variables

* Conventions
    * use snake case where each word in the name is lowercase and connected by underscores (_)
    * are named after the meaning of their contents, not the type of their contents
    * aren’t abbreviated

---

# Naming Practice

Which of the following are invalid? Which go against convention?

* time_machine
* student_count_integer
* homeworkAssignment
* 3_sections
* top_ppl

---

# Integers

```ruby
123456789.class
1_000_000_000_000_000_000_000.class
5.6.class
1.239.class
```

---

# Integer Practice

See lesson plan.

---

# Documentation Review

|Integer Methods | |
|----|----|
|round|%|
|to_f|==|
|to_i|>|
|to_s|>=|
|floor|even?|
|ceil|odd?|
|abs|next|

---

Homework

