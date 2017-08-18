---
layout: page
title: A Perilous Journey
---

# Iteration 6 - Carrying Supplies

We have assembled the wagons for our train to the pacific, but we aren't going to make it very far without supplies. It is, after all, a perilous journey.

Modify your classes so that `Node`s are able to carry supplies. Supplies will be added whenever a new `Node` is created. So you will need to modify `append`, `insert`, and `prepend` wherever they appear.

Additionally, you should be able to list all the supplies in your `WagonTrain` as a single hash. If multiple wagons are carrying the same supplies, be sure to sum their amounts, so you can really tell how much you're carrying.

Expected Behavior:

```ruby
> require "./lib/wagon_train"
> wt = WagonTrain.new
=> <WagonTrain list=<LinkedList @head=nil #234567890890> #456789045678>
> wt.append("Burke", {"pounds of food" => 200})
=> <Node @surname="Burke" @supplies={"pounds of food" => 200} @next_node=nil #5678904567890>
> wt.list.prepend("Hardy", {"spare wagon tongues" => 3})
=> <Node @surname="Hardy" @supplies={"spare wagon tongues" => 3} @next_node=<Node @surname="Burke" ... > #5678904567890>
> wt.list.insert(1, "West", {"pounds of food" => 300})
=> <Node @surname="West" @supplies={"pounds of food" => 300} @next_node=<Node @surname="Burke" ... > #5678904567890>
> wt.count
=> 3
> wt.supplies
=> {"spare wagon tongues" => 3, "pounds of food" => 500}
```
