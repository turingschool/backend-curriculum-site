---
layout: page
title: Hash Functions
---

## Learning Goals

* Understand what a hash function is
* Understand the key characteristics of hash functions that are used to hash passwords
* Become familiar with two of the most common hash functions, MD5 and SHA-256

## Vocabulary

* Hash Function
* Hash/Digest
* Collision
* Determinism

# Part 1: Intro to Hash Functions

## What is a Hash Function?

[From Wikipedia](https://en.wikipedia.org/wiki/Hash_function): "A hash function is any function that can be used to map data of arbitrary size onto data of a fixed size".

An important distinction to make here is that a Hash Function is different than a Ruby Hash. They are similar, but not the same thing.

In the following diagram (also from Wikipedia), we are using a Hash Function to take names and map them to numbers.  

![Hash Function](https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Hash_table_4_1_1_0_0_1_0_LL.svg/1920px-Hash_table_4_1_1_0_0_1_0_LL.svg.png)

### Vocabulary

* **Collision** - When two different inputs map to the same output. You can see this in the example above. Two names map to the same number.
* **Hash** or **Digest** - The output of a hash function. There are other names, but those are the two we will use most often.

### Key Characteristics of a Hash Function

1. **Deterministic** - The same input will give the same output
1. **Collision Resistant** - It is unlikely that different inputs will map to the same output
1. **Fixed Size Output** - The output will always be the same size no matter the input

### Uses for Hash Functions

Hash Functions have many uses, including but not limited to storing data (often called Hash Tables), Caching, and finding duplicate records. The SHA-1 hash function is used to create the git commit hash.

The most common and probably most important use of Hash Functions is for storing passwords.

**We never ever ever store a user's raw password in a database.**

So instead, we store a hash of their password.

### Key Characteristics for Password Hash Functions

1. **One Way** - A hash can be easily computed for an input, but it is infeasible (note: not impossible), to reverse it. In the example above, this would mean that it would be easy to go from a name to a number, but infeasible to go from a number to a name.
1. **Discontinuous** - Inputs that are similar do not have a similar output. In the example above, if we hashed the name "Sam Do", it should not be close to the hashed value of 4 for "Sam Doe".

# Part 2: Hashing Exploration

This exploration will use the following two hash functions:

```ruby
def hash_me_1(snack)
  snack.length % 6
end
```

```ruby
def hash_me_2(snack)
  hash1 = (snack.length * 13) % 7
  hash2 = (snack.length * 2) % 6
  ((hash1 + hash2) % 7).to_s + hash1.to_s + hash2.to_s;
end
```

Process:

1. Take a snack
1. Using `hash_me_1` (defined above), compute a digest based on the name of the snack (excluding spaces)
1. Place your snack in the bin labeled with the digest you computed
1. Discuss with the other people at your bin:
  * Does this hash function have the characteristics we discussed earlier?
1. Repeat steps 2 - 4 for `hash_me_2`
1. Eat snack

# Part 3: Hashing in Action

You've done some hash building in the physical space. Let's practice doing it with the machine, using better algorithms.

## Tools

We are going to experiment with two of the most common hash functions:

  * [MD5](https://ruby-doc.org/stdlib-2.4.0/libdoc/digest/rdoc/Digest/MD5.html)
  * [Sha256](https://ruby-doc.org/stdlib-2.1.0/libdoc/digest/rdoc/Digest.html)

You should use the `hexdigest` method for computing digests for both MD5 and SHA-256.

## Instructions

We'll provide timing constraints on the board. If you're moving quickly and feeling confident, complete the *Extension* questions. But if you're not, make sure you complete all the non-Extension exercises first.

## Activity 1: MD5 and SHA-256

Collaborating with the person next to you, experiment and discuss answers to these questions:

1. What is the MD5 digest of your snack string?
2. What is the Sha256 digest of the same string?
3. Repeat both MD5 hashing and Sha256 hashing, but change the input to include a one-letter-off typo. What do you notice about the output? What if you add a blank space to the end of the string? What if you change the capitalization of one letter?
4. Multiply your string 1000x (like "chipschipschipschips..." and hash it again through each algorithm. What's notable about the output as compared to previous runs?

_Then, in your own notebook, jot quick notes to solidify your learning:_

<ol type="a">
  <li>How does a small change to the input of a hash change the output?</li>
  <li>Why does the answer to "A" matter?</li>
  <li>How does a massive change to the size of the input change the output?</li>
  <li>Based on this analysis, can you come up with three potential use cases for hash functions *besides* passwords?</li>
</ol>

#### Extension

Feeling good about hashing? Try answering these questions:

1. Which algorithm (MD5 / Sha256) is faster? Can you prove it using a dataset of at least 200 inputs and calculating the percentage speed difference?
2. Is the percentage difference consistent if you increase the size of each individual input data by 100 times?
3. Is there a scenario where you'd want to intentionally choose a *slower* algorithm? Why?

## Activity 2: Bad Secrets

Let's test your understandings by completing this section on your own. Use your pair as a resource if you get stuck, but try to complete the work on your own.

A hashing function is said to be "one-way" which is often useful in security, but it's not fool-proof. Say you hack into my application and are able to retrieve all my users' hashed passwords. You find that the account with username `boss@example.com` has this hashed password:

```
3e40106b8f4332e18d76e94124d9c82a
```

Based on the length of the digest you guess it's an MD5. You know that some users, particularly bosses, are lazy and they do dumb things like re-use their 4-digit ATM pin for their password. But the application required a password of eight digits, so they might have repeated the pin.

_Work out answers to the following questions in your notebook:_

1. What's this user's password?
2. Would the user's password have been "more secure" if they used eight letters rather than eight numbers? Explain your thinking.

#### Extension

A ["rainbow table"](https://en.wikipedia.org/wiki/Rainbow_table) makes this reverse engineering much faster.

1. Can you generate a CSV file that has two columns: the first column contains all possible 8-digit codes following the 4+4 rule above, then the second column has the MD5 digest for that input.
2. If you now have an MD5 digest for an input that is expected to follow the 4+4 rule, how long does it take you to "crack" a password using the rainbow table?
3. Could you generate a similar table for the all words of eight or more letters in the dictionary? (hint: you have a text file dictionary on your filesystem at `/usr/share/dict/words`)
4. Some developers choose to make passwords more obscure by applying the hashing algorithm more than once (ie: original input into the algorithm, then that output into the algorithm again). Can you expand your dictionary table with columns for double-hashing, quad-hashing, and octo-hashing? As our time is limited, you might need to constrain your input set ;)

# Checks for Understanding

* What is a Hash Function?
* What is a Collision?
* Define each of the following Hash Function characteristics and explain why they are important:
  * Deterministic
  * Collision Resistant
  * Fixed Sized Output
  * One Way
  * Discontinuous
