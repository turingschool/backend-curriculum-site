---
layout: page
title: War or Peace - Iteration 1
---

_[Back to Project Home](./index)_  
_[Back to Requirements](./requirements)_

## Iteration 1

### Cards

A `Card` represents a single card that would be in a traditional deck of 52 cards.

Use the tests provided to drive the development of your `Card` class. **From the root directory of your project, run the test like this**:

```
rspec spec/card_spec.rb
```

If you haven't already, you will need to install rspec:

```
gem install rspec
```

If your `Card` class is written properly and is located at `./lib/card.rb`, you should be able to open a pry session from your `war_or_peace` directory and interact with it like so:

```ruby
# double check that you are in your war_or_peace project directory!
pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new(:heart, 'Jack', 11)
#=> #<Card:0x007fbda8a88348 @rank=11, @suit=:heart, @value="Jack">

pry(main)> card.suit
#=> :heart

pry(main)> card.value
#=> "Jack"

pry(main)> card.rank
#=> 11
```


### Deck

Create a `Deck` class and an accompanying test file with the following instance methods:

* `initialize`: this method will take one argument - an array of cards.
* `cards`: an attr_reader to read the `@cards` attribute
* `rank_of_card_at`: this method will take one argument that represents the index location of a card to be used (typically `0` or `2` *more on this later 😉* ) and will return the rank of that card.
* `high_ranking_cards`: this method will return an array of cards in the deck that have a rank of 11 or above (face cards and aces)
* `percent_high_ranking`: this method will return the percentage of cards that are high ranking
* `remove_card`: this method will remove the top card from the deck
* `add_card`: this method will add one card to the bottom (end) of the deck

Use the interaction pattern below to help you build your Deck test and `Deck` class.

Remember, `#<Card:0x00randomletters&nums...>` means "A Card Object" or "An Instance of the Card Class".  If you need to verify _which_ card object it is, you can refer to the last few digits of the 'random' letters and numbers and match those to a card that is created near the top of the interaction pattern.

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> require './lib/deck'
#=> true

pry(main)> card1 = Card.new(:diamond, 'Queen', 12)
#=> #<Card:0x007fbfd18490e8...>

pry(main)> card2 = Card.new(:spade, '3', 3)    
#=> #<Card:0x007fbfd19f4fa0...>

pry(main)> card3 = Card.new(:heart, 'Ace', 14)    
#=> #<Card:0x007fbfd18555a0...>

pry(main)> cards = [card1, card2, card3]

pry(main)> deck = Deck.new(cards)
#=> #<Deck:0x007fbfd2984808 @cards=[#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]>

pry(main)> deck.cards
#=> [#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.rank_of_card_at(0)
#=> 12

pry(main)> deck.rank_of_card_at(2)
#=> 14

pry(main)> deck.cards
#=> [#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.high_ranking_cards
#=> [#<Card:0x007fbfd18490e8...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.percent_high_ranking
#=> 66.67

pry(main)> deck.remove_card
#=> #<Card:0x007fbfd18490e8 @rank=12, @suit=:diamond, @value="Queen">

pry(main)> deck.cards
#=> [#<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]

pry(main)> deck.high_ranking_cards
#=> [#<Card:0x007fbfd18555a0...>]

pry(main)> deck.percent_high_ranking
#=> 50.0

pry(main)> card4 = Card.new(:club, '5', 5)
#=> #<Card:0x007fbfd2963978 @rank=5, @suit=:club, @value="5">

pry(main)> deck.add_card(card4)

pry(main)> deck.cards
#=> [#<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>, #<Card:0x007fbfd2963978...>]

pry(main)> deck.high_ranking_cards
#=> [#<Card:0x007fbfd18555a0...>]

pry(main)> deck.percent_high_ranking
#=> 33.33
```
