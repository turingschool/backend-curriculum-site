---
title: SuperFizzBuzz
tags: project
---

# SuperFizzBuzz

In this assignment you'll implement an algorithm that is actually used in some programmer interviews. And the really shocking part is that some people fail it! This is an extension of the FizzBuzz problem, **SuperFizzBuzz**.

A number has a corresponding output. The rules for determining the output are as follows:

*   If it's evenly divisible by 3, 5, and 7 the output is `SuperFizzBuzz`
*   If it's evenly divisible by 3 and 7 the output is `SuperFizz`
*   If it's evenly divisible by 5 and 7 the output is `SuperBuzz`
*   If it's evenly divisible by 3 and 5 the output is `FizzBuzz`
*   If it's evenly divisible by 3, the output is `Fizz`
*   If it's evenly divisible by 5, the output is `Buzz`
*   If it's evenly divisible by 7, the output is `Super`
*   Otherwise the output is just the number


## Iteration 1

Write a program called `super_fizz_buzz.rb`. This program should iterate through the numbers 1 to 1000 and for each one, print the output according to the rules above. The output of your program should look something like this:

```
1
2
Fizz
4
Buzz
Fizz
Super
8
Fizz
Buzz
11
Fizz
13
Super
FizzBuzz
16
...
```

## Iteration 2

Create a class that responds to the following interaction pattern:

```ruby
super_fizz = SuperFizzBuzz.new
super_fizz.output(8)
=> "8"
super_fizz.output(15)
=> "FizzBuzz"
super_fizz.output_range(8, 15)
=> ["8", "Fizz", "Buzz", "11", "Fizz", "13", "Super", "FizzBuzz"]
```

## Iteration 3

Write a Minitest test to verify the behavior of your class


### Iteration 4

Can you make your class work correctly in as few lines as possible?
