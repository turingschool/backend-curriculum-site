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

## Support Tooling

Please make sure that, before your evaluation, your project has the following:

* [SimpleCov](https://github.com/colszowka/simplecov) reporting accurate test coverage statistics


## Encryption Algorithm

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
* Consider the date in the format DDMMYY, like 240818
* Square the numeric form (57993309124) and find the last four digits (9124)
* The first digit is the "A offset" (9)
* The second digit is the "B offset" (1)
* The third digit is the "C offset" (2)
* The fourth digit is the "D offset" (4)

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

## Iteration 1

Add support for encrypting a message. Create an `Enigma` class that has a method `encrypt` that takes a message String as an argument and outputs the encrypted message. The `encrypt` can optionally take a Key and Date as arguments to use for encryption. If the key and date are not included as arguments, you should generate a random Key and use today's Date.

The `Enigma` class should respond to the following interaction pattern:

```ruby
pry(main)> require 'date'
=> true

pry(main)> require './lib/enigma'
=> true

pry(main)> e = Enigma.new
=> #<Enigma:0x00007ff90f24cb78...>

pry(main)> my_message = "this is so secret ..end.."
=> "this is so secret ..end.."

pry(main)> output = e.encrypt(my_message, "12345", Date.today)
=> # encrypted message here

pry(main)> output = e.encrypt(my_message) #key and date are optional (generate random key and use today's date)
=> # encrypted message here
```

## Iteration 2

Add support for decrypting a message. Add a method `decrypt` to your `Enigma` class that outputs a String of the decrypted message. This method takes two arguments. The first is the encrypted message as a String. The second is the Key that was used to encrypt the message. The `decrypt` method can optionally take a date as the third argument. If no date is given, this method should use today's date for decryption.

The `Enigma` class should respond to the following interaction pattern:

```ruby
pry(main)> require 'date'
=> true

pry(main)> require './lib/enigma'
=> true

pry(main)> e = Enigma.new
=> #<Enigma:0x00007ff90f24cb78...>

pry(main)> my_message = "this is so secret ..end.."
=> "this is so secret ..end.."

pry(main)> output = e.encrypt(my_message, "12345", Date.today)
=> # encrypted message here

pry(main)> e.decrypt(output, "12345", Date.today)
=> "this is so secret ..end.."

pry(main)> e.decrypt(output, "12345") # Date is optional (use today's date)
=> "this is so secret ..end.."
```

## Iteration 3

Add a command line interface for encryption and decryption. You should create a Runner file called `encrypt.rb` that takes two command line arguments. The first is an existing file that contains a message to encrypt. The second is a file where your program should write the encrypted message. In addition to writing the encrypted message to the file, your program should output to the screen the file it wrote to, the key and the date.

Additionally, you should create a Runner file called `decrypt.rb` that takes four command line arguments. The first is an existing file that contains an encrypted message. The second is a file where your program should write the decrypted message. The third is the key to be used for decryption. The fourth is the date to be used for decryption. In addition to writing to the decrypted message to the file, your program should output to the screen the file it wrote to, the key used for decryption, and the date used for decryption.

You should be able to use your CLI like this:

```
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
Created 'encrypted.txt' with the key 82648 and date 240818
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818
Created 'decrypted.txt' with the key 82648 and date 240818
```

See [this Lesson Plan](../lessons/working_with_files) for more info about working with files.

## Iteration 4

Add support to your `Enigma` class for cracking an encryption, that is decrypting a message without being given the key. Add a `crack` method to your `Enigma` class that takes an encrypted message as an argument. This method can optionally take a date to use for cracking as a second argument. If no date is given, it should use today's date for cracking.

The `Enigma` class should respond to the following interaction pattern:

```ruby
pry(main)> require 'date'
=> true

pry(main)> require './lib/enigma'
=> true

pry(main)> e = Enigma.new
=> #<Enigma:0x00007ff90f24cb78...>

pry(main)> my_message = "this is so secret ..end.."
=> "this is so secret ..end.."

pry(main)> output = e.encrypt(my_message, "12345", Date.today)
=> # encrypted message here

pry(main)> e.crack(output, Date.today)
=> "this is so secret ..end.."

pry(main)> e.crack(output) # Date is optional, use today's date
=> "this is so secret ..end.."
```

Additionally, you should create a Runner file called crack.rb that takes three command line arguments. The first is an existing file that contains an encrypted message. The second is a file where your program should write the cracked message. The third is the date to be used for cracking. In addition to writing to the cracked message to the file, your program should output to the screen the file it wrote to, the key used for cracking, and the date used for cracking.

```
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
Created 'encrypted.txt' with the key 82648 and date 240818
$ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
Created 'cracked.txt' with the cracked key 82648 and date 240818
```

## Extension

Improve your system so it supports all of the following:

* all capital letters
* all lowercase letters
* all numbers
* spaces
* these symbols: `!@#$%^&*()[],.<>;:/?\|`


## Evaluation Rubric

You will be evaluated based on [this Project Rubric](../project_rubric)
