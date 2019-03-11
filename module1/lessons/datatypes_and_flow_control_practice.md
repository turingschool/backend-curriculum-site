---
layout: page
title: Datatypes and Flow Control Practice
---

## Exercise 1

Open a Ruby file and create a variable called `pets` that holds an Array of three Strings representing the names of pets. Then, write Ruby code to print out the following:

```
The pets are <first pet name> and <second pet name> and <third pet name>
The first pet's name ends with a <last letter of first pet's name>.
The second pet's name is <length of pet name> letters long.
The third pet's name <does/does not> contain the letter s.
```

The output in the angle brackets `< >` should change depending on the values in your `pets` array.

## Code Share

With a partner, share the code you wrote for exercise 1.


## Exercise 2

Write a program that will ask the user to enter some text.

* If the text has an odd number of characters, print "ODD!"
* If the text has an even number of characters, print "EVEN!"
* The program should repeat this process until the user enters "q" or "quit"

**Bonus**: Create three versions of this program that use three different types of loops: `while`, `until`, and `loop do`

## Code Share

With a partner, share the code you wrote for exercise 2.


## Extension

Write a program that will count the number of times a word is used in a sentence. It is recommended that you pseudo-code this out with your partner before actually attacking this challenge with Ruby.

* If the input is "My dogs are the best dogs in the world",
* The output should be:

```ruby
{
  "My": 1,
  "dogs": 2,
  "are": 1,
  "the": 1,
  "best": 1,
  "in": 1,
  "the": 1,
  "world": 1
}
```
