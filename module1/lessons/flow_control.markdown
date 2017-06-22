---
layout: page
title: Flow Control
length: 60
tags: fundamentals, computer science
---

# Flow Control

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
* flow control  
* if/elsif/else 
* loop
* while
* until
* times
* infinite loop 

## Structure  
5 min  - WarmUp   
20min - Intro to Branching & Loops   
5 min  - Break  
20min - Paired Exercises   
5 min  - WrapUp  

## WarmUp  
In your journal, with a partner, and using the internet as a tool, answer the following:  
*  What tools have you seen or used to determine what happens next in your code base?  
*  What are some use cases for each of these?  

## Looping

### Discussion

A loop is a set of instructions that is executed repeatedly until some condition is met. This condition may be a certain number of times that the loop is executed, or it may be a question that returns a true/false (boolean) answer.

#### Examples:

- While looking for a parking spot at a crowded sporting event, a car continues to drive up and down the rows until an empty spot is found (empty == true).   
(Loop that executes until a question returns true or false)
- After baking cookies, you pull the cookie sheet out of the oven which holds 24 cookies. One by one, you remove each of the cookies from the sheet and place them on a cooling rack. (24.times do...)
(Set of instructions that executes 24 times)

**Turn & Talk**

What are some other examples of looping in the real world?

### Some looping options: while, until, times

Let's look at three of the more popular loops Ruby offers.

What are some differences you notice among them?

#### `while`

```ruby
while condition
 # code to execute as long as condition is true
end
```

#### `until`

```ruby
until condition 
  # code to execute if above condition evaluates to false, stop when condition evaluates to true  
end
```

#### `times`

```ruby
5.times do
  # code to execute given number of times  
end
```

```ruby
5.times do |number|
 # code to execute given number of times 
end
```  

If your program gets stuck, you are likely in an infite loop. You can exit using `ctl-c`.  If you want your loop to exit once something is done, you can use `break`. 

```
count = 0
loop do 
  count += 1
  break if count == 3
end
``` 

### Conditional Branching

In programming, branching refers to a choice that is made depending on whether or not a condition is true or false. Think of branching as "choose your own adventure".

Examples:

- If a student earns a 3.8 GPA or higher, then they are invited to the honor roll ceremony. (One branch)
- If you want to spend a lot of money for dinner, go to a fancy restaurant. Otherwise, cook at home. (Two branches)

*Try it*: What are some other examples of branching in the real world?

* `if`

```ruby
if condition
  # code to execute
end
```

* `else`

```ruby
if condition
  # code to execute if true
else
  # code to execute if false
end
```

* `elsif`

```ruby
if condition1
  # code to execute if above condition1 evaluates to true
elsif condition2
  # code to execute if above condition2 evaluates to true
else
  # code to execute if both evaluate to false
end
```

## Exercises  
With a partner, each of you creating a version on your computer:

### Branching
You'll need a few tools to work with user input and output.

* How do we tell Ruby to print text to the screen?
* How do we tell Ruby to bring in text from the user?

#### 1. Basic `puts` / `gets`

Write a simple Ruby program which prompts the user to enter a message, then prints that message to the terminal.   
For example:  
From the command line: 

```
$ touch flow_control.rb
```  
In `flow_control.rb`: 

```ruby
puts "Type your message:"  
message = gets.chomp
puts "You typed: #{message}"
```
From the command line:  

```
$ ruby flow_control.rb
Type your message:
$ pizza
You typed: pizza
```

#### 2. Basic Branching

Extend your previous program so that if the text the user enters has an even number of letters, it prints "EVEN!", and if it has an odd number of letters, it prints "ODD!".

#### 3. Multi-pronged branching

Write a new program that prompts the user for a message, then, depending on the following conditions, prints an appropriate message:

* If the message ends with a consonant, print "CONSONANT!"
* If the message ends with a vowel, print "VOWEL!"
* If the message ends with a "y", print "DON'T KNOW!"

##Turn& Talk
Turning the other direction, use English to explain the flow of your code with your partner.

### Looping
Back with your original partner: 
#### 1. Easy Looping

Use a `times` loop to generate this output:

```
Line
Line
Line
Line
Line
```

#### 2. Looping with a Condition

Build on your answer from the problem above and add an `if`/`else` to generate output like this:

```
Line is even
Line is odd
Line is even
Line is odd
Line is even
```

#### 3. Three Loops

Generate the output below using three totally separate implementations (`times`, `while` and `until`):

```
This is my output line 1
This is my output line 2
This is my output line 3
This is my output line 4
This is my output line 5
``` 

#### 4. Rando-Guesser

Write two implementations, one with `while` and one with `until` that output the following:

```
(The secret number is 8)
Guess is 4
Guess again!
Guess is 5
Guess again!
Guess is 9
Guess again!
Guess is 4
Guess again!
Guess is 8
You win!
```

The secret number and the guesses are both random numbers 0 through 10.

## Turn & Talk  
Turning the other direction, use English to explain the flow of your code with your partner. 

## WrapUp
* What are two ways to control the flow of execution in a code base?  
* Describe a use cases for each type of flow control covered today.(should be about 6)   

## Extensions

If you have time or would like more practice, try [this challenge](flow_control_alt_exercise.markdown).
