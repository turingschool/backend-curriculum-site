---
layout: page
title: Intermediate Enumerables
length: 90
tags: enumerables, max, min, max_by, min_by, sort_by, all?, any?, one?, none?
---

## Learning Goals

* Be able to use `max`, `max_by,` their opposites, and `sort_by` appropriately.

## Slides

Available [here](../slides/intermediate_enumerables)

## Vocabulary
* Enumerable
* Iterate
* Return Value
* max, max_by, min, min_by, sort_by

## Warm Up
* What enumerables have used so far?  

### Hook

We've got a handle on the beginner enumerables, and you've probably discovered some more on your own. In class so far, we've learned how to create a new collection, and how to search in the selection returning us either a single item or multiple items.

### min / max

What would we do if we wanted to take the smallest thing out of an array?

Let's think about how we would do that with .each.

```ruby
  def max(array)
    greatest = array.first
    array.each do |num|
      if num > greatest
        greatest = num
      end

    end

    greatest
  end

  max([1,3,9,2,5])
  => 9
```

That's cool. But there's a much easier way - we can make Ruby do the work for us.

```ruby
[1,3,9,2,5].max
=> 9
```

And what if we wanted to take the smallest? You'd just use `.min` instead.


**TURN & TALK:** All the other enumerables have a do block; these don't but are still considered enumerables - why?


Note that you can use these methods for strings as well as numbers. Letters have a sort of intrinsic values on their own.

What do I mean? open up a pry session in your terminal and type in,
`"a" > "b"`

We can see that the string, `"a"` is in fact, less than the string `"b"`.

Knowing this we can do some cool things like grabbing the "lowest" alphabetical string within an array.

```ruby
  ["victoria", "nate", "ali"].min
```

This code, here, it'll return us `"ali"`. Be careful - this is NOT comparing the length of the strings!

```Ruby
"zzz" > "aaaa"
true
```

If we swap out the min for a max, what will we get?

This is normally where we would have you try this on your own, but I'm not going to insult your intelligence.

### min_by / max_by

Getting the largest value out of an array is all well and good, but life isn't always that simple. We often deal with complex sets of data.

Imagine we have a class `Person` that has some data stored in instance variables. Let's just arbitrarily say that it is storing the person's name and their age.

```ruby
  class Person
    attr_reader :name,
                :age

    def initialize(name, age)
      @name = name
      @age = age
    end
  end
```

 So far, we haven't done anything even remotely exotic. But let's store a number of these persons into an array.

```ruby
people = []
people << Person.new("Tyrion", 32)
people << Person.new("Jaime", 26)
people << Person.new("Cercei", 36)

```

We've now got an array of three `Person` objects.

The challenge here is how we can grab the largest or smallest items by a particular attribute.

So let's walk this process out and look at how we would do this with .each. It's a lot like how we would implement .max or .min.

```ruby
  def max_by(people)
    result = people.first
    people.each do |person|
      result = person if person.age > result.age
    end
  end
```

This is very similar to our original implementation. The main difference is that instead of comparing the objects and determining which is "greater or lesser", we are comparing their attributes to each other.

And so, the max_by enumerable works similarly.

```ruby
  people.max_by do |person|
    person.age
  end
```

We are iterating over the array, looking at each item in the array, looking at the attribute and then returning the entire object that has the largest value that we want.

Simply put, to use this enumerable, we just list our criteria for searching in the block, and the numerable will simply give us the matching object.

We can also grab the first alphabetically here.

```ruby
  people.min_by do |person|
    person.name
  end
```

But we may be overcomplicating things. It doesn't have to be an array of objects, it can be an array of arrays. We're talking about a collection of things that might hold more than one piece of data.

So let's simplify the problem.

```ruby
  people = [
    ["Bob", 24],
    ["Jane", 26],
    ["Optimus Prime", 9_000_000]
  ]

  people.max_by do |person|
    person[1]
  end
```

Now you try.

```ruby
class Person
  attr_reader :name,
              :age

  def initialize(name, age)
    @name = name
    @age  = age
  end
end

bradys = []

bradys << Person.new("Carol", 48)
bradys << Person.new("Greg", 22)
bradys << Person.new("Mike", 52)
bradys << Person.new("Marsha", 19)
bradys << Person.new("Jan", 13)

```

On paper, get the oldest member of the Brady Bunch, and then grab me the first alphabetically.

Now check with your work with your neighbor.

### sort_by

We've worked on grabbing the largest thing or smallest thing out of a
collection, and that's great. But the next logical step is to sort them.

Essentially, it works very similarly to the enumerable methods that we've
been talking about so far. The main difference is that instead of
returning a single object, it returns an array of sorted objects, sorted
by the criteria that you select IN ASCENDING ORDER.

So let's look at some code.

```ruby
  [2,4,3,1].sort_by do |num|
    num
  end
```

This bit of code will return `[1,2,3,4]`, because it sorts items in
ascending order.

That's a simple array, we can take it to the next level by using
our previous example.

```ruby
class Person
  attr_reader :name,
              :age

  def initialize(name, age)
    @name = name
    @age  = age
  end
end

bradys = []

bradys << Person.new("Carol", 48)
bradys << Person.new("Greg", 22)
bradys << Person.new("Mike", 52)
bradys << Person.new("Marsha", 19)
bradys << Person.new("Jan", 13)

```

Using this, how do you think we can sort by their names alphabetically?

Do this on paper. Check your work with a nearby friend.

### all?

And now, for something completely different.

We're going to look at one of the enumerables that returns a simple true or false.

Let's look at the name of this enumerable, `all?`. Simply, it's an enumerable with a conditional in the block. If every item in a collection (every time through the block) returns `true` when going through the block, it returns `true`. Otherwise, it will return `false`.

Example:

```ruby
[1,1,1,1].all? do |num|
  num == 1
end
```

This returns `true`.

```ruby
["dog","cat","pig","hippopotamus"].all? do |word|
  word.length == 3
end
```

This would return false.

## WrapUp
* Name all the enumerables you know. What do they each return?

## For Homework:

In the [enums-exercises](https://github.com/turingschool/enums-exercises) complete the following pattern and regular tests:

-   all?
-   any?
-   none?
-   one?
-   sort_by
