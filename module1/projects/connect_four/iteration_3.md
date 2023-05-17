---
layout: page
title: Iteration 3 - Playing the Game
---

_[Back to Connect Four Home](./index)_
_[Back to Requirements](./requirements)_

Now it's time to put together the components you've built in the last two iterations to make a working game. You are allowed to build any additional classes or methods you think may be useful to accomplish this. You might also run into instances where it would make sense to refactor some methods that you already built in the first two iterations.

You are not expected to test anything related to user input and output in this iteration, but try to use TDD as much as possible to help you design your solution.

You are not expected to follow the Game described below *exactly*. If you want to give your computer player more personality, feel free to do so. However, the information relayed to the user and received from the user should not change. For instance, when either the player or computer places a piece, you are not allowed to omit displaying the board to the user. For your convenience, at the end of this page you will find a checklist that summarizes all of the functionality you are expected to build.

You are expected to build at least one additional class to complete this iteration. This can be a single class that is responsible for running the game. You should have very little code that is not contained in a class.

## Main Menu

When the user starts the game, they should see a welcome message that asks them if they want to play or quit. Whenever a game ends, they should return to this message so they can start a new game, or quit.

```
Welcome to CONNECT FOUR
Enter p to play. Enter q to quit.
```

## Setup

Once the User has chosen to play, display a new game board and ask the player to place their first piece.

### Placing Pieces

Your program will request user input and allow them to place an individual piece.

Your program should ask the user to enter a letter A-G.
Update the board to display the player's piece in the lowest available position of the selected column with an 'X'.

The computer takes its turn by selecting one of the 7 columns at random. Update the board to display the computer's piece in the lowest available position of the selected column with an 'O'.

The player and computer should be able to repeat this sequence and continue taking turns.

If an invalid column is selected by the player, the program should display an error message and ask the player to select a valid column. The program should repeat this process until a valid column is selected.

If an invalid column is selected by the computer, the program should repeat until a valid column is selected. No error message should display to the user when the computer selects an invalid column.

### End of Game

The game ends when one of three endgame conditions is met:

1. The player connects four of their pieces horizontally (in the same row), vertically (in the same column), or diagonally (in consecutively adjacent rows and columns). In this case, the player wins the game.
1. The computer connects four of their pieces horizontally, vertically, or diagonally. In this case, the computer wins the game.
1. The player can no longer place a piece. This occurs when there are no valid columns available; i.e. the game board is full. In this case, the game is a draw.

When one of the end game conditions has been met, an appropriate message should be displayed. The player should be given the option to play again or quit via the Main Menu.

## Functionality Checklist

This checklist summarizes all of the functionality you are expected to build. This will be used to assess the completion of your project:

**Welcome**:

* A welcome message is displayed
* can be combined with Main Menu

**Main Menu**:

* User is shown the main menu where they can play or quit
* can be combined with Welcome

**Setup**:

* A new game board is displayed
* The player is asked to place their first piece.

**Gameplay**:

* The player places their first piece in a valid column.
* The computer places their first piece in a randomly selected valid column.
* The player and computer take turns placing a piece until an endgame condition is met.
* The game board is updated after each piece
* A player attempting to place a piece in an invalid column prompts user to enter a valid column, except in the case of a draw

**End Game**:

* The player connects four of their pieces horizontally, vertically, or diagonally.
* The computer connects four of their pieces horizontally, vertically, or diagonally.
* The player cannot select a valid column.
* The program reports the appropriate endgame status
* Game returns user back to the Main Menu

