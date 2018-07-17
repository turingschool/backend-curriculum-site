---
layout: page
title: Programming with Values
length: 120
tags: Testing, TDD, OOP, Design, Fixtures, Headcount
---

## Outline

This lesson is divided into 5 sections:

1. Short warm-up discussion (~20 minutes)
1. Lecture
1. Student exercise
1. Share out
1. Review potential refactor

## Slides

Available [here](../slides/programming_with_values)

## Lesson

### Warmup

* What does 'single responsibility' mean in a programming context?
* How does programming with an eye towards the single responsibility principle help us as programmers?
* In past projects, what have you decided to test? What have you decided not to test?
* Why?

### Lecture

### Data Pains - limiting our interface to our objects

* Common pain point when dealing with external interfaces: we make
the external data dump the _only_ interface for sending information
into the object
* The action of bringing outside data in is contained within the object,
so our only way to provide it is to put the data in the right place (often a file)
and let the object slurp it in
* Programming with files/HTTP sources/Network data drives us to program with Locations rather
than values
* Rather than telling you the value of something I'll tell you it's on the whiteboard in the other classroom. Then you have to go look it up.
* What does this mean for our tests?
* What would an alternative look like?
* Can we preserve the simple data interface (i.e. provide data in the form of ruby
objects) _as well as_ the "slurp it up from a file" interface?
* Best of both worlds: Testability and flexibility when you want to provide standard basic
objects; Ease of use / "Do it all" when you need to pull in a bunch of external data
* Additional win: If the importing task becomes more complex, we can easily extract
it into a separate entity
* The interface between our objects is simple data, rather than external infrastructure

### Exercise - TDD Pizza Parlor

Keep these principles in mind as you complete this short
[Pizza Parlor Exercise](https://github.com/turingschool-examples/pizza_parlor)

### Share

* What did you test?
* What didn't you test?
* Can you test more if you refactored your code?

### Review Potential Refactors

* Can we isolate the file I/O?
* Can we extract it to a class?

## Further Reading / Watching

* [Programming with Values (earlier version of this lecture)](https://vimeo.com/157333800)
* [The Value of Values by Rich Hickey](https://www.youtube.com/watch?v=-6BsiVyC1kM)
* [Hexagonal Architecture by Alistair Cockburn](http://alistair.cockburn.us/Hexagonal+architecture)
* [Hexagonal Rails by Matt Wynne](https://www.youtube.com/watch?v=CGN4RFkhH2M)
