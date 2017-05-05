---
layout: page
title: Working with Files
tags: files, I/O, command line, unix
length: 90
---

## Learning Goals

* Recognize the significance of files in modern computing systems
* Be able to create a new file from the command line, our editor, and ruby
* Be able to read data from a file from the command line, our editor, and ruby
* Be able to write data to a file from the command line, our editor, and ruby
* Be able to read command-line arguments from within a ruby program using `ARGV`

## Structure

* 5 - Warmup
* 15 - Understanding Terms
* 20 - Exercising Raw Files
* 5 - Progress Checks & Questions

## Lesson

### Warmup

Spend 5 minutes answering the following questions:

1. What exactly goes into files on our computer?
2. Name 3 kinds of files you've worked with in the past.
3. What determines what kind of information goes into each kind of file?
4. Why would you want to read files, especially text files, from Ruby?
5. What other kinds of files might you want to read from a program?

### Basics - Reading an Existing File

* Using `cat` in your terminal  
   Prints out the contents of your file.

```
cat <filename>
```

* Using Ruby from Pry or IRB, `File.open()`   
   Creates a Ruby File object that is "readable."

```ruby
File.open(<filename>, "r")
```

### Basics - Creating an Empty File

* Using `touch` from the command line
   Creates a file.

```
touch <filename>
```

* Using Ruby and `File.open()`  
    Creates a Ruby File object that is "writable."

```ruby
File.open(<filename>, "w")
```

### Basics - Writing Data to a File

* Using `echo` to add content from the command line

```
echo "test" >filename
```

* Using `cat` to add content from the command line

```
cat >filename
CTRL+D
```

* Using Ruby and `File.write()` in Pry, IRB, or your Ruby file.

```ruby
new_file = File.open(<filename>, "w")
new_file.write("text")
```

## Command-line Arguments and `ARGV`

Working with files represents 1 common way our ruby programs will
interact with the system environment.

Another common interaction involves reading **"Command Line Arguments"**

### Reading Arguments from a Ruby Program

* `ARGV` - a special array
* Arguments are provided as strings in the ARGV array
* Arguments are separated by spaces in the commmand line
* `ARGV` is a "constant" and is globally accessible from anywhere
in a ruby program

From the command line:
```
ruby colors.rb red.txt blue.txt
```
In your file:
```
ARGV == ["red.txt", "blue.txt"]
ARGV[0] == "red.txt"
ARGV[1] == "blue.txt"
```

### Exercise

Work with a partner next to you to do the following:

Use `cat` to create a `quiet_quotes.txt` from the command line and paste the following into it:

```
Bob Ross Quotes
“We don't make mistakes, just happy little accidents.”
“Talent is a pursued interest. Anything that you're willing to practice, you can do.”
“There's nothing wrong with having a tree as a friend.”
“I guess I’m a little weird. I like to talk to trees and animals. That’s okay though; I have more fun than most people.”
“All you need to paint is a few tools, a little instruction, and a vision in your mind.”
“The secret to doing anything is believing that you can do it. Anything that you believe you can do strong enough, you can do. Anything. As long as you believe.”
“I started painting as a hobby when I was little. I didn't know I had any talent. I believe talent is just a pursued interest. Anybody can do what I do.”
“Mix up a little more shadow color here, then we can put us a little shadow right in there. See how you can move things around? You have unlimited power on this canvas -- can literally, literally move mountains”
“Let's build a happy little cloud. Let's build some happy little trees.”
```

Using `ARGV`, write a Ruby script that will take in the above text and print out an all caps version to `loud_quotes.txt`.

The program must be executed from the command line like so:

```
ruby <filename.rb> quiet_quotes.txt loud_quotes.txt
```

### Video

https://vimeo.com/130322465
