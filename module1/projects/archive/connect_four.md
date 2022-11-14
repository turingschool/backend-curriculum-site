---
layout: page
title: Connect Four
---

![Connect 4](./c4.jpg)

In this project you'll use Ruby to build a command line implementation of the classic game Connect 4.

## Learning Goals / Areas of Focus

* Practice breaking a program into logical components
* Testing components in isolation and in combination
* Applying Enumerable techniques in a real context
* Practice implementing a useable REPL interface

## Background

Connect Four is a classic board game where players take turns trying to create a line of four of their own pieces without being blocked by their opponent. The game ends when one of the two players successfully lines up four of their pieces horizontally, vertically, or diagonally and wins, or in a draw if the 7-column, 6-row grid is filled without either player successfully connecting four.

For more information see the [wikipedia page](https://en.wikipedia.org/wiki/Connect_Four).

## Project Requirements

For this project, you will create an implementation of Connect Four that you can run from the command line with the following command:

```
$ ruby ./lib/connect_four.rb
```

From there, players will be asked to enter column names to place one of their pieces in a column. The computer will also place its own pieces. The player and the computer will continue to take turns until either one has won the game or they have played to a draw.

### Iteration 1: Printing the Board

When a player first runs the command to start the game, they will see a welcome message, followed by an empty board. The board itself will represent empty spaces with periods and column names with a letter A - G.

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

### Iteration 2: Placing Pieces

Update your program to request user input and allow them to place an individual piece.

Your program should ask for the user to enter a letter A - G, update the board so that their piece has been placed in that column, and then display the board again.

Once a player has completed their turn, the computer should take its turn and place a piece in one of the 7 columns at random. Once the computer has taken their turn, display the board again.

Players should be able to repeat this sequence and continue taking turns.

### Iteration 3: Evaluating Win & Draw Conditions

Continue to update your program so that after each turn the program determines whether one of the players has won or if the game has ended in a draw.

If one of those conditions has been met, the player should be given the option of playing again or quitting.

### Iteration 4: HTTP

* Make it so that a player can play over HTTP against a computer opponent. Use [this](http://backend.turing.edu/module1/projects/http_tutorial) tutorial as a starting place for creating your server.

### Additional Features

* Wrap the proeject in [Gem](https://en.wikipedia.org/wiki/RubyGems) using [Bundler](https://bundler.io/v1.16/guides/creating_gem.html) that can be run from the command line by typing `connect` anywhere on your machine rather than `ruby ./lib/connect_four.rb` from your project directory.
* Give players the option of playing with two players.
* Track win/loss records for players based on a name that they enter that persists between plays (consider writing to CSV). Give players the option of seeing a list of the top ranked players based on their win percentage.
* Record the time it takes for a player to win a game. Track their fastest wins and fastest losses. Provide an option for users to view their personal statistics once they have entered their name.

## Evaluation Rubric

The evaluation rubric for this project is available [here](../project_rubric)
