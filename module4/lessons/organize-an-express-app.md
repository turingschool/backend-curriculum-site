---
title: Organizing an Express App
tags: node, express, knex, database, SQL, http
---

### Pre-reqs

We're going to start from the end of the [Building and Testing with Express lesson](http://backend.turing.io/module4/lessons/building_and_testing_with_express)

If you need it, you can clone this repo, which represents the completed lesson:

```
git clone https://github.com/turingschool-examples/building-app-with-express/tree/1701-intro-to-express
```

## Learning Goals

By the end of this lesson, you will:

*   Understand how to made code organization decisions without a framework


## Faux Models and Controllers

Let's do some refactoring. Right now our implementation has a couple problems:

-   Our code is hard to read.
-   Our methods are doing too much, in tests and in server.js
-   We're repeating ourselves with this SQL

We don't need a framework to have well organized code!! Let's create some folders and some modules!

## Faux Models

Take 3 minutes to answer the following questions with a partner:

-   In the code that we have written, what should live in a model?
-   How could you extract that code in to a function or functions?
-   If you were to extract that code to another file, what questions would you have before you started?

Let's start by extracting SQL out of our test hooks (`beforeEach` & `afterEach`). We'll just create some global functions at the top of our application to start.

```js
function makeSecret() {
  return database.raw(
    'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
    ["I open bananas from the wrong side", new Date]
  )
}

function emptySecretsTable() {
  return database.raw('TRUNCATE secrets RESTART IDENTITY')
}

...

beforeEach(function(done) {
  makeSecret()
  .then(function() { done() })
})

afterEach(function(done) {
  emptySecretsTable()
  .then(function() { done() })
})

```

Promises can be passed around as parameters and return values. Since our functions return our knex promises, you can chain `.then()` right on to the end of them.

`makeSecret` works great for this use case, but let's see if we can write something a little more flexible:

```js
function createSecret(message) {
  return database.raw(
    'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
    [message, new Date]
  )
}

...

beforeEach(function(done) {
  createSecret("I open bananas from the wrong side")
  .then(function() { done() })
})
```

Great! Now we just need to put this code somewhere else. Create a `/lib/models` folder and a `secret.js` file inside. Move our two new functions into this file, along with our three configuration lines that we use to connect to the database. Check your relative paths when you do.

We're really close to being able to run our tests again. We need to export our functions. Add this to the bottom of our new model file:

```js
module.exports = {
  create: createSecret,
  destroyAll: emptySecretsTable
}
```

As long as we're refactoring, you can rename the functions, or even define them in the exports object, but we've at least moved our SQL out of our test file.

Last step is to use this new module and it's functions in our test file. Add a new require to the top, and rewrite our hooks as such:

```js
const Secret = require('../lib/models/secret')

...

beforeEach(function(done) {
  Secret.create()
  .then(function() { done() })
})

afterEach(function(done) {
  Secret.destroyAll()
  .then(function() { done() })
})
```

### Your Turn

-   Can you extract the rest of the SQL from your tests and `server.js`?
-   Can you use promise chaining to extract the `rows` property from in model?
-   Can you do the same to extract a single resource for your `.find` method?

## Faux Controller

Our `server.js` is getting bulky. Something I've noticed is that each block of code in this file is basically 1) an HTTP verb, 2) a route, and 3) a function to handle the request. Could we get it to behave more like a `routes.rb` file from Rails?

Take 3 minutes and discuss with a partner:

-   What code from our `server.js` looks like it might belong in a controller?
-   How could you extract that code in to a function or functions?
-   If you had to extract this code to another file, what questions would you have?

### Your Turn

Given that the second parameter of your `.get()` and `.post()` methods are just functions, try to extract them to a module in `lib/controllers`. Then require and reference them in `server.js`
