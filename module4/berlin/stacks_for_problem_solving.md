---
title: Stacks for Problem Solving
layout: page
---

Let's talk about stacks.

## Learning Goals

* Students will have practiced the basic principles of a Stack data structure
* Students will have tried an example problem where knowledge of a specific data structure makes the work much easier

## Well-Formed Strings

* Read the [Well-Formed Strings challenge](https://github.com/turingschool/challenges/blob/master/well_formed_strings.markdown)
* Think about or sketch pseudocode for how you'd go about solving it
* Imagine real-world situations where you'd want to run this kind of validation on a chunk of text/data

## Quick Introduction to Stacks

A "Stack" was one of the basic data structures we talked about last week. It's similar complexity to a Linked List, but likely a little easier to understand. Let's talk about it for a few minutes, then dive into using it.

### Concept

* Imagine a stack of plates in your kitchen cabinet
* It's "LIFO"
* You `push` an element onto the top
* You `pop` an element off the top
* Those are both "mutator" methods
* Some common "accessor" methods could be `empty?`, `count`, and `top`

### Implementation

* You can of course write a nice `Stack` class in your language of choice
* But we can use an array just like a stack
* Most of the named operations are built right into your language's Array functionaity
* Here's `push` in [JavaScript/MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push) and [Ruby Docs](https://ruby-doc.org/core-2.5.0/Array.html#method-i-push)

### Example Sequence

* Create an empty array
* Push the string `"Mexico"`
* Push the string `"Canada"`
* Push the string `"United States"`
* Pop and you should get `"United States"` returned back
* Count and confirm that there are now only two elements on the stack
* Push `"Cuba"`
* Push `"Dominican Republic"`
* Pop until you run out of elements
* What happens when you call pop on an empty array?

## Work Session

* Work solo on the [Well-Formed Strings challenge](https://github.com/turingschool/challenges/blob/master/well_formed_strings.markdown) using a stack
* Make sure you iterate from *simple* cases to more *complex* cases
* If you get done with the example cases, consider the "edge cases", for example:
  * What about an empty `""` input?
  * What about just a close `")"`?
  * What about too many closes `"())"`
  * Are any other characters allowed like `"( [ ] )"`?

### Review

1. Were you able to get the stack concept working for pairing parentheses?
2. What about more complex cases?
3. If you didn't use a stack, how would you try to solve this problem?

## Additional Information

* I stumbled on [some video I made many years ago about building a `Stack` class in Ruby](https://vimeo.com/125297304)
* That video was probably trying to [complete this assignment of a "Basic Stack"](https://github.com/turingschool/challenges/blob/master/basic_stack.markdown)
