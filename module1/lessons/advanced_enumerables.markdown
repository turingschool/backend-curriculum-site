---
title: Advanced Enumerables
length: 90
tags: enumerables, ruby, zip, group_by, inject
---

## Learning Goals

* Be able to explain the difference between the Enumerable module and Enumerator class
* Understand when and how to use `zip`, `group_by`, and `inject` appropriately

## Vocabulary
* Enumerable
* Enumerator
* zip
* group_by
* inject

## Hook

We've looked at a number of enumerables in the past, quite a lot of them, and today we are going to look at some of the tougher enumerables, and how we can chain them.

## Warm Up  
* Make a chart of all the enumerables you know at this point, what they do, and what they return  

```
enumerable | what it's used for | return value
----------------------------------------------
           |                    |
```

## `zip`

We have two arrays. We want to put them together, but how can we do that? We would use the enumerable `zip`. Similar to the way a zipper works: when we zip up a zipper, we tooth by tooth combine a tooth from the left side and a tooth from the right side and then a tooth from the left side and so on until we are all zipped up.

`zip` in Ruby essentially shifts an element from the first array and shifts one from the second array and continues doing so until it creates a new array where the first element of this array is an array itself where the first element is the shifted element from the first array and the second element is the shifted element of the second array.

That's complicated so let's just see it in action.

```ruby
a = ["1", "2", "3"]
b = ["a", "b", "c"]

a.zip(b)
=> [["1", "a"], ["2", "b"], ["3", "c"]]
```

Is that what we expected? (The answer to this should be yes.)

### Exercise: `zip`

**Challenge #1:** Zip these two arrays together and then print out to the screen this brilliant ditty.

```ruby
chocolate     = [ "Ritual",
                  "Chuao",
                  "Chocolove",
                  "Scharffen Berger"]
peanut_butter = [ "Peter Pan",
                  "Skippy",
                  "Justin's",
                  "Smucker's",
                  "Crazy Richard's"]

"You got your Ritual in my Peter Pan!"
"You got your Peter Pan in my Ritual!"
"You got your Chuao in my Skippy!"
# ...and so on and so forth.
```

**Challenge #2:** Let's practice with some real world data. This is something that you'll often get. Someone writes some pretty poor software, and you get two associated arrays, but you need to actually put it together. People are the worst.

```ruby
people = ["Hannah",
          "Penelope",
          "Rabastan",
          "Neville",
          "Tonks",
          "Seamus"]

houses = ["Hufflepuff",
          "Ravenclaw",
          "Slytherin",
          "Gryffindor",
          "Hufflepuff",
          "Gryffindor"]

"Hannah is in Hufflepuff."
"Penelope is in Ravenclaw."
# ...and so on and so forth.
```

**FlashCard**

Let's make a \#zip flashcard! Following the format that we used for our previous enumerables, create two flashcards for the enumerable \#zip.

## `group_by`

We're going to put this idea of people and houses on hold for a second and talk about the greater idea of why we use enumerables. We've done a lot of things with enumerables.

With `.each` we've iterated through a collection and done something with each item. With `.map` we've iterated through a collection, and returned a new collection whose result was what the block returned. With `.find` and `.find_all` we've searched in a collection for something. We can probably say that `.max`, `.min`, `.max_by` and `.min_by` do the same thing, essentially. We're looking for something in a collection, and what we are looking for has certain criteria.

The next step is to start using enumerables to take existing collections and MAKE OUR OWN. `group_by` is a great place to start.

`group_by` takes an array, creates a Hash where the key is the return value of the block, and the value is the item we are currently examining in the enumerable. Let's just repeat that one more time to ourselves slowly. We are creating a HASH, where the KEY is the return value of the block and the VALUE is the item we are currently examining in the enumerable (the element in the collection we're examining).

```ruby
array = ["dog", "fish", "corgi"]
```

In this example, `group_by` is going to help create a hash, where the keys are how long the words are, and the values are the actual words. This is what `group_by` DOES.

```ruby
array.group_by { |string| string.length }
=> {3=>["dog"], 4=>["fish"], 5=>["corgi"]}
```

Note that the values in this hash are all arrays. In this example, when more than one word shares the same length, the words will be held in the array matching the key length they share.

```ruby
array = ["dog", "cat", "fish", "corgi"]
=> {3=>["dog", "cat"], 4=>["fish"], 5=>["corgi"]}
```
This is cool but kind of useless. What else can we do? How about first letters?

### Exercise: `group_by`

Using `group_by` on this array (`array = ["aardvark", "art", "airplane", "boy", "burp", "boot", "green", "goop", "super"]`), create a Hash where the keys are the first letter of words, and the values are the list of words that share that first letter.

### Group Discussion

* Given what you now know about \#group_by, what might be some limitations of this method?  
* If you were given the array of Record objects created with the class below, how would you produce a hash where the keys are the artist and the values are the array of songs for that artist?

```ruby
class Record
  attr_reader :title,
              :artist,
              :songs
  def initialize(title, artist, songs)
    @title = title
    @artist = artist
    @songs = songs
  end
end

abbey_road = Record.new("Abbey Road", "the Beatles", ["Come Together", "Here Comes the Sun", "Because"])
sgt_pepper = Record.new("Sgt Peppers", "the Beatles", ["Sgt. Pepper's Lonely Hearts Club Band", "With a Little Help from My Friends", "Lucy in the Sky with Diamods"])
out_of_our_heads = Record.new("Out of Our Heads", "the Rolling Stones", ["Mercy Mercy", "Hitch Hike", "The Last Time"])

records = [abbey_road, sgt_pepper, out_of_our_heads]
```

**FlashCard**

Let's make a \#group_by flashcard! Following the format that we used for our previous enumerables, create two flashcards for the enumerable \#group_by.

## `inject`

Inject can be very powerful. It allows us to **inject** something to a single value. To know how to use it, we'll need these three things:

1) The starting value in parens. This isn't always required, but it defaults to the first element of the collection.
2) The block's first argument, which will act as a memory/storage holder. Begins as the starting value.
2) The block's second argument stands in for the single element of the plural collection we're operating over.
3) The block itself

```ruby
collection.inject(starting_value) { |running_total, variable| block }
```

Now, in practice.

```ruby
array = [1,2,3,4,5]
=> [1,2,3,4,5]

array.inject(0) do |sum, num|
   sum + num
end
=> 15
```

### Exercise: `inject`

Summing is easy, but we can also use `inject` to build other things.

**Challenge #1:** Start with a array of 6 words, and write a `inject` block that returns a string with the first letter of all the words in the array.

**Challenge #2:** Start with a string of one long word (your choice). Write a `inject` block that returns a count of all the letters in the word.

**Challenge #3:** Given an array of the numbers 1 through ten, use inject to return the sum of all even numbers.

**FlashCard**

Let's make an \#inject flashcard! Following the format that we used for our previous enumerables, create two flashcards for the enumerable \#inject.


## WrapUp  

* What do zip, group_by, and inject do?  What are the gotchas for each?  

## Additional Reading

[Ruby 2.0 Works Hard So You Can Be Lazy](http://patshaughnessy.net/2013/4/3/ruby-2-0-works-hard-so-you-can-be-lazy)
