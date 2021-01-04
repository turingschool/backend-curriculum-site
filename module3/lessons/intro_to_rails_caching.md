---
layout: page
title: Intro to Caching in Rails
length: 60
tags: rails, caching, performance
---


Warm-Up Prompts:

- What is Caching?
- What is Memoization?
- What's the difference?

Write out some answers to these questions before expanding the notes below!

<details>
  <summary>Click to expand!</summary>

Cache:
* auxiliary memory from which high-speed retrieval is possible
* storage of data so future requests for that data can be served faster
* stored data might be the result of an earlier computation or a copy of data stored elsewhere

Memoization:
* an optimization technique used primarily to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again

## Isn't that the same thing?

No. Memoization is a specific type of caching. Caching is STORING the data. Memoization is caching the RETURN VALUE of a function.

Back in the "old days" we had to look up people's phone numbers in a giant phone book. Caching would be like adding my favorite people in a smaller address book. Occasionally I might need to update their phone number from the bigger phone book, but now I have a smaller, easier-to-access book that I can maybe carry in my pocket.

Memoization would be like the address books that had little letters/tabs on the side to skip to all of my friends who start with "S" to get Sal's phone number in a hurry. The book is the cache, but the lookup of that data from the cache is memoization.
</details>


## Benefits in Our Applications
