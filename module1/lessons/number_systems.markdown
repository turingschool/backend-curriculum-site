---
layout: page
title: Number Systems
length: 90
tags: computer science, binary, fundamentals
---

## Learning Goals
* identify common number systems used in programming

## Slides

Available [here](../slides/number_systems)

## Vocabulary
* Binary
* Hexadecimal
* Octal
* Base-#

## WarmUp
* Deconstruct the number 134. What does the 1 mean? What does the 3 mean? What does the 4 mean?
* What is the significance of increasing the digits in a number? Why do we go from single digit at 9 to double digit at 10?

## Introduction

There's more than one way of counting. You're most familiar with the base-10 number system. In this session we'll work to:

* better understand base-10 (decimal)
* explain and explore base-2 (binary)
* explain and explore base-16 (hexadecimal)
* explain and explore base-8 (octal)

Create a chart like the one below to keep track of each number system:

|base|name|digits|max-digit|
| :---: | :---: | :---: | :---: | :---: |
|10||||
|2||||
|16||||
|8||||

### Base-10 (decimal)

You use base-10 numbers everyday, but let's think a bit more about how they work.

#### Theory

* Uses the symbols `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`
* Digits carry over to the next place when `9` becomes `0`
* One digit can represent 10 unique numbers
* Two digits represent 100 unique numbers
* Moving right to left, positions represent:
  * 10^0 = 1
  * 10^1 = 10 ("tens")
  * 10^2 = 100 ("hundreds")
  * 10^3 = 1000 ("thousands")

### Base-2 (binary)

Everything in computing (hardware, software) is based on binary. At the electrical
level a binary zero means "no electricity", while a binary one means "yes electricity".

#### Theory

* Uses the symbols `0` and `1` only
* Digits carry over to the next place when `1` becomes `0`
* One digit can represent only two unique numbers
* Two digits can represent only four unique numbers
* Moving right to left, positions represent:
  * 2^0 = 1
  * 2^1 = 2
  * 2^2 = 4
  * 2^3 = 8

*Comprehension*: What number would come immediately after `1010`?

### Base-16 (hexadecimal)

Base-16 numbers are powerful for representing a large number of possible values with just a few characters (think of
serial numbers). One common usage that you will see is the #hex value for a color. For example #000000 is the lowest positive number and represents black while #ffffff is the highest positive number (with 6 digits) and represents white.

#### Theory

In hex you have sixteen symbols! The hex system:

* Uses the symbols `0` through `9` then `A`, `B`, `C`, `D`, `E`, `F`
* Digits carry over to the next place when `F` becomes `0`
* One digit can represent sixteen unique numbers
* Two digits can represent 256 unique numbers
* Moving right to left, positions represent:
  * 16^0 = 1
  * 16^1 = 16
  * 16^2 = 256
  * 16^3 = 4096

*Comprehension*: What is the highest value of a 6 digit hex number? What's the decimal equivalent of this number?

### Base-8 (octal)

Octal is the least frequently use of these alternative number systems, but it has some interesting properties. One common
usage is for dealing with [file permissions in the Unix filesystem](http://www.tutonics.com/2012/12/linux-file-permissions-chmod-umask.html#octal_representation).

#### Theory

* Uses the symbols `0`, `1`, `2`, `3`, `4`, `5`, `6`, and `7`
* Digits carry over to the next place when `7` becomes `0`
* One digit can represent eight unique numbers
* Two digits can represent 64 unique numbers
* Moving right to left, positions represent:
  * 8^0 = 1
  * 8^1 = 8
  * 8^2 = 64
  * 8^3 = 512

*Comprehension*: How many more unique numbers can be represented in four decimal digits versus four octal digits?


### Build It

Use these [worksheets](https://drive.google.com/a/casimircreative.com/file/d/0Bz1JMFygchXyejZJWlo0SHZjQjg/view?usp=sharing) to build and write each number 0-20 in each Number System (decimal, binary, hexidecimal, & octal)

Practice counting in your normal number system and think critically about the mechanics of how counting works.

*Comprehension*: If you have three decimal digits, how many unique value can you represent?

## Extensions

If you get done with building out the numbers try out these extensions:

### Using Other Number Systems from Ruby

Ruby by default represents numbers to us using base-10, even though it stores them in binary under the hood. However it also has the ability to represent numbers as strings of different bases when requested.

To do this, you simply pass an optional, numeric argument to the `to_s` method on `Fixnum`:

```
6.to_s(2)
=> "110"
```

Similarly, you can also pass an optional argument to the `to_i` method on `String` to tell ruby to use a different base when it's parsing a string into a number:

```
"110".to_i(2)
=> 6
```

Experiment with these methods to see if you can accomplish all the conversions from the exercises above using ruby.

1. Convert 100 decimal to hex
2. Convert AF6C hex to decimal
3. Convert 10,000 decimal to hex
4. Convert FACE hex to decimal

### Adding & Subtracting in different Number Systems

Using the Adding & Subtracting section of these resources, explore how familiar adding/subtracting algorithms are impacted by using a different number system.

* [Binary](./archive/number_systems_binary)
* [Hexadecimal](./archive/number_systems_hexadecimal)
* [Octal](./archive/number_systems_octal)

### Conversions: From Hex to Binary

Converting Hex to decimal and vice-versa is useful for making Hex numbers more human-readable. But in reality one of the main advantages of hex is that it's very easy to convert between hex and binary. Hexadecimal largely became popular as a number system among computer scientists and programmers because it serves as a convenient "shorthand" for representing binary numbers which would otherwise be very long.

To understand why converting between these two is relatively easy, let's think about what binary and hex each represent.

In hex, each "digit" can represent 16 different values (0-15). In terms of binary, we might say that this represents "4 bits" of information -- we could represent the same range of values in binary using various combinations of the first 4 bits.

Thus, when converting hex to binary, we can actually just treat each digit in the Hexadecimal string as an independent set of 4 bits in binary. Convert all the digits into sets of 4 bits, string them together, and you're done!

Let's look at an example of converting `AF` to Binary:

```plain
F (15) * 16^0 (1)  = 15(10)  =  0000 1111(2)
A (10) * 16^1 (16) = 160(10) =  1010 0000(2)

Total = 0000 1111 + 1010 0000 = Concatenate 1010 + 1111 = 10101111
```

#### Exercises

##### Conversion - Hex <-> Binary

1. Convert 1010 binary to hex
2. Convert AF6C hex to binary
3. Convert 1101 0101 binary to hex
4. Convert FACE hex to binary


## WrapUp

* What are some different number systems used in programming? Where might you use them?
* What do the digits 10 represent in each of these number systems?

**Instructor Note:**
Print out the two pages of worksheet before class. Each student will need their own.

