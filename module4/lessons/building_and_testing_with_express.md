## Building and Testing Express Applications

### Goals

By the end of this lesson, you will:

* Understand when and why to use Express.js in the back-end of an application
* Know how Express.js abstracts difficult server-side logic and makes it easier to write endpoints
* Create a simple Express app that implements all of the basic CRUD methods

An example repository of the completed example can be found [here](https://github.com/turingschool-examples/secret-box).

## What is Express?
Express is a small framework built on top of the web server functionality provided by Node.js. It helps to simplify organize the server-side functionality of your application by providing abstractions over the more confusing parts of Node.js, and adding helpful utilities and features.

## Why do we use Express?
Think about how and why we use jQuery on the front-end. Vanilla JavaScript can be verbose and difficult to read. jQuery came along to give developers a nicer-looking syntax to perform the same operations. It was a library built to abstract the trickier parts of JavaScript and make them easier to write and work with. Express was built for very similar reasons.

Just like browser-based JavaScript, the syntax for using plain Node.js isn't the friendliest. Node gives you enough low-level features to build the back-end of an application, but Express is a light layer built on top of Node to make these low-level features a little easier to read and write.

## Advantages of Express
While Node.js provides us with all of the functionality we need for our back-ends, writing this logic without Express is more difficult to make sense of and maintain. The two biggest advantages of Express are:

1. the collection of helpful utilities and conveniences that abstract away the Node.js complexity. (e.g. sending a single image file in raw Node.js is quite complex, but can be done in just one line with express)
2. the ability to refactor request handlers into smaller pieces that are more modular and maintainable. (Node.js, by default, requires you to create one large request handler, which makes your logic more rigid and difficult to refactor)

## Request Flow
When we are just using Node.js, the flow of a single request might look like this:

![node only][node-only-flow]

When we add Express, there a couple of additional steps added to the flow of a request:

![express flow][express-flow]

While the Express flow might look more complex, it actually makes the developer's job a lot easier. In this flow, the developer is only responsible for the 'Middleware' part of the process. This replaces the single request handler function that you would write without Express. Writing middlware for Express is a lot easier to write and more maintainable because of the 'Express' step that abstracts the complex logic for us.

[node-only-flow]: /assets/images/lessons/express/node-only-flow.png
[express-flow]: /assets/images/lessons/express/express-flow.png

## Routing & Middleware
Earlier we mentioned that with plain Node.js, you would create a single function to handle requests. This single function can get large and unwieldy as your application grows in complexity. Express middlware allows you to break this single function into many smaller functions that only handle one thing at a time.

Most of the Express code that you write will be routing middleware. Middleware is basically the "glue" between two systems that helps them work together (in our case, Node and Express). Our code will be concerned with responding to client requests to different URLs with different methods (GET, POST, etc).

Let's pick apart the structure of how we define an Express route:

```javascript
app.get('/', function (request, response) {
  response.send('Hello World!')
})
```

In the above example, our express app (denoted by `app`), is handling a `GET` request to `'/'`. The second parameter in this call is our callback that defines how we're actually going to handle what happens when a user makes a `GET` request to `'/'`. The callback takes two parameters: the request (`req`) and the response (`res`). In this example, our hander is simply sending back a response (`res.send`) with the text 'Hello World!'.

This pattern is exactly how we can define and handle any routes in an Express application. There are four main pieces to this code:

* `app` - the instance of our Express application
* a METHOD - the method specified when the request is made from the client. (e.g. `GET`, `POST`, `PUT`, `DELETE`)
* a PATH - the endpoint that we are requesting
* a HANDLER - the function we write that contains the logic for how the request should be dealt with, and what kind of response it should return

## Getting Started with Express

Let's go ahead and install some dependencies that we'll need to get things rolling.

```
mkdir secret-box
npm init --yes
npm i express --save
```

We'll get a basic server running using some code I stole from [the Express documentation](http://expressjs.com/starter/hello-world.html) and modified slightly to fit my tastes.

```js
const express = require('express')
const app = express()

app.set('port', process.env.PORT || 3000)
app.locals.title = 'Secret Box'

app.get('/', (request, response) => {
  response.send('It\'s a secret to everyone.')
})

app.listen(app.get('port'), () => {
  console.log(`${app.locals.title} is running on ${app.get('port')}.`)
})
```

Fire up the server using `node server.js` and visit `http://localhost:3000/` to enjoy in the fruits of your copy and pasting labor.

### Making a Dynamic Route

When we go to view a tweet or a user, we do something special with the URL to identify which tweet or user. We specify it in the URL itself. URLs—after all—stand for universal resource locator.

Consider the following:

```js
app.get('/api/secrets/:id', (request, response) => {
  response.json({
    id: request.params.id
  })
})
```

Take that for a spin with a bunch of different words where `:id` should go.

Some things to notice:

- `response.json` is just a short hand for setting the response type as `application/json`.
- It automatically serializes our object as JSON.

### Storing Secrets

In addition, let's add some data structure for keeping track of some kind of arbitrary data.

```js
app.locals.secrets = {}
```

Let's put some fake data in for now.

```js
app.locals.secrets = {
  wowowow: 'I am a banana'
}
```

Here is the feature we want to implement: when a user has the correct secret, we want to show them message associated with that `id`.

```js
app.get('/api/secrets/:id', (request, response) => {
  const { id } = request.params
  const message = app.locals.secrets[id]
  response.json({ id, message })
})
```

Let's go ahead and take this for a spin. It kind of works. If they give us the right `id`, they'll get the message. But they don't get an error if they give us an invalid `id`. It would be preferable to send them a 404 status code, which let's the browser now that the resource was not found.

```js
app.get('/api/secrets/:id', (request, response) => {
  const { id } = request.params
  const message = app.locals.secrets[id]

  if (!message) { return response.sendStatus(404)  }

  response.json({ id, message })
})
```

### Sending Data With Our Post Request

It would be cool if we could store secrets in addition to just being able to retreive the prepopulated ones.

Express did this thing a while back, where they took a bunch of stuff out of the core framework. This makes it smaller and means you don't have cruft you're not using, but it also means that sometimes you have to mix those things back in. One of those components that was pulled out was the ability to parse the body of an HTTP request. That's okay, we can just mix it back in.

```
npm i body-parser --save
```

We'll also need to require and use it in our `server.js`.

```js
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
```

This will add in support for parsing JSON as well as HTML forms. If you only need one of those, you can go ahead and remove the other. (We're only going to use JSON, but I am leaving it here for reference.)

Here is what my server looks like so far.

```js
const express = require('express')
const app = express()
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

app.set('port', process.env.PORT || 3000)
app.locals.title = 'Secret Box'
app.locals.secrets = {
  wowowow: 'I am a banana'
}

app.get('/', (request, response) => {
  response.send('Hello World!')
})

app.get('/api/secrets', (request, response) => {
  const secrets = app.locals.secrets

  response.json({ secrets })
})


app.get('/api/secrets/:id', (request, response) => {
  const { id } = request.params
  const message = app.locals.secrets[id]

  if (!message) { return response.sendStatus(404)  }

  response.json({ id, message })
})

app.listen(app.get('port'), () => {
  console.log(`${app.locals.title} is running on ${app.get('port')}.`)
})
```

### Creating a POST Route

We'll use our super secure method of generating random IDs.

```js
app.post('/api/secrets', (request, response) => {
  const id = Date.now()
  const { message } = request.body

  app.locals.secrets[id] = message

  response.json({ id, message })
})
```

This approach has a bunch of flaws:

- We're storing data in memory, which will be wiped out when the server goes down.
- Using the current time is a terrible idea for a number of reasons. Most obviously, it's super easy to guess IDs and steal secrets.

#### The Unhappy Path

What happens if the user doesn't give us a message parameter?

We should tell them that we got some bad data.

In our previous example, we simply stored a new message object that we received from the client-side and sent it back as a successful response. When we successfully create a new record in a collection of application data, we can signal this success to our end-user by setting an [HTTP Status Code](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html). There are many different status codes to use in various situations. Upon a successful 'creation' you'll want to set the status code to `201` before sending back the response object.

Take a minute to look through some of the other available status codes that can be used. These are a quick way to determine what happened to our request when it was sent to the server, and are easily viewed in the 'Network' panel of your browser developer tools.

Status codes are especially important when handling errors for a request. Let's add some error handling to our previous example. We are going to assume that 'message' is a required property when submitting a new message, and we want to respond with an error if it's missing:

```js
app.post('/api/secrets', (request, response) => {
  const { message } = request.body
  const id = Date.now()

  if (!message) {
    return response.status(422).send({
      error: 'No message property provided'
    })
  }

  app.locals.secrets[id] = message

  response.json({ id, message })
})
```

If either property is missing, we will see an error in the Network tab of our developer tools where the response is highlighted in red and has a status of `422` (client error). The response details will tell us exactly which property we are missing based on the error message we sent along with the 422 response.

It's important to handle errors and write descriptive error messages so that others can more easily debug their code and quickly fix whatever problem they are running into. Setting appropriate status codes and being as specific as possible with the response message is the best way to write a user-friendly API.


It would also be nice if we used the correct status code on the successful response.

```js
response.status(201).json({ id, message })
```

### Generating Unique Keys

At this moment, we're using a key-value store that we whipped up to hold our data. That said, we're going to need some unique keys. We could use something like the current date, but there is a tiny, tiny chance that we could get two requests at the exact same millisecond. I'm personally not willing to risk it.

For the time being, we'll use an MD5 hash, which is a unique value based on the content of the message. You've seen them in Github gists among other places.

```
npm i md5 --save
```

Now, in our `server.js`, we can require the module.

```js
const md5 = require('md5')
```

Finally, let's replace `Date.now()` in our `POST` action.

```js
app.post('/api/secrets', (request, response) => {
  const { message } = request.body
  const id = md5(message)

  if (!message) {
    return response.status(422).send({
      error: 'No message property provided'
    })
  }

  app.locals.secrets[id] = message

  response.status(201).json({ id, message })
})
```

### Additional Resources

# Building and Unit Testing an Express Application

[Here](https://github.com/turingschool-examples/express-train) is a finished example of this app (with the additional section at the bottom). You do not need to clone this to get started but it does provide a good reference if you want to check it out.

## Getting Started

In this tutorial, we're going to build and test an Express application from the ground up—using what you would primarily think of in Rails as controller tests. The goal of the this tutorial is to get super deep into a very small set of things so that you understand how they work.

We're going to keep the use of external tools and libraries to a minimum. As a result, it may get a bit tedious at times, but at the end, you'll have an understanding of how the train gets rolling, so to speak.

## Prerequisites

The only prerequisite is a modern version of [Node.js](https://nodejs.org/en/). I used Node 5.0.0 stable when writing this tutorial. If the code is not working for you, make sure you're using _at least_ that version.

## Getting Started

First things, first: we need to make a directory, right?

```
mkdir express-train
cd express-train
```

Let's get our `package.json` off to a good start as well. What's a `package.json` file you ask? 

A `package.json` file contains meta data about your app or module. Most importantly, it includes the list of dependencies to install from npm when running `npm install` . It's similar to a Gemfile in the Ruby world.

From our command line, let's run:

```
npm init
```

Let's go through the questions together.

```
name: (express-train)
version: (1.0.0)
description: A place for train info
entry point: (index.js) server.js
test command: mocha
git repository: https://github.com/turingschool-examples/express-train
keywords: express, mocha
author: Casey Cumbow
license: (ISC) MIT
```

Let's also go ahead and install some dependencies that we'll need to get things rolling.

```
npm i express --save
npm i mocha --save-dev
```

In our `package.json`, we set the entry point to `server.js` so we'll need to create that file.

```
touch server.js
```

We'll get a basic server running using some code I stole from [the Express documentation](http://expressjs.com/starter/hello-world.html) and modified slightly to fit my tastes.

```js
const express = require('express');
const app = express();

app.set('port', process.env.PORT || 3000);
app.locals.title = 'Express Train';

app.get('/', (request, response) => {
  response.send('Hello World! TOOT! TOOT!');
});

app.listen(app.get('port'), () => {
  console.log(`${app.locals.title} is running on ${app.get('port')}.`);
});
```

Fire up the server using `node server.js` and visit `http://localhost:3000/` to enjoy in the fruits of your copy and pasting labor.

## Unit Testing Our Server

Alright, we have a server and we can test it by visiting the page manually. But, testing by hand gets old pretty fast. It would be nice if we could have some kind of automated testing, right? Yea, I agree. We are going to need to make some modifications to your existing little application, though.

As it stands, whenever `server.js` is run, it fires up the web server. Generally speaking, this is what we want if we're just running `node server.js`. But it's not necessarily what we want if we're trying to grab it from our tests to poke at it.

In that scenario, we _do not_ want it to just start up all on it's own.

What we need to do is to add some introspection and see if our application is being run directly or being required from another file. We can do this by modifying our server slightly.

```js
if (!module.parent) {
  app.listen(app.get('port'), () => {
    console.log(`${app.locals.title} is running on ${app.get('port')}.`);
  });
}
```

> **A Quick Note for Rubyists**: You may have seen something similar in Ruby using `if __FILE__ == $0`. Ruby is comparing the current file location to the name of the file being run. If they are the same, then its the file being run, if it's different, then the current file is being required by another file.

If `server.js` is being run directly, then it has no parent and we should fire up the server. But, if it's being required, then the file requiring `server.js` is its parent and we should not spin up the server automatically.

The other thing we need to do is to export the application.

```js
module.exports = app;
```

### Spinning Up Our Test Server

Enough about modules and their parents. Let's get our tests set up.

```
mkdir test
touch test/server-test.js
```

Let's run `mocha` now to make sure everything is gravy.

```
npm test
```

You're free to use Chai or any assertion library that suits your fancy, but I'm going to use Node's built-in assertion library. I'll go ahead and require that along with our application.

```js
// test/server-test.js
const assert = require('assert');
const app = require('../server');
```

Just to keep our spirits up, let's start with the simplest possible test.

```js
const assert = require('assert');
const app = require('../server');

describe('Server', () => {

  it('should exist', () => {
    assert(app);
  });

});
```

Now, we'll want to start our server up before we run our tests. I don't want to worry about my testing version trying to use the same port as my development server. So, I'll pick another port that makes me happy. (You might also consider reading a port from a environment variable or passing one in as a command line argument. I decided not to in the name of not adding too much complexity to this tutorial.)

```js
before(done => {
  this.port = 9876;
  this.server = app.listen(this.port, (err, result) => {
    if (err) { return done(err); }
    done();
  });
});

after(() => {
  this.server.close();
});
```

Okay, so what's going on here? Well, before we run our server tests, we're going to tell the server to listen on port 9876. For asynchronous test maneuvers, we can use `done()` to let Mocha know when we're ready to move on.

In Node, it's common for callback functions to take an error object as their first parameter if anything went wrong so that you can deal with it. So, if there is an error, then we'll end with that error. Otherwise, we'll move on.

`app.listen` returns an instance of `http.Server` that we'll store in `this.server` so that we can close it in the `after` hook.

Let's go ahead and run our tests using `npm test` to make sure nothing has broken.

### Making Requests To Our Server

Now that we have our server running in our tests. We can make requests to it. We could totally do this using the built-in `http` module but that's pretty low-level. Let's use a library called [Request](https://github.com/request/request) instead.

```
npm i request --save-dev
```

> **Quick Note for Rubyists**: If you're familiar with Ruby, Request is a lot like Hurley or Faraday.

We're saving it to our development dependencies but you could also use Request to make requests against external APIs. In that case it would go into our regular dependencies—using `--save` instead of `--save-dev`.

In `test/server-test.js`, we'll require Request.

```js
const request = require('request');
```

Alright, we've set everything up. Now, we can write our first test. Our app is pretty simple. So, let's start by making sure that we have a `/` endpoint and that it returns a 200 response.

Nested in our `describe('Server')` section, we'll add a `describe('GET /')` section as well. Our test suite will look something like this:

```js
const assert = require('assert');
const request = require('request');
const app = require('../server');

describe('Server', () => {

  before((done) => {
    this.port = 9876;
    this.server = app.listen(this.port, (err, result) => {
      if (err) { return done(err); }
      done();
    });
  });

  after(() => {
    this.server.close();
  });

  it('should exist', () => {
    assert(app);
  });

  describe('GET /', () => {
    // Our tests will go here.
  });

});
```

Now, we'll write a test that will send a request to the `/` endpoint on our server and verify that we did in fact receive a 200.

```js
it('should return a 200', (done) => {
  request.get('http://localhost:9876', (error, response) => {
    assert.equal(response.statusCode, 200);
    done();
  });
});
```

Again, it's a Node convention to pass any errors as the first argument—and Request is going to go ahead and follow that convention. We can improve the quality of the error messages we get from our test suite if we catch that error.

```js
it('should return a 200', (done) => {
  request.get('http://localhost:9876', (error, response) => {
    if (error) { done(error); }
    assert.equal(response.statusCode, 200);
    done();
  });
});
```

#### Quick Experiment

Change the port in the `before` hook to another number. Run the test suite and watch it fail. Now, comment out the error handling we just added and watch it fail. Pay attention to the differences between the two error messages. With the error handling, we get back an error describing what happened when we sent a `GET` request to the server. Without it, we get an error about reading a property off `undefined`. The latter is kind of okay in this exact case, but hopefully you can use your imagination to figure out how it could be less helpful in other contexts.

### Request Defaults

Another problem with this test is that we hard-coded in the port and the server. First off, this is tedious. Secondly, if we did want to read the port from an environment variable or something like that, this wouldn't work. But most importantly: this is tedious.

Request allows us to set defaults. `request.defaults()` will return a wrapped version of Request with some of the parameters already applied. (Take a moment and note [closures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures) and [currying](http://www.sitepoint.com/currying-in-functional-javascript/) in JavaScript.)

In this suite, we're always going to be hitting our test server. So, let's set those as defaults in the `before` hook.

```js
before((done) => {
  this.port = 9876;

  this.server = app.listen(this.port, (err, result) => {
    if (err) { return done(err); }
    done();
  });

  this.request = request.defaults({
    baseUrl: 'http://localhost:9876/'
  });
});
```

We're storing our special, wrapped version of Request in a shared property called `this.request`. Now, we can update our test to use our wrapped version.

```js
it('should return a 200', (done) => {
  this.request.get('/', (error, response) => {
    if (error) { done(error); }
    assert.equal(response.statusCode, 200);
    done();
  });
});
```

Awesome. Now, let's write a test verifying the content of the page located at `/`. You may or may not have noticed that we stored a few things as properties on our application instead of local variables in `server.js`.

```js
app.set('port', process.env.PORT || 3000);
app.locals.title = 'Express Train';
```

If we stored them as local variables, then they would have been trapped in that modules closure. But, as properties on the application, we can access them other places—like our tests and our views.

We used `app.set()` to set the port. Conversely, we can use `app.get()` to fetch the properties. `app.locals` and `app.get()` have a lot in common, the former is primarily for things we want to share in our templates and/or tests and the latter is for configuration details.

Right now, our `/` endpoint just says "Hello World!". That's neat. Let's use a little old fashioned TDD to change that to display the name of our application.

Our test will look something like this:

```js
it('should have a body with the name of the application', (done) => {
  var title = app.locals.title;

  this.request.get('/', (error, response) => {
    if (error) { done(error); }
    assert(response.body.includes(title),
           `"${response.body}" does not include "${title}".`);
    done();
  });
});
```

As in other test runners—like Minitest in Ruby — `assert` takes a second argument that allows you to provide a custom error message. If you don't like the error message, you have no one but yourself to blame.

If we run the test, we'll see that it fails. Our error message should look something like the following.

```
1) Server / should have a body with the name of the application:

    Uncaught AssertionError: "Hello World!" does not include "Express Train".
    + expected - actual

    -false
    +true
```

So, let's go ahead and make this test pass. We'll modify `server.js` to respond with the name of the application instead of "Hello World!".

```js
app.get('/', (request, response) => {
  response.send(app.locals.title);
});
```

Run your tests and verify that they pass.

**Note - we could serve static files OR render views as a response to our request. For now, we're going to move on though to keep making progress. You can follow along with these sections at the end of this lesson.**

## Unit Testing a Post Request

So far, we've covered how to unit test a `GET` request, but, what about sending information to our application?

First, we'll need somewhere to put this information when it's received. In a production application, you'd likely use some kind of data storage. In an attempt to stay on topic. We'll sidestep that for now and just store everything in memory.

This means that if our server crashes for any reason, we'll lose everything. Honestly, we don't have anything of value at this point - so no big deal.

In `server.js`, we'll set up a plain-old JavaScript object that will play the proud role of a key-value store.

```js
app.locals.trains = {};
```

That's it. We could just as easily set it as a local variable or constant and export it as part of `module.exports`. But, we'll set it as a property on our application for now so that we can access it in our tests easily without having to modify a bunch of our server's code.

Okay, so it's time to write some tests. This raises the question: what do we want to happen?

For starters, if we post some data to an endpoint, we're kind of expecting that it will end up in our little data object, right?

Within our server tests, let's start talking about this new endpoint.

```js
describe('POST /trains', () => {

  it('should receive and store data', (done) => {
    // Our implementation will go here…
    assert(true);
    done();
  });

});
```

Let's do a little bit of dream-driven development to figure out what we would _like_ to happen.

1. It has a route called `/trains`;
1. We send a `POST` request with some data.
1. The server takes the data from that request and adds it to our data store.
1. We can see that it's in the data store.

Let's start at the top of the list. If a route doesn't exist a web server worth its salt ought to send back a 404 status code. So, ideally, this route does exist and we're getting something that's not a 404, right? Add the following to `test/server-test.js`:

```js
it('should not return 404', (done) => {
  this.request.post('/trains', (error, response) => {
    if (error) { done(error); }
    assert.notEqual(response.statusCode, 404);
    done();
  });
});
```

 Run the suite, watch it burn. We need to add this route in `server.js` in order to pass this test.

 ```js
 app.post('/trains', (request, response) => {
   response.sendStatus(201);
 });
 ```

`response.sendStatus(201)` sends an empty response body with a 201 status code. This is enough to get our test passing. Okay, one down, three to go.

### Sending Data With Our Post Request

Express did this thing a while back, where they took a bunch of stuff out of the core framework. This makes it smaller and means you don't have cruft you're not using, but it also means that sometimes you have to mix those things back in. One of those components that was pulled out was the ability to parse the body of an HTTP request. That's okay, we can just mix it back in.

```
npm i body-parser --save
```

We'll also need to require and use it in our `server.js`.

```js
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
```

This will add in support for parsing JSON as well as HTML forms. If you only need one of those, you can go ahead and remove the other.

#### Cleaning the Slate Between Tests

One of the reasons that tests fail is because they're not working with a clean slate. We are going to be counting the objects in the data store and make sure that we have what we ought to have at any given moment.

What we don't need is other tests messing with our tenuous grip on reality.

So, in our `POST /trains` block, let's reset the datastore before each test.

```js
describe('POST /trains', () => {

  beforeEach(() => {
    app.locals.trains = {};
  });

  // Our tests live down here…

});
```

#### Writing Our Test

So, let's take a first pass at testing to see if new data is added to the data store when it is received.

```js
it('should receive and store data', (done) => {
  var validTrain = {
    train: {
      name: 'Z line',
      times: [ '1:00', '2:00', '3:00', '4:00' ]
    }
  };

  this.request.post('/trains', { form: validTrain }, (error, response) => {
    if (error) { done(error); }

    var trainCount = Object.keys(app.locals.trains).length;

    assert.equal(trainCount, 1, `Expected 1 trains, found ${trainCount}`);

    done();
  });
});
```

We're doing the following:

1. Creating some data to send and storing it in a local variable.
1. Sending a `POST` request with that data passing in an object with a `form` key as the second argument. (This is how Request knows you're emulating a form.)
1. Getting the length of an array of all the keys in `app.get('train')`.
1. Checking to see if it's what we expect after sending a single request. We're providing an error message because we appreciate helpful error messages and we're willing to do our part for the cause.

If we run the tests, we'll see:

```
1) Server POST /trains should receive and store data:

    Uncaught AssertionError: Expected 1 trains, found 0
    + expected - actual

    -0
    +1
```

We were expecting to find one train in there and we didn't find any. In fairness, we didn't write this functionality, so I guess that's to be expected.

### Generating Unique Keys

At this moment, we're using a key-value store that we whipped up to hold our data. That said, we're going to need some unique keys. We could use something like the current date, but there is a tiny, tiny chance that we could get two requests at the exact same millisecond. I'm personally not willing to risk it.

There are many ways we could create a random hash. We could take the body of our data along with the current time and do an MD5 hash. For now, let's do the simplest possible thing. We'll generate some random bytes with Node's built-in `crypto` module and then hash those.

This seems like something we could break out into a little helper module.

```
mkdir lib
touch lib/generate-id.js
```

In `lib/generate-id.js`, we'll add the following:

```js
const crypto = require('crypto');

module.exports = () => {
  return crypto.randomBytes(10).toString('hex');
};
```

Now, we can require our little helper in `server.js`.

```js
const generateId = require('./lib/generate-id');
```

### Actually Putting a Train in the Data Store

So, now that we can generate unique identifiers. We're finally ready to put something in the database.

Let's update that route in `server.js`.

```js
app.post('/trains', (request, response) => {
  var id = generateId();

  app.locals.trains[id] = request.body;

  response.sendStatus(201);
});
```

Run the tests and you should be green as a bean. If you're not, here is the current code for reference.

In `server.js`:

```js
const express = require('express');
const app = express();

const path = require('path');
const bodyParser = require('body-parser');

const generateId = require('./lib/generate-id');

app.use(express.static('static'));
app.use(bodyParser.urlencoded({ extended: true }));

app.set('view engine', 'jade');

app.set('port', process.env.PORT || 3000);
app.locals.title = 'Express Train';
app.locals.trains = {};

app.get('/', (request, response) => {
  response.render('index');
});

app.post('/trains', (request, response) => {
  var id = generateId();

  app.locals.trains[id] = request.body;

  response.sendStatus(201);
});

if (!module.parent) {
  app.listen(app.get('port'), () => {
    console.log(`${app.locals.title} is running on ${app.get('port')}.`);
  });
}

module.exports = app;
```

In `test/server-test.js`:

```js
const assert = require('assert');
const request = require('request');
const app = require('../server');

describe('Server', () => {

  before((done) => {
    this.port = 9876;

    this.server = app.listen(this.port, (err, result) => {
      if (err) { return done(err); }
      done();
    });

    this.request = request.defaults({
      baseUrl: 'http://localhost:9876/'
    });
  });

  after(() => {
    this.server.close();
  });

  it('should exist', () => {
    assert(app);
  });

  describe('GET /', () => {

    it('should return a 200', (done) => {
      this.request.get('/', (error, response) => {
        if (error) { done(error); }
        assert.equal(response.statusCode, 200);
        done();
      });
    });

    it('should have a body with the name of the application', (done) => {
      var title = app.locals.title;

      this.request.get('/', (error, response) => {
        if (error) { done(error); }
        assert(response.body.includes(title),
               `"${response.body}" does not include "${title}".`);
        done();
      });
    });

  });

  describe('POST /trains', () => {

    beforeEach(() => {
      app.locals.trains = {};
    });

    it('should not return 404', (done) => {
      this.request.post('/trains', (error, response) => {
        if (error) { done(error); }
        assert.notEqual(response.statusCode, 404);
        done();
      });
    });

    it('should receive and store data', (done) => {
      var validTrain = {
        train: {
          name: 'Z line',
          times: [ '1:00', '2:00', '3:00', '4:00' ]
        }
      };

      this.request.post('/trains', { form: validTrain }, (error, response) => {
        if (error) { done(error); }

        var trainCount  = Object.keys(app.locals.trains).length;

        assert.equal(trainCount, 1, `Expected 1 trains, found ${trainCount}`);

        done();
      });
    });

  });

});
```

### Refactoring your tests with fixtures

I don't _love_ how much room `validTrain` is taking up and I suspect it has some friends waiting in the wings. So, I'm going to move it out to a separate file.

```
touch test/fixtures.js
```

I'll export each one individually in `test/fixures.js`. (Granted, I only have one, right now.)

```js
exports.validTrain = {
  name: 'Z line',
  times: [ '1:00', '2:00', '3:00', '4:00' ]
};

```

I'll require `test/fixtures.js` in `test/server-test.js`.

```js
const fixtures = require('./fixtures');
```

And, finally, I'll update my test to reflect my new approach.

```js
it('should receive and store data', (done) => {
  var payload = { train: fixtures.validTrain };

  this.request.post('/trains', { form: payload }, (error, response) => {
    if (error) { done(error); }

    var trainCount = Object.keys(app.locals.trains).length;

    assert.equal(trainCount, 1, `Expected 1 trains, found ${trainCount}`);

    done();
  });
});
```

Don't forget to run your tests again to make sure you haven't messed anything up.

## Dynamic Routes and Individual Trains

We can create trains, but we can't get to them. This is slightly problematic.

Luckily Express supports dynamic parameters in the route. Let's say—totally hypothetically—that we have a route that we defined as `/trains/:id`.

That colon is meaningful. It means that `:id` is a dynamic parameter. Any and all parameters are added to `request.params`. For example, if you visited `/trains/123`, then `request.params.id` would be `123`.

Let's write a test to make sure we're getting a particular train if we visit that route. As usual, we'll start with a `describe` block in `test/server-test.js`.

```js
describe('GET /trains/:id', () => {});
```

Before each test, we'll put something in our little data store.

```js
describe('GET /trains/:id', () => {

  beforeEach(() => {
    app.locals.trains.testTrain = fixtures.validTrain;
  });

});
```

Next, we'll verify that it does not return a 404.

```js
it('should not return 404', (done) => {
  this.request.get('/trains/testTrain', (error, response) => {
    if (error) { done(error); }
    assert.notEqual(response.statusCode, 404);
    done();
  });
});
```

Let's run the tests and watch our new one fail miserably. That route does, in fact, return a 404. Bummer. Well, I guess we'll have to go ahead and implement it I suppose. We'll add the route to `server.js`.

```js
app.get('/trains/:id', (request, response) => {
  response.sendStatus(200);
});
```

Alright, cool. But you and I know both know this isn't really what we want. We're not just looking for a quick 200 status code around here. We want to fetch this particular train. But, we're being good developers and waiting until we have a test, right?

Okay, so a mediocre-to-decent way—with the technology we have at the moment—to tell if we have what we're expecting on the page is to see if the title of our lovely train is somewhere in to body. By that logic, we could get the ball rolling with a test like this:

```js
it('should return a page that has the title of the train', (done) => {
  var train = app.locals.trains.testTrain;

  this.request.get('/trains/testTrain', (error, response) => {
    if (error) { done(error); }
    assert(response.body.includes(train.name),
           `"${response.body}" does not include "${train.name}".`);
    done();
  });
});
```

We're making the request, but right now, we're only sending the status code. We're not actually sending any data yet. As a result, we're getting an error message that looks something like this:

```
Uncaught AssertionError: "OK" does not include "undefined".
```

Rather than create a template, let's return the raw data. Let's adjust our route in `server.js` accordingly.

```js
app.get('/trains/:id', (request, response) => {
  var train = app.locals.trains[request.params.id];

  response.send({ train: train });
});
```
We fetch the train from our little data store, then we create an plain JS object by passing in the `train` from our data store name-spaced under `train` so that it doesn't conflict with the application's title and whatnot.


## Testing Redirection

We have a home page. We have a page for an individual train. But, we still leave the user hanging when they create a train. (Nevermind the fact that we haven't given them a form for submitting the train yet of course.)

Let's take a look at our test route for posting a new train.

```js
app.post('/trains', (request, response) => {
  var id = generateId();

  app.locals.trains[id] = request.body.train;

  response.sendStatus(201);
});
```

We just send a 201 and call it a day. It would be better if we redirected the user to their train page. Let's write a test and see how it goes. This test should go in the describe 'POST /trains' block, not the 'GET /trains' block.

```js
it('should redirect the user to their new train', (done) => {
  var payload = { train: fixtures.validTrain };

  this.request.post('/trains', { form: payload }, (error, response) => {
    if (error) { done(error); }
    var newTrainId = Object.keys(app.locals.trains)[0];
    assert.equal(response.headers.location, '/trains/' + newTrainId);
    done();
  });
});
```

What's going on here?

- We make a new train.
- Then we turn our data store into an array of keys.
- We grab the first key. There is only one thing in our data store—so, this is it.
- Then we make sure the location in the response headers is the location of the individual train resource.

Alright cool, so we have a test. Making it pass should be easy, right?

```js
app.post('/trains', (request, response) => {
  var id = generateId();

  app.locals.trains[id] = request.body.train;

  response.redirect('/trains/' + id);
});
```

We simply change `response.sendStatus(201)` to `response.redirect('/trains/' + id)`. Everything should work, right?

Whoops, another test broke. That's because in one of our tests, we actually don't send any data and we don't have any validations in place. Let's catch that error early on. If the user doesn't send us any train, then they're bad and their request is bad. As a result, we'll send them a 400 in an attempt to teach them a lesson.

```js
app.post('/trains', (request, response) => {
  if (!request.body.train) { return response.sendStatus(400); }

  var id = generateId();

  app.locals.trains[id] = request.body.train;

  response.redirect('/trains/' + id);
});
```

## Conclusion

So, we went super deep in testing a few very small pieces of an Express application.

Hopefully, you noticed the following:

- Express applications aren't anything special, you can pass them around and require them just like any other object in JavaScript.
- Doing stuff by hand can be hard. Typically, we're used to having large frameworks like Rails abstract a lot of stuff away from us. It's definitely a trade off and there is no right answer. We worked pretty hard on this application, but we don't really have much in the way of validation or any abstractions around fetching and persisting models.
- Asynchronous code can be hard, but it has some powerful advantages. For example, Mocha is able to run multiple tests simultaneously while we wait for a given request to come back. This means as our application grows, the test suite will likely be faster than a similar sized Ruby code base.

There are frameworks and tools built on top of Express that make it easier to build complicated applications. If this is something you're interested in, check out [Endpoints](http://endpointsjs.com/).

### What Didn't We Cover?

We didn't touch integration testing. Right now, all of our tests that check for content get the HTTP response as a giant string of text and see if a given substring is in there. There is no concept of DOM traversal or querying at this time.

If we wanted that, we'd have to look at something like [Phantom.js](http://phantomjs.org/) or [Nightmare](http://www.nightmarejs.org/).

## Serving Static Assets

You could serve raw HTML files. That will work and it might be the right approach for your projects. But, in the name of education, let's talk about how to use views with your Express application.

Right now, we're sending snippets of text using `response.send()`.

Let's serve some static files. First, we'll create a `static` directory. (This is not special, you could call it anything you want.) We'll also add an `index.html`.

```
mkdir static
touch static/index.html
```

In `static/index.html`, we'll add the following:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Express Train</title>
  </head>
  <body>
    <h1>Express Train</h1>
  </body>
</html>
```

We can send an entire file using `response.sendFile()` and passing in the location of the file we're looking to send. For example, let's say we had an `index.html` inside of the `static` directory.

```js
// (Require express and other libraries…)

const path = require('path');

// (Set up our application properties and whatnot…)

app.get('/', (request, response) => {
  response.sendFile(path.join(__dirname, '/static/index.html'));
});
```

Run your tests. They should be passing.

Having a directory for static assets is incredibly useful because we'll probably want to serve fun stuff like CSS and client-side JavaScript one day.

```js
app.use(express.static('static'));
```

By default, `express.static` serves everything in the `static` directory from the root. While Express will automatically serve index.html as '/' we'll be explicit to get in the habit.

At this moment, your `server.js` should look something like the code sample below and your tests should be passing.

```js
const express = require('express');
const app = express();

const path = require('path');

app.use(express.static('static'));

app.set('port', process.env.PORT || 3000);
app.locals.title = 'Express Train';

app.get('/', (request, response) => {
  response.sendFile(path.join(__dirname, '/static/index.html'));
});

if (!module.parent) {
  app.listen(app.get('port'), () => {
    console.log(`${app.locals.title} is running on ${app.get('port')}.`);
  });
}

module.exports = app;
```

### Rendering views

We did have a small regression when we went from sending some arbitrary text with `response.send()` to sending a full HTML file with `response.sendFile()`. We're no longer dynamically inserting the title of the application in the response. It's hard-coded in that HTML file. Whoops.

There really isn't a way to get around this. Our HTML is a static asset. It's static. We're going to need something more dynamic.

There are a number of view template languages out there for Node.

- [EJS (Embedded JavaScript)](http://www.embeddedjs.com/)
- [Jade](http://jade-lang.com/)
- [Handlebars](http://handlebarsjs.com/)

It's worth stopping for a few moments and exploring the options above. It's ultimately a matter of taste. Go ahead, I'll wait.

For a while, Jade came packaged with Express, so we'll use that. It's also fairly easy to set up. This is a lesson on working with and testing Express, not template languages. Let's install it.

```
npm install jade --save
```

Next, we'll tell Express that this is the template language that we're using.

```js
// (Require express and other libraries…)

// (Set up our application properties and whatnot…)

app.set('view engine', 'jade');
```

By default, Express will look for views in a `views` directory. Let's go ahead and create one as well an initial `index.jade` file.

```
mkdir views
touch views/index.jade
rm static/index.html
```

For now, we'll convert the contents of `static/index.html` to `views/index.jade`. It will look like this:

```jade
doctype html
html(lang="en")
  head
    title "Express Train"
  body
    h1 "Express Train"
```

We'll need to get acquainted with another method on the `response` object — the `response.render()` method.

Modify your route accordingly:

```js
app.get('/', (request, response) => {
  response.render('index');
});
```

Run you're tests and verify that everything passes. It should. But, we're not out of the woods yet. We need to modify `views/index.jade` to use the values we pass in. Let's modify `views/index.jade` to do just that.

```jade
doctype html
html(lang="en")
  head
    title= title
  body
    h1= title
```

We'll run our tests one more time and make sure that everything works as it should.

