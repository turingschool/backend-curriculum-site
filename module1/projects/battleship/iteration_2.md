---
layout: page
title: BattleShip - Iteration 2
---

## Iteration 2

1. [Player Shot Sequence](#player-shot-sequence)
1. [Computer Shot Sequence](#computer-shot-sequence)

### Player Shot Sequence

Once the ships are laid out the game starts with the Player Shot Sequence.

1. Display the map from the current player's point of view
2. Prompt the player for a position on which to fire
3. Indicate whether that shot was a hit or a miss and display an updated map

#### 1. Displaying the map

Display a map using the format described above. On the map, include
information about the current player's previous shots. For every
shot that landed a hit, mark that position with an `H`, and for every
shot that missed, mark that position with an `M`.

So, on the first turn, a player's grid will look empty. But as the game
progresses, it will gradually fill up with misses and hits:

```
===========
. 1 2 3 4
A H M
B H   M
C   H M
D
===========
```

#### 2. Prompting Player for a Shot

At the bottom of the grid display, the board should include a message
prompting the player to enter a coordinate to fire on. This should follow
the same pattern as when placing ships --  a letter/number combination to
indicate the row and column to hit.

You should validate that the player's choice is a valid coordinate on the
board, and that they have not already fired on that position before. (If they
have, display a message explaining these constraints)

#### 3. Displaying Shot Information

After the player has entered their target, display a short message indicating
whether it was a hit or a miss. Additionally, re-render the board showing
the new shot.

Finally, prompt the player to end their turn by pressing `ENTER`.

### Computer Shot Sequence

Once the player has ended their turn, the AI will fire. This follows
a similar process, except that instead of prompting for a target, the
computer will simply select one at random from the positions that it
has not yet fired at (again, not a very sophisticated AI, but good enough
for now).

Once the computer has selected, display a message to the human player
indicating which position the computer fired at and whether it was a
miss or a hit.

Finally, give the player an overview of the computer's progress so far by
displaying the game grid of the player's ships with `H`s over any positions
the computer has hit and `M`s over any positions the computer has fired at but
missed.

Then, return to the Player Shot Sequence.
