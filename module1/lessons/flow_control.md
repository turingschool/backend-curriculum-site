---
layout: page
title: Flow Control
length: 60
tags: fundamentals, computer science
---

## But First, The Word Of The Day

**equifinality (n):** `the property of allowing or having the same effect or result from different events`

I think of this as multiple paths that end up at the same point or place or result.

The result we are aiming for today is a functioning piece of software that forks or branches based on one or more conditions, and this lesson will show you a few of the logical tools that can help us arrive there.


## Learning Goals

* explain the flow of execution through a chunk of code  
* use `if` statements to control execution
* use an `else` statement to create an alternative path
* combine `if`, `elsif`, and `else` to create multiple branches
* use `while` and `until` to repeat instructions
* apply the `times` method to repeat instructions
* use `loop` and `break` to repeat instructions
* break out of an infinite loop in both IRB and regular Ruby

## Vocabulary  
* condition
* boolean
* conditional branching
* flow control  
* if/elsif/else
* loop
* while
* until
* times
* infinite loop

### Note

You're going to learn different ways to accomplish the same thing in this lesson. Remember that these are tools, and as you learn to be a software developer, you'll get a better idea of which tool to use for which job. For now, just try to understand how the tool works, and at least one use for that tool.

# Conditions

In programming, we refer to something that is either `true` or `false` as a **Boolean**.

A condition is something that evaluates to a Boolean. This can be as simple as a variable that holds a Boolean value:

```ruby
play_again = false
play_again
#=> false
```

We can also use comparison operators to create a condition by comparing two values. The important comparison operators are:

* `==` equal to
  * Be careful not to mix this up with `=` which is used for **variable assignment**
* `>` greater than
* `>=` greater than or equal to
* `<` less than
* `<=` less than or equal to
* `!=` not equal

We can use them like so:

```ruby
mood = "hungry"
mood == "hungry"
#=> true
mood == "sleepy"
#=> false
mood.length > 5
#=> true
mood != "grumpy"
#=> true
```

You can also use the negation operator `!` (also known as a "bang") to reverse something from true to false. The "bang" will always return the opposite boolean of the boolean that is returned from a method or variable. I use the word `not` in my head in conjunction with the negation operator.

```ruby
!false
#=> true
play_again = true
!play_again
#=> false
def hungry?
  true
end
!hungry?
#=> false
```
**not** `play_again` translates to **not** `true` which translates to `false`

**not** `hungry?` translates to **not** `true` which translates to `false`

There are also built-in ruby methods that can be used as conditions. Although it's not a rule, Rubyists typically end these methods with a `?` to imply that a boolean will be returned:

```ruby
1.even?
#=> false
"hello".include? "h"
#=> true
"hello".end_with? 'o'
#=> true
```

## `||` and `&&`

We can use the "or" operator `||` and the "and" operator `&&` to combine two conditions into a single condition. `||` evaluates to true if one of the conditions is true. `&&` evaluates to true if both are true:

```ruby
breed = "Corgi"
age = 2
breed == "Corgi" || age == 3
#=> true
breed == "Corgi" && age == 3
#=> false
```

Be careful... a common mistake is to try to use `||` with two possible values. If we want to say "the length is either equal to 0 or 10", you may try something like this:

```ruby
length = "letters".length
length == 0 || 10
```

This won't give us an error, but it isn't working like we expect. This condition will always evaluate to true, which probably isn't what we expect, and thus is not a very useful condition. If we read this as "length is equal to zero or ten", it makes sense to us, but that's not how Ruby reads it. Ruby evaluates each condition on the left and right independently and then combines them. So Ruby reads it as "Length is equal to zero; or ten.". The important point here is that both sides of an `||` or `&&` are valid conditions. This statement would be correctly written as:

```ruby
length = 5
length == 0 || length == 10
#=> false
```

Bonus:
What is the return value of:

```ruby
length = "letters".length
length == 0 || 10
```

Why?

# Conditional Branching

