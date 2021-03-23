---
title: Each
length: 60
tags: enumerable, ruby, collections, arrays, each,
---

## Learning Goals

* Understand how to use #each to iterate over an array
* Understand how to transform, create a subset, and  create something new with #each


## Vocabulary

* Collection
* Iteration
* Block
* Block Variable

## Warm Up

* What do you notice about the code below?
* What issues could potentially crop up?
* Is there an alternative you could propose?

```ruby
students = ["Megan", "Bob", "Mike"]
puts students[0]
puts students[1]
puts students[2]
```

## Lesson

When we have a solution that works for a small number of items, but does not work for a large number of items, we say that _it doesn't scale_. We want to design solutions that are dynamic, meaning they will work if we have 3 elements or 1 million elements.

### Introduction

A **Collection** in Ruby is an Array or a Hash. For now, we will be focusing on Arrays.

**Iterating** is doing something several times.

`each` is a method that iterates over a collection. This means that `each` allows us to do something for every element of an array. An **Iteration** is a single pass over an element. We can use `each` to print all of our students like this:

```ruby
students = ["Megan", "Bob", "Mike"]

students.each do |student|
  puts student
end
```

Let's break this down. `students` is our collection. It is an Array of three strings. `.each` is a method that we call on `students`.

Everything between the `do` and `end` is the **Block**. The **Block** is what runs for each element in the Array. Since we have three elements, this block will run a total of three times.

`student` is the **Block Variable**. For each iteration, this variable will contain the current element we are iterating over. So for the first iteration, `student` holds the value `Megan`, the second time it holds the value `Bob`, and the third time it holds the value `Mike`.

In general, the format for using `.each` looks like this.

```ruby
collection.each do |block_variable|
  # Code here runs for each element
  # the current element's value is stored in the block_variable variable
end
```
**Return Values**
One very important thing to remember: **each returns the original array**. This will make more sense as we learn more about enumerables during a later lesson.

### When to use \#each

Aside from printing all of the elements in a list, there are **a lot** of situations where we would need to use \#each.  You can use \#each to transform elements within a collection, transform the collection itself into a new collection, locate specific elements from a collection, or create something new with some or all of the elements in a collection.  The possibilities are really endless, which makes \#each (and iteration in general) one of the most useful tools in a developer's skillset.

Ruby has other methods that allow you to manipulate arrays. We will learn more about them later, but each is the workhorse of the array world. If you ever aren't quite sure if there's a method to do specifically what you want, you can always use each.

## Transform Every Element

Often, you will have a collection of objects that you need to transform, or map, into a new collection.  For example, if you had the array `['mike', 'bob', 'megan']` and you needed the array `['Mike', 'Bob', 'Megan']` you could use \#each to accomplish this goal.  Let's open a playground.rb file and take a look:

```ruby
#playground.rb
names = ['mike', 'bob', 'megan']

names.each do |name|
  name.capitalize
end

p names
```

Run the playground file - what happens?

Is this what you expected?

Most students would expect to see `['Mike', 'Bob', 'Megan']`, so why is that not the case?

Each gives us *access* to every element, but it doesn't save anything for us. If we want to save the capitalization (or save the transformed information), we need to create a place to save it, enter the accumulator:

```ruby
names = ['mike', 'bob', 'megan']

capitalized_names = []

names.each do |name|
  capitalized_names << name
end

p capitalized_names
```

Since we know that each won't save anything for us, we need to create some placeholder container to store our _new_ collection. In Mod 1, you may hear this placeholder called the accumulator or the aggregator. The thing to remember is that when you are using \#each, you will almost always use some sort of placeholder to preserve the result that you want - in this case, the capitalized names.  Without the placeholder, you will not be able to access the information that you want!

Again - without the accumulator/placeholder/aggregator, you will NOT be able to access the information you want.

## Get a Subset of a Collection

In the example above, we are using \#each to create a new array that is the same length as the original array - we are doing something to and storing _each and every_ element in the array. But what if we wanted to return only a subsection of a collection? We can still use \#each!

Take a look at the example below - what do you think will be printed to the terminal when this file is executed?

```ruby
#playground.rb
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

odd_numbers = []

numbers.each do |number|
  if number.odd?
    odd_numbers << number
  end
end

p odd_numbers

```

In this example, we can see how the addition of a simple boolean statement can help us use \#each to accomplish a more complex task - grabbing only _some_ of the elements in the array based on whether or not they meet a specific condition.

## Create Something New

What if we want to use a collection to build something new? Say we have a collection of integers and we want to know the sum of all of those integers? Let's take a look:

```ruby
#playground.rb
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

total = 0

numbers.each do |number|
  total += number
end

puts total
```

Unlike our previous examples, here we can see how \#each can be used to create something other than another collection.  In this case, we are using \#each to collect a running total (or sum) of each of the elements within the original collection, `numbers`.

The examples we have outlined are by no means a complete list of the ways that \#each can be used; they are only illustrations of the types of things you can accomplish with \#each.  As you grow your skills as a programmer, you will find more and more complex uses for \#each and iteration in general.

## Single-Line Syntax

You can replace a `do`/`end` with `{`/`}`. This allows you to write `each` on a single line. Our example from before could also be written as:

```ruby
students = ["Megan", "Bob", "Mike"]
students.each { |student| puts student }
```

Generally, we avoid using single-line syntax unless the operation inside the block is *very* short. In this example, it is appropriate since we have a short and simple operation.

"Programming is not like being in the CIA, you don't get credit for being sneaky" - Justin Etheredge.

Readability matters more than being clever.

# Practice

Now it's your turn to practice.

With your new best friends in your breakout room, use the following array with
`.each` to complete the following:

`singers = ["billie", "ariana", "lizzo", "leon"]`

1. Can you print out their names capitalized?
2. Can you print out their names in all caps?
3. Can you print out their names but reversed? (`["leon", "lizzo", "ariana", "billie"]`)
4. Can you create a new array with only the names that are longer than four letters in length?
5. Can you create a new array with the lengths of their names?

Now, with this array can you do the following using `.each`?

`numbers = [1,2,3,4,5]`

1. Can you create a new array with only the odd numbers?
2. Can you create a new array with only the even numbers?
3. Can you print out each number doubled?
4. Can you print out if the number is divisible by 2 or not?
5. Can you find the the sum of the numbers?

### Additional Resources

* [Video](https://vimeo.com/160173522)
