---
layout: page
title: Night Writer
---

## Learning Goals / Areas of Focus

* Practice breaking a program into logical components
* Testing components in isolation and in combination
* Applying Enumerable techniques in a real context
* Reading text from and writing text to files

## Background

The idea of [Night Writing](https://en.wikipedia.org/wiki/Night_writing) was first developed for Napoleon's army so soldiers could communicate silently at night without light. The concept of night writing led to Louis Braille's development of his [Braille tactile writing system](https://en.wikipedia.org/wiki/Braille).


## Evaluation Rubric

The evaluation rubric for this project is available [here](./rubric)

## Project Requirements

In this project we'll implement systems for generating Braille-like text from [English characters](https://en.wikipedia.org/wiki/English_alphabet) and the reverse.

Unlike previous projects where we may have provided an interaction pattern representing what you might see in Pry, this tool will be used from the command line. The general pattern is that we will run the program, providing an existing file for input, and the name of a nonexistent file for output, and the program will provide us with a confirmation:

```
$ ruby ./lib/night_writer.rb message.txt braille.txt
Created 'braille.txt' containing 11 characters
```

That will use the plaintext file `message.txt` to create a Braille simulation file `braille.txt`.

### Project Resources

* [Working with Files](https://backend.turing.edu/module1/lessons/working_with_files): Module 1 Backend lesson
* [SimpleCov](https://github.com/simplecov-ruby/simplecov): Ruby code coverage analysis tool

### Iteration 1: Creating a Command Line Interface

Write a Ruby program that prints a line to the terminal like the one below:

```
$ ruby ./lib/night_writer.rb message.txt braille.txt
Created 'braille.txt' containing 11 characters
```

In the example above:

* `./lib/night_writer.rb` is the path to your Ruby program.
* `message.txt` is the name of an existing text file in your project directory.
* `braille.txt` is the name that we would like to give to a file that we will create in iteration 2.
* 11 is the count of characters in your `message.txt` file.

In order to break this problem down further, you may wish to work on things in the following order:

* Create a Ruby program that prints the sample line of text provided above no matter what arguments are provided from the command line.
* Update your existing program so that the name of the file that it prints out changes based on the second input that the user provides from the command line.
* Further update your program so that the number of characters it prints out changes based on the number of characters in the file that the user provides as the first argument that the user provides from the command line.

### Iteration 2: Writing Braille

Update your existing program so that you can create a new file containing characters representing Braille.

Braille uses a two-by-three grid of dots to represent characters. We'll simulate that concept by using three lines of symbols. For example, we are going to represent a `h` character as follows:

```
0.
00
..
```

with a zero in the first position of the first row representing a raised dot, and two zeros in the second row representing two raised dots, and periods in the remaining spaces representing unraised spaces.

Following the same pattern, `hello world` would be represented as follows:

```
0.0.0.0.0....00.0.0.00
00.00.0..0..00.0000..0
....0.0.0....00.0.0...
```

<!-- You can experiment with [converting other words](http://www.brailletranslator.org/) yourself and share some samples with your classmates. Use the [lowercase letters a-z here from the American Foundation for the Blind](http://braillebug.afb.org/braille_print.asp) for your project. -->
You can experiment with [converting other words](http://www.brailletranslator.org/) yourself and share some samples with your classmates. Use the [lowercase letters a-z here](./braille_basics.pdf) for your project.

Each line of your Braille file should be no wider than 40 Braille characters (80 dots) wide.

In order to break this problem down further, you may wish to work on things in the following order:

* Update your existing Ruby program to take the entire message contained in your input file and save it to the output file provided by a user. At this point, do not do any work to translate the message to Braille.
* Create a dictionary of some sort that allows you to look up a English letter and find its Braille equivalent.
* Update your program to take an input file with a single letter and create an output file with the Braille equivalent.
* Update your program again so that it can take multiple letters. Compare results with a classmate.
* Update the program so that messages of more than 80 characters are split over multiple lines.

### Iteration 3: Writing English Letters

Create a NightReader program that will convert Braille back to English text:

```
$ ruby ./lib/night_reader.rb braille.txt original_message.txt
Created 'original_message.txt' containing 11 characters.
```

In order to break this problem down further, you may wish to work on things in the following order:

* Using your existing Ruby program as a template, create a new program called NightReader that prints a confirmation message to the terminal that contains the name of the file that the user input as their second argument.
* Create a dictionary that maps some representation of Braille characters to English characters.
* Convert a single Braille character contained in your input file into a single English character in your output file.
* Convert multiple Braille characters into multiple English characters.
* Convert a file containing multiple lines of Braille into English characters.
* 11 is the count of characters in your `original_message.txt` file.

### Iteration 4: Refactor & Support Additional Characters

Complete two of the following:

#### Extract a File I/O class

* Refactor your code so that each of your existing programs use a shared File I/O class. If you'd like an example of how you might extract the File I/O into an external class, [check out this gist](https://gist.github.com/jcasimir/fd0ceaf731e79c9dd5da).

#### Support Capitalization

In Braille, capitalization comes from a shift character. You'll find that character at the end of the fourth row of the previous graphic. When that character appears, the next character (and only the next character) is a capital. So `e` comes out as one 2x3 set of Braille points, but `E` is 4x3: the shift character followed by the English `e`. Consider how this will affect your line width restrictions.

#### Support Numbers

Return to the graphic referenced above and you'll find a the `#` in the bottom left corner. Notice that the representations for 1-9 are actually the same as a-i. This number sign is a "switch" which means that all of the following "letters", up to the next space, are actually numbers. After the space it's assumed that we're back to words/letters unless we see another number switch.

Add support for numbers to your program.

#### Support Contractions

There are contractions commonly understood in Braille. They're a single letter symbol (so it has spaces on each side) which stands in for a common word.

Find the symbols [here on Wikipedia](https://en.wikipedia.org/wiki/English_Braille#One-letter_contractions) and add support in your program for the following:

```
a, but, can, do, every, from, go, have, just, knowledge, like, more, not, people, quite, rather, so, that, us, very, it, you, as, child, shall, this, which, out, will, enough, were, in
```

These should be used both when going from standard characters to Braille (ie, `from` is output as one character of Braille) and in your expansion from Braille to standard characters.

## Examples

Below are a few examples to help you develop your implementation. You're encouraged
to submit additional examples, especially for the extensions, as pull requests.

### lowercase character
Note, a Braille character is the full 6 .s or 0s

    "a"

    0.
    ..
    ..

### two lowercase characters

    "ab"

    0.0.
    ..0.
    ....

### uppercase character

    "A"

    ..0.
    ....
    .0..

### two uppercase characters

    "AB"

    ..0...0.
    ......0.
    .0...0..

### 80 positions wide (40 Translated English lowercase letters)

    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

    0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.
    ................................................................................
    ................................................................................

### 82 positions (41 Translated English lowercase letters)

    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

    0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.
    ................................................................................
    ................................................................................
    0.
    ..
    ..

### all characters

    " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    ..............0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...0...0...00..
    ..00..0...000...0....0.00.00000.00..0....0.00.00000.00..0.00...0.0......0.......
    ..0.0...00.000....................0.0.0.0.0.0.0.0.0.0.0000.0000000.0...0...0...0
    00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0..0...0....0..
    .0...0..0...00..00..0...00......0........0...0..0...00..00..0...00......0...00..
    ...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00..000.000.0.0.0
    00..00..0.
    .....0...0
    00.000.000

<!-- ## Evaluation Rubric

The evaluation rubric for this project is available [here](./rubric) -->
