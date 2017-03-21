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

[node-only-flow]: https://github.com/turingschool/front-end-curriculum/blob/gh-pages/assets/images/lessons/express/node-only-flow.png
[express-flow]: https://github.com/turingschool/front-end-curriculum/blob/gh-pages/assets/images/lessons/express/express-flow.png

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
npm init
npm i express --save
npm i mocha --save-dev
```

We'll get a basic server running using some code I stole from [the Express documentation](http://expressjs.com/starter/hello-world.html) and modified slightly to fit my tastes.

```js
// server.js
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

We'll go ahead and use Chai as our assertion library - let's not forget to add it via `npm i chai --save-dev`. I'll go ahead and require that along with our application.

```js
// test/server-test.js
const assert = require('chai').assert;
const app = require('../server');
```

Just to keep our spirits up, let's start with the simplest possible test.

```js
const assert = require('chai').assert;
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

Right now, our `/` endpoint just says "It's a secret to everyone". That's neat. Let's use a little old fashioned TDD to change that to display the name of our application.

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

    Uncaught AssertionError: "It's a secret to everyone." does not include "Secret Box".
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
  const id = request.params.id
  const message = app.locals.secrets[id]
  response.json({ id, message })
})
```

Let's go ahead and take this for a spin. It kind of works. If they give us the right `id`, they'll get the message. But they don't get an error if they give us an invalid `id`. It would be preferable to send them a 404 status code, which let's the browser now that the resource was not found.

```js
app.get('/api/secrets/:id', (request, response) => {
  const id = request.params.id
  const message = app.locals.secrets[id]

  if (!message) { return response.sendStatus(404)  }

  response.json({ id, message })
})
```

It appears we're successfully making this work - let's add a test though to ensure the correct functionality. 

First, we'll verify that it returns a 404 when we ask for a secret that doesn't exist.

```js
  describe('GET /api/secrets/:id', () => {
    beforeEach(() => {
      app.locals.secrets = {
        wowowow: 'I am a banana'
      }
    })
    it('should return a 404 if the resource is not found', (done) => {
      this.request.get('/api/secrets/bahaha', (error, response) => {
        if (error) { done(error) }
        assert.equal(response.statusCode, 404)
        done()
      })
    })
   })

```

Next, let's verify that we're returning the correct data. 

```js
		it('should have the id and message from the resource', (done) => {
      const id = 'wowowow'
		  const message = app.locals.secrets['wowowow'];

      this.request.get('/api/secrets/wowowow', (error, response) => {
		    if (error) { done(error); }
		    assert(response.body.includes(id),
		           `"${response.body}" does not include "${id}".`);
		    assert(response.body.includes(message),
		           `"${response.body}" does not include "${message}".`);
		    done();
		  });
		});

```

**Note: since we aren't fully TDDing this app, let's make sure we're testing the correct pieces of info. Be sure to make your tests above fail by changing something in your code before moving on.**

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
  response.send(app.locals.title)
})

app.get('/api/secrets', (request, response) => {
  const secrets = app.locals.secrets

  response.json({ secrets })
})


app.get('/api/secrets/:id', (request, response) => {
  const id = request.params.id
  const message = app.locals.secrets[id]

  if (!message) { return response.sendStatus(404)  }

  response.json({ id, message })
})

app.listen(app.get('port'), () => {
  console.log(`${app.locals.title} is running on ${app.get('port')}.`)
})
```

### Creating a POST Route

Before we create a post route, let's write a test. We'll check to see that the post route exists.

```js
  describe('POST /api/secrets', () => {
    beforeEach(() => {
      app.locals.secrets = {}
    })
    it('should not return 404', (done) => {
      this.request.post('/api/secrets', (error, response) => {
        if (error) { done(error) }
        assert.notEqual(response.statusCode, 404)
        done()
      })
    })
  })

```
Next, do as little as possible to make this test pass, which maybe something like the following:

```js
app.post('/api/secrets', (request, response) => {
  response.status(201).end()
})
```

Cool - our post method is defined. Let's write another test to build out the functionality we'd like. We want tot send data to this post route and save it to our `app.locals.secrets` for now (eventually we'll save it to a database).

```js
    it('should receive and store data', (done) => {
      const message = {
        message: 'I like pineapples!'
      };

      this.request.post('/api/secrets', { form: message }, (error, response) => {
        if (error) { done(error); }

        const secretCount  = Object.keys(app.locals.secrets).length;

        assert.equal(secretCount, 1, `Expected 1 secret, found ${secretCount}`);

        done();
      });
    });

```

Next, we'll use our super secure method of generating random IDs.

```js
app.post('/api/secrets', (request, response) => {
  const id = Date.now()
  const message = request.body.message

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
  const message = request.body.message
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

Finally, let's replace `Date.now()` in our `POST` action, we'll need to make sure `message` is defined before using `md5` though. 

```js
app.post('/api/secrets', (request, response) => {
  const message = request.body.message
  const id = md5(message)

  if (!message) {
    return response.status(422).send({
      error: 'No message property provided'
    })
  } else {
    const id = md5(message)
    app.locals.secrets[id] = message
    response.status(201).json({ id, message })

  }
})
```

You've built your first Express app!! Things we did not cover: put and delete actions.

If you'd like another tutorial walk through of using Express, check out the [Express Train](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module4/lessons/express_tutorial.md)



