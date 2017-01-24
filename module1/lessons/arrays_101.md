---
title: Arrays
length: 60
tags: ruby, arrays, data structures
---

# Introduction to Arrays

## Learning Goals

*   Understand the basic idea of a collection type
*   Develop a mental model to understand arrays
*   Gain some familiarity with common array methods

### What is a data structure?

-   A data structure is a particular way of organizing data in a computer so that it can be used efficiently

### What is an array?

-   Arrays are the most fundamental collection type in programming. Just about every language has them. Arrays are collections of data where each element is addressed by an arbitrary number called the *index* or *position*.

We'll step through using some of the fundamental Array methods, including:

*   `[]`
*   `count`
*   `<<` / `push`
*   `unshift`
*   `insert`
*   `pop`
*   `shift`
*   `shuffle`

As we go, we'll work with an IRB session.

1.  Create a new file in your module 1 folder called ```intro_to_arrays.rb```. In this file, you can take notes and recreate what we have used in our pry session to refer to.
2.  In our pry session let's create some data:
```ruby
name_1 = "Ilana"
name_2 = "Beth"
name_3 = "Lauren"
```
3.  Now that we have more than one name, we need a way to collection this data. Let's set a variable name "data" to an empty array.
```ruby
name_1 = "Ilana"
name_2 = "Beth"
name_3 = "Lauren"
data = []
```

  *This is how we represent an empty array in ruby*

4.  Count is a built-in ruby method. If our data array is empty, what would be expected to be returned from ```data.count```?

5.  How do we get information into the empty array?
```ruby
data << name_1
```
"shovel" or push
```ruby
data.push(name_1)
```
  This will always add to the end of the array.

  If we call ```data.count``` now, what do we expect to get?

  *Try it:* Let's shovel all our names into our data array.

6.  Just like a string, we can access each item by index/position.
```ruby
data[0]
```

-   We can also explicitly set the index of an item:
```ruby
data[0] = "Jeff"
```
What will this do to our original ```data```?

8.  We also have other ways to access positions within the array:
```ruby
data.first
data.last
```

9.  What if we want to add an item to the **beginning** of the array?
```ruby
name_4 = "Louisa"
data.unshift(name_4)
```

10. We can also pick a specific position to insert the item into:
```ruby
data.insert(2, "Horace")
```
  Now what does our data array show?

11. *Try It:* Using ruby docs, what method might we use to remove the last element of the array? What about the first element?

12. There are also a lot of other methods that we can call on an array. What do we think ```data.shuffle``` will do?

13. At this point, it is reasonable to wonder, how could we only get certain information from the array. Let's say that we only want to retrieve the first letter of each name. Now we have to go one by one through the array (what else is this called?) and return only the first letter of the name. How do we do that?

     Our data array already has names in it. Let's continue to use that. We need to make a new array that will hold our new collection of first letters.
```ruby
  certain_names = []
  data.each do |name|
    certain_names << name[0]
  end
```

  What happens when we call ```certain_names```? What about ```data```?

Got it? Here are the important concepts you've seen:

*   You can directly assign a value to a location in an array using `[]`
*   You can access the value stored at a position by using `[]`
*   You can add an element to the end of an array with `<<` or `.push`
*   You can remove an element from the end of an array with `.pop`
*   You can add an element to the front of an array with `.unshift`.
*   The `insert` method takes two arguments: first is the position where you want to insert the data, the second is the data to be inserted
*   `shuffle` returns a copy of your array with the elements randomly jumbled up
*   `each` is an *enumerable* method which takes a block parameter and runs that block once for *each* element in the collection.
