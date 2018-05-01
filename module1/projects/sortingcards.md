--- 
layout: page
title: SortingCards
---

In this project, you will write a program that is used through the command line. A user will be able to see cards, guess what the card is, and sort the cards.

In order to build good habits, we've broken the project up into small classes to demonstrate objects that have a single responsibility. As you work through each iteration, use TDD to drive out the desired behavior.

The rubric for this project is included at the bottom of this file.

# Iteration 1: Cards and Guesses

We start off with a card object. Use TDD to drive the creation of an object that has this interaction pattern:

```ruby
card = Card.new("Ace", "Spades")
card.value
=> "Ace"
card.suit
=> "Spades"
```

Along with the card, we also have a guess.  Users will enter a guess and we're going to have to figure out if the guess is correct. Use TDD to create this interaction pattern:

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

We also want to make sure that incorrect guesses are also handled properly.

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

Let's store the cards in a deck. Be sure to use TDD to create an object that has this interaction pattern:

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

A round will be the object that processes responses and records guesses. The idea is that when we start a round, the current card is the first in the deck. As we make a guess on that card, the current card becomes the next card in the deck. As always, use TDD to drive this following behavior.

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
round.record_guess("3 of Hearts")
=> #<Guess:0x007ffdf19c8a00 @card=#<Card:0x007ffdf1820a90 @value="3", @suit="Hearts">, @response="3 of Hearts">
round.guesses.count
=> 1
round.guesses.first.feedback
=> "Correct!"
round.number_correct
=> 1
round.current_card
=> #<Card:0x007ffdf1820a90 @value="4", @suit="Clubs">
round.record_guess("Jack of Diamonds")
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

# Iteration 3: Bubble Sort

In this iteration, we will start to add some algorithmic complexity. We are going to add to the deck object the ability to sort the cards based on their value from lowest to highest. (Assume that you won't have two cards of the same value with different suits.)

For this iteration, you will be using an algorithm called Bubble Sort. 

Bubble Sort Resources:

* [Wikipedia](https://en.wikipedia.org/wiki/Bubble_sort)
* [YouTube CS50](https://www.youtube.com/watch?v=RT-hUXUWQ2I)
* [Folk Dance](https://www.youtube.com/watch?v=lyZQPjUT5B4)
* [Visualization (Watch till the end, the last part is SO satisfying)](https://www.youtube.com/watch?v=Cq7SMsQBEUw)

The interaction pattern will look like this:

```ruby
card_1 = Card.new("4","Hearts")
card_2 = Card.new("3", "Clubs")
card_3 = Card.new("5", "Diamonds")
deck = Deck.new([card_1, card_2, card_3])

deck.bubble_sort
=> [card_2, card_1, card_3]
```

# Iteration 4: Insertion Sort

We're doing the same here, but with a different sorting algorithm, insertion sort. As you implement this, think about why do we need different algorithms? How many swaps does insertion sort make in the best case scenario? Worst case? How does this compare to Bubble Sort?


* [Wikipedia](https://en.wikipedia.org/wiki/Insertion_sort)
* [YouTube CS50](https://www.youtube.com/watch?v=kU9M51eKSX8)
* [Folk Dance](https://www.youtube.com/watch?v=ROalU379l3U)
* [Visualization (Watch till the end, the last part is SO satisfying)](https://www.youtube.com/watch?v=8oJS1BMKE64)

The interaction pattern will look like this:

```ruby
card_1 = Card.new("4","Hearts")
card_2 = Card.new("3", "Clubs")
card_3 = Card.new("5", "Diamonds")
deck = Deck.new([card_1, card_2, card_3])

deck.insertion_sort
=> [card_2, card_1, card_3]
```

# Extensions

* Prevent duplicate cards from being added to a deck.
* Put incorretly guessed cards back into the iteration to be asked again until the user guesses correctly.
* A deck can have up to two jokers. 


## Evaluation Rubric

The project will be assessed with the following guidelines:

* 4: Above expectations
* 3: Meets expectations
* 2: Below expectations
* 1: Well-below expectations

**Expectations:**

### 1. Ruby Syntax & Style

* Applies appropriate attribute encapsulation  
* Developer creates instance and local variables appropriately
* Naming follows convention (is idiomatic)
* Ruby methods used are logical and readable
* Code is indented properly
* Code does not exceed 80 characters per line
* Each class has correctly-named files and corresponding test files in the proper directories 

### 2. Breaking Logic into Components

* Code is effectively broken into methods & classes 
* Developer writes methods less than 10 lines 
* No more than 3 methods break the principle of SRP 

### 3. Test-Driven Development

* Each method is tested  
* Tests implement Ruby syntax & style   

### 4. Functionality

* Application meets all requirements (extension not req'd)

* 4: Completes Iteration 4 and one extension.
* 3: Completes Iteration 3
* 2: Completes Iteration 2
* 1: Completes Iteration 1
