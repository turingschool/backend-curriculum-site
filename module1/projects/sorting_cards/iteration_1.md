---
layout: page
title: SortingCards - Project Requirements
---

## Iteration 1

### Cards

A `Card` represents a single card in our deck. It stores a suit and a value.

Use the tests provided to drive the development of your `Card` class. From the root directory of your project, run the test like this:

```
ruby spec/card_spec.rb
```

If you haven't already, you will need to install minitest:

```
gem install rspec
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
#=> #<Guess:0x00007f99842f0998 @card=#<Card:0x00007f9984004cc0 @suit="Hearts", @value="10">, @response="10 of Hearts">

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
#=> #<Guess:0x00007f998413ee60 @card=#<Card:0x00007f99839aa2a8 @suit="Clubs", @value="Queen">, @response="2 of Diamonds">

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
