---
layout: page
title: BattleShip - Iteration 1
---

## Iteration 1

1. [Start Game Sequence](#start-game-sequence)
1. Setup [SimpleCov](https://github.com/colszowka/simplecov) to monitor test coverage along the way
1. [Computer Ship Placement](#computer-ship-placement)
1. [Player Ship Placement](#player-ship-placement)


### Start Game Sequence

* The player starts the game by running `ruby battleship.rb` from within your project directory
* Then they see:

```
Welcome to BATTLESHIP

Would you like to (p)lay, read the (i)nstructions, or (q)uit?
>
```

* If they enter `p` or `play` then they enter the *ship layout* described below.
* If they enter `i` or `instructions` they should be presented with a short explanation of how
the game is played.
* If they enter `q` or `quit` then the game should exit

### Computer Ship Placement

When the player decides to start a game, the computer player should place
their ships. The baseline computer should simply use random placements,
but still obey these constraints:

#### Validating Ship Coordinates

Note that there are certain restrictions on where a ship can be placed.
Specifically:

* Ships cannot wrap around the board
* Ships cannot overlap
* Ships can be laid either horizontally or vertically
* Coordinates must correspond to the first and last units of the ship.
(IE: You can't place a two unit ship at "A1 A3")

### Player Ship Placement

After the computer has placed its ships, the player should see:

```
I have laid out my ships on the grid.
You now need to layout your two ships.
The first is two units long and the
second is three units long.
The grid has A1 at the top left and D4 at the bottom right.

Enter the squares for the two-unit ship:
```

#### Player Entering Ship Coordinates

Then they enter coordinates like this:

```text
A1 A2
```

Which places the two element ship on squares A1 and A2. Then it asks for the
coordinates for the three-unit ship.

Player ship positions should be validated according to the same rules
listed above. If a user enters an invalid ship coordinate, the game should display a
message explaining which of the rules their choice violated, then
ask them to re-enter all coordinates for that specific ship. (Any previous
ship placements should still be retained)

Once all ships have been placed, the user can enter the main game flow
phase.

### Game Flow (Main Phase)

During the main game, players take turns firing
at one another by selecting positions on the grid to attack.

#### Rendering the Game Grid

During this phase the game will frequently need to display
the current game view. We'll use a simple ASCII text grid
of letters (to indicate rows) and numbers (to indicate columns).

Your board will look something like this:

```
===========
. 1 2 3 4
A
B
C
D
===========
```
