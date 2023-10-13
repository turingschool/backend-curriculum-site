---
layout: page
title: Beat Box
---
# Iteration 1

## Node Basics

Our Linked List will ultimately be composed of individual nodes, so in this iteration we'll start with building out these nodes.
Note that they are quite simple -- a Node simply needs to have a slot for some data and a slot for a "next node". Eventually this
`next_node` position will be what we use to link the multiple nodes together to form the list.

For this iteration, build a simple node class that can perform these functions:

```ruby
pry(main)> require "./lib/node"
#=> true

pry(main)> node = Node.new("plop")
#=> #<Node:0x007fbda8a88348 @data="plop", @next_node=nil>

pry(main)> node.data
#=> "plop"

pry(main)> node.next_node
#=> nil
```

## Append, To String, and Count (Single Node / Element)

Great! We have nodes. In this iteration we'll create the `LinkedList` class and start filling in the basic functionality needed to append our _first node_.

We'll be adding the following methods:

1. `append` - creates a new node with the data that we pass into this method and adds it to the end of the linked list
2. `count` - tells us how many nodes are in the list
3. `to_string` - generates a string containing the data from every node in the list, separated by spaces

But for now, focus on building these functions so they work for just the __first__ element of data appended to the list (we'll handle multiple elements in the next iteration).

Expected behavior:

```ruby
pry(main)> require "./lib/linked_list"
#=> true

pry(main)> require "./lib/node"
#=> true

pry(main)> list = LinkedList.new
#=> #<LinkedList:0x000000010d670c88 @head=nil>

pry(main)> list.head
#=> nil

pry(main)> list.append("doop")

pry(main)> list
#=> #<LinkedList:0x0000000110e383a0 @head=#<Node:0x0000000110e382d8 @data="doop", @next_node=nil>>

pry(main)> list.head.data
#=> "doop"

pry(main)> list.head.next_node
#=> nil

pry(main)> list.count
#=> 1

pry(main)> list.to_string
#=> "doop"
```

## Append, All/To String, and Insert (Multiple Nodes)

Now that we can insert the first element of our list (i.e. the Head), let's focus on supporting these operations for multiple elements in the list.

This iteration is really where we'll build out the core structure that makes up our linked list -- it will probably take you more time than the previous iterations.

Update your `append`, `count`, and `to_string` methods to support the following interaction pattern:

```ruby
pry(main)> require "./lib/linked_list"
#=> true

pry(main)> require "./lib/node"
#=> true

pry(main)> list = LinkedList.new
#=> #<LinkedList:0x000000010d670c88 @head=nil>

pry(main)> list.head
#=> nil

pry(main)> list.append("doop")
#=> "doop"

pry(main)> list
#=> #<LinkedList:0x0000000110e383a0 @head=#<Node:0x0000000110e382d8 @data="doop", @next_node=nil>>

pry(main)> list.head
#=> #<Node:0x0000000110e382d8 @data="doop", @next_node=nil>

pry(main)> list.head.next_node
#=> nil

pry(main)> list.append("deep")

pry(main)> list
#=> #<LinkedList:0x00000001116213a0 @head=#<Node:0x00000001116212b0 @data="doop" @next_node=#<Node:0x00000001116210f8 @data="deep", @next_node=nil>>>

pry(main)> list.head.next_node
#=> #<Node:0x00000001116210f8 @data="deep", @next_node=nil>

pry(main)> list.count
#=> 2

pry(main)> list.to_string
#=> "doop deep"
```

Notice the key point here -- the first piece of data we append becomes the Head, while the second becomes the Next Node of that (Head) node.
