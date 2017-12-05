---
title: Debugging Techniques
length: 60
tags: pry, debugging
---

## Goals

* Install tools to help support our debugging process.
* Understand how to use feedback, verify assumptions and read stack traces.

## Tools & Repositories

To start, we need to make sure we have the appropriate tooling installed.

* [pry](https://github.com/pry/pry) - `gem install pry`

We'll also be using the [Erroneous Creatures](https://github.com/turingschool-examples/erroneous_creatures) respository. Clone that repository so that you have a version that you can work on locally.

## Warmup

* What do you do when you don't know what's going wrong with your application?
* What do you know about `pry`?
* What questions do you still have about `pry`?

## Lesson

### Overview

Things to try:

* Read your stack trace (find the error).
* Verify your assumptions.
* Try things.

You might add `research` to that list, but generally research is something that you do so that you can try things.

### Reading Your Stack Trace

Assuming you've written a test (often even if you haven't) you will likely have access to a stack trace that will tell you exactly where things are going wrong.

What does a stack trace look like?

Let's run our Erroneous Creatures test suite to see some examples.

```
Error:
HippogriffTest#test_when_moonrock_is_magical_when_collected:
NoMethodError: undefined method `push' for nil:NilClass
    /Users/sespinos/Desktop/erroneous_creatures/hippogriff.rb:14:in `fly'
        /Users/sespinos/Desktop/erroneous_creatures/hippogriff_test.rb:51:in `test_when_moonrock_is_magical_when_collected'`
```

Notice that the stack trace includes the following information:

* A specific error that was generated (in this case a no method error)
* The file where the error occurred
* The line in that file where the error occurred
* The file/line where the call that caused that error originated (here it's our test file)

In order to read a stack trace:

* Start at the top
* Read carefully (maybe even twice)
* Ignore references to code that you didn't write

### Verifying Your Assumptions

Not verifying your assumptions can be one of the costliest mistakes you make as a dev. It's possible to be *absolutely convinced* that you know exactly what's causing an error, spend hours working to resolve an issue that you're sure exists, only to later find that the error occurred long before the piece of code that held your focus so tightly.

While it's nice to drop into IRB to see if there are methods that exist in Ruby that I can use to solve my problem, it's even better to put a `pry` *into my code* to see exactly what I can do given the other methods and variables I've defined.

Let's run the Hippogriff test again, and review the errors that are generated there:

```
Error:
HippogriffTest#test_when_it_files_it_collects_a_unique_moonrock:
NoMethodError: undefined method `push' for nil:NilClass
    /Users/sespinos/Desktop/erroneous_creatures/hippogriff.rb:14:in `fly'
    /Users/sespinos/Desktop/erroneous_creatures/hippogriff_test.rb:37:in `test_when_it_files_it_collects_a_unique_moonrock'
```

Let's start by reading that stack trace, and then answer the following questions with a partner:

* What test is generating this error?
* What line in that test is generating the error?
* Is there any setup involved before we hit that line?
* If so, can we use pry to confirm that the setup has been completed successfully? Do we have access to the variables that we think we do? Are they holding the objects we expect them to?
* What about in the Hippogriff class itself? What line is generating an error?
* Use pry to verify that the variables we are using in that method are holding the objects we expect them to.
* Can you identify the error?
* Can you make the test pass?

### Trying Things

One other thing we can do when we are trying to debug is to use `pry` to try something in our code before we actually commit to adding it to our class.

Let's look at an error from our Hydra test suite:

```
Failure:
HydraTest#test_it_dies_if_it_loses_all_heads [/Users/sespinos/Desktop/erroneous_creatures/hydra_test.rb:36]:
Expected: true
  Actual: 0
```

With a partner:

* Read the stack trace to determine where the error is occurring.
* Use pry in the test file to verify any assumptions you may have about what's happening.
* Use pry in the Hydra class to see if you can determine how to implement this method before you enter any code into the Hydra class. Ask yourself: how can I get the return value that I want?

## Exercise - Erroneous Creatures

See if you can finish updating the Erroneous Creatures to make the rest of the test suite pass.

Use the debugging techniques discussed above to diagnose and fix the bugs, and get your creatures back to passing.

### Addenda / More Material

* http://tutorials.jumpstartlab.com/topics/debugging/debugging.html
