---
title: Each
length: 90
tags: enumerable, ruby, collections, arrays, each,
---

## Learning Goals

* Understand how to use #each to iterate over a collection
* Recognize the "map" and "inject" patterns used in iteration

## Vocabulary

* Collection
* Iteration
* Block
* Block Variable
* Map
* Inject/Reduce
* Modulo

# Scalability

Let's pretend that we've just graduated from Turing, and that we've landed our first sweet job at Hogwarts School of Witchcraft and Wizardry. Let's say that we've got an array of student names:

```ruby
students = ["Katie Bell", "Neville Longbottom", "Luna Lovegood"]
```

What if we wanted to print out all of the items in this array? If we didn't know what loops were we might do something like this.

```ruby
puts students[0]
puts students[1]
puts students[2]
```

And that works, right?

But what are some of the problems inherent to this approach? It wasn't too terrible to do with just three students in this array, but what if we had ten students? A hundred? A thousand? A million?

When we have a solution that works for a small number of items, but it doesn't work for a large number of items, we say that _it doesn't scale_. We want to design solution that are dynamic, meaning they can work for various inputs.

# \#each

A **Collection** in Ruby is an Array or Hash. For now, we will be focusing on Arrays.

**Iterating** is doing something several times.

`each` is a method that iterates over a collection. This means that `each` allows us to do something for every element of an array. An **Iteration** is a single pass over an element. We can use `each` to print all of our Hogwarts students like this:

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

# Credit Check Example

Let's use the [Credit Check Project](../projects/credit_check) as an example problem where we'll need to do some iteration. We'll follow along with the given example to write our Luhn Algorithm to validate the number `5541808923795240`.

## Getting the Digits

The first step is to double every other digit. For now, we'll double every digit, and then worry about every other. Because we need to do something for every element, this indicates to us that we need to use iteration. However, we can only iterate over collections, and what we have is a String. So, we need to change our String into an Array of characters using the `.chars` method:

```ruby
card_number = "5541808923795240"
characters = card_number.chars
p characters
```

We are using the `p` to print our `characters` array to the screen to check and see if it's what we want. `p` is a combination of `puts` and `inspect`. It is more useful to use `p` over `puts` when printing an array because it prints it in a format that is easier to read.

We now have characters, but what we want is an Array of Integers so we can do some math:

```ruby
card_number = "5541808923795240"
characters = card_number.chars
digits = []
characters.each do |character|
  digits << character.to_i
end
p digits
```

The first step is to create a container to hold our Integers, which we do with `digits = []`.

Then, for each character, we change it to an Integer, and then put it in our `digits` Array.

Run this code and you'll see an Array of Integers printed to the screen.

## Map

What we just did is known as the **Map** pattern. It is a very common pattern used when iterating over a collection. Mapping is when you take each value in the collection and change it using some rule or operation. In this case, we mapped each String in the Array to an Integer using the `to_i` method. We will learn later how to do this with the enumerable `map`, but for now it is important to understand how mapping works at the low level before getting fancy with enumerables.

A good indication that you need to use the map pattern is when the Array that you start with has the same number of elements as the Array you are trying to create. Our next task is to double every digit. The Array we start with is an Array of the 16 digits. The Array we want is an Array of 16 digits with the numbers doubled. This is another map:

```ruby
card_number = "5541808923795240"
characters = card_number.chars
digits = []
characters.each do |character|
  digits << character.to_i
end

doubled = []
digits.each do |digit|
  doubled << digit * 2
end

p doubled
```

## with_index

Now that we can double our digits, we want to be able to double every other digit. We can do this by getting the **Index** of our iteration. The index tells us which number iteration is currently running. Indexing starts at 0, so the first iteration is index 0, the second iteration is index 1, etc.

In order to access the index, we chain the `.with_index` method onto the each and add a second block variable. It's general form looks like:

```ruby
collection.each.with_index do |element, index|

end
```

On the first iteration, the value of index will be 0, on the second it will be 1, and so on. Notice that in order to use multiple block variables we separate them with a comma. This is true for any block that takes multiple variables.

According to our algorithm, we want to double the digits on the 0th, 2nd, 4th, 6th, etc. iterations. Notice that these are the even iterations. We can use this information to update our code to only double the even indexed numbers:

```ruby
card_number = "5541808923795240"
characters = card_number.chars
digits = []
characters.each do |character|
  digits << character.to_i
end

doubled = []
digits.each.with_index do |digit, index|
  if index.even?
    doubled << digit * 2
  else
    doubled << digit
  end
end

p doubled
```

## Summing digits over 10

The next step is to sum the digits over ten. We can use a handy shortcut that summing the digits together is the same as subtracting 9. Once again, this follows the map pattern:

```ruby
card_number = "5541808923795240"
characters = card_number.chars
digits = []
characters.each do |character|
  digits << character.to_i
end

doubled = []
digits.each.with_index do |digit, index|
  if index.even?
    doubled << digit * 2
  else
    doubled << digit
  end
end

summed_over_ten = []
doubled.each do |digit|
  if digit > 9
    summed_over_ten << digit - 9
  else
    summed_over_ten << digit
  end
end

p summed_over_ten
```

## Summing the digits

Now we need to add all the digits together. Finally, something doesn't follow the map pattern! This pattern is the **inject** or **reduce** pattern. We want to take all the elements of the collection and combine them to create a single value. In this case, we want to add them all together:

```ruby
card_number = "5541808923795240"
characters = card_number.chars
digits = []
characters.each do |character|
  digits << character.to_i
end

doubled = []
digits.each.with_index do |digit, index|
  if index.even?
    doubled << digit * 2
  else
    doubled << digit
  end
end

summed_over_ten = []
doubled.each do |digit|
  if digit > 9
    summed_over_ten << digit - 9
  else
    summed_over_ten << digit
  end
end

sum = 0
summed_over_ten.each do |digit|
  sum += digit
end

p sum
```

## Checking Validity

The final step of the algorithm is to check if the number is divisible by ten. We will do this finding the **Modulo**, more commonly known as the remainder. You can find the modulo using the `%` operator:

```ruby
card_number = "5541808923795240"
characters = card_number.chars
digits = []
characters.each do |character|
  digits << character.to_i
end

doubled = []
digits.each.with_index do |digit, index|
  if index.even?
    doubled << digit * 2
  else
    doubled << digit
  end
end

summed_over_ten = []
doubled.each do |digit|
  if digit > 9
    summed_over_ten << digit - 9
  else
    summed_over_ten << digit
  end
end

sum = 0

summed_over_ten.each do |digit|
  sum += digit
end

if sum % 10 == 0
  puts "The number #{card_number} is valid"
else
  puts "The number #{card_number} is invalid"
end
```

This code prints `The number 5541808923795240 is valid`, which is what we would expect. Our Luhn Algorithm is complete.

# Practice

Now it's your turn to practice.

With your new best friend sitting next to you, with this following array use
`.each` to:

`singers = ["justin", "selena", "demi", "carly"]`

1. Can you print out their names capitalized?
2. Can you print out their names in all caps?
3. Can you print out their names but reversed?
4. Can you create a new array with only the names that are longer than four letters in length?
5. Can you create a new array with the lengths of their names?


Now with this array can you do the following with `.each`?

`array = [1,2,3,4,5]`

1. Can you create a new array with only the odd numbers?
2. Can you create a new array with only the even numbers?
3. Can you print out each number doubled?
4. Can you print out if the number is divisible by 2 or not?
5. Can you find the the sum of the numbers?

### Additional Resources

* [Video](https://vimeo.com/160173522)
