---
title: Organizing an Express App
tags: node, express, knex, database, SQL, http
---

## Learning Goals

By the end of this lesson, you will:

*   Understand how to made code organization decisions in an unopinionated framework.

## Slides

Available [here](../slides/organizing_an_express_app)

## Pre-reqs

We're going to start from the end of the [SQL in Node Lesson](http://backend.turing.io/module4/lessons/sql-in-node)

If you need it, you can clone [this](https://github.com/turingschool-examples/secret-box-revisited) repo, which has a branch `02_sql_lesson_complete` that represents the code that we expect to have been completed at the end of that lesson.

## Warmup

Given the code that you currently have in the `/api/secrets.js` file:

* Walk through each line of code and describe what it's doing.
* How might you split the code in that function into smaller functions?
* How might you split it into separate files?

## Models and Controllers

Let's do some refactoring. Right now, `server.js` is hard to read and its methods are doing too much.

Think of the last Rails app you've built. You probably spent a very small amount of time making structural and design decisions (think routes, controllers, models). Just because the framework we're currently using doesn't prepackage our structure, doesn't mean we shouldn't implement something that's still quite helpful. Therefore, we'll be aiming to add some lightweight MVC strcuture to our Express apps.

> Note: The models and controllers we initially create will not be structured by classes, but we will eventually refactor them to be so. In the meantime, something like our `models/secret.js` file itself will be required in as a pseudo model and used as such.

## Models

### Dicuss: Where Can We Refactor?

Take 3 minutes to answer the following questions with a partner assuming you were going to create a new file to act as a model in your application:

* What will this file be called?
* Where will you put it?
* What are its responsibilities?
* Are there things currently in `secrets.js` that are specifically *not* the responsibility of the model?
* Go ahead and see if you can move your code and ensure that everything still works.

### With a Partner: Implement Models

First, some structure:

```
$ mkdir models
$ touch models/secret.js
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
const destroyAll = () => {
  return database.raw('TRUNCATE secrets RESTART IDENTITY')
}

module.exports = {
  create,
  destroyAll,
}
```

### Your Turn

-   Can you extract the rest of the SQL from your tests and `server.js`?
-   Can you use promise chaining to extract the `rows` property from in model?
-   Can you do the same to extract a single resource for your `.find` method?

## Controllers

Our `app.js` is still a little bulky. Something I've noticed is that each block of code in this file is mostly comprised of 1) an HTTP verb, 2) a route, and 3) a function to handle the request.

These were all things our `routes.rb` handled in Rails. Could we get `app.js` to behave more like a `routes.rb` file?

Take 3 minutes and discuss with a partner:

* What code from our `app.js` looks like it might belong in a controller?
* How could you extract that code in to a function or functions?
* If you had to extract this code to another file, what questions would you have?

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

### `static` Class Methods

Ideally in OOP, our controllers and models would be class-based. Explore [`static`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/static) methods to see how we can easily emulate Ruby's class methods.

### `next()` and Middleware

Curious what the `next` argument in `postSecret` up there is? In my opinion, it's the coolest thing about Express.

`next` is a unique tool that allows you write your own application middleware. With this, you can take your Express app in virtually any direction. The only difference between a middleware function and a route handler callback is that middleware functions are expected to call `next` if they don't complete the request cycle.

There are middleware packages for cookies, sessions, user logins, URL params, POST data, security headers and much more.

Hop over to the [Express docs](https://expressjs.com/) or [Mozilla docs](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs/Introduction#Using_middleware) and learn about [writing your own middleware](https://expressjs.com/en/guide/writing-middleware.html).

### Sessions

Express doesn't come packaged with simple session tooling, but [cookie-session](https://github.com/expressjs/cookie-session) makes things just as easy. Check out their docs for getting quickly set up.
