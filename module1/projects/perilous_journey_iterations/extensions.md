---
layout: page
title: A Perilous Journey
---

# Extensions

## 1. Hunting

The journey is perilous but it is also long. You may not be able to make it the whole way without fresh provisions. Add a `.go_hunting` method to your `WagonTrain`. This will result in 'pounds of food' being added to one of your wagons.

Your hunt will result in a random (0-5) number of animals, and each animal will randomly be a "squirrel", "deer", or "bison". The animals yield 2, 40 and 100 pounds of food respectively. Make sure you pluralize "squirrel" if you get more or less than one.

```ruby
> require "./lib/wagon_train"
> wt = WagonTrain.new
=> <WagonTrain list=<LinkedList head=nil #234567890890> #456789045678>
> wt.append("Burke", {"pounds of food" => 200})
=> <Node surname="Burke" supplies={"pounds of food" => 200} next_node=nil #5678904567890>
> wt.go_hunting
=> "You got 3 squirrels, 0 deer and 1 bison for 106 pounds of food"
> wt.supplies
=> {"pounds of food" => 306}
```

## 2. Circle the Wagons

The "tail" (the last element) of your LinkedList doesn't have a `next_node`. Rewrite your functionality so that the `next_node` of the "tail" now points to the head, but all other functionality still works.
