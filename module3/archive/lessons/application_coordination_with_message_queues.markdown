---
layout: page
title: Application Coordination with Message Queues
sidebar: true
---

## Why

As applications grow in complexity it's common to break out child applications, often called "services" or "workers." Message queues provide a language-agnostic, asynchronous way for applications to speak with each other.

### Learning Goals

* Student can explain the lifespan of a message
* Student can add messages to a queue
* Student can read messages from a queue
* Student can perform work based on a queue message
* Student can describe how/why work is extracted out into a secondary application

## Structure

* Theory - 55 Minutes
* Break ~ 5 Minutes
* Solo Practice - 30 Minutes
* Break ~ 10 Minutes
* Paired Practice - 55 Minutes
* Recap ~ 5 Minutes

## Part 1: Theory

Let's diagram and explore these roles and idea:

*   Primary application
*   Message service
*   Message queue
*   Connection / Handle
*   Anatomy of a Message
*   Sitting in the queue
*   Client
*   Client Connection / Handle
*   Polling vs Push
*   Retrieving a message
*   Timeout / Repeat / Problems

### Demonstrating Your Understanding

Let's model the message lifecycle in the physical space:

* Pair Up
* Establish a physical space for a queue
* Person on the right is the publisher
* Person on the left is the subscriber
* Publisher builds messages on scraps of paper
* Publisher puts them on to the queue one at a time
* Subscriber watches the queue
* Subscriber reads "Got the message: " followed by the message

What happens when two pairs combine so there's one publisher and three subscribers?

* How many total work cycles happen?
* What's the effective work time?
* Does each subscriber do the same amount of work?
* What if there is no subscriber?
* What if I'm subscribed and the publisher goes to get coffee?

## Part 2: Solo Practice

### A Remote Queue Server

We don't want to get bogged down in the ops-side of configuring a message queue server. Therefore we've setup a server for you that we can all share.

How it works:

* We have a DigitalOcean VPS (Virtual Private Server) running in THE CLOUD (OOOH!)
* On that VPS we've installed RabbitMQ, a powerful queue server
* The RabbitMQ server has a user account setup that'll be shared with you in Slack
* You'll connect to the server from your program (as a *client*)
* You'll interact with the server's message queues

### Queue Names & Collisions

If we're sharing a server and login, then how do we differentiate ourselves? If we're all pumping messages into and reading off of the same queue it'll be chaos.

Queues are "free" -- so we'll just each create our own queues on the server.

**In the below code snippets, you'll see queue names like `XYZ.counter_1`. Replace the `XYZ` with your first and last name in lowercase without punctuation, like `alanturing.counter_1`.**

### Organizing Your Code

To complete the exercises below you'll want to create a folder to hold your work and individual Ruby files for each section. We won't be using tests since we're just experimenting.

### Setup Bunny

We'll use the Bunny library to connect to and interact with RabbitMQ. Install it at your terminal:

```
$ gem install bunny
```

### First Steps with One Queue

Let's start with a small demo program to illustrate some of the functionality. Put this whole snippet into its own file so you can easily change it and run it from the terminal.

```ruby
require 'bunny'
require 'pry'

# Connect to the RabbitMQ Instance
connection = Bunny.new(
  :host => "experiments.turing.edu",
  :port => "5672",
  :user => "replace with correct account",
  :pass => "replace with correct password"
)
connection.start

# Establish a "channel" on that connection
channel = connection.create_channel

# Create a single queue
queue   = channel.queue("XYZ.counter")

# Publish some messages to the queue
n = 10
puts "Publishing #{n} Messages to the Queue"
n.times do |i|
  queue.publish("This is message #{i} published at #{Time.now.strftime('%H:%M:%S.%L')}")
  sleep 0.2
end
puts "Publishing complete"

sleep 5

puts "Starting the Queue Subscription"
queue.subscribe do |delivery_info, metadata, payload|
  puts "Found message at #{Time.now.strftime('%H:%M:%S.%L')}: [#{payload}]"
  sleep 1
end
puts "Queue Subscription Processed"

# puts "Type ctrl-c to stop"
# loop do
#  sleep 1
# end

sleep 1
connection.close
```

It should run without error. Then continue with the questions below:

#### Essential Understandings

Run the code as presented above:

