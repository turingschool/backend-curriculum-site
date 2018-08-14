---
title: Debugging with Pry
tags: debugging, pry
layout: page
---

# Pry

## Installing Pry

If you haven't already, in your terminal, enter the command:

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


### Pausing

Create a new Ruby file called `pry.rb` and add this code to it:

```ruby
require 'pry'

favorite_things = ["Trapper Keeper", "Netscape Navigator", "Troll Doll"]
binding.pry
```

The first line requires Pry, which allows us to use it in this file.

Run the code and you should see a Pry prompt. Depending on your screen size, you may also see a colon, which means you are in a pager. Hit `q` to exit the pager.

Whenever Ruby sees a `binding.pry` statement, Ruby pauses the execution of code and opens up a Pry session *in the middle of the code*. This Pry session is a the same as the one we opened before, except that you now have access to the variables and methods that Ruby has created up to that point in the code. In your Pry prompt, enter `favorite_things` and you will see the array stored in the favorite_things variable. Just like the Pry session before, you can run any Ruby code inside this session. Try it by entering `favorite_things.length` and `favorite_things[0]`.

### Resuming

You can type `exit` to tell Ruby to close the Pry session and continue running the code. The program will run and stop again if it hits another `binding.pry`. Enter `exit` into your Pry session and you will see the program end since there are no more `binding.pry`s

Update your code to this:

```ruby
require 'pry'

favorite_things = ["Trapper Keeper", "Netscape Navigator", "Troll Doll"]
binding.pry
new_thing = "Banana Split"
favorite_things << new_thing
binding.pry
```

Run this code, and your program will pause at the *first* `binding.pry`. Try typing in `new_thing` and you will see that this variable hasn't been defined yet. Type `exit` and Ruby will continue running and stop at the second `binding.pry`. Now type `new_thing` and you will see that you have access to that variable, because this `binding.pry` happened after the variable was defined. Also, type in `favorite_things` and you will see the array has been updated.

### Stopping

We can also put a `binding.pry` in a loop. Update your code to this:

```ruby
require 'pry'

favorite_things = ["Trapper Keeper", "Netscape Navigator", "Troll Doll"]
new_thing = "Banana Split"
favorite_things << new_thing
25.times do
  p favorite_things
  binding.pry
end

```

Now our `binding.pry` is inside a loop that happens 25 times. Run this code and type `exit` a couple times. You'll notice that you continue to hit the same pry statement. If we have a loop that runs many times, it can be a pain to type `exit` over and over to get to the end of the program. You can instead force the program to end by typing `exit!` or `!!!`.

### Summary

* `require 'pry'` at the top of your file.
* Use `binding.pry` inside your code to tell Ruby to *Pause* your program when it hits that line of code.
* Use `exit` to tell Ruby to *Resume* running your code.
* Use `exit!` or `!!!` to tell Ruby to *Stop* your program.
* If you get stuck in a pager, denoted by a colon `:`, you can hit `q` to exit the pager.
