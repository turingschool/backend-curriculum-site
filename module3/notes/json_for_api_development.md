---
layout: page
title: JSON for API Development
---

When designing a service or an API, you need a machine-readable way to transmit data. Typically, machine-readable formats have been just that—machine-readable (Think zeros and ones).

At its core, JSON is an agreed upon format to represent data. It strikes a balance between being machine-readable, but also human-readable. It is frequently used as a language-neutral means to transmit data on the web.

Because it's also more lightweight than XML (read: fewer characters) it's typically faster because it requires less bandwidth to transmit.

Other notes:

* JSON stands for "JavaScript Object Notation"
* It is sent as one really long string in the body of the HTTP response
* It maps easily onto primitives (integers, strings, booleans, nulls, etc) and data structures (hashes/maps and arrays) used by most programming languages
* It looks and acts similarly to Ruby's hash syntax
  * except it will contain `null` instead of `nil` -- watch out for this!
* It's lightweight and easy for humans to read and write
* Most programming languages have built-in libraries for reading and writing JSON structures
* It's a subset of the object syntax in JavaScript. All JSON is valid JavaScript, but not all JavaScript objects are valid JSON (functions, non-string keys, etc.)
* When working in Ruby we will rarely work with JSON directly
  * we'll parse incoming JSON data as a hash, and access the elements of the hash as we have in our previous work, or
  * we'll build a hash or object, and "serialize" that as JSON for sending a response


## JSON Rules

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

## Common Mistakes

* Using single quotes instead of double quotes
* Not using quotes at all (JavaScript doesn't require quotes on keys nor does Ruby's symbol shorthand)
* Including a trailing comma in an array
* Trying to break a string over multiple lines (`\n` is fine)
