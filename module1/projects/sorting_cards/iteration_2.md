---
layout: page
title: SortingCards - Project Requirements
---

## Iteration 2

### Storing Cards in a Deck

Create a `Deck` class with an accompanying test file. A `Deck` is initialized with an array of `Card` objects. The `Deck` class should respond to the following interaction pattern:

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> require './lib/deck'
#=> true

pry(main)> card_1 = Card.new("3","Hearts")
#=> #<Card:0x00007fa16104e160 @suit="Hearts", @value="3">

pry(main)> card_2 = Card.new("4", "Clubs")
#=> #<Card:0x00007fa160a62e90 @suit="Clubs", @value="4">

pry(main)> card_3 = Card.new("5", "Diamonds")
#=> #<Card:0x00007fa161a136f0 @suit="Diamonds", @value="5">

pry(main)> cards = [card_1, card_2, card_3]

pry(main)> deck = Deck.new(cards)
#=> #<Deck:0x00007fa160a38ed8...>

pry(main)> deck.cards
#=> [#<Card:0x00007fa16104e160...>, #<Card:0x00007fa160a62e90...>, #<Card:0x00007fa161a136f0...>]

pry(main)> deck.count
#=> 3
```

### The Round

A `Round` will be the object that processes responses and records guesses. A `Round` is initialized with a `Deck`. The idea is that when we start a Round, the current card is the first in the deck (the first in the Deck's array of Cards). When we make a guess, the guess is recorded, and the current card becomes the next card in the deck.

The `record_guess` method is the crux of this problem. The `record_guess` method takes a hash representing the guess. It should create a new `Guess` object with the appropriate response and Card. It should store this new guess, as well as return it from the `record_guess` method. Also, when the `record_guess` method is called, the `Round` should move on to the next card in the deck.

A `Round` should respond to the following interaction pattern:

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> require './lib/deck'
#=> true

pry(main)> require './lib/round'
#=> true

pry(main)> card_1 = Card.new("3","Hearts")
#=> #<Card:0x00007f972a227f18 @suit="Hearts", @value="3">

pry(main)> card_2 = Card.new("4", "Clubs")
#=> #<Card:0x00007f9729a87998 @suit="Clubs", @value="4">

pry(main)> deck = Deck.new([card_1, card_2])
#=> #<Deck:0x00007f972a214288...>

pry(main)> round = Round.new(deck)
#=> #<Round:0x00007f972a1c7960...>,

pry(main)> round.deck
#=> #<Deck:0x00007f972a214288...>

pry(main)> round.guesses
#=> []

pry(main)> round.current_card
#=> #<Card:0x00007f972a227f18 @suit="Hearts", @value="3">

pry(main)> new_guess = round.record_guess({value: "3", suit: "Hearts"})
#=> #<Guess:0x00007f972a15c160 @card=#<Card:0x00007f972a227f18 @suit="Hearts", @value="3">, @response="3 of Hearts">

pry(main)> new_guess.class
#=> Guess

pry(main)> new_guess.correct?
#=> true

pry(main)> round.guesses
#=> [#<Guess:0x00007f972a15c160 @card=#<Card:0x00007f972a227f18 @suit="Hearts", @value="3">, @response="3 of Hearts">]

pry(main)> round.number_correct
#=> 1

pry(main)> round.current_card
#=> #<Card:0x00007f9729a87998 @suit="Clubs", @value="4">

pry(main)> round.record_guess({value: "Jack", suit: "Diamonds"})
#=> #<Guess:0x00007f972a215b38...>

pry(main)> round.guesses.count
#=> 2

pry(main)> round.guesses.last.feedback
#=> "Incorrect."

pry(main)> round.number_correct
#=> 1

pry(main)> round.percent_correct
#=> 50.0
```


