---
layout: page
title: War or Peace - Iteration 3
---

_[Back to Project Home](./index)_  
_[Back to Requirements](./requirements)_

## Iteration 3

### Play the Game!

So far we've focused on modeling the data, classes, and methods that make up our game. However we haven't done much in the way of setting up the game to be played.  Now, we will tackle that problem.

A few key points to keep in mind as you work on this iteration:

* Use `p` to display a line of text output to the user
* In this iteration we'll introduce a new file called a "runner" -- its job is to serve as the main entry point to our program by starting up a new game

**First**, create your runner file:

```
touch war_or_peace_runner.rb
```

Inside of this file, write the code to do the following:

* Create 52 Cards (A standard deck)
* Put those card into two Decks (some randomness would be nice here!)
* Create two players with the Decks you created
* **Start** the game using a new method called `start`
  * This method will need to be included in a class - it is up to you which class to include it in - either existing or ✨new ✨

**Keep in mind** that your existing objects should still pass all existing tests - nothing that you add in this iteration should break anything that functioned in iterations 1 or 2!

When we start the game by running `ruby war_or_peace_runner.rb`, it should produce the following interaction from the command line:


```
Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are Megan and Aurora.
Type 'GO' to start the game!
------------------------------------------------------------------
```

Then a user will be able to type `GO`, and a game will start.  The user will then see each turn being played, like this:

```
Turn 1: Megan won 2 cards
Turn 2: WAR - Aurora won 6 cards
Turn 3: *mutually assured destruction* 6 cards removed from play
...
...
...
Turn 9324: Aurora won 2 cards
*~*~*~* Aurora has won the game! *~*~*~*
```

The game continues until one player has all cards in play, at which point, that player is declared the winner of the game! *Hint: take a look at the classes that you have built already, is there a method that will help you determine when the game has been won? or lost?*

In this game, there is the possibility of no winner. In order to cut down the amount of time it takes to play each game, and ensure that the game eventually does end, only 1,000,000 turns will be allowed.  If no player has all cards after 1,000,000 turns, the result of the game is a draw.

```
Turn 1: Megan won 2 cards
Turn 2: WAR - Aurora won 6 cards
Turn 3: *mutually assured destruction* 6 cards removed from play
...
...
...
Turn 1000000: Aurora won 2 cards
---- DRAW ----
```
