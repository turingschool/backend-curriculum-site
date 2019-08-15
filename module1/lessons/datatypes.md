---
layout: page
title: Ruby Datatypes
tags: fundamentals, datatypes, computer science
---

## Learning Goals

* Explain the key points of each of the important built-in Ruby data types.
* Speak to a few common methods for each data type.
* Be able to reference Ruby Docs in order to determine what an object's method does.

## Vocabulary

* Datatype
* Class
* Method
* Integer
* Float
* String
* Array

# Datatypes

Programming is all about interacting with data, but data can come in many different forms such as numbers, words, or collections of data. The built-in Ruby Datatypes we will cover today are:

* Integer
* Float
* String
* Array

Each of these is a Ruby **Class**. A Class is a description of how something should behave. You can think of it as a blueprint for creating data. When you have data of a certain Class type, that piece of data is an **Instance** of that **Class**. We also say that piece of data is a "(Class type) **Object**". For example:

* `4` is an instance of the `Integer` class.
* `4` is an `Integer` object
* `3.14` is an instance of the `Float` class
* `3.14` is a `Float` object
* `"Hello World"` is an instance of the `String` class
* `"Hello World"` is a `String` object
* `[1,2,3,4,5]` is an instance of the `Array` class
* `[1,2,3,4,5]` is an `Array` object

We will discuss **Objects**, **Instances**, and **Classes** in another lesson. For now, you just need to get used to using the vocabulary to talk about Ruby Datatypes. Specifically, you need to be able to say something is an "Instance of the \_\_\_\_ Class", or something is a "\_\_\_\_ Object".

# Variables

Variables are used to store data. You make a variable by using the **Assignment Operator**, `=`. For example:

```ruby
greeting = "Hello World!"
```

Ruby evaluates assignments from right to left. This means Ruby will evaluate whatever code is on the right side of the `=`, and then store that in the variable on the left side of the `=`. In the previous example, when Ruby hits that line of code, it first evaluates `"Hello World!"`, which just evaluates to the String `"Hello World!"`, and stores it in the variable `greeting`.

Variables in Ruby can hold any datatype. You can also switch a variable to a completely different datatype. This is known as "Dynamic Typing". For example:

```ruby
x = 7
x = "pizza"
x = [7, 7, 7]
```

It is very important that you distinguish between a variable and the object it holds. The **Variable** is just a container, and the **Object** is what that container is holding. In this example:

```ruby
greeting = "Hello World!"
```

the variable `greeting` is holding a `String` object.


## Naming Variables

For now, all the variables we will be using are **Local Variables**. Local variables must start with a lowercase letter, and can only contain letters, numbers, and underscores `_`. In Ruby, the convention is to name variables using "Snake Case", which is all lowercase letters with words separated by underscores. For example, this is a good variable name:

```ruby
things_i_like
```

And these are bad variable names:

```ruby
thingsILike
things_I_Like
```

Another good practice is to name your variables as specifically as possible. Ideally, someone reading your code could read just the variable name and know what data it holds. For example, if you are keeping a running total of numbers, you could name that variable `sum` or `count`, but you should name it `num` or `x`.


# Integers

* Numbers without decimals
    * `1`
    * `-1`
    * `100_033_443`

## Integer Math

```ruby
4 + 3
#=> 7
7 * 2
#=> 14
45 % 10
#=> 5 (the modulo aka the remainder)
3 / 4
#=> 0
```

## Integer Methods

* `#even?`
* `#odd?`

## Integer Comparison

```ruby
4 == 4
#=> true
12 <= 8
#=> false
3 != 6
#=> true
```

# Floats

* Numbers with decimals
    * `4.25`
    * `8.275`
    * `-14.5`

## Float Methods

* `#round`

## Float Math

```ruby
4.1 + 3.2
#=> 7.3
4 + 7.5
#=> 11.5
3 / 4
#=> 0
3.0 / 4.0
#=> 0.75
3.0 / 4
#=> 0.75
3 / 4.0
#=> 0.75
```

## Float Comparison

```ruby
4.0 == 4.0
#=> true
4.0 == 4
#=> true
3.1 <= 2.8
#=> false
3 != 3.1
#=> true
```

# Check for Understanding

What will each line of code return? Write down your answers, then use Pry or IRB to check your answers.

```ruby
7 / 2
7 / 2.0
7 >= 7
7.even?
7.31.round(1)
```

# Strings

* A series of characters between quotation marks
* Double quotes or single quotes so long as they match

## String Methods

* `#length`
* `#chars`
* `#upcase`
* `#downcase`
* `#capitalize`

## String Interpolation

Creates a new String by evaluating whatever is inside the `#{}`. The String must be in double quotes to use interpolation. For example:

```ruby
name = "Sal"
"My name is #{name}"
#=> "My name is Sal"
```

You can insert any ruby code inside the `#{}`. For example:

```ruby
"Two plus two is #{2 + 2}"
#=> "Two plus two is 4"
```

Remember, your code should still be readable, so don't go crazy with putting too much code in an interpolation.

## String Concatenation

Creates a new string by appending one onto the other. For example:

```ruby
greeting = "hello"
place = "world"
greeting + place
#=> "helloworld"
```

You can concatenate as many Strings as you want, for example:

```ruby
greeting = "hello"
place = "world"
greeting + " " + place + "!"
#=> "hello world!"
```

## Substrings

A substring is part of String.

You can select a single character substring using brackets and an index like this:

```ruby
"Sal"[0]
#=> "S"
```

Remember, indexing starts at 0.

We can get a range of characters using a beginning and an ending index like this:

```ruby
"Sal"[0..1]
#=> "Sa"
```

You can also index from the end of the String:

```ruby
"Sal"[0..-1]
#=> "Sal"
```

# Check for Understanding

What will each line of code return? Write down your answers, then use Pry or IRB to check your answers.

```ruby
teacher = "sal"
teacher.upcase
"My favorite teacher is #{teacher.capitalize}"
"My first initial is " + "Megan"[0] + "!"
"My name is #{"Brian".length} letters long"
"My name ends in #{teacher[-1]}"
```

# Changing Data Types

- `.to_f` - change to a Float
- `.to_i` - change to an Integer
- `.to_s` - change to a String

Be careful, sometimes these can behave unexpectedly and Ruby won't give you an error to let you know something might be wrong.

```ruby
"hello".to_i
#=> 0
"3 little monkeys".to_i
#=> 3
" 3".to_f
#=> 3.0
"_3".to_f
#=> 0.0
```

# Arrays

```ruby
[]
["Sal", "Brian", "Megan"]
[1, 2, 3, 7, 2]
[1.5, 2.2, 3.3]
[[0, 0], [0, 1], [1, 0], [1, 1]]
[1, "one", 1.0, [1]]
```

* **Ordered** list that is comma-separated and enclosed in square brackets
* Can hold many pieces of data (we call each piece an `element`); or be empty!
* Can hold any data type - integer, string, hash, array
* Can mix datatypes, but generally we want to avoid this

# Array Methods

* array[0]
* length/count/size
* push/pop
* shift/unshift
* delete_at
* insert
* join

# Check for Understanding

What will each line of code return? Write down your answers, then use Pry or IRB to check your answers.

```ruby
numbers = [5, 4, 7, 9]
numbers[0]
numbers.push(7)
numbers.pop
numbers.length
numbers.insert(1, 4)
numbers.join(", ")
```

## Additional Resources

* [Intro to Hashes](https://vimeo.com/238162528)
* [Strings and Integers](https://vimeo.com/235827172)
* [Arrays](https://www.youtube.com/watch?v=c2UnIQ3LRnM&list=PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5&t=0s&index=4)
