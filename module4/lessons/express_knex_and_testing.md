# Building & Testing an Express App

### Goals

By the end of this lesson, you will:

* Understand when and why to use Express.js (Express) in the back-end of an application
* Know how Express abstracts difficult server-side logic and makes it easier to write endpoints
* Build and test a simple Express app that implements all of the basic CRUD methods

## What is Express?
Express is a small framework built on top of the web server functionality provided by Node.js. It helps to simplify and organize the server-side functionality of your application by providing abstractions over the more confusing parts of Node.js, and adding helpful utilities and features.

## Why do we use Express?
Think about how and why we use jQuery on the front-end. Vanilla JavaScript can be verbose and difficult to read. jQuery came along to give developers a nicer-looking syntax to perform the same operations. It was a library built to abstract the trickier parts of JavaScript and make them easier to write and work with. Express was built for very similar reasons.

Just like browser-based JavaScript, the syntax for using the plain [Node `http` library](https://nodejs.org/api/http.html) isn't the friendliest. Node gives you enough low-level features to build the back-end of an application, but Express is a light layer built on top of Node to make these low-level features a little easier to read and write.

## Advantages of Express
While Node's `http` library provides us with all of the functionality we need for our back-ends, writing this logic without Express is more difficult to make sense of and maintain. The two biggest advantages of Express are:

1. The collection of helpful utilities and conveniences that abstract away the Node.js complexity. (e.g. sending a single image file in a response with only raw Node `http` is quite complex, but can be done in just one line with Express)
2. The ability to refactor route handlers into smaller pieces that are more modular and maintainable. (Node `http`, by default, requires you to create one large route handler, which makes your logic more rigid and difficult to refactor)

## Request Flow
When we are just using Node.js, the flow of a single request might look like this:

![node only][http://frontend.turing.io/assets/images/lessons/express/node-only-flow.png]

When we add Express, there are a couple of additional steps added to the flow of a request:

![express flow][http://frontend.turing.io/assets/images/lessons/express/express-flow.png]

While the Express flow might look more complex, it actually makes the developer's job a lot easier. In this flow, the developer is only responsible for the "Middleware" part of the process. This replaces the single route handler function that you would write with only Node `http`. Writing middleware for Express is a lot easier to write and more maintainable because of the "Express" step that abstracts the complex logic for us.

## Routing & Middleware
Earlier we mentioned that with plain Node `http`, you would create a single function to handle requests. This single function can get large and unwieldy as your application grows in complexity. Express middleware allows you to break this single function into many smaller functions that only handle one thing at a time.

Most of the Express code that you write will be routing middleware. Middleware is basically the "glue" between two systems that helps them work together (in our case, Node and Express). Our code will be concerned with responding to client requests to different URLs with different methods (GET, POST, etc).

Let's pick apart the structure of how we define an Express route:

```javascript
app.get('/', function (request, response) {
  response.send('Hello World!');
});
```

In the above example, our express app (denoted by `app`), is handling a `GET` request to `'/'`. The second parameter in this call is our callback that defines how we're actually going to handle what happens when a user makes a `GET` request to `'/'`. The callback takes two parameters: the request (`req`) and the response (`res`). In this example, our handler is simply sending back a response (`res.send`) with the text 'Hello World!'.

This pattern is exactly how we can define and handle any routes in an Express application. There are four main pieces to this code:

* `app` - the instance of our Express application
* a METHOD - the method specified when the request is made from the client. (e.g. `GET`, `POST`, `PUT`, `DELETE`)
* a PATH - the endpoint that we are requesting
* a HANDLER - the function we write that contains the logic for how the request should be dealt with, and what kind of response it should return

## Getting Started with Express

Let's explore Express at it's most basic level - using `app.locals` for data, before we connect to a database. Read through the server.js in [this repo](https://github.com/turingschool/chatbox)file and answer the following:
- What packages are we bringing in and what are they doing for us?
- How are we grabbing info from the request?
- How do we send HTTP statuses?
- What else do you oberve? Find interesting? What questions do you have?




//background on knex
//build publications

//testing libs/frameworks
//test publications
