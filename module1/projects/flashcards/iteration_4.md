---
layout: page
title: FlashCards - Iteration 4
---

## Iteration 4

### Loading Text Files

Right now, we're hardcoding the flashcards into our runner. Wouldn't it be nice to have a whole text file of questions and answers to use?

Let's build an object that will read in a text file and generate cards. Go back to using TDD for this iteration.

Assuming we have a text file `cards.txt` that looks like this:

```
What is 5 + 5?,10
What is Rachel's favorite animal?,red panda
What is Mike's middle name?,nobody knows
What cardboard cutout lives at Turing?,Justin bieber
```

Then we should be able to do this:

```ruby
pry(main)> require './lib/card_generator'
#=> true

pry(main)> filename = "cards.txt"
#=> "cards.txt"

pry(main)> cards = CardGenerator.new(filename).cards
#=> [#<Card:0x007f9f1413cbe8 @answer="10", @question="What is 5 + 5?">,
 #<Card:0x007f9f1413c788 @answer="red panda", @question="What is Rachel's favorite animal?">,
 #<Card:0x007f9f1413c2b0 @answer="nobody knows", @question="What is Mike's middle name?">,
 #<Card:0x007f9f14137da0 @answer="Justin bieber", @question="What cardboard cutout lives at Turing?">]
```

Modify your program so that when you run `ruby flashcard_runner.rb`, it uses cards from `cards.txt` instead of hardcoded cards.
