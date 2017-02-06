---
layout: page
title: Application Coordination with Message Queues
sidebar: true
---

## Why

As applications grow in complexity it's common to break out child applications, often called "services" or "workers." Message queues provide a language-agnostic, asynchronous way for applications to speak with each other.

## Learning Goals

* Student is able to run a message queue engine
* Student can explain the lifespan of a message
* Student can add messages to a queue
* Student can read messages from a queue
* Student can perform work based on a queue message

## Structure

* Theory - 15 Minutes
* In Practice - 30 Minutes
* Paired Exercise - 30 Minutes
* Recap - 10 Minutes

## Theory

Let's diagram and explore these roles and idea:

* Primary application
* Message service
* Message queue
* Connection / Handle
* Anatomy of a Message
* Sitting in the queue
* Client
* Client Connection / Handle
* Polling vs Push
* Retrieving a message
* Timeout / Repeat / Problems

## In Practice

### Setup

```
$ brew install rabbitmq
$ gem install bunny
$ rabbitmq-server
```

In another tab:

```
$ rabbitmq-plugins enable rabbitmq_management
$ open http://localhost:15672/
```

Login with `guest` / `guest`.

### A Two-Queue Example

```
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

## Paired Exercise

Let's put these ideas into practice by writing two sets of programs. For these exercises one member of the pair is "P1" and the other member is "P2".

First, start a RabbitMQ instance on P1's machine.

### A Simple Number Game

#### On P1's Machine

Work together on P1's machine to write a program that:

* Creates a queue named `"messages.for.p2"`
* Publishes a message on to the queue with just the content `"2"`
* Subscribes to a queue named `"messages.for.p1"`

When a message is published to the `"messages.for.p1"` queue:

* Print a line `"Got: X"` where X is the number in the message
* Publish a message to `"messages.for.p2"` with the content of `X` squared
* Sleep for a few seconds: `sleep (2 + rand(3))`
* Increment a counter

Write a loop such that the program does not terminate until the counter reaches 10.

#### On P2's Machine

Work together on P2's machine to write a program that:

* Connects to the RabbitMQ running on P1's machine (*hint: find P1's local IP address*)
* Creates a queue named `"messages.for.p1"`
* Subscribes to a queue named `"messages.for.p2"`

When a message is published to the `"messages.for.p2"` queue:

* Print a line `"Got: X"` where X is the number in the message
* Publish a message to `"messages.for.p1"` with the content of `X` squared
* Sleep for a few seconds: `sleep (2 + rand(3))`
* Increment a counter

Write a loop such that the program does not terminate until the counter reaches 10.

#### Observations & Considerations

* What happens when you start P1 then P2?
* What happens when you start P2 without starting P1?
* How would this setup be different if the message queue was on a third machine instead of on P1?

### A Better Application

Now that you've got the workflow, let's make something that better illustrates the business use-case.

#### P1 as the Publisher

Use your original P1 program as a guide to implement a program that:

* Establishes a queue named `"email.confirmation"`
* Publishes each element of this array as an individual JSON-ified message into the queue:

```
[
  {:name => "Jeff", :email => "jeff@turing.io", :order_total => "25.99"},
  {:name => "Nate", :email => "nate@turing.io", :order_total => "27.10"},
  {:name => "Mike", :email => "mike@turing.io", :order_total => "125.00"},
  {:name => "Lia", :email => "lia@turing.io", :order_total => "3.99"},
  {:name => "Jorge", :email => "jorge@turing.io", :order_total => "249.99"},
  {:name => "Andrew", :email => "andrew@turing.io", :order_total => "12.00"},
  {:name => "Sal", :email => "sal@turing.io", :order_total => "1.99"},
  {:name => "Lauren", :email => "lauren@turing.io", :order_total => "199.99"},
  {:name => "Meeka", :email => "meeka@turing.io", :order_total => "19.99"},
  {:name => "Brenna", :email => "brenna@turing.io", :order_total => "79.99"}
]
```

Add a longer sleep between each queue message: `sleep (2 + rand(15))`

#### P2 as the Emailer

Use your original P2 program as a guide to implement a program that:

* Still connects to P1's RabbitMQ
* Subscribes to the queue `"email.confirmation"`

Whenever a message is received, parse it from JSON into a Ruby has and output a string like this:

```
To: Jeff
From: Customer Service
Subject: Your Order
Thanks for placing your order! Your credit card has been charged $25.99
```

After each message is printed add a delay with this: `sleep(2 + rand(5))`

Add a loop like this to keep the listener alive:

```
loop do
  sleep .5
  printf "."
end
```

Use `ctrl-c` when you want the program to end.

#### The Experiments

* Run the P2 consumer first
* Run the P1 program to queue the messages
* Observe the output on P2
* Start a *second instance* of the P2 program in a new terminal window
* Run the P1 program again
* Observe the output on the two P2 terminals
* Run a third instance of the P2 program in a new terminal window
* Run the P1 program again
* Observe the output on the three P2 terminals

Think about / discuss:

* How long did it take P1 to queue the messages?
* Email actually is slow to send. What does this scenario tell you about how big sites send email?
* How was the total processing time different with one, two, and three instances?
* What does this tell you about how message queue-based systems scale?

## Recap

* Reviewing the big-picture
* Recap the learning goals
* Questions

## Addendum

* [Bunny's GitHub page](https://github.com/ruby-amqp/bunny)
* For another take on how to consume messages from RabbitMQ, check out [Sneakers](https://github.com/jondot/sneakers)
* Check out [this blog post from Adam Niedzielski for another walk-through ](http://blog.sundaycoding.com/blog/2015/03/22/using-message-queue-in-rails/)
