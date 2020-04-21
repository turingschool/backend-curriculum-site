---
layout: page
title: Building an API
subheading:
length: 90
tags: apis, testing, requests, rails
---

This lesson plan last updated with Ruby 2.4.1 and Rails 5.2.0

## Learning Goals

* Understand how an API works at a conceptual level
* Use request specs to TDD an API
* Understand what makes a valid JSON data structure
* Learn how to parse and create JSON in Ruby

## Slides

Available [here](../slides/building_an_internal_api)

## Warmup

* What is an API?
* As early as Mod 1, everyone in this room has already built an API. Can you give an example?
* What do you suspect is different about the APIs we will be building in Mod 3?
* What value will these APIs provide?

## Lecture

### Discussion

Answer the questions above.

### APIs

* Sketch a diagram of a standard browser application consuming HTML (Airbnb)
  * HTML responses
  * Include: Browser, Rails, Database
* Who is the intended audience for HTML?
* Add a mobile device to the diagram (running the Airbnb app)
  * Is this app going to consume HTML? Why or why not?
  * What would be the fastest way to send data back and forth?

APIs provide a means for us to transmit data between web-based applications without worrying about all the overhead associated with HTML.

Why else might we create an API?

* Create an application that uses client-side JavaScript to update a page without a full-page refresh.
* Provide a means for developers at other companies to use a service that we provide.
* Split the work of our application into smaller applications that are each deployed separately (service oriented architecture)

### Background: JSON

#### Exploration

Discuss the examples of JSON linked below with a partner and describe what you notice.

* [Example 1](https://developer.github.com/v3/git/commits)
* [Example 2](https://birdeck-api.herokuapp.com/api/v1/posts/2).

#### Overview

When designing a service or an API, you need a machine-readable way to transmit data. Typically, machine-readable formats have been just that—machine-readable (Think zeros and ones).

At its core, JSON is an agreed upon format to represent data. It strikes a balance between being machine-readable, but also human-readable. It is frequently used as a language-neutral means to transmit data on the web.

Because it's also more lightweight than XML (read: fewer characters) it's typically faster because it requires less bandwidth to transmit.

Other notes:

* JSON stands for "JavaScript Object Notation"
* It is a string
* It maps easily onto the data structures used by most programming languages (numbers, strings, booleans, nulls, arrays and hashes/dictionaries)
* It looks and acts similarly like Ruby's hash syntax
* It's lightweight and easy for humans to read and write
* Most programming languages have a library for reading and writing JSON structures
* It's a subset of the object syntax in JavaScript. All JSON is valid JavaScript, but not all JavaScript objects are valid JSON (functions, non-string keys, etc.)
* When working in Ruby we will rarely work with JSON directly. Instead, we will parse JSON as a hash and access the elements of the hash as we have in our previous work.

#### JSON Rules

JSON data structures are typically string representations of either a single JavaScript object (similar to a Ruby hash) or an array of objects or other values.

* Objects are made up of name/value pairs
* Keys must be double-quoted and followed by a colon

You also have a few types of values available in a JSON structure:

* Numbers
* Strings (in double quotes only)
* Booleans (`true` and `false`)
* Arrays
* Objects (again, objects in JavaScript are similar to hashes in Ruby)
* `null`

#### Common Mistakes

* Using single quotes instead of double quotes
* Not using quotes at all (JavaScript doesn't require quotes on keys nor does Ruby's symbol shorthand)
* Including a trailing comma in an array
* Trying to break a string over multiple lines (`\n` is fine)

### New Tools

Before we begin, let's take a look at some of the new tools you'll be using.

#### JSON and Ruby

Let's play around with it in our `pry` consoles.

```rb
my_hash = { hello: "goodbye" }
puts JSON.generate(my_hash) #=> "{"hello":"goodbye"}"
puts  my_hash.to_json #=> "{"hello":"goodbye"}"
```

```rb
person = '{"name":"Jennifer Johnson","street":"641 Pine St.","phone":true,"age":50,"pets":["cat","dog","fish"]}'
parsed_person = JSON.parse(person) #=> {"name"=>"Jennifer Johnson", "street"=>"641 Pine St.", "phone"=>true, "age"=>50, "pets"=>["cat", "dog", "fish"]}
puts parsed_person
puts parsed_person['pets']
```

#### JSON in Rails Testing

Diagram feature testing and draw comparisons to writing request specs.

* `get 'api/v1/items'`: submits a get request to your application (like `visit`, but without all of the Capybara bells and whistles)
* `response`: captures the response to a given request (like `page` when using Capybara)
* `JSON.parse(response)`: parses a JSON response

### JSON in the Controller

* `render`: tells your controller what to render as a response
* `json: Item.all`: hash argument for render - converts Item.all to valid JSON

### Discussion

* What is API versioning?
* Why do we do it?
* The Importance of Habit:
  * Was anyone at Traversal?
  * Juniors who struggle on the job frequently have haphazard window placement, use the mouse a lot, start and stop servers etc
* While working through the tutorial:
  * practice a consistent window setup.
  * add one keyboard shortcut (Make it CMD + TAB if you aren't already using it).
  * keep a Rails server running
  * keep a Rails console running
  * keep a tab with a command prompt ready for running tests
  * BONUS: setup your editor with a keyboard shortcut for running your tests without leaving your editor.

## Practice

Complete the exercise [here](./exercises/building_an_api)

## Checks for Understanding

* What are some reasons you'd want to create an API?
* At its core, what is JSON?
* What are the main differences between creating a traditional Rails application and creating an API?
