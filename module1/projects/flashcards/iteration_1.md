---
layout: page
title: FlashCards - Iteration 1
---

_[Back to FlashCards Home](./index)_  
_[Back to Requirements](./requirements)_

## Iteration 1

### Cards

A `Card` represents a single flashcard in our set. It stores a question, an answer, and a category.

Use the tests provided to drive the development of your `Card` class. From the root directory of your project, run the test like this:

```
rspec spec/card_spec.rb
```

If you haven't already, you will need to install rspec:

```
gem install rspec
```

If your `Card` class is written properly and is located at `./lib/card.rb`, you should be able to open a pry session from your `flashcards` directory and interact with it like so:

```ruby
# double check that you are in your flashcards project directory!
pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
#=> #<Card:0x00007f800e29f0c8 @question=""What is the capital of Alaska?", @answer="Juneau", @category=:Geography>

pry(main)> card.question
#=> "What is the capital of Alaska?"

pry(main)> card.answer
#=> "Juneau"

pry(main)> card.category
#=> :Geography
```


### Turns

Create a `Turn` class and an accompanying test file with the following methods:

* `initialize(string, card)` - A turn is initialized with two arguments. The first is a string representing a guess to a card's question. The second argument is a `Card` object representing the current flashcard being shown.
* `guess` - This method returns the guess
* `card` - This method returns the Card
* `correct?` - This method returns a boolean indicating if the guess matched the answer on the Card.
* `feedback` - This method either returns `"Correct!"` or `"Incorrect."` based on whether the guess was correct or not.

The `Turn` class should respond to the following interaction pattern:

```ruby
pry(main)> require './lib/turn'
#=> true

pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
#=> #<Card:0x00007f800e29f0c8 @question=""What is the capital of Alaska?", @answer="Juneau", @category=:Geography>

pry(main)> turn = Turn.new("Juneau", card)
#=> #<Turn:0x00007f99842f0998 @card=#<Card:0x00007f800e29f0c9 @question=""What is the capital of Alaska?", @answer="Juneau", @category=:geography>, @guess="Juneau">

pry(main)> turn.card
#=> #<Card:0x00007f800e29f0c8 @question=""What is the capital of Alaska?", @answer="Juneau", @category=:Geography>

pry(main)> turn.guess
#=> "Juneau"

pry(main)> turn.correct?
#=> true

pry(main)> turn.feedback
#=> "Correct!"
```

We also want to make sure that incorrect guesses are handled properly.

```ruby
pry(main)> require './lib/turn'
#=> true

pry(main)> require './lib/card'
#=> true

pry(main)> card = Card.new("Which planet is closest to the sun?", "Mercury", :STEM)
#=> #<Card:0x007ffdf1820a90 @answer="Mercury", @question="Which planet is closest to the sun?", @category=:STEM>

pry(main)> turn = Turn.new("Saturn", card)
#=> #<Turn:0x00007f998413ee60 @card=#<Card:0x007ffdf1820a90 @answer="Mercury", @question="Which planet is closest to the sun?", @category=:STEM>, @guess="Saturn">

pry(main)> turn.card
=> #<Card:0x007ffdf1820a90 @answer="Mercury", @question="Which planet is closest to the sun?", @category=:STEM>

pry(main)> turn.guess
=> "Saturn"

pry(main)> turn.correct?
=> false

pry(main)> turn.feedback
=> "Incorrect."
```

Remember, `#<Turn:0x00007f998413ee60 ... >` means "A Turn Object" or "An Instance of the Turn Class".
