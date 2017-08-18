---
layout: page
title: A Perilous Journey
---

# Iteration 5 - Creating the WagonTrain Linked List "Wrapper"

Awesome! We have built most of our program and now it's time to wrap the Linked List logic in a `WagonTrain` class.

When we create a new instance of the `WagonTrain` class, a `LinkedList` object is also instantiated and available as an attribute on the `WagonTrain` instance. Now, we can manage our linked list through the `WagonTrain` class.

Expected behavior:

```ruby
> require "./lib/wagon_train"
> wt = WagonTrain.new
=> <WagonTrain list=<LinkedList head=nil #234567890890> #456789045678>
> wt.list
=> <LinkedList head=nil #234567890890>
> wt.list.head
=> nil
> wt.append("Burke")
=> <Node surname="Burke" next_node=nil #5678904567890>
> wt.list.head.surname
=> "Burke"
> wt.append("West")
=> <Node surname="West" next_node=nil #5678904567890>
> wt.count
2
```
