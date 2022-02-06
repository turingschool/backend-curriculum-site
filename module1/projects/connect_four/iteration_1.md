---
layout: page
title: Iteration 1 - Game Board
---

_[Back to Connect Four Home](./index)_
_[Back to Requirements](./requirements)_

## Test Driven Development

In this iteration, you are required to use TDD to create your classes. Use the interaction pattern to determine what a method should do and write one or more tests to verify that expected behavior. Then you can implement the method. You should always write code with the purpose of making a test pass.

## Printing the Board

When a user runs the command to start the game, they will see a welcome message, followed by an empty board. The board itself will represent empty spaces with periods and column names with a letter A-G.

```
ABCDEFG
.......
.......
.......
.......
.......
.......
```

Player pieces will be represented by X's, while computer pieces will be represented by O's. A board later in the game might look something like the following:

```
ABCDEFG
.......
.......
O......
X.O...O
XXOX..X
XOOXOOX
```

For Iteration 1, students should have a program that will print out a welcome message and an empty board.
