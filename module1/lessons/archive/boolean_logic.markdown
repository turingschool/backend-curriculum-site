---
title: Boolean Logic
length: 90
tags: ruby, computer science, logic
---

## Learning Goals

* Understand the key logic operators AND, OR, and NOT
* Be able to combine operations into a logic expression
* Be able to use a truth table to illustrate a logical expression
* Understand short-circuit evaluation of logical statements
* Be able to trace the paths through a chunk of code
* Be able to use compound logic to flatten nested `if` statements

## Why?
Why is it helpful to have a working understanding of boolean logic? Flattening `if` statements

## Truthy and falsey values
Which of these are truthy and which are falsey?

* 1.0
* "hello"
* nil
* 0
* false
* true
* "false"

## AND/OR/NOT and Truth Tables
We'll use a truth table and an `irb` session to clarify how these rules work.

## Taking it to the next level

### Expressions and precedence with parentheses
Create Truth Table for this expression using the boolean values `A`, `B`, and `C`:

* `(A || B) && (A || C)`
* `(A || !B) || (!A || C)`
* `((A && B) && C) || (B && !A)`
* `((A && B) && !C) || ((A && C) && !B)`

### Short-Circuit evaluation
[Short-Circuit Evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation)


### Activity 1: Vehicle
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
    puts "Vehicle has four wheels"
    if vehicle.four_wheel_drive?
      puts "with four wheel drive"
    else
      puts "with two wheel drive"
    end
  end
elsif vehicle.tractor?
  puts "Vehicle has four wheels"
  if vehicle.big_back_wheels?
    puts "with big wheels in the back"
  end
elsif vehicle.pickup?
  puts "Vehicle has four wheels"
  if vehicle.four_wheel_drive?
    puts "with four wheel drive"
  else
    puts "with two wheel drive"
  end
  if vehicle.big_back_wheels?
    puts "With big wheels in the back"
  end
end

```
* How many unique execution paths are there through the block of code starting with `if vehicle.car?` statement?
* Chart out the conditions which would lead to these paths (consider a truth table).


### Activity 2: Flattening if statements

Take the code from the previous exercise. Let's try to refactor it. Start by flattening it down. Can you simplify the logic to reduce the number of paths? How few can you get it down to? Compare your results with a peer.

Convert the nested if/else statements to flatter boolean expressions.


## Wrapup

Last let's get together to recap and answer questions.
