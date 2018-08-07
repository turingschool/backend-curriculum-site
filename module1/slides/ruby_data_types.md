# Ruby Data Types

---

# Integers & Floats

* Integers: numbers without decimals
    * `1`
    * `-1`
    * `100_033_443`
* Floats: numbers with decimals
    * `4.25`
    * `8.275`
    * `-14.5`

---

# Integer & Float Methods

* Mathematical operations

```ruby
4 + 3 #=> 7
7 * 2 #=> 14
45 % 10 #=> 5 (the modulo find the remainder)
```
* Comparison operators

```ruby
4 == 4 #=> true
12 <= 8 #=> false
3 != 6 #=> true
```
---

# Detour Variables

* Store Data

```ruby
my_age = 30
your_age = 29
my_age == your_age
#=> false
```

---

# Check

What will each line of code below return?

```ruby
6 % 5
4 != 4
5 > 5
10 >= 10
```

---

# Strings

* A series of characters between quotation marks
* Double quotes or single quotes so long as they match

---

# String Methods

* `#length`
* `#chars`
* `#upcase`
* `#downcase`
* `#capitalize`

---

# String Interpolation

```
name = "Sal"
"My name is #{name}"
```

---

# Bracket Notation

```ruby
"Sal"[1]
```

* Requires double quotes

---

# Check

What will each line of code below return?

```ruby
"Sal".upcase
"Megan"[3]
"Brian".chars
```

---

# Changing Data Types

- `.to_f` - change an integer to a float
- `.to_i` - change a float to an integer
- `.to_s` - change an integer or float to a "string"

---

# Arrays

```ruby
["Sal", "Brian", "Megan"]
[1, 2, 3, 7, 2]
[1.5, 2.2, 3.3]
[[0, 0], [0, 1], [1, 0], [1, 1]]
```

* Ordered list that is comma-separated and enclosed in square brackets
* Count always starts at 0
* Can hold many pieces of data (we call each piece an `element`); or be empty!
* Can hold any data type - integer, string, hash, array

---

# Array Methods

* array[0]
* length/count/size
* push/pop
* shift/unshift
* delete_at
* insert

---

# Enumerables

* each
* map
* find
* select

---

# Check

What will each line of code below return?

```ruby
numbers = [5, 4, 7, 9]
numbers[0]
numbers.push(7)
numbers.pop
numbers.length
numbers.insert(1, 4)
```

---

# Hashes

* Key value pair:

```ruby
sal = {first_name: "Sal", last_name: "Espinosa", position: "Instructor", dogs: 0}
sal[:first_name]
#=> "Sal"
sal[:last_name]
#=> "Espinosa"
```

---

# Check

What will each line of code below return?

```ruby
spot = {age: 3, name: "Spot", breed: "Dalmation", siblings: ["Sadie", "Sarah", "Simone"]}
spot[:name]
spot[:age] = 4
spot[:siblings]
spot[:siblings].push("Sunny")
spot
```

---

# Checks for Understanding

Please complete [this](https://goo.gl/forms/CPhMUhOkjwc0Prs93) form.
