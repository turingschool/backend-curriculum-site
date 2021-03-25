---
layout: page
title: Working with Services
length: 120
tags: ruby, apis, services
---

## Why

We've built some experiments using queues and services, but let's build something with demonstrable business value.

## Learning Goals

* Students will demonstrate comfort with using a message queue
* Students will implement three distinct programs/services that coordinate with each other
* Students will revisit their understandings of CSVs
* Students will revisit their understandinds of accessing APIs

## Challenge

Imagine that we have a group of politically engaged youth who want to reach out to their congresspeople and senators. We'll use their address data to lookup and supply them with the relevant contact information.

In this work session you'll work alone to build a cluster of services called RepFinder.

### How It's Used

From the terminal we run this command:

```
$ ruby repfinder.rb event_attendees.csv
```

Which means that it's taking an existing `event_attendees.csv` as input.

### Input Data

You'll need this [event_attendees.csv](https://cl.ly/47242m1X1n3j) file.

### What It Does

Each line of the input file includes several fields of data. But we're only interested in the:

* ID
* First Name
* Last Name
* Street
* City
* State
* Zipcode

For each attendee, use the Street, City, State, and Zipcode to lookup the representatives from the Sunlight Foundation API described below. Then output a file that can be printed and distributed to the attendees as the event.

### Sunlight Foundation's Congress API

* You'll want to install the `congress` gem
* The SunlightFoundation's API registration is down, but use the key `"e179a6973728c4dd3fb1204283aaccb5"`
* Have the [API documentation](https://sunlightlabs.github.io/congress/)
* See the [gem documentation](https://github.com/codeforamerica/congress)

### Output Expectations

* Create a folder named `output`
* For each attendee, generate a text file like the below.
* Use a filename like `00123_casimir_jeff.txt` for an attendee with ID 123 and name Jeff Casimir

```
== Jeff Casimir ==

Sen Cory Gardner (R): 202-224-5941
Rep Diana DeGette (D): 202-225-4431
Rep Mike Coffman (R): 202-225-7882
Sen Michael Bennet (D): 202-224-5852
```

### Architecture

Build three separate programs that use RabbitMQ as a message queue between them.

#### The Parser Service

* reads the CSV
* pulls out the data needed for individual lookups
* publishes a message with the data to be looked up to a queue for the Fetcher

#### The Fetcher Service

* watches for messages to hit the queue
* uses the data in a message to fetch the data from the Sunlight API
* publishes the relevant data for the user and representatives to the Printer queue

#### The Printer Service

* watches for messages to hit the queue
* formats the data and stores it to an output file

### Extension

The Fetcher is our slowest component:

* Use the unix `time` utility to see how long the run takes
* Reconfigure your app to spin up three Fetcher instances all using the same queues * Time the program runtime now
