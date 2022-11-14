---
layout: page
title: Iteration 4 - Additional Features
---

_[Back to Connect Four Home](./index)_ |
_[Back to Requirements](./requirements)_

Add to your Connect Four game implementation with one or more of the following features: 

### HTTP

* Make it so that a player can play over HTTP against a computer opponent.
* Use [this](http://backend.turing.edu/module1/projects/http_tutorial) tutorial as a starting place for creating your server.

### Ruby Gem

* Wrap the project in [Gem](https://en.wikipedia.org/wiki/RubyGems) using [Bundler](https://bundler.io/v1.16/guides/creating_gem.html) that can be run from the command line by typing `connect` anywhere on your machine rather than `ruby ./lib/connect_four.rb` from your project directory.

### Intelligent Computer

* Win: The computer always selects the column that would connect four of their pieces
* Block: The computer always selects the column to block the player with three connecting pieces
* When presented with Win vs. Block, the computer makes the decision to Win
* When presented with two or more different Block scenarios, selecting any Block is acceptable

### Two Human Players

* Give players the option of playing with two players.
* Each player enters a unique name.

### Win/Loss Record Keeping

* Track win/loss records for players based on a name that they enter that persists between plays (consider writing to CSV).
* Give players the option of seeing a list of the top ranked players based on their win percentage.

### Time Keeping

* Record the time it takes for a player to win a game.
* Track their fastest wins and fastest losses.
* Provide an option for users to view their personal statistics once they have entered their name.
