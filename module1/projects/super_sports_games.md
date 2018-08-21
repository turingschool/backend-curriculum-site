---
layout: page
title: Super Sports Games
---

# Super Sports Games

![Imgur](https://i.imgur.com/wwM9IQe.png)

Imagine a world-wide competition where countries send athletes to compete in different events. Those athletes are awarded medallions based on the place they finish in the events, and countries compete against each other to see who can win the most medallions. These are the Super Sports Games!

## Standard Deviation

In this project, we are going to need to find the standard deviation of an array of numbers. Assume we have an array of numbers `[24, 30, 18, 20, 41]`. The steps for finding the standard deviation are:

Step | Description | Operation | Result
--- | --- | ---- | ---
0 | input | | [24, 30, 18, 20, 41]
1 | sum all the integers | 24 + 30 + 18 + 20 + 41 | 133
2 | find the number of integers in the input array | | 5 |
3 | divide the sum of the integers (step 1) by the number of integers (step 2). This is the average (also known as the mean). | 133 / 5 | 26.6
4 | subtract each integer by the average found in step 3 | [24 - 26.6, 30 - 26.6, 18 - 26.6, 20 - 26.6, 41 - 26.6] | [-2.6, 3.4, -8.6, -6.6, 14.4]
5 | Take the result from step 4 and square each number | [-2.6 ^ 2, 3.4 ^ 2, -8.6 ^ 2, -6.6 ^ 2, 14.4 ^ 2] | [6.76, 11.56, 73.96, 43.56, 207.36]
6 | sum all the numbers from step 5 | 6.76 + 11.56 + 73.96 + 43.56 + 207.36 | 343.2
7 | divide the result from step 6 by the number of integers (step 2) | 343.2 / 5 | 68.64
8 | take the square root of the result from step 7 | sqrt(68.64) | 8.28

# Assignment

## Setup

1. Fork [this Repository](https://github.com/turingschool-examples/super_sports_games)
1. Clone your forked repo to your machine with git clone <ssh key for your repo>
  1. Make sure you clone it to a location that makes sense, for example `/Users/your_user_name/turing/1module/projects`.

## Submission

When you are ready to turn in the project, submit a pull request from your forked repository to the turingschool-examples repository.

**Make sure to put your name in your PR!**

## Iteration 1 - Standard Deviation

Open up the `standard_deviation.rb` file in the `lib` directory. You should see this template:

```ruby
ages = [24, 30, 18, 20, 41]

# Your code here for calculating the standard deviation

# When you find the standard deviation, print it out
```

Write code to find the standard deviation and print it to the screen. (You should not use any built-in code or gems for finding the standard deviation or average)

## Iteration 2 - Event Class

Create an `Event` class given the following criteria:

* An `Event` is initialized with two arguments
  * The first is a string representing the name of the event
  * The second is an Array of integers representing the ages of participants in the event.
* An `Event` has getter methods called `name` and `ages` for reading the name and ages of the event.
* An `Event` has a method called `max_age` that returns the largest age as an integer
* An `Event` has a method called `min_age` that returns the smallest age as an integer
* An `Event` has a method called `average_age` that returns the average age as a float rounded to 2 decimal places
* An `Event` has a method called `standard_deviation_age` that returns the standard deviation of the ages as a float rounded to 2 decimal places.

If your `Event` class follows all of the criteria, you should be able to run the `games_test.rb` test and see all of the tests pass.

Also, if the previous criteria are met, you should be able to interact with the `Event` class from a Pry session like so:

```ruby
pry(main)> require './lib/event'
#=> true

pry(main)> event = Event.new("Curling", [24, 30, 18, 20, 41])
#=> #<Event:0x00007fba3fc42ab0 @ages=[24, 30, 18, 20, 41], @name="Curling">

pry(main)> event.name
#=> "Curling"

pry(main)> event.ages
#=> [24, 30, 18, 20, 41]

pry(main)> event.max_age
#=> 41

pry(main)> event.min_age
#=> 18

pry(main)> event.average_age
#=> 26.6

pry(main)> event.standard_deviation_age
#=> 8.28
```

## Iteration 3 - Testing

Write tests for your `Event` class that cover that expected behavior described in the previous iteration.

## Iteration 4 - Extensions

* Create a program that allows a User to interact with the Games through the command line
  * Upon starting the program, the User should enter the year for the games
  * The User can then create new Events and get a Summary of the Events
