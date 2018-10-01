---
layout: page
title: SortingCards - Project Requirements
---

## Iteration 4: Merge Sort

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


