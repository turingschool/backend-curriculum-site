---
layout: page
title: SortingCards
---

In this project, you will write a program to simulate a deck of cards. We will add functionality to guess what the card on the top of the deck is, and sort the deck.

In order to build good habits, we've broken the project into small classes to demonstrate objects that have a single responsibility.

# Iteration 1: Cards and Guesses

We start off with a Card object. A Card is initialized with a value and suit. The Card class should respond to the following interaction pattern:

```ruby
card = Card.new("Ace", "Spades")
card.value
=> "Ace"
card.suit
=> "Spades"
```

Along with the Card, we also have a Guess. It should respond to the following interaction pattern:

```ruby
card = Card.new("10", "Hearts")
guess = Guess.new("10 of Hearts", card)
guess.card
=> #<Card:0x007ffdf1820a90 @value="10", @suit="Hearts">
guess.response
=> "10 of Hearts"
guess.correct?
=> true
guess.feedback
=> "Correct!"
```

We also want to make sure that incorrect guesses are handled properly.

```ruby
card = Card.new("Queen", "Clubs")
guess = Guess.new("2 of Diamonds", card)
guess.card
=> #<Card:0x007ffdf1820a90 @value = "Queen", @suit="Clubs">
guess.response
=> "2 of Diamonds"
guess.correct?
=> false
guess.feedback
=> "Incorrect."
```

# Iteration 2: Storing Cards in a Deck and The Round

Let's store the cards in a Deck.

```ruby
card_1 = Card.new("3","Hearts")
card_2 = Card.new("4", "Clubs")
card_3 = Card.new("5", "Diamonds")
deck = Deck.new([card_1, card_2, card_3])
deck.cards
=> [card_1, card_2, card_3]
deck.count
=> 3
```

A Round will be the object that processes responses and records guesses. The idea is that when we start a Round, the current card is the first in the deck. As we make a guess on that card, the current card becomes the next card in the deck.

```ruby
card_1 = Card.new("3","Hearts")
card_2 = Card.new("4", "Clubs")
deck = Deck.new([card_1, card_2])
round = Round.new(deck)
round.deck
=> #<Deck:0x007ffdf181b9c8 @cards=[...]>
round.guesses
=> []
round.current_card
=> #<Card:0x007ffdf1820a90 @value="3", @suit="Hearts">
round.record_guess({value: "3", suit: "Hearts"})
=> #<Guess:0x007ffdf19c8a00 @card=#<Card:0x007ffdf1820a90 @value="3", @suit="Hearts">, @response="3 of Hearts">
round.guesses.count
=> 1
round.guesses.first.feedback
=> "Correct!"
round.number_correct
=> 1
round.current_card
=> #<Card:0x007ffdf1820a90 @value="4", @suit="Clubs">
round.record_guess({value: "Jack", suit: "Diamonds"})
=> #<Guess:0x007ffdf19c8a00 @card=#<Card:0x007ffdf1820a90 @value="4", @suit="Clubs">, @response="Jack of Diamonds">
round.guesses.count
=> 2
round.guesses.last.feedback
=> "Incorrect."
round.number_correct
=> 1
round.percent_correct
=> 50
```

# Iteration 3: Sorting the Deck

In this iteration, we will start to add some algorithmic complexity. We are going to add to the deck object the ability to sort the cards based on their value from lowest to highest. The order of values from lowest to highest is 2 through 10, Jack, Queen, King, Ace.

If two cards have the same value, the suit should be used to determine the order they are sorted. The order of suit from lowest to highest is Clubs, Diamonds, Hearts, Spades.

You are *NOT* allowed to use any built in sorting methods.

The interaction pattern will look like this:

```ruby
card_1 = Card.new("4","Hearts")
card_2 = Card.new("Jack", "Clubs")
card_3 = Card.new("5", "Diamonds")
card_4 = Card.new("Ace", "Spades")
card_5 = Card.new("Ace", "Diamonds")
deck = Deck.new([card_1, card_2, card_3, card_4, card_5])

deck.sort
=> [card_1, card_3, card_2, card_5, card_4]
```

# Iteration 4: Merge Sort

We're doing the same here, but with a different sorting algorithm, merge sort. As you implement this, think about why do we need different algorithms? How many swaps does your sort from iteration 3 make in the best case scenario? Worst case? How does this compare to Merge Sort?

The interaction pattern will look like this:

```ruby
card_1 = Card.new("4","Hearts")
card_2 = Card.new("Jack", "Clubs")
card_3 = Card.new("5", "Diamonds")
card_4 = Card.new("Ace", "Spades")
card_5 = Card.new("Ace", "Diamonds")
deck = Deck.new([card_1, card_2, card_3, card_4, card_5])

deck.merge_sort
=> [card_1, card_3, card_2, card_5, card_4]
```

### Merge Sort Resources

* [Youtube CS50](https://youtu.be/Pr2Jf83_kG0)
* [Merge Sort Visualization](https://www.youtube.com/watch?v=ZRPoEKHXTJg)
* [Folk Dance](https://www.youtube.com/watch?v=XaqR3G_NVoo)


# Evaluation Rubric

## Functionality

* Student completes through Iteration 3

## Mechanics

The student:

* appropriately uses Strings, Integers, Floats, Ranges, Symbols, Nils, Arrays, and Hashes
* implements best-choice enumerable methods to iterate over collections
* uses boolean expressions and flow control structures to logically manage a program's flow
* uses methods, arguments, and return values to break code into logical components
* creates Classes that utilize instance variables, attribute accessors, and instance methods

## Design

The student:

* adheres to the Single Responsibility and DRY principles
* creates Objects and Classes that appropriately encompass state and behavior
* uses instance and local variables appropriately
* writes readable code with the following characteristics:
    * Variable and method names are self explanatory
    * Methods are under 7 lines
    * Lines of code are under 80 characters
    * Project directory structure adheres to convention
    * A linter reports less than 5 errors

## Testing

The student:

* writes Minitest tests that describe the expected behavior of a program according to technical specifications
* names and orders tests so that a test file reads like documentation
* writes Minitest assertions that accurately test a piece of functionality
* writes a test before writing code that implements the behavior to make that test pass
* writes both integration and unit tests

## Version Control

The student:

* hosts their code on the master branch of their remote repository
* makes commits in small chunks of functionality
* submits and merges Pull Requests using the Github interface
