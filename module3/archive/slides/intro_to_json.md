# JSON

---

# Warmup

* What can you find about JSON on the internet?

---

# Overview

* Machine readable way to transmit data
* Also human readable
* Commonly used by APIs
* [Sunlight](http://congress.api.sunlightfoundation.com/legislators/locate?zip=80229&apikey=e179a6973728c4dd3fb1204283aaccb5)
* [Birdie](https://birdeck-api.herokuapp.com/)

---

# What is JSON?

* JavaScript Object Notation
* A string
* Looks and acts similarly like Ruby's hash syntax
* Subset of the object syntax in JavaScript
* All JSON is valid JavaScript, but not all JavaScript objects are valid JSON (functions, non-string keys, etc.)

---

# Advantages

* Lightweight relative to serving a full web page
* Typically faster
* Easy to read
* Most programming languages have a library for reading and writing JSON structures

---

# In the Wild

* APIs (e.g. Github, Twitter)
* Sending data back and forth to your app through AJAX requests; building DOM with on the client with data from the server
* Node's `package.json` and Bower's `bower.json` dependency manifests

---

# Rules

* Objects are made up of name/value pairs
* Keys must be double-quoted and followed by a colon

---

# Values Available

* Numbers
* Strings (in double quotes only)
* Booleans (`true` and `false`)
* Arrays
* Objects (again, objects in JavaScript are similar to hashes in Ruby)
* `null`

---

# Example

```
var person = '{
  "name":"Jennifer Johnson",
  "street":"641 Pine St.",
  "phone":true,
  "age":50,
  "pets":["cat","dog","fish"]
}'
```

---

# Common Mistakes

* Using single quotes instead of double quotes for keys
* Not using quotes at all for keys
* Including a trailing comma in an array
* Trying to break a string over multiple lines (`\n` is fine)

---

# Create Some JSON

Use [JSONLint](http://jsonlint.com/) to create and lint some JSON

---

# JSON versus XML

Review [JSON and XML](https://gist.github.com/stevekinney/210a7fb9c9b3c0be2e53).

Any differences you notice?

---

# JSON and Ruby

```rb
require 'json'

my_hash = { hello: "goodbye" }
puts JSON.generate(my_hash) #=> "{"hello":"goodbye"}"
puts  my_hash.to_json #=> "{"hello":"goodbye"}"
```

---

# More JSON and Ruby

```rb
require 'json'

person = "{\"name\":\"Jennifer Johnson\",\"street\":\"641 Pine St.\",\"phone\":true,\"age\":50,\"pets\":[\"cat\",\"dog\",\"fish\"]}"
parsed_person = JSON.parse(person) #=> {"name"=>"Jennifer Johnson", "street"=>"641 Pine St.", "phone"=>true, "age"=>50, "pets"=>["cat", "dog", "fish"]}
puts parsed_person
puts parsed_person['pets']
```

---

# Wrap Up

* What are some reasons you'd want to use JSON in your application?
* At its core, what is JSON?
* What are some places you've seen JSON?
* What are some of the gotchas working with JSON?
