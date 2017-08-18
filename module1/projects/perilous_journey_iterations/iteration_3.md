---
layout: page
title: A Perilous Journey
---

# Iteration 3 - Additional Methods - `.insert` and `.prepend`

Now we have nodes and a `LinkedList` class that manages the list. Next step is to add the `.insert` and `.prepend` methods.

`.prepend` will add nodes to the beginning of the list.

`.insert` will insert one or more elements at a given position in the list. It takes two parameters, the first one is the position at which to insert nodes, the second parameter is the string of data to be inserted.

Expected behavior:

```ruby
> require "./lib/linked_list"
> list = LinkedList.new
> list.append("Brooks")
=> <Node @surname="Brooks" @next_node=nil #5678904567890>
> list.to_string
=> "The Brooks family"
> list.append("Henderson")
=> <Node @surname="Henderson" @next_node=nil #5678904567890>
> list.prepend("McKinney")
=> <Node @surname="McKinney" @next_node=<Node @surname="Brooks" ... > #5678904567890>
> list.to_string
=> "The McKinney family, followed by the Brooks family, followed by the Henderson family"
> list.count
=> 3
> list.insert(1, "Lawson")
=> <Node @surname="Lawson" @next_node=<Node @surname="Brooks" ... > #5678904567890>
> list.to_string
=> "The McKinney family, followed by the Lawson family, followed by the Brooks family, followed by the Henderson family"
```
