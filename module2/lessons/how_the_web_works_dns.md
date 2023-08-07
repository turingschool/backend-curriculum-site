---
title: How the Web Works, DNS Edition
length: 60
tags: http, dns, servers, rack, self-guided
---

## Learning Goals

* Describe how DNS lookup works.
* Describe how caching works.

## Vocabulary

* DNS
* IP address
* Server
* Caching

## Warmup

* Take 1 minute to write down any phone numbers that you have memorized.
* How do you normally look up someone's phone number?

## How do computers find each other?

We know that in the HTTP request/response cycle, there are two players. A client and a server. But how do these two devices know **where** to send their requests/responses?

When you send a letter to a friend, you have to specify their address. This address uniquely identifies your friend's house in the world. Computers have a corresponding address called an **IP Address**. The IP address address uniquely identifies a device on the internet. IP stands for "Internet Protocol". In order to find a computer anywhere in the world, all you need is its IP address, for example 142.811.0.1.

However, when you go to your web browser, you don't type in "142.811.0.1", you type in "google.com". So how does "google.com" become "142.811.0.1"? The answer is **DNS**.

## DNS

DNS is the Domain Name System. Its entire job is to take a domain, like `google.com`, and translate it to an IP address, like 142.811.0.1.

You can think of DNS as the phonebook (or, in more modern terms a *contact list*) of the internet. While you might click "Juliet" in your contact list to call Juliet's phone, the phone actually connects to `1-123-555-1234` since that's Juliet's phone number. 

Similarly, when we go to `https://google.com`, DNS is the translation between what that website is *called* and what it actually *is* to the internet. So, if we were to express this correlation as an analogy: 

Contacts : Domain Names :: Phone Numbers : IP Addresses

You can look up DNS information for your favorite websites on a Mac by using the `dig` command in Terminal. For example, type `dig google.com` and see what it comes back with in the `ANSWER` section. Can you identify the IP address that matches that domain? 

## Activity

Research the steps of DNS and draw a diagram to illustrate it.

## Why so many steps?

As you found, there are several steps in a DNS lookup. Why?

The reason is that transmissions across the internet take time. The farther away a device is, the longer the transmission takes. The longer transmissions take, the slower web pages will load. The slower web pages load, the angrier people on the internet will be. 😠 

If we imagine that rather than several steps involving several servers, DNS included just _one_ server that was located in Australia, all requests to the DNS from clients located in Australia would be very fast, whereas all requests from the western hemisphere would be very slow. So by having many servers, any step in the DNS process will send you to the closest possible server to reduce the distance.

## Caching

Another way DNS speeds up this whole process is with **caching**. Caching is when a device stores data locally so that future requests for that data can be served faster.

You already use caching in your own brain! Have you ever had someone ask you, "what time is it?" so you look at your watch, and you say "it's 12:30.". Then a few seconds later, someone else asks, "hey, what time is it?". Instead of looking at your watch again, you say "It's 12:30" because you just looked at the time and can remember. This is the same idea that computers use when dealing with repeated requests asking for the same information. 

For example, your computer may cache the answer of `2 + 2` as `4`. The next time you ask your computer what 2 + 2 is, rather than doing the computation, it will return the answer stored in its cache, which is 4. In this example, the cacluation of 2 + 2 is pretty simple, but you can see the benefits once the data we're after becomes very expensive to compute.

In DNS, any step of the lookup process may be **cached**. This makes it so that a number of steps in the process can be skipped if the information needed is already in cache.

## Reflection Questions

1. Looking at the DNS diagram you drew, mirror that diagram with a diagram of the Contact List / Phone Number scenario. Add any information you learned about DNS or Caching to one or both diagrams. 
2. If DNS uses caching, what could be some potential problems if the IP address associated with our domain name needs to change? 
3. Can you think of any other potential downsides to caching? 

## Checks for Understanding

* What is DNS?
* How does DNS work?
* What is caching?
* How does caching relate to DNS?

You can also use [this Check For Understanding quiz](https://forms.gle/cwthfKMmS5WNoCd37) to guide your learning. 