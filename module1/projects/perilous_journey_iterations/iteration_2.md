---
layout: page
title: A Perilous Journey
---

# Iteration 2 - `.append` and `.to_string` (Multiple Nodes)

Now that we can insert the first element of our list (i.e. the Head), let's focus on supporting these operations for multiple elements in the list.

This iteration is really where we'll build out the core structure that makes up our linked list -- it will probably take you more time than the previous iterations.

Update your `.append`, `.count`, and `.to_s` methods to support the following interaction pattern:

```ruby
> require "./lib/linked_list"
> list = LinkedList.new
=> <LinkedList @head=nil #45678904567>
> list.head
=> nil
> list.append("Rhodes")
=> => <Node @surname="Rhodes" @next_node=nil #5678904567890>
> list
=> <LinkedList @head=<Node @surname="Rhodes" ... > #45678904567>
> list.head
=> <Node @surname="Rhodes" @next_node=nil #5678904567890>
> list.head.next_node
=> nil
> list.append("Hardy")
=> => <Node @surname="Hardy" @next_node=nil #5678904567890>
> list.head.next_node
=> <Node @surname="Hardy" @next_node=nil #5678904567890>
> list.count
=> 2
> list.to_string
=> "The Rhodes family, followed by the Hardy family"
```

Notice the key point here -- the first piece of data we append becomes the Head, while the second becomes the Next Node of that (Head) node.
