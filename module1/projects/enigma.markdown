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
* Consider the date in the format DDMMYY, like 240818
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

## Iteration 1

```ruby
pry(main)> require './lib/enigma'
#=> true
pry(main)> e = Enigma.new
pry(main)> my_message = "this is so secret ..end.."
pry(main)> output = e.encrypt(my_message)
#=> # encrypted message here
pry(main)> output = e.encrypt(my_message, "12345", Date.today) #key and date are optional (gen random key and use today's date)

## Extension

### Character Support

Improve your system so it supports all of the following:

* all capital letters
* all lowercase letters
* all numbers
* spaces
* these symbols: `!@#$%^&*()[],.<>;:/?\|`

## Support Tooling

Please make sure that, before your evaluation, your project has the following:

* [SimpleCov](https://github.com/colszowka/simplecov) reporting accurate test coverage statistics
* [HoundCI](http://houndci.com) HoundCI Pull Request based linter. (This should be set up when you start your project.)


## Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

**Expectations:**

### 1. Ruby Syntax & Style

* Applies appropriate attribute encapsulation  
* Developer creates instance and local variables appropriately
* Naming follows convention (is idiomatic)
* Ruby methods used are logical and readable  
* Developer implements appropriate enumerable methods (#each is used only when necessary)
* Code is indented properly
* Code does not exceed 80 characters per line
* Each class has correctly-named files and corresponding test files in the proper directories
* Code has been linted and corrected properly.

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 2. Breaking Logic into Components

* Code is effectively broken into methods & classes
* Developer writes methods less than 8 lines
* Methods do not break the principle of SRP

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 3. Test-Driven Development

* Each method is tested  
* Functionality is accurately covered
* Tests implement Ruby syntax & style   
* Balances unit and integration tests
* Evidence of edge cases testing
* Test Coverage metrics are present (SimpleCov)
* Test Coverage metrics exceed 95%

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 4. Git Workflow

* Repository demonstrates that each member of team has contributed fairly equally.
* Developers commit at a rate of approximately one commit every 30 minutes.
* Repository shows the use of branches.
* Developers use a pull request workflow.
* Developers resolve HoundCI complaints in their pull requests.

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

### 5. Functionality

* Application meets all requirements (extensions not required for a 3)

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations
