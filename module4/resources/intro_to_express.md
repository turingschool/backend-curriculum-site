---
layout: page
title: Building & Testing Express Applications
---

## Goals

By the end of this lesson, you will:

* Understand when and why to use Express.js in the back-end of an application
* Know how Express.js abstracts difficult server-side logic and makes it easier to write endpoints
* Create a simple Express app that serves static pages

An example repository of the completed example can be found [here](https://github.com/turingschool-examples/secret-box-revisited).

## Slides

Available [here](../slides/intro_to_express)

## Warmup

Using the internet:

* What is Node.js?
* What is Express?

## What is Node?

Node is an open-source, cross platform, runtime environment that allows developers to create all kinds of server side tools and applications in JavaScript. It is intended for use outside of a browser context so the environment omits browser-specific JavaScript APIs and adds support for more traditional OS APIs including HTTP and file system libraries.

## What is Express?

Express is a lightweight, unopinionated web framework built on top of the server functionality provided by Node.js. It helps to simplify and organize the server-side functionality of your application by providing abstractions over the more confusing parts of Node.js, and adding helpful utilities and features. It provides mechanisms to:
* Write handlers for requests with different HTTP verbs at different URL paths (routes).
* Integrate with "view" rendering engines in order to generate responses by inserting data into templates.
* Set common web application settings like the port to use for connecting, and the location of templates that are used for rendering the response.
* Add additional request processing "middleware" at any point within the request handling pipeline.

## Why do we use Express?

Think about how and why we use jQuery on the front-end. Vanilla JavaScript can be verbose and difficult to read. jQuery came along to give developers a nicer-looking syntax to perform the same operations. It was a library built to abstract the trickier parts of JavaScript and make them easier to write and work with. Express was built for very similar reasons.

Just like browser-based JavaScript, the syntax for using plain Node.js isn't the friendliest. Node gives you enough low-level features to build the back-end of an application, but Express is a light layer built on top of Node to make these low-level features a little easier to read and write.

## Advantages of Express

While Node.js provides us with all of the functionality we need for our back-ends, writing this logic without Express is more difficult to make sense of and maintain. The two biggest advantages of Express are:

1. the collection of helpful utilities and conveniences that abstract away the Node.js complexity. (e.g. sending a single image file in raw Node.js is quite complex, but can be done in just one line with express)
2. the ability to refactor request handlers into smaller pieces that are more modular and maintainable. (Node.js, by default, requires you to create one large request handler, which makes your logic more rigid and difficult to refactor)

## Request Flow

When we are just using Node.js, the flow of a single request might look like this:

![node only](https://raw.githubusercontent.com/turingschool/front-end-curriculum/gh-pages/assets/images/lessons/express/node-only-flow.png)

When we add Express, there a couple of additional steps added to the flow of a request:

![express flow](https://raw.githubusercontent.com/turingschool/front-end-curriculum/gh-pages/assets/images/lessons/express/express-flow.png)

While the Express flow might look more complex, it actually makes the developer's job a lot easier. In this flow, the developer is only responsible for the 'Middleware' part of the process. This replaces the single request handler function that you would write without Express. Writing middleware for Express is a lot easier to write and more maintainable because of the 'Express' step that abstracts the complex logic for us.

[node-only-flow]: https://github.com/turingschool/front-end-curriculum/blob/gh-pages/assets/images/lessons/express/node-only-flow.png
[express-flow]: https://github.com/turingschool/front-end-curriculum/blob/gh-pages/assets/images/lessons/express/express-flow.png

## Routing & Middleware

Earlier we mentioned that with plain Node.js, you would create a single function to handle requests. This single function can get large and unwieldy as your application grows in complexity. Express provides routing methods(`.get`, `.post`, etc.) that allow you to break this single function into many smaller functions that only handle one thing at a time.

Express is a routing and middleware web framework that has minimal functionality of its own: An Express application is essentially a series of middleware function calls. Our code will be concerned with responding to client requests to different URLs with different methods (GET, POST, etc).

Let's pick apart the structure of how we define an Express route:

```javascript
app.get('/', function(request, response) {
  response.send('Hello World!')
})
```

In the above example, our express app (denoted by `app`), is handling a `GET` request to `'/'`. The second parameter in this call is our callback that defines how we're actually going to handle what happens when a user makes a `GET` request to `'/'`. The callback takes two parameters: the request (`request`) and the response (`response`). In this example, our hander is simply sending back a response (`response.send`) with the text 'Hello World!'.

This pattern is exactly how we can define and handle any routes in an Express application. There are four main pieces to this code:

* `app` - the instance of our Express application
* a METHOD - the method specified when the request is made from the client. (e.g. `GET`, `POST`, `PUT`, `DELETE`)
* a PATH - the endpoint that we are requesting
* a HANDLER - the function we write that contains the logic for how the request should be dealt with, and what kind of response it should return

## Express Generator

While it's possible to build an Express app from scratch, we're going to use the generator that Express provides to createe our application. We're going to install it globally so that we can use it from the command line.

```
$ npm install express-generator -g
```

Using the generator itself, check to see options that you can use when generating a new application:

```
$ express -h
```

Discuss with a partner and share.

## Create and Explore: New Express App

Create a new application from the command line using the generator that we installed:

```
$ express --view ejs --css sass --git secret-box
```

The generator will prompt you to run two additional commands:

```
$ cd project-name && npm install
$ DEBUG=express-practice:* npm start
```

Run each of those commands and visit `localhost:3000` to see that you've properly generated a new site. You should see a site with the message `Welcome to Express`.

If you don’t have nodemon installed globally, now might be a useful time to do that. Nodemon will auto-restart your server for you any time you make changes to your server file. When starting an app with node, you would have to manually shut your server down and spin it up again to see your most recent changes reflected.

```
$ npm install nodemon -g
$ nodemon bin/www
```

With a partner, review the files that Express generates. Answer the following questions:

* What does it seem like each file does?
* Can you create a new route?
* Can you create a new template and serve that from your new route?

Share out. `app.js` in particular includes a ton of information:

* `require` statements at the top bringing in dependencies including `express` itself.
* `require` statements for different routes files that the express generator created.
* Configurations set by the generator using `app.set`.
* Middleware that provides the app some additional functionality set using `app.use`.
* Middleware that tells the application what to use for routing to `/` and to `/users`
* Middleware that tells the app how to handle a 404.
* Middleware that tells the app how to handle 500 level errors.
* A final statement that exports the app itself, which gets required by `bin/www`, which is the entry point for the app (see `package.json`).

In order to create new routes:

* Create a new file within the `routes` directory.
* Within that file:
    * `var express = require('express');`
    * `var router  = express.Router();`
* Require the newly created file in your `app.js` file.
* Tell your app to use that newly created file to respond to requests to a particular URL
* Note: you can further specify endpoints in your routes file, e.g.
    * Assume you tell `app.js` to use a particular routes file to respond to requests to `/muffins`.
    * In your muffins router, you can then handle requests to `/`, `/:id`, `/new`, `/:id/edit`, etc.
* Create a view for any new route that you've created that requires one.

## Conclusion

You've built your first Express app!!!

There are other frameworks and tools built on top of Express that make it easier to build complicated applications. If this is something you're interested in, check out [Endpoints](http://endpointsjs.com/).

If you'd like another tutorial walk through of using Express, check out the [Express Train](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module4/lessons/express_tutorial.md)
