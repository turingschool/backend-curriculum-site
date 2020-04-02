---
layout: page
title: War or Peace - Iteration 4
---

_[Back to Project Home](./index)_  
_[Back to Requirements](./requirements)_

## Iteration 4

### Loading Text Files

Right now, we're hardcoding the cards into our runner. Wouldn't it be nice to have file of card information to use?

Let's build an object that will read in a text file and generate cards. Remember to using TDD for this iteration!

Assuming we have a text file `cards.txt` that looks like this (but with all 52 cards):

```
2, Heart, 2
3, Heart, 3
4, Heart, 4
5, Heart, 5
6, Heart, 6
7, Heart, 7
8, Heart, 8
9, Heart, 9
10, Heart, 10
Jack, Heart, 11
Queen, Heart, 12
King, Heart, 13
Ace, Heart, 14
...
```

Then we should be able to do this:

```ruby
pry(main)> require './lib/card_generator'
#=> true

pry(main)> filename = "cards.txt"
#=> "cards.txt"

pry(main)> cards = CardGenerator.new(filename).cards
#=> [#<Card:0x007f9f1413cbe8...>, ... #<Card:0x007f9f1413c2b0...>]
```

Modify your program so that when you run `ruby war_or_peace_runner.rb`, it uses cards from `cards.txt` instead of hardcoded cards.
