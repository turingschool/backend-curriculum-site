---
layout: page
title: A Perilous Journey
---

# Iteration 0 - Node Basics

Our Linked List will ultimately be composed of individual nodes, so in this iteration we'll start with building out these nodes.
Note that they are quite simple -- a Node needs to have a slot for some data and a slot for a "next node". Eventually this
`next_node` position will be what we use to link the multiple nodes together to form the list.

For this iteration, build a node class that can perform these functions:

```ruby
> require "./lib/node"
> node = Node.new("Burke")
=> <Node @surname="Burke" @next_node=nil #5678904567890>
> node.surname
=> "Burke"
> node.next_node
=> nil
```
