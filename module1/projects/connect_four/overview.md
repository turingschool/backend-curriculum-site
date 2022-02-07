---
layout: page
title: Connect Four - Overview
---

_[Back to Connect Four Home](./index)_

## Project Requirements

You are to build a playable game of Connect Four that runs in a REPL interface. The game will allow a single human player ("player") to play against a (simplistic) computer player ("computer"). The game will run from the command line with the following command:

```
$ ruby ./lib/connect_four.rb
```

From there, players will be asked to enter column names to place one of their pieces in a column. The computer will also place its own pieces. The player and the computer will continue to take turns until either one has won the game or they have played to a draw.

Here is a representation of the start of a game.
```
ABCDEFG
.......
.......
.......
.......
.......
.......
```

The Game is over when either the Player or Computer connects four of their pieces as described below, or the game ends in a draw (also described below).

Here is a representation of the human player (the 'X' player) winning the game with four connected pieces horizontally (in the same row).
```
ABCDEFG
.......
.......
...O...
...X...
..OXO..
XXXXOO.
```

Here is a representation of the human player (the 'X' player) winning the game with four connected pieces vertically (in the same column).
```
ABCDEFG
.......
.......
...X...
...X...
.OOX...
XOXXOO.
```

Here is a representation of the computer player (the 'O' player) winning the game with four connected pieces diagonally (in consecutively adjacent rows and columns).
```
ABCDEFG
.......
.......
....OO.
...OXX.
..OXOX.
XOXXOOX
```

Here is a representation of a draw game. Neither the human player ('X') nor the computer player ('O') achieved four connected pieces horizontally, vertically, or diagonally.
```
ABCDEFG
OXOXOOX
XOOXXOO
XXXOOXX
OXOXXOO
OOOXXOX
XXOXOOX
```
