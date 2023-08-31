---
layout: page
title: Beat Box
---

# Iteration 4 - Extensions

### 1. Validating Beats

There are a lot of words which aren't going to work for beats. Like `Mississippi`.

Add validation to your program such that the input beats must be members of your
defined list. Insertion of a beat not in the list is rejected. Like this:

```ruby
pry(main)> bb = BeatBox.new("deep")
#=> #<BeatBox:0x000000010f500108 @list=#<LinkedList:0x000000010f4e3ee0 @head=#<Node:0x000000010d179d88 @data="deep", @next_node=nil>>>

pry(main)> bb.append("Mississippi")

pry(main)> bb.all
#=> "deep"

pry(main)> bb.prepend("tee tee tee Mississippi")

pry(main)> bb.all
#=> "tee tee tee deep"
```

Here's a starter list of valid beats, but add more if you like:

```
tee dee deep bop boop la na
```

### 2. Speed & Voice

Let's make it so the user can control the voice and speed of playback. You may not have all the voices referenced here available on your machine. You can check which voices you have by following the steps documented [here](https://support.apple.com/guide/mac-help/change-the-voice-your-mac-uses-to-speak-text-mchlp2290/mac).

Originally
we showed you to use `say -r 500 -v Boing` where `r` is the rate and `v` is the
voice. Let's setup a usage like this:

```ruby
pry(main)> bb = BeatBox.new("deep dop dop deep")
#=> #<BeatBox:0x000000010f500108 @list=#<LinkedList:0x000000010f4e3ee0 @head=#<Node:0x000000010d179d88 @data="deep", @next_node=#<Node:0x000000010d179d38 @data="dop", @next_node=#<Node:0x000000010d179c70 @data="dop", @next_node=#<Node:0x000000010d179d38 @data="deep", @next_node=nil>>>>>>

pry(main)> bb.play
#=> # plays the four sounds normal speed with Boing voice

pry(main)> bb.rate = 100
#=> 100

pry(main)> bb.play
#=> # plays the four sounds slower with Boing voice

pry(main)> bb.voice = "Daniel"
#=> "Daniel"

pry(main)> bb.play
#=> # plays the four sounds slower with Daniel voice

pry(main)> bb.reset_rate
#=> 500

pry(main)> bb.reset_voice
#=> "Boing"

pry(main)> bb.play
#=> # plays the four sounds normal speed with Boing voice
```

Note: You do not need to test the `play` method, but are welcome to give it a shot
