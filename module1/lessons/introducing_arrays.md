---
title: Introducing Arrays
length: 60
tags: ruby, arrays, names structures
---

## Learning Goals

*   Understand the basic idea of a collection type
*   Develop a mental model to understand arrays
*   Gain some familiarity with common array methods

## Slides

Available [here](../slides/introducing_arrays)

## Warmup

[Ruby Doc](https://ruby-doc.org/core-2.4.2/Array.html) defines an array as "ordered, integer-indexed collections of any object."

* What information can you pull out of that definition?
* Looking at the other information on that page, what can you tell about arrays?

## Vocabulary

* Data Structure
* Array
* Iterate

### What is a data structure?

-   A data structure is a particular way of organizing information so that it can be used efficiently

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

-   Create a new file in your module 1 folder called `intro_to_arrays.rb`. In this file, you can take notes and recreate what we have used in our pry session to refer to.
-   In our irb session let's create some names:

    ```ruby
    name_1 = "Josh"
    name_2 = "Mike"
    name_3 = "Lauren"
    ```
-   Now that we have more than one name, we need a way to collect this data or create a collection. Let's set a variable named "names" to an empty array.

    ```ruby
      name_1 = "Josh"
      name_2 = "Mike"
      name_3 = "Lauren"

      names = []
    ```

    *This is how we represent an empty array in ruby*

-   `.count` is a built-in ruby method. If our names array is empty, what would be expected to be returned from ```names.count```?

-   How do we get information into the empty array?

    ```ruby
    names << name_1
    ```

      "shovel" or push

    ```ruby
    names.push(name_1)
    ```

    This will always add to the end of the array.

    > What are the differences between `<<` and `.push`, if any? Let's check the Ruby docs to find an answer.

    If we call ```names.count``` now, what do we expect to get?

    *Try it:* Let's shovel all our names into our names array.

-   Just like a string, we can access each item by index/position.

    ```ruby
      names[0]
    ```

-   We can also explicitly set the index of an item:

    ```ruby
      names[0] = "Jeff"
    ```

    What will this do to our original ```names```?

-   We also have other ways to access positions within the array:

    ```ruby
      names.first
      names.last
    ```

-   What if we want to add an item to the **beginning** of the array?

    ```ruby
      name_4 = "Louisa"
      names.unshift(name_4)
    ```

-   We can also pick a specific position to insert the item into:

    ```ruby
      names.insert(2, "Sally")
    ```
    Now what does our names array show?

-   *Try It:* Using ruby docs, what method might we use to remove the last element of the array? What about the first element?

-   There are also a lot of other methods that we can call on an array. What do we think ```names.shuffle``` will do?

-   At this point, it is reasonable to wonder how we could only get certain information from the array. Let's say that we only want to retrieve the first letter of each name. Now we have to go one by one through the array (what else is this called?) and return only the first letter of the name. How do we do that?

    Our names array already has names in it. Let's continue to use that. We need to make a new array that will hold our new collection of first letters.

    ```ruby
      first_initial = []
      names.each do |name|
        first_initial << name[0]
      end
    ```

    What happens when we call ```first_initial```? What about ```names```?

## Summary

Got it? Here are the important concepts you've seen:

*   You can directly assign a value to a location in an array using `[]`
*   You can access the value stored at a position by using `[]`
*   You can add an element to the end of an array with `<<` or `.push`
*   You can remove an element from the end of an array with `.pop`
*   You can add an element to the front of an array with `.unshift`.
*   The `insert` method takes two arguments: first is the position where you want to insert the names, the second is the names to be inserted
*   `shuffle` returns a copy of your array with the elements randomly jumbled up
*   `each` is an *enumerable* method which takes a block parameter and runs that block once for *each* element in the collection.