1. Do you see all the "Found Message" lines?
2. Where does "Queue Subscription Processed" print relative to the messages?
3. What does this tell you about how subscriptions are handled?
4. Run the code again. What messages come out?

Uncomment the four lines toward the end and re-run:

1. Did anything change about which messages are displayed?
2. What can you infer about threads? What role is the `loop` playing?
3. Which version, with or without the `loop`, better matches your expectations for the functionality?

#### Explorations

If you have time in the work period, try these:

1. What happens if you move the `subscribe` chunk up above the message publishing?
2. Can you break the code into two separate files, one responsible for publishing and one responsible for subscribing?
3. What if you increase `n` to `50` and add a `sleep 0.5` inside the `n.times do` block? What does the output tell you?

You can find the API documentation for [Bunny's `Queue` class here](http://reference.rubybunny.info/Bunny/Queue.html).

1. Try using the `message_count` method to output the size of the pending queue each time you fetch a message.
2. Experiment with using the `pop` method. How does it seem to differ from `subscribe`?
3. Check out [the Bunny Queue documentation](http://rubybunny.info/articles/queues.html) for other ideas you can pursue.

## Part 3: Paired Challenge

Let's work in pairs and write two different programs. They can both run on the same machine or one on each machine at your preference.

*Imagine* we're an e-commerce shop selling [Brawndo, the Thirst Mutilator](http://www.brawndo.com/). We have a web application that conducts all the sales process for users, but we need our warehouse to keep track of the total number of pallets to be shipped by the end of the day.

### Sales Publisher

Write a ruby program that:

* Connects to a message queue (call it `XYZ.brawndo`)
* Publishes a message every two seconds while the program is running
* Formats the messages in JSON like below:

```json
{"order_id":12,"quantity":24}
```

Where the *quantity* is a random number between 2 and 36 and *order_id* just increments linearly.

### Warehouse Aggregator

Write a ruby program that:

* Connects to the same message queue
* Subscribes to messages
* Outputs aggregates to the screen each time a message is read like the following:

```
Daily Total: 12 orders, 212 units, 5 pallets
```

Where there are *48 units per pallet* and pallets can't be divided.

#### Pro-Tip

Did you know that you can get the effect of "updating" a single line of text in your terminal output? Try running this snippet in IRB:

```ruby
length = 30
length.times do |i|
  print "\r[#{'=' * i}#{' ' * (length-i)}]"
  sleep 0.5
end
```

The trick here is the `\r` which *returns* the cursor back to the beginning of the current line.

Can you update your aggregator to update a single line rather than scrolling as results come in?

### Extra Challenge

Could you add another layer? Create another queue so messages don't overlap.

* When the Warehouse Aggregator gets enough orders to add a pallet, it publishes a message for the Pallet Puller
* The Pallet Puller sees the new pallet message like this:

```
Fetch daily pallet 4, requested at 08:10:21.614
```

## Recap

* How would the warehouse program work differently if we had multiple instances of the warehouse subscription? What about multiple instances of the publishing application?
* Recap the learning goals
* Reviewing the big-picture message lifecycle
* Questions

## Addendum

Some additional resources related to RabbitMQ and message queues:

*   [Bunny's GitHub page](https://github.com/ruby-amqp/bunny)
*   For another take on how to consume messages from RabbitMQ, check out [Sneakers](https://github.com/jondot/sneakers)
*   Check out [this blog post from Adam Niedzielski for another walk-through](http://blog.sundaycoding.com/blog/2015/03/22/using-message-queue-in-rails/)

### Two Queues in One Program

Here's a little sample app that runs cross-publishes to two queues in one program.

```ruby
require 'bunny'
require 'pry'

# Connect to the RabbitMQ Instance
connection = Bunny.new
connection.start

# Establish a "channel" on that connection
channel = connection.create_channel

# Create two "queue" instances
queue_1   = channel.queue("sample.counter_1")
queue_2   = channel.queue("sample.counter_2")

queue_1.subscribe do |delivery_info, metadata, payload|
  puts "Q1: #{payload}"
  sleep rand*2
end

queue_2.subscribe do |delivery_info, metadata, payload|
  puts "Q2: #{payload}"
  sleep rand*2
end

5.times do |i|
  queue_1.publish(i.to_s)
  queue_2.publish(i.to_s)
end

sleep 10

connection.close
```