In programming, branching refers to a choice that is made depending on whether or not a condition is true or false. Think of branching as "choose your own adventure".

Examples:

- If a student earns a 3.8 GPA or higher, then they are invited to the honor roll ceremony. (One branch)

```ruby
if gpa >= 3.8
  invite_to_honor_roll
end
```

![inline](./assets/if_condition.jpg)


- If you want to spend a lot of money for dinner, go to a fancy restaurant. Otherwise, cook at home. (Two branches)

```ruby
if spend_that_money == true
  fancy_dinner
else
  cook_at_home
end
```

![inline](./assets/if_else_condition.jpg)


## `if`

All of our conditional branches will begin with an `if`. The code following the `if` will run if the condition is true.

```ruby
if condition
  # code to execute if condition is true
end
```

## `elsif`

Use an `elsif` to create more branches.

```ruby
if condition1
  # code to execute if above condition1 evaluates to true
elsif condition2
  # code to execute if above condition2 evaluates to true
elsif condition3
  # code to execute if above condition3 evaluates to true
end
```

## `else`

Code inside an `else` will run when none of the previous conditions are true.

```ruby
if condition1
  # code to execute if above condition1 evaluates to true
elsif condition2
  # code to execute if above condition2 evaluates to true
elsif condition3
  # code to execute if above condition3 evaluates to true
else
  # code to execute if all previous conditions evaluate to false
end
```

## Other rules

* Conditional branches have exactly one `if`
* The `if` can be following by any number of `elsif`s
* A conditional branch will have either zero or one `else`
* The `else` comes after the `if`/`elsif`s
* The conditional branch always ends with an `end`
* Only one branch can be taken.
* Conditions are evaluated in order.

## Check for Understanding

What will the following code print to the screen?

```ruby
play_again = true
lives = 3
if lives == 0
  puts "You Lose!"
elsif !play_again
  puts "Game Over!"
elsif play_again && lives > 0
  puts "Welcome back!"
else
  puts "invalid input"
end
```

What values would `play_again` and `lives` need to be assigned to in order to print each of the following to your terminal:
  * "You Lose!"
  * "Game Over!"
  * "Welcome back!"
  * "Invalid input



## Looping

A loop is a set of instructions that is executed repeatedly until some condition is met. This condition may be a certain number of times that the loop is executed, for example:

- After baking cookies, you pull the cookie sheet out of the oven which holds 24 cookies. One by one, you remove each of the cookies from the sheet and place them on a cooling rack. (24.times do...)
(Set of instructions that executes 24 times)

or it may be a question that returns a true/false (boolean) answer. For example:

- While looking for a parking spot at a crowded sporting event, a car continues to drive up and down the rows until an empty spot is found (full == false).   
(Loop that executes until a question returns true or false)

## `times`

A `times` loop executes code an exact number of times.

```ruby
5.times do
  # code to execute a given number of times. This code block will run 5 times before exiting
end
```

We can also include a **Block Variable** that tells us which iteration of the loop is running.

This code

```ruby
5.times do |number|
 puts number
end
```  

will print out

```
0
1
2
3
4
```

## `while`

```ruby
while condition
 # code to execute as long as condition evaluates to true
end
```

```ruby
while parking_spot.full?
  keep_driving
end
```

The above code does not run. Why is this?

## `until`

```ruby
until condition
  # code to execute if above condition evaluates to false, stop when condition evaluates to true  
end
```  

```ruby
until parking_spot.empty?  
 keep_driving  
end
```

## loop do

`loop do` allows you to run code in an infinite loop.


```ruby
loop do
  # code will run forever
end
```

You can use the `break` keyword to end a `loop do`:

```ruby
count = 0
loop do
  count += 1
  if count == 3
    break
  end
end
```

If you accidentally get stuck in an infinite loop, use `control + c` to stop it.

### Check for Understanding

Using `times`, `while`, `until` and `loop`, print "Beetlejuice" to the terminal 3 times. 🐝
