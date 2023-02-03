---
layout: page
title: Jungle Beat
---
# Iteration 1

## Node Basics

Our Linked List will ultimately be composed of individual nodes, so in this iteration we'll start with building out these nodes.
Note that they are quite simple -- a Node simply needs to have a slot for some data and a slot for a "next node". Eventually this
`next_node` position will be what we use to link the multiple nodes together to form the list.

For this iteration, build a simple node class that can perform these functions:

```ruby
> require "./lib/node"
> node = Node.new("plop")
> node.data
=> "plop"
> node.next_node
=> nil
```

## Append, To String, and Count (Single Node / Element)

Great! We have nodes. In this iteration we'll create the `LinkedList` class and start filling in the basic functionality needed to append our _first node_.

We'll be adding the following methods:

1. `append` - adds a new piece of data (data can really be anything) to the list
2. `count` - tells us how many things are in the list
3. `to_string` - generates a string of all the elements in the list, separated by spaces

But for now, focus on building these functions so they work for just the __first__ element of data appended to the list (we'll handle multiple elements in the next iteration).

Expected behavior:

```ruby
> require "./lib/linked_list"
> require "./lib/node"

> list = LinkedList.new
=> <LinkedList head=nil #45678904567>
> list.head
=> nil
> list.append("doop")
=> "doop"
> list
=> <LinkedList head=<Node data="doop" next_node=nil #5678904567890> #45678904567>
> list.head.next_node
=> nil
> list.count
=> 1
> list.to_string
=> "doop"
```

## Append, All/To String, and Insert (Multiple Nodes)

Now that we can insert the first element of our list (i.e. the Head), let's focus on supporting these operations for multiple elements in the list.

This iteration is really where we'll build out the core structure that makes up our linked list -- it will probably take you more time than the previous iterations.

Update your `append`, `count`, and `to_s` methods to support the following interaction pattern:

```ruby
> require "./lib/linked_list"
> require "./lib/node"

> list = LinkedList.new
=> <LinkedList head=nil #45678904567>
> list.head
=> nil
> list.append("doop")
=> "doop"
> list
=> <LinkedList head=<Node data="doop" next_node=nil #5678904567890> #45678904567>
> list.head
=> <Node data="doop" next_node=nil #5678904567890>
> list.head.next_node
=> nil
> list.append("deep")
=> "deep"
> list.head.next_node
=> <Node data="deep" next_node=nil #5678904567890>
> list.count
=> 2
> list.to_string
=> "doop deep"
```

Notice the key point here -- the first piece of data we append becomes the Head, while the second becomes the Next Node of that (Head) node.
