---
layout: page
title: Intro to Methods
length: 60
tags: ruby, methods
---

## Learning Goals

* Understand Return Values
* Define methods in Ruby
* Explain why we use methods
* Define methods that take arguments
* Define methods that do not take arguments
* Understand different types of methods
* Understand how abstraction helps us program

## Vocabulary
* Return
* Method
* Argument
* Parameter
* Parse
* Execute
* Abstraction

## Warmup

* Write out a list of steps to describe how these lines of code work:
  ```ruby
    pi = 3.14159265359.round(2)
    puts pi
  ```
* How is the following different?
  ```ruby
    3.14159265359.round(2)
  ```

## Return Values

A **Return Value** is the output of a **Method**.

Every **Method** has *exactly one* **Return Value**.

A **Return Value** can be any type, for example `4`, `"Hello World"`, `true`, `[1,2,3]`, `nil`.

If you open a pry session and type

```ruby
pry(main)> "Hello World".upcase
=> "HELLO WORLD"
```

You are calling the `upcase` **Method** on the string`"Hello World"`. The **Return Value**, denoted by the `=>`, is `"HELLO WORLD"`.

## Parameters

**Parameters** are the input to a method.

If you open a pry session and type

```ruby
pry(main)> "Hello World".include? "Hello"
=> true
```

You are calling the `include?` method on the string `"Hello World"`. You are **Passing** the **Parameter** `"Hello"` to the `include?` method. The **Return Value** is `true`. 






Parsing vs Executing
  Turn and talk about what is happening
Input and Output
Parameters
DRY
Command and Query
Black Box
Chaining


How to return
What Return values have you already used?
What happens if you don't save a return value?
  It goes poof
Scope - what happens if you call a method before you defined it?
