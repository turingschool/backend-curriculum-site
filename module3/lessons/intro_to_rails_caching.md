---
layout: page
title: Intro to Caching in Rails
length: 60
tags: rails, caching, performance
---


Warm-Up Prompts:

- What is Caching?
- What is Memoization?
- What's the difference?

Write out some answers to these questions before expanding the notes below!

---

<details>
  <summary>Click to expand!</summary>

<h2>Cache</h2>
<ul>
  <li>auxiliary memory from which high-speed retrieval is possible</li>
  <li>storage of data so future requests for that data can be served faster</li>
  <li>stored data might be the result of an earlier computation or a copy of data stored elsewhere</li>
</ul>

<h2>Memoization</h2>
<ul>
  <li>an optimization technique used primarily to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again</li>
</ul>

<h2>Isn't that the same thing?</h2>

<p>No. Caching is STORING the data. Memoization is caching the RETURN VALUE of a function.</p>

<code>
  cache = {}                   # this is our cache
  cache['jenny'] = '867-5309'  # this is "caching" the data
  puts cache['jenny']          # this is using "memoization" to retrieve the data
</code>

<p>Back in the "old days" we had to look up people's phone numbers in a giant phone book. Caching would be like adding my favorite people in a smaller address book. Occasionally I might need to update their phone number from the bigger phone book, but now I have a smaller, easier-to-access book that I can maybe carry in my pocket.</p>

<p>Memoization would be like the address books that had little letters/tabs on the side to skip to all of my friends who start with "S" to get Sal's phone number in a hurry. The book is the cache, but the lookup of that data from the cache is memoization.</p>
</details>

---

## Breakout Groups

Discuss in your group:

1. How caching and memoization can be benefitial in the applications we've been making in Mod 3 so far
2. How the ideas here could help in your group project

## Group Discussion

Let's call on some random groups to discuss your thoughts.

---

## Benefits in Our Applications

The primary benefit we'll see in Rails is fetching API data. If the user is searching for the same data a second time, do we really need to make another API call to get the same data back? How likely is it that the data has changed since we last retrieved the results?

## Quick Review of other Memoization you've done

In discussion of authentication, we typically create a `current_user` method in our `ApplicationController` as a helper method, which allows us to fetch, and remember, who a current user is.

This has benefits in that we can call `current_user` over and over again, and we only go to the database one time.

The downside to this memoized data is that it disappears as soon as we build our HTTP response and close the connection for that user. Every connection coming to our Rails server is treated as a brand new request/respoinse cycle, and the first time we try to use `current_user` we have to look it up all over again, but the we can reuse it as many times as we need to until we send back that HTTP response.

## How is Rails caching going to be different than Memoization

In our Rails cache, we can remember things beyond a single HTTP request/response transaction. If a guest visits our site and we process some data, or fetch something from an API, and we send back that response, we COULD remember the data for the next user who comes to our site and is looking for the EXACT same data.

If we think about hitting a food API, for example, and someone searches for the recipe for "scalloped potatoes", we could "cache" that recipe for a while, and use "memoization" to retrieve the recipe the next time someone searches for the same text.

At some point, though, we should probably refresh that recipe. Also, whenever Rails restarts, it forgets everything it cached.

## Speed Improvements

Caching and Memoization don't actually make our application faster the first time someone searches for data, as we still have to process some data, or make a calculation, or go fetch something from an API. But the speed optimization happens for the NEXT user.

One parallel to draw here is using VCR with our API testing. The first test to use VCR has to go make a real API call, but then that inforamation is remembered so the next time we try to do the exact same operation, VCR uses the stored (cached) result and uses memoization to replace the "return value" of calling Faraday.

---

## Workshop!

Rails can implement caching in different ways, but the great thing is that it's BUILT INTO Rails. There's actually relatively little we need to do to enable it and to use it, and the performance boosts make for a great user experience.

Using the code-along you've been doing with your instructors in week 1 and 2 (ie, Propublica, or Dog API, etc), work in small groups in breakout rooms to implement some simple caching.

Reference the [Rails documentation](https://guides.rubyonrails.org/caching_with_rails.html) and avoid using third-party gems.

We're going to call on some groups at the end of the class to see what you've come up with!

---

## Gotchas, and Things to Be Aware of

There are ways you can use a `cache` keyword in our Views but we need to know how to "name" things in our cache. If you use a term which is too generic, you risk overwriting data. If you use a term which is highly specific you can remember finer details, but risk using a lot more memory. Look up the Rails documentation for how to cache things with a "key" name of some type.

#### How will you "invalidate" cached data so you retrieve a new copy later?

Just like VCR and refreshing those cassettes, we don't want to try to remember our fetched data forever otherwise we might as well just put it in a database. Look up Rails documentation for how to cache things for a period of time. What seems resonable for a period of time to remember some details? Should some details be remembered longer than others?

#### How can we cache non-View code, like our API calls?

Check the documentation page for how you can implement some low-level caching.
