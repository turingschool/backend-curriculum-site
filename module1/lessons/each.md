--- 
title: Introduciton to .each
length: 90
tags: enumerable, ruby, collections, arrays, each,
---

# Exploring .each

### Goals

* understsand how to use single-line and multi-line each

### Introduction 

`#each` is the simplest of enumerables. Which leads us to the question, what is 
an enumerable?

It is a kind of method that lets us iterate over a collection. Those are all 
sorts of words. The large idea is that we have an array, and an array has a
collection of objects. When we use an enumerable, we want to go through each
and do something to each individual items. 

### Hogwarts 

So let's pretend that we've just graduated from Turing, and that we've landed
our first sweet job at Hogwarts School of Witchcraft and Wizardry. Our first 
task is to do some stuff with students. 

Now let's say that we've got an array of student names.

```
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
```

What if we wanted to print out all of the items in this array? If we didn't
know what loops were we might do something like this.

```
puts students[0]
puts students[1]
puts students[2]
```

And that works, right?

But what are some of the problems inherent to this approach? It wasn't too 
terrible to do with just three students in this array, but what if we had ten 
students? A hundred? A thousand? A million?

When we have a solution that works for a small number of items, but we 
it doesn't work for a large number of items, we say that _it doesn't scale_.

When we look at this pattern, we can come up with a kind of algorithmic 
solution. Each line of code that we've written is essentially the same except 
for the number, which goes up by one. So if we only new about loops, we can do 
something like this:

```
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]

counter = 0

while counter < 3 
  puts students[counter]
  counter += 1
end
```

Here, we are using a while loop in order to go through each item in this given
array to print out the name of the student. If you've had previous experience
in another language, you might reach for what's called a for loop. We don't have
those in Ruby, but this implementation using a while loop is probably the 
closest conceptually.

But here's another way.

```
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]

3.times do |index|
  puts students[index]
end
```

Here, we've looked at the times method yesterday, and this is slighly different. 

Right after the times method, we have a do, and in pipes we have index. This is 
what is known as a block parameter. How it works is that it kind of keeps track.
Here, we are executing the block thrice. `index` becomes 0 the first time it is 
executed, it becomes 1 the second time it is executing, and 2 the third time 
that it is executed. 

Let's talk a little bit more here about scalability.

The first approach that we took - to print out an array of three students
that took three lines of code. How many lines would we need if our array 
contained ten students? Fifty? A million?