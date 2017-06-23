---
layout: page
title: Scrabble Challenge
tags: ruby, challenges
---

## Starter Repo

Find the starter repo [here](https://github.com/turingschool/scrabble)

## Instructions

1.  Fork and clone the repo above.
2.  Check out a branch called `yourname_scrabble` (your name = YOUR ACTUAL NAME)
3.  Pull the branch `fix_me_1701` into your branch.
4.  Resolve any merge conflicts.
5.  Make sure existing tests pass.
6.  Complete as much of the challenge as possible.
7.  Push up your branch.
8.  Create a Pull Request to the Turing School scrabble repo.

## The Challenge

### 1. Multipliers

Implement letter multipliers for scoring like this:

```ruby
game = Scrabble.new
game.score_with_multipliers('hello', [1,2,1,1,1])  # => 9
```

Then add word multipliers like this:

```ruby
game = Scrabble.new
game.score_with_multipliers('hello', [1,2,1,1,1], 2)  # => 18
```

And there should be a 10-point bonus for any seven letter word before the word multiplier:

```ruby
game = Scrabble.new
game.score_with_multipliers('sparkle', [1,2,1,3,1,2,1], 2)  # => 58
```

### 2. Highest Scoring Word

Implement a `highest_scoring_word` method that works like the examples below.

```ruby
game = Scrabble.new
game.highest_scoring_word(['home', 'word', 'hello', 'sound'])  # => "home"
```

Note that it's better to use fewer tiles, so if the top score is tied between multiple words, pick the one with the fewest letters:

```ruby
game = Scrabble.new
game.highest_scoring_word(['hello', 'word', 'sound'])  # => "word"
```

But there is a bonus for using all seven letters. If one of the highest scores uses all seven letters, pick that one:

```ruby
game = Scrabble.new
game.highest_scoring_word(['home', 'word', 'silence'])  # => "silence"
```

But if the there are multiple words that are the same score and same length, pick the first one in supplied list:

```ruby
game = Scrabble.new
game.highest_scoring_word(['hi', 'word', 'ward'])  # => "word"
```

### 3. Word List

Implement a Linked List to track words like this:

```ruby
list = WordList.new
list.count       # => 0
list.total_score # => 0

list.add("hello")
list.count       # => 1
list.head.score  # => 8
list.total_score # => 8

list.add("hi")
list.count       # => 2
list.head.score  # => 5
list.total_score # => 13

list.add("snacker")
list.count       # => 3
list.head.score  # => 13
list.total_score # => 26
```

Your implementation should not need any internal arrays.

### 4. Reading Game Data

Find a file named `input.csv` in the `./test/` folder with this game data:

```
player_id,word
1,hello
2,hi
1,silence
2,snacker
1,fun
```

Write code that can parse that file and follow this interaction pattern:

```ruby
game = GameReader.new('./test/input.csv')
game.word_count(:player_1)  # => 3
game.word_count(:player_2)  # => 2
game.score(:player_1)       # => 23
game.score(:player_2)       # => 18
```

### 5. Word Finder

You can load up a huge list of words using the OS X internal dictionary
like so:

```ruby
File.read('/usr/share/dict/words').split("\n")
```

That instruction will return you a massive array of strings.

Let's use that to cheat at Scrabble. Write a `WordFinder` with a `for_letters`
methods that finds all the words a player can play, using their letters.

```ruby
finder = WordFinder.new
finder.for_letters(['r', 'e', 'x', 'a', 'p', 't', 'o'])       # => ["a", "ae", "aer", "aero", "ape", "aper", "apert", "apex", ...
finder.for_letters(['r', 'e', 'x', 'a', 'p', 't', 'o']).count # => 141
```

Then build a second method named `for_letters_with` that takes a list of available letters along
with *one required letter*:

```ruby
finder.for_letters_with(['e', 'x', 'a', 'p', 't', 'o'], 'r')        # => ["aer", "aero", "aper", "apert", "aport", "ar", "are", "art", "arx", "ear", "er", "era", "export", "extra", ...
finder.for_letters_with(['e', 'x', 'a', 'p', 't', 'o'], 'r').count  # => 85
```

### 6. Player Tracking

Create a `Player` class which can track an aggregate score across multiple
plays. The player wins when they have more than 25 points.

```ruby
player = Player.new
player.play('hello')    # => 8
player.total            # => 8
player.play('hi')       # => 5
player.total            # => 13
player.won?             # => false
player.play('snacker')  # => 13
player.total            # => 26
player.won?             # => true
player.words            # => ['hello', 'hi', 'snacker']
player.tile_count       # => 14
player.tiles            # => {"h"=>2, "e"=>2, "l"=>2, "o"=>1, "i"=>1, "s"=>1, "n"=>1, "a"=>1, "c"=>1, "k"=>1, "r"=>1}
```

Then add a 10-point bonus when a player plays a seven letter word:

```ruby
player = Player.new
player.play('silence')
player.total  # => 19
```
