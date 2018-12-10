---
title: Organizing an Express App
tags: node, express, knex, database, SQL, http
---

## Learning Goals

By the end of this lesson, you will:

*   Understand how to make code organization decisions in an unopinionated framework.

## Slides

Available [here](../slides/organizing_an_express_app)

## Pre-reqs

We're going to start from the end of the [Building an Express App](http://backend.turing.io/module4/lessons/express_knex)

If you need it, you can clone [this](https://github.com/turingschool-examples/library) repo, which has a branch `01_build_express_app_complete` that represents the code that we expect to have been completed at the end of that lesson.

## Warmup

Given the code that you currently have in the `/index.js` file:

* Walk through each line of code and describe what it's doing.
* How might you split the code in your routes into smaller functions?
* How might you split it into separate files?

## Models and Controllers

Let's do some refactoring. Right now, `/index.js` is hard to read and its methods are doing too much.

Think of the last Rails app you've built. You probably spent a very small amount of time making structural and design decisions (think routes, controllers, models). Just because the framework we're currently using doesn't prepackage our structure, doesn't mean we shouldn't implement something that's still quite helpful. Therefore, we'll be aiming to add some lightweight MVC structure to our Express apps.

> Note: The models and controllers we initially create will not be structured by classes, but we will eventually refactor them to be so. In the meantime, something like our `models/secret.js` file itself will be required in as a pseudo model and used as such.

## Models

### Discuss: Where Can We Refactor?

Take 3 minutes to answer the following questions with a partner assuming you were going to create a new file to act as a model in your application:

* What will this file be called?
* Where will you put it?
* What are its responsibilities?
* Is there any code in this function that is specifically not the responsibility of a model?
* Go ahead and see if you can move your code and ensure that everything still works.

### With a Partner: Implement Models

First, some structure:

```
$ mkdir lib
$ mkdir lib/models
$ touch models/paper.js
```

Let's start by extracting our SQL out of our handlers and into `paper.js`

```js
// paper.js

const environment = process.env.NODE_ENV || 'development';
const configuration = require('../../knexfile')[environment];
const database = require('knex')(configuration);

const all = () => database('papers')
  .select()

module.exports = {
  all,
}
```

We can now refactor our `index.js` GET handler as such:

```js
// index.js
const Paper = require('./models/paper')

app.get('/api/v1/papers', (request, response) => {
  Paper.all()
    .then((papers) => {
      response.status(200).json(papers);
    })
    .catch((error) => {
      response.status(500).json({error});
    })
})
```

### Your Turn

- Can you extract the rest of the Knex calls from your `index.js` file?

## Controllers

Our `index.js` is still a little bulky. Something I've noticed is that each block of code in this file is mostly comprised of a function to handle the request.

Could we create a controller to handle this functionality?

Take 3 minutes and discuss with a partner:

* What code from our `index.js` looks like it might belong in a controller?
* How could you extract that code in to a function or functions?
* If you had to extract this code to another file, what questions would you have?

### Your Turn

Given that the second parameter of your `.get()` and `.post()` methods are just functions, try to extract them to a module in `lib/controllers` and reference them from `routes/api/secrets.js`

For example:

```js
// lib/controllers/papers_controller.js
const Paper = require('../models/paper')

const index = (request, response) => {
  Paper.all()
    .then((papers) => {
      response.status(200).json(papers);
    })
    .catch((error) => {
      response.status(500).json({error});
    })
}

module.exports = {
  index,
}
```

## Routes

As our application accrues more routes, it might also be nice to move our routes out to separate files. Express will let us do that using Express Router. Create a new file to hold the code below:

```
# lib/routes/api/v1/footnotes.js

const express = require('express');
const router  = express.Router();
const footnotesController = require('../../../controllers/footnotes_controller')

router.get('/', footnotesController.index);

module.exports = router
```

And update `index.js` by taking out the footnotesController and the get route for footnotes. Replace with the following:

```
# index.js
const footnotes = require('./lib/routes/api/v1/footnotes')

app.use('/api/v1/footnotes', footnotes)
```

### Your Turn

Refactor to pull the routes that you have for papers out to a separate file as well or put all of your routes in a separate file.

## Going Further

### `static` Class Methods

Ideally in OOP, our controllers and models would be class-based. Explore [`static`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/static) methods to see how we can easily emulate Ruby's class methods.

### Sessions

Express doesn't come packaged with simple session tooling, but [cookie-session](https://github.com/expressjs/cookie-session) makes things just as easy. Check out their docs for getting quickly set up.
