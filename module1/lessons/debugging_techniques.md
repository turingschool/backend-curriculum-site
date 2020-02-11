---
title: Debugging Techniques
length: 120
tags: pry, debugging
layout: page
---

## Learning Goals

* Understand how to read a stack trace
* Understand common error messages
* Understand how to use pry to create breakpoints in code to help verify assumptions
* Develop a debugging process

## Tools & Repositories

To start, we need to make sure we have the appropriate tooling installed.

* [pry](https://github.com/pry/pry) - `gem install pry`

We'll also be using the [Erroneous Creatures](https://github.com/turingschool-examples/erroneous_creatures) respository. Clone that repository so that you have a version that you can work on locally.


## Warmup

* What do you do when you don't know what's going wrong with your application?
* What do you know about `pry`?
* What questions do you still have about `pry`?

## Debugging Process

There are two ways that programming can go wrong:

1. Your program doesn't run. You get an **Error**.
1. Your program runs, but it doesn't work the way you expect. You get a **Failure**.

Having a debugging process when things go wrong is crucial to being an effective developer. No matter how skilled you are at coding, you will always write bugs, so it is very important to know how to hunt them down and fix them.

The recommended series of steps you should take to Debug your program are:

* Read your error (the WHOLE error)
* Read your stack trace (find the error).
* Verify your assumptions.
* Try things.

You might add `research` to that list, but generally research is something that you do so that you can try things.

## Stack Trace

A Stack Trace shows what line of code an error occurred on, and all the method calls that led to that error. It is like a treasure map of exactly where to find the cause of the error.

### Reading a Stack Trace

Let's look at an example. If we run the `hobbit_test.rb` test in our erroneous_creatures directory with `ruby test/hobbit_test.rb`, we will see this:

```
1) Error:
HobbitTest#test_can_get_tired_if_play_3times:
NoMethodError: undefined method `>=' for nil:NilClass
    /Users/timo/staff_turing/lessons/debugging_techniques/erroneous_creatures/lib/hobbit.rb:18:in `adult?'
    /Users/timo/staff_turing/lessons/debugging_techniques/erroneous_creatures/lib/hobbit.rb:22:in `play'
    test/hobbit_test.rb:75:in `block in test_can_get_tired_if_play_3times'
    test/hobbit_test.rb:74:in `times'
    test/hobbit_test.rb:74:in `test_can_get_tired_if_play_3times'
```

Let's break this down line by line:

* `HobbitTest#test_can_get_tired_if_play_3times`: This is Minitest telling us what test was running when this error occurred.
* `NoMethodError: undefined method '>=' for nil:NilClass`: This is the actual error that occurred
* All of the following lines are part of the **Stack Trace**:
  * `/Users/timo/staff_turing/lessons/debugging_techniques/erroneous_creatures/lib/hobbit.rb:18:in 'adult?'`: This is the first line of the stack trace, and is the line where the error actually happened. The first part is a big long file path to the file. Generally, we only care about the last part, the file name. In this case, it is `hobbit.rb:18`. This is telling us that the error occurred in the `hobbit.rb` file on line 18. The next part, `in 'adult?'` tells us that this error happened in the `adult?` method. `hobbit.rb:18` is the most important part of the whole stack trace. It tells us the exact location of the error.
  * `/Users/timo/staff_turing/lessons/debugging_techniques/erroneous_creatures/lib/hobbit.rb:22:in 'play'`: The next line in the stack trace tells us where the `adult?` method was called from. Again, the most important part is the file and line number, `hobbit.rb` line 22. The last part, `in 'play'` is telling us that the `play` method was running when the `adult?` method was called.
  * `test/hobbit_test.rb:75:in block in test_can_get_tired_if_play_3times`: The next line in the stack trace tells us where the `play` method was called from. It was called from the `hobbit_test.rb` file on line 75 in a block.
  * `test/hobbit_test.rb:74:in times` is telling us that that block was part of a `times` loop that started on line `74`
  * `test/hobbit_test.rb:74:in 'test_can_get_tired_if_play_3times'` is telling us that the `times` loop was called from `test_can_get_tired_if_play_3times`.

If we chart this out as a series of method calls, it looks something like this:

```
test_can_get_tired_if_play_3times -> times -> play -> adult?
```

### Tracing back through our Program

When we use the stack trace, we start at the top and work our way down. In this case, we start at `hobbit.rb:18` to see the line where the error occurred. The error was `undefined method '>=' for nil:NilClass`. Looking at that line of code, we can see that the variable `@age` was misspelled, causing it to be `nil`. Fixing the spelling resolves the error.

If we didn't find an error in the `play` method, we could take another step back into the `adult?` method to see if we can find an error there.

When reading a stack trace, you should ignore references to code that you didn't write. For instance, run the `unicorn_test.rb` file and you will see this output:

```
/Users/timo/.rvm/rubies/ruby-2.4.1/lib/ruby/site_ruby/2.4.0/rubygems/core_ext/kernel_require.rb:120:in `require': cannot load such file -- .lib/unicorn (LoadError)
	from /Users/timo/.rvm/rubies/ruby-2.4.1/lib/ruby/site_ruby/2.4.0/rubygems/core_ext/kernel_require.rb:120:in `require'
	from test/unicorn_test.rb:4:in `<main>'
```

Let's follow our same process for reading the Stack Trace (note that unlike before, Minitest doesn't tell us what test was running). The first line tells us the error is `cannot load such file -- .lib/unicorn (LoadError)`. The next line tells it happened on line 20 of `kernel_require`. Because we didn't write `kernel_require` we can ignore that. The next line tells us that `kernel_require` code was called from `unicorn_test.rb` line 4. Examining this line, we can see a mispelling in our require statement.

## Errors

When you see an error in your terminal, it can be tempting to read it as "blah blah blah something isn't working, let me open up my code and fix it". Instead, you should read the error, the **ENTIRE** error, maybe even read it twice, and really try to understand your problem before you try to fix it. Here are some common errors and how we can interpret them:

`NameError: uninitialized constant SomeClass::SomeConstant` - Ruby doesn't know what `SomeConstant` is.

`undefined local variable or method 'x' for SomeObject (NameError)` - Ruby doesn't know what `x` is. It looked for a local variable `x` but couldn't find one. It then looked for a method `x` and couldn't find one for `SomeObject`

`wrong number of arguments (given x, expected y) (ArgumentError)` - You called a method with `x` number of arguments, but the method definition specifies it needs `y` number of arguments. This often happens when we call `.new` on something. Remember, when you call `.new` it also calls `.initialize` so you need to make sure the number of arguments you pass to `.new` match the number of arguments defined in `.initialize`

`undefined method 'some_method' for SomeObject:SomeClass (NoMethodError)` - you tried to call `some_method` on `SomeObject`, but `SomeObject` doesn't respond to that method. This means that `some_method` is not defined in `SomeClass`. This error can take several forms:

1. If you didn't write `SomeClass`, you called a method that doesn't exist i.e. `"hello world".first`.
1. If you did write `SomeClass`, you misspelled the name of the method or you didn't define `some_method` for `SomeClass`
1. If `SomeObject:SomeClass` shows up as `nil:NilClass`, this means that something is nil that shouldn't be.
1. Sometimes `SomeObject:SomeClass` looks like `#<SomeClass:0x00007f7fa21d5410>`. You can read this as "you tried to call `some_method` on a `SomeClass` object".

`syntax error, unexpected end-of-input, expecting keyword_end` - You are missing an `end`. Indenting your code properly will make it MUCH easier to hunt down the missing end.

`syntax error, unexpected end-of-input, expecting keyword_end` - You have an extra `end` or an `end` in the wrong place. Indenting your code properly will make it MUCH easier to hunt down the offensive end.


`require': cannot load such file -- file_name (LoadError)` - Ruby cannot load the file `file_name`. Make sure `file_name` is spelled correctly, the path is written correctly i.e. `./lib/file_name`, and that you are running from the root directory of your project.

## Verifying Your Assumptions

Not verifying your assumptions can be one of the costliest mistakes you make as a dev. It's possible to be *absolutely convinced* that you know exactly what's causing an error, spend hours working to resolve an issue that you're sure exists, only to later find that the error occurred long before the piece of code that held your focus so tightly.

While it's nice to drop into IRB to see if there are methods that exist in Ruby that I can use to solve my problem, it's even better to put a `pry` *into my code* to see exactly what I can do given the other methods and variables I've defined.

Let's run the Hippogriff test, and review the errors that are generated there:

```
Error:
HippogriffTest#test_when_it_flies_it_collects_a_unique_moonrock:
NoMethodError: undefined method `push' for nil:NilClass
    /Users/timo/staff_turing/lessons/debugging_techniques/erroneous_creatures/lib/hippogriff.rb:14:in `fly'
    test/hippogriff_test.rb:37:in `test_when_it_flies_it_collects_a_unique_moonrock'
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

Let's look at an error from our Wizard test suite:

```
Failure:
WizardTest#test_is_not_always_bearded [test/wizard_test.rb:25]:
Expected {:bearded=>false} to not be truthy.
```

With a partner:

* Read the stack trace to determine where the error is occurring.
* Use pry in the test file to verify any assumptions you may have about what's happening.
* Use pry in the Wizard class to see if you can determine how to implement this method before you enter any code into the Wizard class. Ask yourself: how can I get the return value that I want?

## Exercise - Erroneous Creatures

See if you can finish updating the Erroneous Creatures to make the rest of the test suite pass.

Use the debugging techniques discussed above to diagnose and fix the bugs, and get your creatures back to passing.

### Addenda / More Material

* http://tutorials.jumpstartlab.com/topics/debugging/debugging.html
