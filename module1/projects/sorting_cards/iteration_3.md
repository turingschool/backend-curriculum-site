---
layout: page
title: SortingCards - Project Requirements
---

## Iteration 3: Sorting the Deck

In this iteration, we will start to add some algorithmic complexity. We are going to add to the deck object the ability to sort the cards based on their value from lowest to highest. The order of values from lowest to highest is 2 through 10, Jack, Queen, King, Ace.

If two cards have the same value, the suit should be used to determine the order they are sorted. The order of suit from lowest to highest is Clubs, Diamonds, Hearts, Spades.

You are *NOT* allowed to use any built in sorting methods.

The interaction pattern will look like this:

```ruby
card_1 = Card.new("4","Hearts")
card_2 = Card.new("Ace", "Spades")
card_3 = Card.new("5", "Diamonds")
card_4 = Card.new("Jack", "Clubs")
card_5 = Card.new("Ace", "Diamonds")
deck = Deck.new([card_1, card_2, card_3, card_4, card_5])

deck.sort
=> [card_1, card_3, card_4, card_5, card_2]
```


