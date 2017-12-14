# Call Stacks & Return Values

---

![](https://www.youtube.com/watch?v=beqqGIdabrE)

---

# The "Stack" Data Structure

* a fundamental Data Structure in computer science
* a type of **Queue**
* "first-in-last-out" semantics
* things on top of the stack hide things on the bottom
* great for modeling processes that "nest"

---

# Terminology

* __Top__ - Most recently added element
* __Pushing__ - adding a new element to the top of the stack
* __Popping__ - removing the top element from the stack

---

# The "Stack" as Program Execution Model

* managing flow of execution and context within a computer program
* the program stack is so omnipresent we often refer to is as The Stack
* stacks are good for problems that require nesting or ordered execution
* programs "nest" from one method call or line of code into another
* interpreter uses a Stack to model and manage this process

---

# Example

```ruby
def module_one
  puts "projects are:"
  puts projects
end

def projects
  "enigma, complete me, headcount"
end

module_one
```

__Discussion:__ What happens when we evaluate this code?

---

# Series of Steps

1. Define each method (ruby evaluates the definitions)
2. Ruby invokes `module_one`
3. `module_one` calls `puts`, passing to it a new string (`"projects are:"`)
4. `puts` evaluates, printing some text and then **RETURNING** a value back to the place from which it was called (**Q:** What is the return value of puts)
5. `module_one` wants to call `puts` again, **but** this time it needs to call `projects` first in order to get the value to provide to `puts`, so it first calls `projects`
6. `module_one` now calls `puts` again, passing it the value it got from `projects`
7. `puts` evaluates, printing some text and again returning a value back to the place from which it was called

---

# So What

1. An outer method is able to "call into" another method, and it will wait until the inner method completes before continuing its execution
2. The inner method is able to generate a value and __return__ it back to the outer method, which can then access and use it.

---

# Exercise: Thinking About Return Values

In your notebook, write down the answers to these 2 questions:

1. What does it mean for a method to *return* a value to another method
2. What are some of the things that can happen to a returned value (try to come up with at least 2)

---

# Illustrating the Stack

* __Frame__ - When discussing the Stack in the context of program execution, we refer to each "element" on the stack as a Frame.
* __Winding / Unwinding__ - Synonyms for Pushing / Popping

---

# Visualizing Stack Exercise 1 - Module One

* Which methods are called
* In what order

Each time a method is invoked, put an index card for it onto the stack.

When the method is finished, remove its card from the stack.

**Question:** From a Stack perspective, how do you know when a program is "done"?

---

# The Stack and Execution Context

---

# Ruby Metaphysics: What Things Are There?

* Operations: generally methods
* Vaues: local variables/self (current object)

---

# Evaluating a Ruby Program

1. Track the sequential execution of methods in the order listed in the program (as we did in the previous stack example)
2. Track which objects are currently available to our program: What **local variables** are defined and what is **self**.

---

# Local Variable Definitions

* Local variables can be defined anywhere in a ruby program
* Variables are defined within a given "scope"
* Common scopes we encounter: methods and blocks (each creates its own independent scope)
* Passing a method argument creates a new local variable with the name of the argument

---

# Self

* `self` is ruby's way to identify the current object
* In reality there are 2 things we need to know about `self`
* 1. What is its __Class__ (since this gives it methods)
* 2. What are its __Instance Variables__ (since this gives it state)

---

# Exercise: Visualizing the Stack with State Mixed In

Use the cards to track 3 things:

1. What is the order of execution (shown by stacking cards)
2. What are the current local variables (list these on each card)
3. What is the current object (`self`) (list this on each card. include the object's Class and any ivars it contains)

---

# Setup

```
                       Current
 Locals      self      Method
--------   --------   --------
|      |   |      |   |      |
|      |   |      |   |      |
--------   --------   --------
```

---

# Exercise

As we step through the next simple program, we're going to place a card on *each* Stack, representing the current state of that column.

* See lesson plan for class.

---

# Paired Exercises

See lesson plan
