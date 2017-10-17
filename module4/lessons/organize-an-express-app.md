---
title: Organizing an Express App
tags: node, express, knex, database, SQL, http
---

### Pre-reqs

We're going to start from the end of the [SQL in Node Lesson](http://backend.turing.io/module4/lessons/sql-in-node)

If you need it, you can clone this repo, which represents the completed lesson:

```
git clone -b sql-in-node git@github.com:turingschool-examples/building-app-with-express.git
```

## Learning Goals

By the end of this lesson, you will:

*   Understand how to made code organization decisions without a framework

## Models and Controllers

Let's do some refactoring. Right now, `server.js` is hard to read and its methods are doing too much.

Think of the last Rails app you've built. You probably spent a very small amount of time making structural and design decisions (think routes, controllers, models). Just because the framework we're currently using doesn't prepackage our structure, doesn't mean we shouldn't implement something that's still quite helpful. Therefore, we'll be aiming to add some lightweight MVC strcuture to our Express apps.

## Models

### Dicuss: Where Can We Refactor?

Take 3 minutes to answer the following questions with a partner:

-   In the code that we have written, what should live in a model?
-   How could you extract that code in to a function or functions?

### Code Along: Implement Models

First, some structure:

```
mkdir /lib
mkdir /lib/models
touch /lib/models/secret.js
```

Let's start by extracting our SQL out of our handlers and into `secret.js`

```js
// secret.js
const create = (message) => {
  return database.raw(
    'INSERT INTO secrets (message, created_at) VALUES (?, ?) RETURNING id, message',
    [message, new Date]
  )
};

module.exports = {
  create,
}
```

We can now refactor our `server.js` POST handler as such:

```js
// server.js
const Secret = require('./lib/models/secret')

app.post('/api/secrets', (request, response) => {
  let id = Date.now()
  let message = request.body.message

  if (!message) {
    return response.status(422).send({ error: "No message property provided!"})
  }

  Secret.create(message)
    .then((data) => {
      response.status(201).json(data.rows[0])
    })
})
```

While we're at it, we can create a handy `destroyAll` method.

```js
// secret.js
let destroyAll = () => {
  return database.raw('TRUNCATE secrets RESTART IDENTITY')
}

module.exports = {
  create,
  destroyAll,
}
```

Last step is to use this new module and its functions in our test file.

```js
const Secret = require('../lib/models/secret')

describe('GET /api/secrets/:id', function(){
  beforeEach((done) => {
    Secret.create("I open bananas from the wrong side")
    .then(() => done())
  })

  afterEach((done) => {
    Secret.destroyAll()
    .then(() => done())
  })
})
```

### Your Turn

-   Can you extract the rest of the SQL from your tests and `server.js`?
-   Can you use promise chaining to extract the `rows` property from in model?
-   Can you do the same to extract a single resource for your `.find` method?

## Controllers

Our `server.js` is getting bulky. Something I've noticed is that each block of code in this file is mostly comprised of 1) an HTTP verb, 2) a route, and 3) a function to handle the request.

These were all things our `routes.rb` handled in Rails. Could we get `server.js` to behave more like a `routes.rb` file?

Take 3 minutes and discuss with a partner:

-   What code from our `server.js` looks like it might belong in a controller?
-   How could you extract that code in to a function or functions?
-   If you had to extract this code to another file, what questions would you have?

### Your Turn

Given that the second parameter of your `.get()` and `.post()` methods are just functions, try to extract them to a module in `lib/controllers` and reference them from `server.js`

For example:

```js
// lib/controllers/secrets.js
const postSecret = (request, response, next) => {
  let message = request.body.message;

  if (!message) {
    return response.status(422).send({ error: "No message property provided!"})
  }

  Secret.create(message)
    .then(function(data){
      response.status(201).json(data.rows[0])
    })
}
```

## Going Further

### `next()` and Middleware

Curious what the `next` argument in `postSecret` up there is? In my opinion, it's the coolest thing about Express.

`next` is a unique tool that allows you write your own application middleware. With this, you can take your Express app in virtually any direction. (_literally_) The only difference between a middleware function and a route handler callback is that middleware functions are expected to call `next` if they don't complete the request cycle.

There are middleware packages for cookies, sessions, user logins, URL params, POST data, security headers and much more.

Hop over to the [Express docs](https://expressjs.com/) or [Mozilla docs](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs/Introduction#Using_middleware) and learn about [writing your own middleware](https://expressjs.com/en/guide/writing-middleware.html).

### Sessions

Express doesn't come packaged with simple session tooling, but [cookie-session](https://github.com/expressjs/cookie-session) makes things just as easy. Check out their docs for getting quickly set up.
