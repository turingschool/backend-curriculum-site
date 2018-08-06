---
title: Each
length: 90
tags: enumerable, ruby, collections, arrays, each,
---

## Learning Goals

* understand how to use #each
* Identify common patterns used with #each

# Scalability

Let's pretend that we've just graduated from Turing, and that we've landed our first sweet job at Hogwarts School of Witchcraft and Wizardry. Let's say that we've got an array of student names:

```ruby
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
```

What if we wanted to print out all of the items in this array? If we didn't
know what loops were we might do something like this.

```ruby
puts students[0]
puts students[1]
puts students[2]
```

And that works, right?

But what are some of the problems inherent to this approach? It wasn't too
terrible to do with just three students in this array, but what if we had ten
students? A hundred? A thousand? A million?

When we have a solution that works for a small number of items, but we
it doesn't work for a large number of items, we say that _it doesn't scale_. We want to design solution that are dynamic, meaning they can work for various inputs.

# \#each

A **Collection** in Ruby is an Array or Hash. For now, we will be focusing on Arrays.

Iterating is doing something several times.

`each` is method that iterates over a collection. This means that `each` allows us to do something for every element of an array. We can use `each` to print all of our Hogwarts students like this:

```ruby
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
students.each do |student_name|
  puts student_name
end
```

Let's break this down. `students` is our collection. It is an Array of three strings. `.each` is a method that we call on `students`.

Everything between the `do` and `end` is the **Block**. The **Block** is what runs for each element in the Array. Since we have three elements, this block will run a total of three times.

`student_name` is the **Block Variable**. For each iteration, this variable will contain the current element we are iterating over. So for the first iteration, `student_name` holds the value `Katie Bell`, the second time it holds the value `Neville Longbottom`, and the third time it holds the value `Luna Lovegood`.

In general, the format for using `.each` looks like this.

```ruby
collection.each do |block_variable|
  # Code here runs for each element
end
```

## Single-Line Syntax

You can replace a `do`/`end` with `{`/`}`. This allows you to write `each` on a single line. Our example from before could also be written as:

```ruby
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
students.each {|student_name| puts student_name }
```

Generally, we avoid using single-line syntax unless the operation inside the block is *very* short. In this example, it is appropriate. 

### Your Turn

Now it's your turn to practice.

With your new best friend sitting next to you, with this following array use
`.each` to:

`array = ["justin", "selena", "demi", "carly"]`

1. Can you print out their names capitalized?
2. Can you print out their names in all caps?
3. Can you print out their names but reversed?
4. Can you print out only the names that are longer than four letters in length?
5. Can you print out only the lengths of their names?


Now with this array can you do the following with `.each`?

`array = [1,2,3,4,5]`

1. Can you print only the odd numbers?
2. Can you print only the even numbers?
3. Can you print out each number doubled?
4. Can you print out if the number is divisible by 2 or not?
5. Can you print out the sum of the numbers?

### Additional Resources

* [Video](https://vimeo.com/160173522)
