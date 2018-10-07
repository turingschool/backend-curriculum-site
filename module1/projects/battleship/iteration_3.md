---
layout: page
title: BattleShip - Iteration 3
---

## Iteration 3

1. [Ship Hit Sequence](#ship-hit-sequence)
1. [End Game Sequence](#end-game-sequence)

### Ship Hit Sequence

* If the hit did not sink the ship, tell them that they hit an enemy ship
* If the hit sunk the ship, tell them they sunk it and the size of the ship.
* If the hit sunk the ship and it was the last enemy ship, then enter the End Game Sequence

### End Game Sequence

When either the player or computer win the game...

* Output a sorry or congratulations message
* Output how many shots it took the winner to sink the opponent's ships
* Output the total time that the game took to play
