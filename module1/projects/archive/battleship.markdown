---
layout: page
title: BattleShip
---

![Classic fun for the whole patriarchy!](http://vignette4.wikia.nocookie.net/battleship/images/f/fd/Battleship-1.jpg/revision/latest?cb=20120303020432)

In this project you'll use Ruby to build an implementation of the classic game Battleship.

## Introduction

### Learning Goals / Areas of Focus

* Proficiently use TDD to drive development
* Practice breaking a program into logical components
* Practice implementing a useable REPL interface
* Apply previously learned Enumerable techniques in a real context

## Base Expectations

You are to build a playable game of Battleship that runs in a REPL interface.
The game will allow a single human player to play against a (simplistic)
computer player.

The game will include several distinct phases:

1. [Start Game Sequence](#start-game-sequence)
2. [Computer Ship Placement](#computer-ship-placement)
3. [Player Ship Placement](#player-ship-placement)
4. [Player Shot Sequence](#player-shot-sequence)
5. [Computer Shot Sequence](#computer-shot-sequence)
6. [Ship Hit Sequence](#ship-hit-sequence)
7. [End Game Sequence](#end-game-sequence)
8. Setup [SimpleCov](https://github.com/colszowka/simplecov) to monitor test coverage along the way

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

### Ship Hit Sequence

* If the hit did not sink the ship, tell them that they hit an enemy ship
* If the hit sunk the ship, tell them they sunk it and the size of the ship.
* If the hit sunk the ship and it was the last enemy ship, then enter the End Game Sequence

### End Game Sequence

When either the player or computer win the game...

* Output a sorry or congratulations message
* Output how many shots it took the winner to sink the opponent's ships
* Output the total time that the game took to play

## Extension

Make your game playable through a web browser. You may find [This Tutorial](/module1/projects/http_tutorial) helpful.

## Evaluation Rubric

The project will be assessed with the following rubric:

### 1. Ruby Syntax & Style

Expectations:

- [ ] Applies appropriate attribute encapsulation  
- [ ] Developer creates instance and local variables appropriately
- [ ] Naming follows convention (is idiomatic)
- [ ] Ruby methods used are logical and readable  
- [ ] Developer implements best-choice enumerable methods
- [ ] Code is indented properly
- [ ] Code does not exceed 80 characters per line
- [ ] A directory/file structure provides basic organization via lib/ and/or /test


### 2. Breaking Logic into Components

Expectations:

- [ ] Code is effectively broken into methods & classes
- [ ] Developer writes methods less than 7 lines
- [ ] No more than 3 methods break the principle of SRP

### 3. Test-Driven Development

Expectations:

- [ ] Each method is tested  
- [ ] Functionality is accurately covered
- [ ] Tests implement Ruby syntax & style   
- [ ] Balances unit and integration tests
- [ ] Evidence of edge cases testing
- [ ] Test Coverage metrics are present (SimpleCov)
- [ ] A test RakeTask is implemented

### 4. Functionality

Expectations:

- [ ] Application meets all requirements (extension not req'd)

### 5. Version Control

- [ ] Developer commits at a pace of at least 1 commit per hour
- [ ] Developer implements branching and PRs
- [ ] The final submitted version is merged into master
