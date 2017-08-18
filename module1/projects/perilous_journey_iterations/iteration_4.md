---
layout: page
title: A Perilous Journey
---

# Iteration 4 - Additional Methods - `find`, `pop`, `includes?`

Perfect, we are almost there! Next is to add `find`, `pop` and `includes?` methods.

`find` takes two parameters, the first indicates the first position to return and the second parameter specifies how many elements to return.

`includes?` gives back true or false whether the supplied value is in the list.

`pop` removes the last element from the list. Before returning the last node, print that this family has "died of dysentery"

Expected behavior:

```ruby
....
> list.to_string
=> "The McKinney family, followed by the Lawson family, followed by the Brooks family, followed by the Henderson family"
> list.find(2, 1)
=> "The Brooks family"
> list.find(1, 3)
=> "The Lawson family, followed by the Brooks family, followed by the Henderson family"
> list.includes?("Brooks")
=> true
> list.includes?("Chapman")
=> false
> list.pop
The Henderson family has died of dysentery
=> <Node surname="Henderson" next_node=nil #5678904567890>
> list.pop
The Brooks family has died of dysentery
=> <Node surname="Brooks" next_node=nil #5678904567890>
> list.to_string
=> "The McKinney family, followed by the Lawson family"
```
