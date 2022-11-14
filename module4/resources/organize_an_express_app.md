---
title: Organizing an Express App
tags: node, express, knex, database, SQL, http
---

## Learning Goals

By the end of this lesson, you will:

*   Understand how to make code organization decisions in an un-opinionated framework.

## Slides

Available [here](../slides/organizing_an_express_app)

## Pre-reqs

We're going to start from the end of the [Building an Express App](http://backend.turing.edu/module4/lessons/express_knex)

If you need it, you can clone [this](https://github.com/turingschool-examples/publications) repo.

## Warmup

Given the code that you currently have in the `/index.js` file:

* Walk through each line of code and describe what it's doing.
* How might you split the code in your routes into smaller functions?
* How might you split it into separate files?

## Models and Controllers

Let's do some refactoring. Right now, `/index.js` is hard to read and its methods are doing too much.

Think of the last Rails app you've built. You probably spent a very small amount of time making structural and design decisions (think routes, controllers, models). Just because the framework we're currently using doesn't prepackage our structure, doesn't mean we shouldn't implement something that's still quite helpful. Therefore, we'll be aiming to add some lightweight MVC structure to our Express apps.

## Models

### Discuss: Where Can We Refactor?

Take 3 minutes to answer the following questions with a partner assuming you were going to create a new file to act as a Paper Model in your application:

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

## Controllers

Our `index.js` is still a little bulky. Something I've noticed is that each block of code in this file is mostly comprised of a function to handle the request.

Could we create a controller to handle this functionality?

Take 3 minutes and discuss with a partner:

* What code from our `index.js` looks like it might belong in a controller?
* How could you extract that code in to a function or functions?
* If you had to extract this code to another file, what questions would you have?

### Your Turn

Given that the second parameter of your `.get()` and `.post()` methods are just functions, try to extract them to a module in `lib/controllers`.

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
# lib/routes/api/v1/papers.js

const express = require('express');
const router  = express.Router();
const papersController = require('../../../controllers/papers_controller')

router.get('/', papersController.index);

module.exports = router
```

And update `index.js` by taking out the papersController and the get route for papers. Replace with the following:

```
# index.js
const papers = require('./lib/routes/api/v1/papers')

app.use('/api/v1/papers', papers)
```

### Check Your Refactor

Start our application by spinning up our server `node index.js` & visit `localhost:3000/api/v1/papers` in Postman.
You should see all the papers in you database.

### Your Turn

Refactor to pull the remaining routes into the necessary files following the same pattern as above.
Check to see if your routes are still working after you refactor by using Postman.

## Going Further

### `static` Class Methods

Ideally in OOP, our controllers and models would be class-based. Explore [`static`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/static) methods to see how we can easily emulate Ruby's class methods.

### Sessions

Express doesn't come packaged with simple session tooling, but [cookie-session](https://github.com/expressjs/cookie-session) makes things just as easy. Check out their docs for getting quickly set up.
