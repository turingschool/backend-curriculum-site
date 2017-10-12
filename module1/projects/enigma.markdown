---
layout: page
title: Enigma
---

In this project you'll use Ruby to build a tool for cracking an encryption algorithm.

## Introduction

### Learning Goals / Areas of Focus

* Practice breaking a program into logical components
* Testing components in isolation and in combination
* Applying Enumerable techniques in a real context
* Reading text from and writing text to files

## Base Expectations

You are to build an encryption engine for encrypting, decrypting, and cracking
messages.

Additionally, your program will need to read messages from and output them to
the file system.

### Encryption Notes

The encryption is based on rotation. The character map is made up of all the
lowercase letters, then the numbers, then space, then period, then comma. New
lines will not appear in the message nor character map.

#### The Key

* Each message uses a unique encryption key
* The key is five digits, like 41521
* The first two digits of the key are the "A" rotation (41)
* The second and third digits of the key are the "B" rotation (15)
* The third and fourth digits of the key are the "C" rotation (52)
* The fourth and fifth digits of the key are the "D" rotation (21)

#### The Offsets

* The date of message transmission is also factored into the encryption
* Consider the date in the format DDMMYY, like 020315
* Square the numeric form (412699225) and find the last four digits (9225)
* The first digit is the "A offset" (9)
* The second digit is the "B offset" (2)
* The third digit is the "C offset" (2)
* The fourth digit is the "D offset" (5)

#### Encrypting a Message

* Four characters are encrypted at a time.
* The first character is rotated forward by the "A" rotation plus the "A offset"
* The second character is rotated forward by the "B" rotation plus the "B offset"
* The third character is rotated forward by the "C" rotation plus the "C offset"
* The fourth character is rotated forward by the "D" rotation plus the "D offset"

#### Decrypting a Message

The offsets and keys can be calculated by the same methods above. Then each character
is rotated backwards instead of forwards.

#### Cracking a Key

When the key is not known, the offsets can still be calculated from the message
date. We believe that each enemy message ends with the characters `"..end.."`. Use
that to determine when you've correctly guessed the key.

### Usage

Then we'll exercise the functionality from a Pry session:

```ruby
> require './lib/enigma'
> e = Enigma.new
> my_message = "this is so secret ..end.."
> output = e.encrypt(my_message)
=> # encrypted message here
> output = e.encrypt(my_message, "12345", Date.today) #key and date are optional (gen random key and use today's date)
=> # encrypted message here
> e.decrypt(output, "12345", Date.today)
=> "this is so secret ..end.."
> e.decrypt(output, "12345") # Date is optional (use today's date)
=> "this is so secret ..end.."
> e.crack(output, Date.today)
=> "this is so secret ..end.."
> e.crack(output) # Date is optional, use today's date
=> "this is so secret ..end.."
```

### Working with Files

In addition to the pry form above, we'll want to use the tool
from the command line like so:

```
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
Created 'encrypted.txt' with the key 82648 and date 030415
```

That will take the plaintext file `message.txt` and create an encrypted file `encrypted.txt`.

Then, if we know the key, we can decrypt:

```
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 030415
Created 'decrypted.txt' with the key 82648 and date 030415
```

But if we don't know the key, we can try to crack it with just the date:

```
$ ruby ./lib/crack.rb encrypted.txt cracked.txt 030415
Created 'cracked.txt' with the cracked key 82648 and date 030415
```

## Development Phases

As you work to implement the project here are ideas for some of your first iterations:

### 1. Key Generator

It'd be great if instead of random numbers we could generate a legitimate key. Starting from your runner:

* Create an instance of a key generator
* Figure out what, if anything, you'd need to pass in to the object
* Start writing tests for the key generator object based on the specs above
* Go through building the implementation
* Use it from your runner to generate and output a valid key

### 2. Offsets

Before we can start encrypting we probably need to calculate the offsets.

* From your runner, create an instance of an offset calculator
* Pass the current date and the generated key into the offset calculator
* Write tests and implementation around the idea of being able to pass in the date and key, then query the A, B, C, and D final rotations

### 3. Encryption

Now that you have all the components you're ready to encrypt a message.

* Create an encryptor object in your runner
* What information would the encryptor need to be "setup" and ready to encrypt messages? Pass that in.
* Call an encrypt method and pass in a string message. Get back the encrypted version.

### 4. Next Steps

Now you should have all the components in place such that your command-line encryption is working! Next up:

* Follow a similar flow to develop the decrypt script and functionality
* Swap some encrypted messages with a classmate and see if each other can decrypt them correctly
* Start experimenting with the cracking functionality

## Extension

### Character Support

Improve your system so it supports all of the following:

* all capital letters
* all lowercase letters
* all numbers
* spaces
* these symbols: `!@#$%^&*()[],.<>;:/?\|`

## Support Tooling

Please make sure that, before your evaluation, your project has each of the following:

* [SimpleCov](https://github.com/colszowka/simplecov) reporting accurate test coverage statistics


## Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 1. Ruby Syntax & Style

Expectations: 

- [ ] Applies appropriate attribute encapsulation  

- [ ] Developer creates instance and local variables appropriately

- [ ] Naming follows convention (is idiomatic)

- [ ] Ruby methods used are logical and readable  

- [ ] Developer implements appropriate enumerable methods (#each is used sparingly)

- [ ] Code is indented properly

- [ ] Code does not exceed 80 characters per line  

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 2. Breaking Logic into Components

Expectations: 

- [ ] Code is effectively broken into methods & classes 

- [ ] Developer writes methods less than 8 lines 

- [ ] No more than 3 methods break the principle of SRP 

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 3. Test-Driven Development

Expectations: 

- [ ] Each method is tested  

- [ ] Functionality is accurately covered

- [ ] Tests implement Ruby syntax & style   

- [ ] Balances unit and integration tests 

- [ ] Evidence of edge cases testing 

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 4. Functionality

Expectations: 

- [ ] Application meets all requirements (extension not req'd)

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

