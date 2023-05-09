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
> bb = BeatBox.new("deep")
> bb.append("Mississippi")
> bb.all
=> "deep"
> bb.prepend("tee tee tee Mississippi")
> bb.all
=> "tee tee tee deep"
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
> bb = BeatBox.new("deep dop dop deep")
> bb.play
=> 4 # plays the four sounds normal speed with Boing voice
> bb.rate = 100
=> 100
> bb.play
=> 4 # plays the four sounds slower with Boing voice
> bb.voice = "Daniel"
=> "Daniel"
> bb.play
=> 4 # plays the four sounds slower with Daniel voice
> bb.reset_rate
=> 500
> bb.reset_voice
=> "Boing"
> bb.play
=> 4 # plays the four sounds normal speed with Boing voice
```
