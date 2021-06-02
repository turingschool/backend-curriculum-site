---
layout: page
title: Nested Iteration
length: 90
tags: enumerables, ruby
---

## Objectives
- Practice more complex iteration patterns
- Iterate over multiple collections
- Use `pry` to debug / as an implementation tool

## Warmup

Given the following array:  
```ruby
animals = [:dog, :cat, :zebra, :quokka, :unicorn, :bear]
```
Use an enumerable to
1. Return an array of animals as strings
2. Return an array of animals with length >= 4

Given the following array:  
```ruby
nested_animals = [[:dog, :cat, :zebra], [:quokka, :unicorn, :bear]]
```
Use an enumerable to
1. Return an unnested (single layer) array of animals as strings
2. Return an unnested array of animals with length >= 4
3. Return a hash where the keys are the animal, and the values are the length. ex: `{dog: 3, cat: 3, zebra: 5 ... }`

## Practice

We will be using the tools we have already learned (`.each`, `.map`, `pry`, etc...) to tackle some more complex iterations.  Up to now we have focused on iterating over a single collection to get some information, but you will often need to look at multiple collections to get the desired information.  To help us practice, clone [this repo](https://github.com/turingschool-examples/ruby_nested_iteration).

In the repo, you will find 4 skipped tests.  Starting with `course_spec.rb`, write the implemenation code to make these tests pass.  The first test will help familiarize you with the code base.  After `course_spec`, move on to the skipped tests in `school_spec.rb`. We will be stopping and checking in as a group throughout the exercise.

As you work, use `pry` OFTEN to verify your assumptions and try things out!
