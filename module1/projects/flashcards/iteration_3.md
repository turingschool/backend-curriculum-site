---
layout: page
title: FlashCards - Iteration 3
---

_[Back to FlashCards Home](./index)_  
_[Back to Requirements](./requirements)_

## Iteration 3


### Playing the Game!

So far we've focused on modeling the data, classes, and methods that make up our game. However we haven't done much to put any kind of useable **interface** onto the game. In this iteration, let's remedy this by adding a simple Command-Line-Interface (CLI) to the game.

A few key points to keep in mind as you work on this iteration:

* We'll abandon testing for this bit -- the techniques for testing this kind of input/output behavior are somewhat involved and are beyond the scope of this project
* Use `puts` to display a line of text output to the user
* Use `gets` to read a line of text input from the user (this will be important to allow users to enter guesses)
* In this iteration we'll introduce a new file called a "runner" -- its job is to serve as the main entry point to our program by starting up a new game

**First**, create your runner file:

```
touch flashcard_runner.rb
```

Inside of this file, write the code to do the following:

* Create some Cards
* Put those card into a Deck
* Create a new Round using the Deck you created
* **Start** the round using a new method called `start`

**Keep in mind** that your existing objects should already contain, more or less, the data and methods needed to manage this process. Your challenge in this iteration is to build out the input/output messaging to support the user's card experience *using your existing pieces to store and manage all the necessary data*.

When we start the round by running `ruby flashcard_runner.rb`, it should produce the following interaction from the command line:


```
Welcome! You're playing with 4 cards.
-------------------------------------------------
This is card number 1 out of 4.
Question: What is 5 + 5?
```

Then a user will be able to type in a guess, in this case `10`, and hit enter to move the game play forward.

```
10
Correct!
This is card number 2 out of 4.
Question: What is Rachel's favorite animal?
```

The game will continue until all the Cards in the Deck have had a guess made against them (until you have completed as many Turns as you have Cards in the Deck).

```
panda
Incorrect.
This is card number 3 out of 4.
Question: What is Mike's middle name?
nobody knows
Correct!
This is card number 4 out of 4.
Question: What cardboard cutout lives at Turing?
Justin Bieber
Correct!
```

When all the Turns have been made, the game will end and will present the user with a final score.

```
****** Game over! ******
You had 3 correct guesses out of 4 for a total score of 75%.
STEM - 100% correct
Turing Staff - 50% correct
Pop Culture - 100% correct
```

Seen together, the CLI will look something like this when the game is over:

```
Welcome! You're playing with 4 cards.
-------------------------------------------------
This is card number 1 out of 4.
Question: What is 5 + 5?
10
Correct!
This is card number 2 out of 4.
Question: What is Rachel's favorite animal?
panda
Incorrect.
This is card number 3 out of 4.
Question: What is Mike's middle name?
nobody knows
Correct!
This is card number 4 out of 4.
Question: What cardboard cutout lives at Turing?
Justin Bieber
Correct!
****** Game over! ******
You had 3 correct guesses out of 4 for a total score of 75%.
STEM - 100% correct
Turing Staff - 50% correct
Pop Culture - 100% correct
```
