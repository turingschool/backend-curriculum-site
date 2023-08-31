---
layout: page
title: Beat Box
---
# Iteration 3

## Creating the BeatBox Linked List "Wrapper"

Awesome! We have built most of our program and now it's time to wrap the Linked List logic in a `BeatBox` class.

When we create a new instance of the `BeatBox` class, a `LinkedList` object is also instantiated and available as an attribute on the `BeatBox` instance. Now, we can manage our linked list through the `BeatBox` class.

Up until now, we have only been able to `append` and `prepend` a single node at a time. The LinkedList class hasn't formatted the data it received, consequently, passing the string "deep bop dop" to `append` has resulted in _one_ node created with data `deep bop dop`. With `BeatBox` as an extra layer, it can take care of properly formatting the data (eg: splitting the string) before passing it down to the `LinkedList`. This implementation results in _three_ nodes appended to the list if we pass the string "deep bop dop" to `BeatBox#append`.

Expected behavior:

```ruby
pry(main)> require "./lib/beat_box"
#=> true

pry(main)> require "./lib/linked_list"
#=> true

pry(main)> require "./lib/node"
#=> true

pry(main)> bb = BeatBox.new
#=> #<BeatBox:0x000000010f500108 @list=#<LinkedList:0x000000010f4e3ee0 @head=nil>>

pry(main)> bb.list
#=> #<LinkedList:0x000000010f4e3ee0 @head=nil>

pry(main)> bb.list.head
#=> nil 

pry(main)> bb.append("deep doo ditt")

pry(main)> bb.list.head.data
#=> "deep"

pry(main)> bb.list.head.next_node.data
#=> "doo"

pry(main)> bb.append("woo hoo shu")

pry(main)> bb.count
#=> 6
```

<br>

## Playing Beats

Now that we have our BeatBox class put together using the internal Linked List to keep track of our beats, let's use it to actually play the beats.

Remember that, at the command line, we can play sounds using the `say` command:

```
$ say -r 500 -v Boing "ding dah oom oom ding oom oom oom ding dah oom oom ding dah oom oom ding dah oom oom "
```

It turns out we can also easily issue this command (or any other system command) from ruby by using backticks: ```.

For example:

```
$ pry
> `say -r 500 -v Boing "ding dah oom oom ding oom oom oom ding dah oom oom ding dah oom oom ding dah oom oom "`
```

Additionally, we can use standard string interpolation (`#{}`) to pass dynamic content into a system command:


```
$ pry
> beats = "ding dah oom oom ding oom oom oom ding dah oom oom ding dah oom oom ding dah oom oom "
> `say -r 500 -v Boing #{beats}`
```

For this final section, add a `play` method to your BeatBox class that will generate the string content of the Beat and use it as input to the `say` command.

```ruby
pry(main)> require "./lib/beat_box"
#=> true

pry(main)> require "./lib/linked_list"
#=> true

pry(main)> require "./lib/node"
#=> true

pry(main)> bb = BeatBox.new
#=> #<BeatBox:0x000000010f500108 @list=#<LinkedList:0x000000010f4e3ee0 @head=nil>>

pry(main)> bb.append("deep doo ditt woo hoo shu")

pry(main)> bb.count
#=> 6

pry(main)> bb.list.count
#=> 6

pry(main)> bb.play
#=> # plays the sounds deep doo ditt woo hoo shu
```

Note: You do not need to test the `play` method, but are welcome to give it a shot
