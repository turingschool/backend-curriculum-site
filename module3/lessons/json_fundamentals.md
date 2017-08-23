---
title: JSON Fundamentals
length: 30-
tags: json, javascript
status: draft
---

## Learning Goals


![SAD JSON](https://s-media-cache-ak0.pinimg.com/originals/32/7b/89/327b89ed22ccd2f75dfb9dd1241d830a.jpg)

* Understand what makes a valid JSON data structure
* Learn how to parse and create JSON in Ruby and JavaScript
* Compare JSON to XML and discuss its advantages and disadvantages

## Lecture

### Warmup

* Who or what is HTML/CSS designed for?
* What are some cases where you might not want to render an entire HTML page and only send the data to a client?

**Basic Narrative**: When designing a service or an API, you need a machine-readable way to transmit data. Typically, machine-readable formats have been just that—machine-readable (Think zeros and ones). JSON strikes a balance between being machine-readable, but also human-readable. Because it's also more lightweight than XML (read: less characters) it's typically faster because it requires less bandwidth to transmit.

Before diving deep into what JSON is, let's take a look at it [here](http://congress.api.sunlightfoundation.com/legislators/locate?zip=80229&apikey=e179a6973728c4dd3fb1204283aaccb5) or [here](https://birdeck-api.herokuapp.com/api/v1/posts/2). What do you notice?

### What is JSON?

* JSON stands for "JavaScript Object Notation"
* It is a string
* It maps easily onto the data structures used by most programming languages (numbers, strings, booleans, nulls, arrays and hashes/dictionaries)  
* It looks and acts similarly like Ruby's hash syntax
* It's lightweight and easy for humans to read and write
* Most programming languages have a library for reading and writing JSON structures
* It's a subset of the object syntax in JavaScript. All JSON is valid JavaScript, but not all JavaScript objects are valid JSON (functions, non-string keys, etc.)

**tl;dr**: JSON strikes a balance between being human readable and machine readable.

JSON is commonly used by APIs to send data back and forth when you don't need/want to render a full web page.

### Analyzing JSON  

JSON data structures are typically either an object (similar to a hash) or an array of objects or other values.

JSON objects follow some rules:

* Objects are made up of name/value pairs
* Keys must be double-quoted and followed by a colon

You also have a few types of values available in a JSON structure:

* Numbers
* Strings (in double quotes only)
* Booleans (`true` and `false`)
* Arrays
* Objects (again, objects in JavaScript are similar to hashes in Ruby)
* `null`

#### Example

```
person = '{
  "name":"Jennifer Johnson",
  "street":"641 Pine St.",
  "phone":true,
  "age":50,
  "pets":["cat","dog","fish"]
}'
```

This is valid JSON in a Ruby context.

#### Some Common Mistakes

* Using single quotes instead of double quotes
* Not using quotes at all (e.g. JavaScript doesn't require quotes on keys nor does Ruby's symbol shorthand)
* Including a trailing comma in an array
* Trying to break a string over multiple lines (`\n` is fine)

#### Lint Your JSON

If you find yourself writing JSON (we'll do this when we get to AJAX), [JSONLint](http://jsonlint.com/) is a great way to validate and troubleshoot your JSON formatting.

#### Try it!  
Hop into the JSONlinter and make yourself an object like above.  

### Where you'll find JSON

* APIs (e.g. Github, Twitter)
* Node's `package.json` and Bower's `bower.json` dependency manifests
* Sending data back and forth to your app through AJAX requests; building DOM with on the client with data from the server

### JSON and Ruby

Requiring the `json` library gives you `JSON.parse` and  `JSON.generate`. It also adds a `.to_json` method to most objects.

The `json` library is part of the standard library these days, so there is no need to require it in your `Gemfile`.

Let's play around with it in our `pry` consoles.

```rb
require 'json'

my_hash = { hello: "goodbye" }
puts JSON.generate(my_hash) #=> "{"hello":"goodbye"}"
puts  my_hash.to_json #=> "{"hello":"goodbye"}"
```

```rb
require 'json'

person = '{"name":"Jennifer Johnson","street":"641 Pine St.","phone":true,"age":50,"pets":["cat","dog","fish"]}'
parsed_person = JSON.parse(person) #=> {"name"=>"Jennifer Johnson", "street"=>"641 Pine St.", "phone"=>true, "age"=>50, "pets"=>["cat", "dog", "fish"]}
puts parsed_person
puts parsed_person['pets']
```

### JSON versus XML

Let's look at some data in [JSON and XML](https://gist.github.com/stevekinney/210a7fb9c9b3c0be2e53).

Any differences you notice?

*  XML slightly resembles HTML (both are markup languages)
*  JSON has less overhead, therefore making it faster in many cases

### Wrap Up

* What are some reasons you'd want to use JSON in your application?
* At its core, what is JSON?
* What are some places you've seen JSON?
* What are some of the gotchas working with JSON?

## Supporting Materials

* [Slides](https://www.dropbox.com/s/j3waahelo4q3f2e/Turing%20-%20JSON%20Fundamentals.key?dl=0)

## Additional Resources

### JSON and JavaScript

Even if all JavaScript objects are not JSON objects, all JSON objects are JavaScript objects.

So, it's tempting to think that when you pull some JSON in on the client side, that you're good to go.

_Not so fast._

JSON, in all, is a string at its core. To work with JSON as a JavaScript object, it must be parsed as one.

The JSON library gives you two handy methods for working with JSON in JavaScript.

* `JSON.parse` This method accepts a string of JSON and turns it into a JavaScript object.
* `JSON.stringify` This method accepts a JavaScript object and turns it into a JSON string.

These methods are relatively straight-forward.

`parse` will take a string of JSON and turn it into a JavaScript object.
`stringify` will take a JavaScript object and—umm—_stringify_ it.

`JSON.parse` is fairly strict. If there is an error in your JSON, it will throw an error (usually not a particularly helpful one). If you're getting some cryptic errors, toss your JSON into [JSONLint](http://jsonlint.com/) and make sure your JSON is malformed in some way before you spend too much time scratching your head trying to figure out what's wrong.

## Corrections & Improvements for Next Time

* None
