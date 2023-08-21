---
layout: page
title: Beat Box
---

# Iteration 2

## Additional Methods - `insert` and `prepend`

Now we have nodes and a `LinkedList` class that manages the list. Next step is to add the `insert` and `prepend` methods.

`prepend` will add nodes to the beginning of the list.

`insert` will insert one or more elements at a given position in the list. It takes two parameters, the first one is the position at which to insert nodes, the second parameter is the string of data to be inserted.

Expected behavior:

```ruby
pry(main)> require "./lib/linked_list"
#=> true

pry(main)> require "./lib/node"
#=> true

pry(main)> list = LinkedList.new
#=> #<LinkedList:0x000000010d670c88 @head=nil>

pry(main)> list.append("plop")

pry(main)> list.to_string
#=> "plop"

pry(main)> list.append("suu")

pry(main)> list.to_string
# "plop suu"

pry(main)> list.prepend("dop")

pry(main)> list.to_string
#=> "dop plop suu"

pry(main)> list.count
#=> 3

pry(main)> list.insert(1, "woo")

pry(main)> list.to_string
#=> "dop woo plop suu"
```


<br>

## Additional Methods - `find`, `pop`, `includes?`

Perfect, we are almost there! Next is to add `find`, `pop` and `includes?` methods.

`find` takes two parameters, the first indicates the first position to return and the second parameter specifies how many elements to return.

`includes?` gives back true or false whether the supplied value is in the list.

`pop` removes the last element from the list and returns it.

Expected behavior:

```ruby
....
pry(main)> list.to_string
#=> "deep woo shi shu blop"

pry(main)> list.find(2, 1)
#=> "shi" 

pry(main)> list.find(1, 3)
#=> "woo shi shu"

pry(main)> list.includes?("deep")
#=> true

pry(main)> list.includes?("dep")
#=> false

pry(main)> list.pop
#=> "blop"

pry(main)> list.pop
#=> "shu"

pry(main)> list.to_string
#=> "deep woo shi"
```
