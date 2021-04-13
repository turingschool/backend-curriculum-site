---
title: Intro to APIs
layout: page
---

### What is an API?

Read through these articles to get a sense of what an api is:

* [What is an API in Plain English? (freecodecamp)](https://www.freecodecamp.org/news/what-is-an-api-in-english-please-b880a3214a82)
* [What exactly is an API? (Medium article)](https://medium.com/@perrysetgo/what-exactly-is-an-api-69f36968a41f)

Then, watch [this video](https://www.youtube.com/watch?v=s7wmiS2mSXY)

### APIs

In the broadest sense of the term, an API is the part of an application that other people interact with. Using the example from the video above, restaurant customers don't walk back to the kitchen and give their order to the chef directly. Instead, they give their order to the waiter, the waiter relays that information to the chef, and then the waiter brings the food back to the customer. In this example, the waiter is the API.

You have already used the APIs of many libraries, though up to this point we have not discussed them as such. When you  use RSpec in your test suite, it would technically be accurate to say that you are using the API of the RSpec library. You don't go in and work directly with all of the classes and methods that make up the RSpec library, but instead only the methods included in the documentation that RSpec intends for other people to use. This collection of methods is the RSpec API, which is documented in the [RSpec API documentation](https://rspec.info/documentation/). If you go to that link and click on the latest version of the rspec-core library, you'll see examples that are very familiar to you.

You can also see the term API used in this very broad sense in [this documentation of the Ruby language](https://rubyapi.org/), [these Rails docs](https://apidock.com/rails), and the docs linked from [this Capybara page](https://teamcapybara.github.io/capybara/).

### Web APIs

Why haven't we been using the word API up to this point if we have seen so many of them? Because 99% of the time, when web developers use the word API we actually specifically mean a web API. We do this so often that we generally reserve the term API to refer to web APIs.

A web API can be described as _the subset of routes for a web app that the creators intend other programmers to interact with to retrieve data from the application_.

Just like our waiter example above, we don't want to allow an external user to come access every part of our web application. Outside users aren't allowed to come back and give our database (the chef) orders! But there are cases where we want to allow other programmers to access certain information from our database in a format they can use efficiently.

One thing to notice is that the API for our application does not include the routes that return the HTML pages that we have been creating up to this point. While it would be possible for other programmers to send requests to those routes and parse the HTML that is returned to pull out information (this is commonly described as web scraping), parsing HTML can be kind of a pain and there's very little guarantee that the HTML won't change when we redesign our website.

For that reason, when another developer uses our API we return the information in a format that is easy for computers to understand. In our case, we'll be using JSON.

Note that the _information_ that is presented at `http://www.ourapp.com/horses/1` will likely be the same as the information we get when we visit `http://www.ourapp.com/api/v1/horses/1`, but the first will be better formatted for human consumption and the second will be formatted to be easy to use by other programmers/applications.

### JSON

So far, you have built applications for humans to view, so you've been outputting css and html that a web browser can render in a readable way.

When designing an API, you are building it for other applications to read, so you need a machine-readable way to transmit data. Typically, machine-readable formats have been just that: machine-readable (Think zeros and ones).

JSON is that format. At its core, JSON is an agreed upon format to represent data. It strikes a balance between being machine-readable, but also human-readable. It is frequently used as a language-neutral means to transmit data on the web.

Take a look at some examples. What do you notice?

* [Example 1](https://developer.github.com/v3/git/commits)
* [Example 2](https://api.github.com/orgs/turingschool).

That's right! It looks just like a hash!

**Tip:** Installing the chrome extension [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa) is very helpful when viewing JSON in Google Chrome. It will format the JSON in a much more readable way.

### APIs in Action

"I want to see some code!" - you, right now

Here you go! Make a new ruby file and paste this code in, replacing `<your github username>` with your github username.

```ruby
require 'faraday'
require 'pry'
require 'json'

response = Faraday.get 'https://api.github.com/users/<your github username>'

body = response.body

binding.pry
```

Run the code. If you get an error that the faraday gem is missing, run `gem install faraday`. If you get a Bad URI error, double check your github username spelling. It has to be an actual github user.

The Faraday gem allows us to send HTTP requests from our code. We will use it a lot in Mod 3.

When you hit the pry, check out what the `response` and `body` variables are holding. Notice that the body contains that JSON format we talked about. What type of object is it?

That's right, it's a string! Wait, didn't we read about JSON being super flexible and easy to work with? A giant string doesn't seem that flexible or easy to work with :(

You're right again. Luckily, Ruby comes with a super handy library called `JSON` that we can use to parse this data.

Run this code in your pry session:

```ruby
JSON.parse(body)
```

BOOM! A hash! Huzzah! We know how to work with hashes! Right? Right.

Give it a try. Using this data:

* find your number of followers
* find the date you joined GitHub
* find some data of your choice!

Congratulations! You just consumed an API.

### Checks for Understanding

1. How could you incorporate the GitHub API into a Rails Application? Where should this functionality live?

2. Think about how the HTTP request/response cycle works when building a "normal" Rails web application, an application that is meant to be viewed by a human user.

* Who is the client?
* Who is the server?
* Who is the "user"?
* What do the HTTP requests look like?
* What do the HTTP responses look like?

Now think about how your answers would change if you were building an API.
