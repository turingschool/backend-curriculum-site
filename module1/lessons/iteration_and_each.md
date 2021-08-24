---
layout: page
title: Iteration and Each
tags: iteration, each
---

### What is iteration?

**Iterating** is doing something several times. In programming, **iteration** is used to describe taking a **collection** of items (like an array) and doing something to each of the items in that collection.

For example, let's say that we have a collection of names:

```ruby
names = ["Megan", "Brian", "Sal"]
```

What if we wanted to print out all the names in the collection; we may do something like this:

```ruby
print names[0]
print names[1]
print names[2]
```

And that works, right?

But what are some of the problems inherent to this approach? It wasn't too terrible to do with just three students in this array, but what if we had ten students? A hundred? A thousand? A million?

When we have a solution that works for a small number of items, but it doesn't work for a large number of items, we say that _it doesn't scale_. We want to design solution that are dynamic, meaning they can work for various inputs.

### Each

The scalability issue described above can be solved by using the method `each`.  `each` is a method that iterates over a collection. This means that `each` allows us to do something for every element of an array. An **Iteration** is a single pass over an element. We can use `each` to print all the names in our collection like this:

```ruby
names = ["Megan", "Brian", "Sal"]
names.each do |name|
  puts name
end
```

Let's break this down. `names` is our collection. It is an Array of three strings. `.each` is a method that we call on `names`.

Everything between the `do` and `end` is the **Block**. The **Block** is what runs for each element in the Array. Since we have three elements, this block will run a total of three times.

`name` is the **Block Variable**. For each iteration, this variable will contain the current element we are iterating over. So for the first iteration, `name` holds the value `"Megan"`, the second time it holds the value `"Brian"`, and the third time it holds the value `"Sal"`.

### Syntax

In general, the format for using `.each` looks like this.

```ruby
collection.each do |block_variable|
  # Code here runs for each element
end
```

#### Single-Line Syntax

You can replace a `do`/`end` with `{`/`}`. This allows you to write `each` on a single line. Our example from before could also be written as:

```ruby
names = ["Megan", "Brian", "Sal"]
names.each {|name| puts name }
```

Generally, we avoid using single-line syntax.


### Exercises

Use your debugger to work through the following exercises.

* If you had an array of numbers, e.g. [1,2,3,4], how do you print out the
doubles of each number? Triples?
* If you had the same array, how would you only print out the even numbers?
What about the odd numbers?
* How could you create a new array which contains each number multipled by 2?
* Given an array of first and last names, e.g. ["Alice Smith", "Bob Evans",
"Roy Rogers"],  how would you print out the full names line by line?
	* How would you print out only the first name?
	* How would you print out only the last name?
	* How could you print out only the initials?
	* How can you print out the last name and how many characters are in it?
	* How can you create an integer which represents the total number of characters in all the names?
