---
layout: page
title: A Perilous Journey
---

# Iteration 3 - Additional Methods - `insert` and `prepend`

Now we have nodes and a `LinkedList` class that manages the list. Next step is to add the `insert` and `prepend` methods.

`prepend` will add nodes to the beginning of the list.

`insert` will insert one or more elements at a given position in the list. It takes two parameters, the first one is the position at which to insert nodes, the second parameter is the string of data to be inserted.

Expected behavior:

```ruby
> require "./lib/linked_list"
> list = LinkedList.new
> list.append("Brooks")
=> "Brooks"
> list.to_string
=> "Brooks"
> list.append("Henderson")
=> "Henderson"
> list.prepend("McKinney")
=> "McKinney"
> list.to_string
=> "The McKinney family, followed by the Brooks family, followed by the Henderson family"
> list.count
=> 3
> list.insert(1, "Lawson")
=> "Lawson"
list.to_string
=> "The McKinney family, followed by the Lawson family, followed by the Brooks family, followed by the Henderson family"
```
