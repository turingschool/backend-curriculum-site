---
title: Beginner Enumerables
length: 90
tags: enumerables, map, select, find
---

## Learning Goals

* Learn how to use & recreate the functionality of `map`, `select` and `find` using .each
* Understand when to use map, select, and find appropriately.

## Vocabulary  
* enumerable  
* iterate  
* map, select, find  

## WarmUp  
* What is an enumerable? What is a use case for one?  
* Write the block of code to use .each to print each letter in the following array `name = ["A", "l", "i"]`

## Intro

We've already learned how to use each, and we can do some really cool
things with it, but let's do better.

### `map` / `collect`

`map` is a lot like `each`.

The difference is that `map` actually returns whatever we do in the block. Think about how this is different from each which will always return the content of the original array.

Let's look at this in code. Let's take an array of the numbers one through five, and we want to end up with an array with the doubles of each of those numbers. With `each`, we would do it like this:

```ruby
def double
  numbers = [1,2,3,4,5]

  result = []

  numbers.each do |num|
    result << num * 2
  end

  result
end

result 
=> [2,4,6,8,10]

numbers 
=> [1,2,3,4,5]
```

We've written a method called `double`. We start off with `result`, which we set to an empty array. With each, we iterate through each item of `numbers`, and with each element, we are doubling the number and we are putting it into the `result` container. At the end, we are returning the `result` variable, which should now contain [2,4,6,8,10].

This code is decent. But there are things about it I'm not entirely thrilled about. For example, we are temporarily storing things in a variable, `result`, which is inefficient. You want to avoid the use of unnecessary variables when you can. This is how we can achieve the same result using `map`.

```ruby
def double
  numbers = [1,2,3,4,5]

  numbers.map do |num|
    num * 2
  end
end
```

Instinctually, this should look better to you. We don't have any unnecessary variable assignment and `map` is handling all we need to return.

```ruby
def double
  numbers = [1,2,3,4,5]

  numbers.map do |num|
    num * 2
    puts "I really, really like you"
  end
end
```

With this code, what do you think this method returns? Why?  
Many folks are tempted to save the result of map to a variable. Why might I disagree with this choice?  

#### Independent Practice
I want this method to return all of these names in caps.

```ruby
def internally_screaming
  people = ["Taylor Swift", "Carly Rae Jeppsen", "Justin Bieber"]

  people.map do |name|
    # CODE HERE!
  end
end
```
**Turn & Talk**  
Share you code with your neighbor.  Talk them through what is happening line by line - be specific. What is similar/different? Why did you make the choices you made?  

### `find` / `detect`

A good thing about the methods in Ruby is that you can pretty much figure out what they do just by their name.

**Agree/Disagree**
What do you think `find` or `detect` does? What will it return?  

`find` will return the first item from the collection that evaluates as truthy.

But before we go into how that works, let's implement it with `each`.

```ruby
def find_me_first_even
  numbers = [1,2,3,4,5]

  numbers.each do |num|
    return num if num.even?
  end
end
```

We walk through the array, and upon the first number it comes across that makes the block return true, it just returns the item and we are D-U-N, done.

This looks like fairly simple code, but we can make it cleaner with `find`.

```ruby
def find_me_first_even
  numbers = [1,2,3,4,5]

  numbers.find do |num|
    num.even?
  end
end
```

Oh just look at that, so nice. Remember, it will return the first item for which the block returns a truthy value.

#### Independent Practice  
Find the first word over three letters in length.

```ruby
def find_long
  array = ["dog", "caterpillar", "bee" ]

  array.find do |word|
    #CODE HERE
  end
end
```
**Turn & Talk**  
Share you code with your neighbor.  Talk them through what is happening line by line - be specific. What is similar/different? Why did you make the choices you made?  

### `find_all` / `select`

We've figured out how to get one matching thing out of an array, but what if we want ALL of the matching things?

Let's start by thinking about how we would do this using our old friend, `each`.

```ruby
def all_the_odds
  numbers = [1,2,3,4,5]
  result = []
  numbers.each do |num|
    result << num if num.odd?
  end
  result
end
```

How does this look?
Not bad, but we're stuck with that `result` container that we don't like. Pay attention to this - it's a pattern we want to keep an eye out for in the future. **If we are catching things with a collector like this, there's probably a better enumerable that we can use.** So let's use `select`.

```ruby
def all_the_odds
  numbers = [1,2,3,4,5]
  numbers.select do |num|
    num.odd?
  end
end
```

**Agree/Disagree** Why is this better? 

#### Independent Practice
Let's grab all of the people whose name starts with a T.

```ruby
def named_t
  names = ["Taylor", "Francis", "Bella", "Tori", "Jay"]
  names.select do |name|
    # CODE HERE
  end
end
```

## WrapUp 
* What do map, find, and select do? What do they return? 
* What makes them preferable to each?   


### Homework

Work on the `map`, `find`, and `select` exercises for [Enums-Exercises](https://github.com/turingschool/enums-exercises).

Work through [Beginner Enumerables](https://github.com/turingschool-examples/beginner_enums/) according to instructions within its README.
