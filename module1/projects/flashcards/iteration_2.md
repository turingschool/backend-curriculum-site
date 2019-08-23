---
layout: page
title: FlashCards - Iteration 2
---

_[Back to FlashCards Home](./index)_  
_[Back to Requirements](./requirements)_

## Iteration 2

### Storing Cards in a Deck

Create a `Deck` class with an accompanying test file. A `Deck` is initialized with an array of `Card` objects. A `Deck` should also be able to return cards based on a given category. The `Deck` class should respond to the following interaction pattern:

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> require './lib/deck'
#=> true

pry(main)> card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
#=> #<Card:0x00007fa16104e160 @answer="Juneau", @question="What is the capital of Alaska?", @category=:Geography>

pry(main)> card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
#=> #<Card:0x00007fa160a62e90 @answer="Mars", @question="The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", @category=:STEM>

pry(main)> card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
#=> #<Card:0x00007fa161a136f0 @answer="North north west", @question="Describe in words the exact direction that is 697.5° clockwise from due north?", @category=:STEM>

pry(main)> cards = [card_1, card_2, card_3]

pry(main)> deck = Deck.new(cards)
#=> #<Deck:0x00007fa160a38ed8...>

pry(main)> deck.cards
#=> [#<Card:0x00007fa16104e160...>, #<Card:0x00007fa160a62e90...>, #<Card:0x00007fa161a136f0...>]

pry(main)> deck.count
#=> 3

pry(main)> deck.cards_in_category(:STEM)
#=> [#<Card:0x00007fa160a62e90...>, #<Card:0x00007fa161a136f0...>]

pry(main)> deck.cards_in_category(:Geography)
#=> [#<Card:0x00007fa16104e160...>]

pry(main)> deck.cards_in_category("Pop Culture")
#=> []
```

### The Round

A `Round` will be the object that processes responses and records guesses. A `Round` is initialized with a `Deck`. The idea is that when we start a Round, the current card is the first in the deck (the first in the Deck's array of Cards). When we make a guess, the guess is recorded, and the next card in the deck becomes the current card.

The `take_turn` method is the crux of this problem. The `take_turn` method takes a string representing the guess. It should create a new `Turn` object with the appropriate guess and Card. It should store this new Turn, as well as return it from the `take_turn` method. Also, when the `take_turn` method is called, the `Round` should move on to the next card in the deck.

A `Round` should respond to the following interaction pattern:

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> require './lib/turn'
#=> true

pry(main)> require './lib/deck'
#=> true

pry(main)> require './lib/round'
#=> true

pry(main)> card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
#=> #<Card:0x00007fa16104e160 @answer="Juneau", @question="What is the capital of Alaska?", @category=:Geography>

pry(main)> card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
#=> #<Card:0x00007fa160a62e90 @answer="Mars", @question="The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", @category=:STEM>

pry(main)> card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
#=> #<Card:0x00007fa161a136f0 @answer="North north west", @question="Describe in words the exact direction that is 697.5° clockwise from due north?", @category=:STEM>

pry(main)> deck = Deck.new([card_1, card_2, card_3])
#=> #<Deck:0x00007fa160a38ed8...>

pry(main)> round = Round.new(deck)
#=> #<Round:0x00007f972a1c7960...>,

pry(main)> round.deck
#=> #<Deck:0x00007fa160a38ed8...>

pry(main)> round.turns
#=> []

pry(main)> round.current_card
#=> #<Card:0x00007fa16104e160 @answer="Juneau", @question="What is the capital of Alaska?", @category=:Geography>

pry(main)> new_turn = round.take_turn("Juneau")
#=> #<Turn:0x00007f99842f09e8 @card=#<Card:0x00007f800e29f0c9 @question=""What is the capital of Alaska?", @answer="Juneau", @category=:Geography>, @guess="Juneau">

pry(main)> new_turn.class
#=> Turn

pry(main)> new_turn.correct?
#=> true

pry(main)> round.turns
#=> [#<Turn:0x00007f99842f09e8 @card=#<Card:0x00007f800e29f0c9 @question=""What is the capital of Alaska?", @answer="Juneau", @category=:Geography>, @guess="Juneau">]

pry(main)> round.number_correct
#=> 1

pry(main)> round.current_card
#=> #<Card:0x00007fa160a62e90 @answer="Mars", @question="The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", @category=:STEM>

pry(main)> round.take_turn("Venus")
#=> #<Turn:0x00007f972a215b38...>

pry(main)> round.turns.count
#=> 2

pry(main)> round.turns.last.feedback
#=> "Incorrect."

pry(main)> round.number_correct
#=> 1

pry(main)> round.number_correct_by_category(:Geography)
#=> 1

pry(main)> round.number_correct_by_category(:STEM)
#=> 0

pry(main)> round.percent_correct
#=> 50.0

pry(main)> round.percent_correct_by_category(:Geography)
#=> 100.0

pry(main)> round.current_card
#=> #<Card:0x00007fa161a136f0 @answer="North north west", @question="Describe in words the exact direction that is 697.5° clockwise from due north?", @category=:STEM>
```
