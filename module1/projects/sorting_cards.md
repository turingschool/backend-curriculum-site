---
layout: page
title: SortingCards
---

In this project, you will write a program to simulate a deck of cards. We will add functionality to guess what the card on the top of the deck is, and sort the deck.

In order to build good habits, we've broken the project into small classes to demonstrate objects that have a single responsibility.

## Setup

* Fork [this repository](https://github.com/turingschool-examples/sorting_cards)
* Clone YOUR fork to your computer
  * Make sure you don't clone the turingschool-examples repository
* Complete the iterations below
  * Remember to commit frequently!

## Submission

When you are finished, make sure your code is pushed up to your repository on Github. Submit a Pull Request from your repository to the turingschool-examples repository.

# Iteration 1

### Cards

A `Card` represents a single card in our deck. It stores a suit and a value.

Use the tests provided to drive the development of your `Card` class. From the root directory of your project, run the test like this:

```
ruby test/card_test.rb
```

If you haven't already, you will need to install minitest:

```
gem install minitest
```

If your `Card` class is written properly, you should be able to open a pry session and interact with it like so:

```ruby
pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new("Ace", "Spades")
#=> #<Card:0x00007f800e29f0c8 @suit="Spades", @value="Ace">

pry(main)> card.value
#=> "Ace"

pry(main)> card.suit
#=> "Spades"
```

This interaction pattern assumes your `Card` class is in a file located at `./lib/card.rb`.

### Guesses

Create a `Guess` class and an accompanying test file with the following methods:

* `initialize(string, Card)` - A guess is initialized with two arguments. The first is a string representing a response to a card in the form of `<value> of <suit>`. The second argument is a `Card` object representing the card being guessed.
* `response` - This method returns the response
* `card` - This method returns the Card
* `correct?` - This method returns a boolean indicating if the response correctly guesses the value and suit of the Card
* `feedback` - This method either returns `"Correct!"` or `"Incorrect."` based on whether the guess was correct or not

The `Guess` class should respond to the following interaction pattern:

```ruby
pry(main)> require './lib/guess'
#=> true

pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new("10", "Hearts")
#=> #<Card:0x00007f9984004cc0 @suit="Hearts", @value="10">

pry(main)> guess = Guess.new("10 of Hearts", card)
#=> #<Guess:0x00007f99842f0998 @card=#<Card:0x00007f9984004cc0 @suit="Hearts", @value="10">, @guess="10 of Hearts">

pry(main)> guess.card
#=> #<Card:0x00007f9984004cc0 @suit="Hearts", @value="10">

pry(main)> guess.response
#=> "10 of Hearts"

pry(main)> guess.correct?
#=> true

pry(main)> guess.feedback
#=> "Correct!"
```

We also want to make sure that incorrect guesses are handled properly.

```ruby
pry(main)> require './lib/guess'
#=> true

pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new("Queen", "Clubs")
#=> #<Card:0x00007f99839aa2a8 @suit="Clubs", @value="Queen">

pry(main)> guess = Guess.new("2 of Diamonds", card)
#=> #<Guess:0x00007f998413ee60 @card=#<Card:0x00007f99839aa2a8 @suit="Clubs", @value="Queen">, @guess="2 of Diamonds">

pry(main)> guess.card
=> #<Card:0x00007f99839aa2a8 @suit="Clubs", @value="Queen">

pry(main)> guess.response
=> "2 of Diamonds"

pry(main)> guess.correct?
=> false

pry(main)> guess.feedback
=> "Incorrect."
```

Remember, `#<Guess:0x00007f998413ee60 ... >` means "A Guess Obeject" or "An Instance of the Guess Class".

# Iteration 2

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

# Iteration 3: Sorting the Deck

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

# Iteration 4: Merge Sort

We're doing the same here, but with a different sorting algorithm, merge sort. As you implement this, think about why we might need different algorithms. How many swaps does your sort from iteration 3 make in the best case scenario? Worst case? How does this compare to Merge Sort?

The interaction pattern will look like this:

```ruby
card_1 = Card.new("4","Hearts")
card_2 = Card.new("Ace", "Spades")
card_3 = Card.new("5", "Diamonds")
card_4 = Card.new("Jack", "Clubs")
card_5 = Card.new("Ace", "Diamonds")
deck = Deck.new([card_1, card_2, card_3, card_4, card_5])

deck.merge_sort
=> [card_1, card_3, card_4, card_5, card_2]
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
