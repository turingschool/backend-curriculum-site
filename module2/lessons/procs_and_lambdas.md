---
title: Procs and Lambdas in Ruby
length: 60
tags: procs, lambdas, ruby, enumerables
---

## Learning Goals

* Don't be scared when someone says Proc or lambda
* Explain how Procs, lambdas, and blocks are all related
* Refactor common enumerables with lambdas

## Structure

|--|--|
|5|Warm Up|
|10|Overview|
|10|Code Along|
|5| Pomodoro |
|15|Code Along|
|10|Wrap Up|

## Warm-up

* How do you know when you see a "block" of code in Ruby?
* In your own words, what is a block?
* Why is the DRY principle important?

## Brief Overview

Procs and lambdas are NOT required to be a good programmer. I was really intimidated by them when I was going through Turing, because they had weird syntax, and people said to just not worry about them. After diving into Javascript and falling in love with functions as objects I could pass around, I wanted to have the same abilities in Ruby. Procs and lambdas are just that: *blocks of code in the form of an object*.

Proc is short for **procedure**. That's it. Nothing fancy or complex. Just a bundle of code that we can use to carry out a task. Lambdas are special types of Procs, which you can explore in the resources below another time. Today we're just going to see how they can clean up our code.

Methods carry out tasks the minute they are called, Procs and lambdas just require a "message" in order to invoke them. When you type `some_method` that refers to:

```ruby
def some_method
  ...
end
```

that `some_method` is not an object. It is just an instantly invoked set of instructions. However, since everything is an object in Ruby, we can actually peek under the hood at how `some_method`, actually **is** an object. Open a pry session and run this code:

```ruby
def adder(number1, number2)
  number1 + number2
end

adder(1,10) #=> 11

method(:adder) #=> #<Method: Object#adder>
method(:adder).call(10,1) #=> 11
```

When we call `adder` on its own, it appears that `.call` happens under the hood. That `.call` is the message that Procs and lambdas need to hear before they actually execute their instructions. If a set of instructions doesn't execute right when it is mentioned, like a regular method or block (`{...}` and `do ... end`), we can save it assign it to a variable and pass it around just like any other object.

In review, Procs and lambdas are the Ruby way to store methods as objects. Let's see it in action.

## Code Along

Clone [this repo](https://github.com/turingschool-examples/text_analyzer).

We'll walk through refactoring these methods as a class.

## Wrap-Up

* Review learning goals:
  * What does Proc stand for?
  * In Ruby, are methods objects?
  * How are Procs and lambdas different from blocks and methods?
  * How are Procs, lambdas, methods, and blocks the same?
  * What are some cases where refactoring with a lambda could be useful?

## Resources

* [Blocks, Procs, and Lambdas](http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/)
* [Blog post with examples](https://medium.com/@tmikeschutte/lambdas-and-enumerables-in-ruby-d1f52c34852)
* [Gist with examples](https://gist.github.com/tmikeschu/1edc0dafce76aaf51ef450cb9525989c)
* [A succinct stack overflow answer](https://stackoverflow.com/questions/1246099/ruby-method-proc-and-block-confusion)
