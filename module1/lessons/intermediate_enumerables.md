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
* Block
* max, max_by, min, min_by, sort_by

## Warm Up

Given the array `kardashians = ["Khloe", "Kim", "Kris", "Kourtney"]`

* Find all the Kardashians with 3 or more letters
* Find `"Kris"`
* Create a new array with all the names upcased

# Lesson

We've got a handle on the beginner enumerables, and you've probably discovered some more on your own. In class so far, we've learned how to create a new collection, and how to search in the selection returning us either a single item or multiple items.

## min / max

What would we do if we wanted to get the largest thing out of an array?

Let's think about how we would do that with .each.

```ruby
nums = [1,3,9,2,5]
greatest = nums.first
nums.each do |num|
  if num > greatest
    greatest = num
  end
end

puts greatest
```

That's cool. But there's a much easier way - we can make Ruby do the work for us.

```ruby
nums = [1,3,9,2,5]
puts nums.max
```

And what if we wanted to take the smallest? You'd just use `.min` instead.

**TURN & TALK:** All the other enumerables have a do block; these don't but are still considered enumerables - why?

## Comparing Strings

You can use these methods for strings as well as numbers. Letters have a sort of intrinsic values on their own.

What do I mean? open up a pry session in your terminal and type in,
`"a" > "b"`

We can see that the string, `"a"` is in fact, less than the string `"b"`.

Knowing this we can do some cool things like grabbing the "lowest" alphabetical string within an array.

```ruby
  ["Brian", "Mike", "Amy"].min
```

This code, here, it'll return us `"Amy"`. Be careful - this is NOT straight up comparing the length of the strings - it's comparing the value of each string! Try running this: `["hello", "hi", "hey"].min`

```Ruby
"zzz" > "aaaa"
true
```

If we swap out the min for a max, what will we get?

This is normally where we would have you try this on your own, but I'm not going to insult your intelligence.

## min_by / max_by

Let's go back to our code to find the largest value using `each`. This time we'll use an array of Strings as the example:

```ruby
names = ["Khloe", "Kim", "Kris", "Kourtney"]
greatest = names.first
names.each do |name|
  if name > greatest
    greatest = name
  end
end

puts greatest
```

In this example, we use the greater than operator `>` to compare our Strings. We just saw that by default Ruby compares Strings by the letter value. What if we want it to do something different, for example, compare by the length of the String? We'd have to do this:

```ruby
names = ["Khloe", "Kim", "Kris", "Kourtney"]
greatest = names.first
names.each do |name|
  if name.length > greatest.length
    greatest = name
  end
end

puts greatest
```

The idea here is that we are overriding how we are comparing the elements in the array. We can do this even easier with `max_by`:

```ruby
names = ["Khloe", "Kim", "Kris", "Kourtney"]
greatest = names.max_by do |name|
  name.length
end
```

`max_by` takes whatever the last line of code executed in the block is and uses that to find the max element. In this case, it uses the length of each String to determine what the max should be.

This is quite handy when we make our own objects and we want to find the max/min based on some criteria. Imagine we have a class `Person` that stores a name and age:

```ruby
  class Person

    attr_reader :name,
                :age

    def initialize(name, age)
      @name = name
      @age  = age
    end

  end
```

 And let's store some instances of `Person` in an Array:

```ruby
people = []
people << Person.new("Sofia", 4)
people << Person.new("Scarlett", 9)
people << Person.new("Stella", 8)
```

What if we wanted to get the max Person by age? If you call `people.max`, Ruby will tell you it doesn't know how to compare two `Person` objects.

So let's walk this process out and look at how we would do this with .each. It's a lot like how we would implement .max or .min.

```ruby
  def max_by(people)
    oldest = people.first

    people.each do |person|
      if person.age > oldest.age
        oldest = person
      end
    end

    oldest
  end
```

This is very similar to our original implementation. The main difference is that instead of comparing the objects and determining which is "greater or lesser", we are comparing _their attributes_ to each other.

And so, the max_by enumerable works similarly.

```ruby
  greatest = people.max_by do |person|   # use the max_by enumerable to iterate
    person.age                # max_by will return the greatest person.age
  end
```

We are iterating over the array, looking at each item in the array, looking at the attribute and then returning the entire object that has the largest value that we want.

Another way to see it, to use this enumerable, we list our criteria for searching in the block, and the enumerable will simply give us the matching object.

We can also grab the first alphabetically here.

```ruby
  people.min_by do |person|
    person.name
  end
```

It doesn't have to be an array of objects, it can be an array of arrays. We're talking about a collection of things that might hold more than one piece of data.

So let's simplify the problem.

```ruby
  people = [
    ["Sofie", 4],
    ["Scarlett", 9],
    ["Stella", 8]
  ]

  people.max_by do |person|
    person[1]                # index 1 is the integer/age
  end
```

To find the youngest person, I would use the `min_by` method.

#### Now you try:

```ruby
class Person
  attr_reader :name,
              :age

  def initialize(name, age)
    @name = name
    @age  = age
  end
end

kardashians = []

kardashians << Person.new("Kourtney", 39)
kardashians << Person.new("Kim", 37)
kardashians << Person.new("Kris", 62)
kardashians << Person.new("Khloe", 33)
```

Write code to:

* Get the youngest member
* Get the person with the shortest name

## Sort

We've worked on grabbing the largest thing or smallest thing out of a
collection, and that's great. But the next logical step is to sort them.

Essentially, it works very similarly to the enumerable methods that we've
been talking about so far. The main difference is that instead of
returning a single object, it returns an array of sorted objects, sorted
by the criteria that you select IN ASCENDING ORDER.

Just like with `max`, ruby Arrays have a method `sort` that will sort based on the default comparison. For Integers, this is simply sorting based on value:

```ruby
[2,4,3,1].sort
=> [1,2,3,4]
```

For Strings, it will sort alphabetically:

```Ruby
["Brian", "Mike", "Amy"].sort
=> ["Amy", "Brian", "Mike"]
```

## sort_by

Just like with `max` and `min`, sometimes the default comparison isn't good enough, and we want to override how ruby will compare our objects. For instance, if we want to sort Strings based on their length:

```ruby
names = ["Khloe", "Kim", "Kris", "Kourtney"]
sorted = names.sort_by do |name|
  name.length
end
```

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

kardashians = []

kardashians << Person.new("Kourtney", 39)
kardashians << Person.new("Kim", 37)
kardashians << Person.new("Kris", 62)
kardashians << Person.new("Khloe", 33)
```

Using this, how do you think we can sort by their names alphabetically?
Do this on paper. Check your work with your BFF.

Extension: How could you create a list of names going in the opposite order?

**CFU:** What is the return value of `sort_by`?

## all?

And now, for something completely different.

We're going to look at one of the enumerables that returns a simple true or false. This is  indicated by the method ending with a '?'.

Let's look at the name of this enumerable, `all?`. Under the hood, it's an enumerable with a conditional in the block. If **every** item in a collection returns `true` when going through the block, the entire method returns `true`. Otherwise, it will return `false`.

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

Given what you just learned about `all?` - can make an educated guess about what `any?`, `none?`, and `one?` do/return?

## Wrap Up

* Name all the enumerables you know. What do they each return?

### For Homework:
In the enums-exercises, complete the following:

* find_using_max_by_test.rb
* sort_by_test.rb
* all_pattern_test.rb
* all_test.rb
* any_pattern_test.rb
* any_test.rb
* none_pattern_test.rb
* none_test.rb
* one_pattern_test.rb
* one_test.rb
