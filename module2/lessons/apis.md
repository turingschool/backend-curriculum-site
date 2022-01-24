---
title: Intro to APIs
layout: page
---

## What is an API?

Read through these articles to get a sense of what an api is:

* [What is an API in Plain English? (freecodecamp)](https://www.freecodecamp.org/news/what-is-an-api-in-english-please-b880a3214a82)
* [What exactly is an API? (Medium article)](https://medium.com/@perrysetgo/what-exactly-is-an-api-69f36968a41f)

Then, watch [this video](https://www.youtube.com/watch?v=s7wmiS2mSXY)

## APIs

At a *very* high level, APIs allow web applications to communicate with each other. For example, an app you are building may want to use Twitter's API to show tweets about a specific topic, or you may want to consume the Google Maps API to embed an interactive map into one of your views.

The term "API" is very broad and can have many different meanings depending on the context. We are focused on building Web applications, so we are mostly concerned with **Web Based APIs**. These types of APIs are so common that this is what most people (including us) are talking about when referring to an "API". 

Since web apps communicate in HTTP, an API can be more specifically thought of as the format of HTTP requests an application accepts, and the format of data it returns.

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
require 'httparty'
require 'pry'
require 'json'

response = HTTParty.get 'https://api.github.com/users/<your github username>'

body = response.body

binding.pry
```

Run the code. If you get an error that the httparty gem is missing, run `gem install httparty`. If you get a Bad URI error, double check your github username spelling. It has to be an actual github user.

The HTTParty gem allows us to send HTTP requests from our code.

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

### Practice

1. We almost always want our code to be wrapped in classes and/or methods so that we can reuse it. Refactor your code to include at least 1 class and 1 method. Feeling good about that? Try to include 2 or even 3 classes and multiple methods inside each of those classes.
2. After you've refactored your code to include some classes and methods, write some RSpec tests that test those classes and methods.
3. APIs are typically rate limited which means there's a limit to how often you can send requests to them. The GitHub API [only allows 60 requests per hour for unauthenticated requests](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting). Implement RSpec mocking/stubbing to avoid sending the HTTP request when you run your tests.

## Checks for Understanding

1. How could you incorporate the GitHub API into a Rails Application? Where should this functionality live?

2. Think about how the HTTP request/response cycle works when building a "normal" Rails web application, an application that is meant to be viewed by a human user.

* Who is the client?
* Who is the server?
* Who is the "user"?
* What do the HTTP requests look like?
* What do the HTTP responses look like?

Now think about how your answers would change if you were building an API.
