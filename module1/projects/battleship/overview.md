---
layout: page
title: Battleship - Overview
---

_[Back to Battleship Home](./index)_

You are to build a playable game of Battleship that runs in a REPL interface. The game will allow a single human player to play against a (simplistic) computer player.

Both the Human Player and the Computer have a 4 x 4 board that holds their ships. Each of them has 2 ships: The Cruiser which is 3 cells long and The Submarine which is 2 cells. A board will look like this:

```
  1 2 3 4
A S S S .
B . . . .
C . S . .
D . S . .
```

Each `S` represents part of a ship and each `.` represents an empty space. In this case, the Cruiser is held in cells A1, A2, and A3, and the Submarine is held in cells C2 and D2.

During the main phase of the game, the computer and the player take turns firing at each other's ships. The board shown above might look like this after a couple rounds of firing:

```
  1 2 3 4
A H S S .
B M . . M
C . X . .
D . X . .
```

Where `H` represents a hit, `M` represents a shot that missed, and `X` represents a sunken ship.

The Game is over when either the User or Computer sinks both enemy ships
