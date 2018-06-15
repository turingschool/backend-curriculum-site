---
layout: page
title: Pre-Work
subheading: Day 1: Questions
---

Open your terminal and run the following commands:

```
$ cd ~/turing/prework
$ touch day_1/exercises.rb
$ atom ./
```

Atom should again open showing all the files and subdirectories that you have in your `prework` directory.

As before, in Atom hit `command-t` to open up a text box that will allow you to search your project directory for files. Begin typing `exercises.rb` and you should see a list of files appear below the text box (in this case your list might only be one item long). Be sure that the file `day_1/exercises.rb` is highlighted and hit return.

This will open the file in Atom and allow you to start typing.

The goal of this exercise will be to enter code into this file using the Ruby that you have learned so far.

To get started, type the following into your `exercises.rb` file.

```ruby
puts "Counting Down"
puts "----------------"
```

Now, in your terminal, run this code by entering the text below and hitting return:

```sh
$ ruby day_1/exercises.rb
```

You should then see the following output printed to your screen:

```sh
Counting Down
----------------
```

Once you have that working, continue to enter code into your `exercises.rb` file that will generate the text described below:

1. A countdown from 10 to 0.
1. Counting by twos from 2 to 20.
1. The remainder for each number between 1 and 10 when divided by 3.

Be sure to tackle these problems one at a time, checking your work as you go by running `ruby day_1/exercises.rb` from your terminal as you go.

When you are finished you should see the following output when you run your file.

```sh
Counting Down
----------------
10
9
8
7
6
5
4
3
2
1
------DONE------

Counting by twos
----------------
2
4
6
8
10
12
14
16
18
20
------DONE------

Remainders of 3 up to 10
----------------
1
2
0
1
2
0
1
2
0
1
------DONE------
```
