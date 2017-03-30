---
title: Boolean Logic
length: 90
tags: ruby, computer science, logic
---

## Learning Goals

* Understand falsy vs truthy in Ruby
* Understand the key logic operators AND, OR, and NOT
* Be able to combine operations into a logic expression
* Be able to use a truth table to illustrate a logical expression
* Be able to trace the paths through a chunk of code
* Be able to use compound logic to flatten nested `if` statements

## Why?

Why is it helpful to have a working understanding of boolean logic? It can help us flatten `if` statements and reduce the number of lines in our code. We are also going to encounter this frequently in our jobs. A lack in understanding can introduce bugs into our code bases.

## Truthy and falsey values

First, start by doing some research.

* How many falsey values are there in Ruby?
* What is truthy in Ruby?

When you've answered the questions above, which of these are truthy and which are falsey?

* 1.0
* "hello"
* nil
* 0
* false
* true
* "false"

## AND/OR/NOT and Truth Tables

A truth table is a mathematical table used in logic. In the truth table below the first two columns (`a` and `b`) are our _input variables_. Our table should cover all of the different possible combinations input variables. There are four different combinations for our two input variables (`a` and `b`). These are represented as rows. The remaining columns show all of the possible results of the different Ruby operators for a given row. So the first row says if `a` is `true` and `b` is `true` then `a && b` is `true`, <code>a &#124;&#124; b</code> is `true`, and `!a` is `false`.

Use a `pry` session to clarify how these three Ruby operators work. For each row, set `a` and `b` to their values and experiment with the Ruby operators.

**Example:**

```ruby
[1] pry(main)> a = true
=> true
[2] pry(main)> b = true
=> true
[3] pry(main)> a && b
=> true
```

| `a` | `b` | `a && b` | <code>a &#124;&#124; b</code> | `!a` |
| :---: | :---: | :---: | :---: | :---: |
| true | true | true | true | false |
| true | false | false | true | false |
| false | true | false | true | true |
| false | false | false | false | true |

## Fist of Five: Smaller Group Breakouts

**If not teaching as a class, skip to "Expressions and Precedence with Parentheses".**

Those feeling a "5" with logic so far, break out together, glance over the following parens section, then move onto Activity B. You'll work through this outside of the classroom individually - we'll regroup 15 minutes before the end of class to share solutions.

For the rest of us, we'll work through the rest of the lesson as a class.

### Expressions and Precedence with Parentheses

Let's pop this into pry without hitting 'enter':

```ruby
false && false || true
```

What do you expect it to return? `true`? `false`? It seems to depend on the order Ruby executes in. What if the order you want Ruby executes this in to be different from its default?

Enter, parens.

Let's revisit that last expression in `pry`, but let's add some parentheses.

```ruby
false && (false || true)
```

Turn to your neighbor and discuss what order you believe Ruby is evaluating our boolean expressions in.

### More Complex Truth Tables

Evaluate the following by creating a truth table for three boolean values (`A`, `B`, and `C`) and using it to solve the following expressions:

* `(A || B) && (A || C)`
* `(A || !B) || (!A || C)`
* `((A && B) && C) || (B && !A)`
* `((A && B) && !C) || ((A && C) && !B)`

<!-- ### Quick Aside: Short-Circuit Evaluation

[Short-Circuit Evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation) is used by many programming languages (including Ruby) to shortcut-eval an expression based on its first value and operator. Only if the result of the operation cannot be determined by that does it look at the second value.

For example, `false && x # => false` without needing to know what `x` equals.

-->

### Activity 1.a: Vehicle

```ruby
class Vehicle
  attr_reader :model, :four_wheel, :big_back_wheels

  def initialize(model, four_wheel, big_back_wheels)
    @model = model
    @four_wheel = four_wheel
    @big_back_wheels = big_back_wheels
  end

  def car?
    model == "car"
  end

  def tractor?
    model == "tractor"
  end

  def pickup?
    model == "pickup"
  end

  def four_wheel_drive?
    four_wheel
  end

  def big_back_wheels?
    big_back_wheels
  end
end

vehicle = Vehicle.new("pickup", true, true)

if vehicle.car?
  if vehicle.four_wheel_drive? || !vehicle.four_wheel_drive?
    puts "Vehicle has four wheels "
    if vehicle.four_wheel_drive?
      puts "with four wheel drive"
    else
      puts "with two wheel drive"
    end
  end
elsif vehicle.tractor?
  puts "Vehicle has four wheels "
  if vehicle.big_back_wheels?
    puts "with big wheels in the back"
  end
elsif vehicle.pickup?
  puts "Vehicle has four wheels "
  if vehicle.four_wheel_drive?
    puts "with four wheel drive"
  else
    puts "with two wheel drive"
  end
  if vehicle.big_back_wheels?
    puts "with big wheels in the back"
  end
end
```

* How many unique execution paths are there through the block of code starting with `if vehicle.car?` statement?
* Chart out the conditions which would lead to these paths (consider a truth table).

### Activity 1.b: Flattening `if` statements

Take the code from the previous exercise. Let's try to refactor it. Start by flattening it down. Can you simplify the logic to reduce the number of paths? How few can you get it down to? Compare your results with a peer.

Convert the nested if/else statements to flatter boolean expressions.

## Wrapup

Last, let's get together to recap and answer questions.
