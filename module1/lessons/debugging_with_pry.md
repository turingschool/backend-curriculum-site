---
title: Debugging with Pry
tags: debugging, pry
---

# Pry

## Installing Pry

In your terminal, enter the command:

`gem install pry`

You should see output saying Pry was successfully installed. If you got an error saying that you don't have permission, it is likely that you do not have Rbenv set up properly. Look back in the prework setup instructions and verify the Rbenv is setup properly. If you cannot resolve this error, ask an instructor for help before moving on.

## Pry as a REPL

Pry is very similar to IRB. Enter the command `pry` into your terminal and you should see a prompt like `[1] pry(main)>`. This is a REPL, which stands for Read, Evaluate, Print, Loop. This means that Pry will read whatever you type in, evaluate it, and print out the evaluation known as the **return value**. It will do all three of those things in a continuous loop. Try entering some Ruby code into Pry that you may already know, for example:

```ruby
[1] pry(main)> greeting = "hello"
=> "hello"
[2] pry(main)> place = "world"
=> "world"
[3] pry(main)> "#{greeting} #{place}"
=> "hello world"
```

The value printed after the `=>` is the **return value** of the previous line of code.

## Pry as a Debugger

As programmers we often make assumptions about what our code is doing. We are often wrong. One of the most important and effective debugging techniques is to validate your assumptions.

Have you ever found yourself working on a programming problem and as you attempt to solve it, you are forced to run the entire file over and over again until you get the correct result? Wouldn't it be awesome if you could pause your code at a specific line and interact with it? Enter Pry.

Create a new Ruby file called `pry.rb`. In order to use Pry, you need to require it at the top of your file:

```ruby
require "pry"
```

Now add this code to the file:

```ruby
favorite_things = ["Trapper Keeper", "Netscape Navigator", "Troll Doll"]
first_thing = favorite_things[0]
second_thing = favorite_things[1]
third_thing = favorite_things[2]
binding.pry
puts "first thing is #{first_thing}"
puts "second thing is #{second_thing}"
puts "third thing is #{third_thing}"
puts "Lets add another thing"
favorite_things << "Sega Dreamcast"
last_thing = favorite_things[-1]
puts "last thinng is #{last_thing}"
```

Run the code and you should see a Pry prompt. Depending on your screen size, you may also see a colon, which means you are in a pager. Hit `q` to exit the pager.

Whenever Ruby sees a `binding.pry` statement, Ruby pauses the execution of code and opens up a Pry session *in the middle of the code*. This Pry session is a the same as the one we opened before, except that you now have access to the variables that Ruby has created up to that point in the code. In your Pry prompt, enter `favorite_things` and you will see the array stored in the favorite_things variable. Do the same with `first_thing`, `second_thing`, and `third_thing`. Just like the Pry session before, you can run any Ruby code inside this session. Try it by entering `favorite_things.length` and `favorite_things[0]`.

You can type `exit` to tell Ruby to close the Pry session and continue running the code. The program will run and stop again if it hits another `binding.pry`. Add another `binding.pry` to the end of this code, run it, and enter `exit` into the Pry session that opens up. You should hit another Pry.

You can also type `!!!` to tell Ruby to end the program right there instead of continuing to run the code. This can be very useful if you have many `binding.pry` statements, or if they are located inside a loop that will run many times.
