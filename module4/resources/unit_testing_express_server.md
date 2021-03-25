---
title: Testing An Express Server
length: 90
tags: express, testing, server, node
---

## Learning Goals

By the end of this lesson, you will...
* Write tests for your Express application
* Explain the differences between the way we test when we have a front end
* Explain the benefits of testing

## Overview

Server-side testing is a crucial facet of testing. As your app grows in size and complexity, there will be more points of potential failure.

When we have render our applications through a front-end, our server-side testing looks a little different than what are you used to testing in Rails - **front-end** testing should test what renders based on user interactions, while **server-side** testing focuses on the API routes - looking at a request coming from a client, processing the request, and testing if the correct response to the client is given.

## Why do we test?

* Why do we test our code?
* What do you like and dislike about testing?

## Basic Structure of a Server-Side Test

1. DB setup (if testing route that interacts with the database)
2. Make a request to a server route
3. Get a response from the server
4. Test the response
5. DB clean up (if testing route that interacts with the database)

What about the response should we test?

* The status code
* What content type do we expect? (json, plain text)
* What is the data structure of the response body? (object, array)
* What should be contained in the body?
  - If it's an array, how many elements should be in the array?
  - If it's an object, what properties and values should the object have?

## Let's Go Through Some Examples

We'll be using [mocha](https://mochajs.org/) for our test runner, [chai](http://chaijs.com/) for our assertion library, and [chai-http](https://github.com/chaijs/chai-http) for our request generator.

We will use the express app that we've been working on in class to practice testing. Checkout to the `testing-practice` branch.


### Setup

Now let's install our testing tools from the terminal.

```shell
npm install -D mocha chai
npm install -D https://github.com/chaijs/chai-http#3ea4524 # Must use this version for correct error handling
```

Create a directory called `test` and create a new test file called `routes.spec.js` within the `test` directory. Open the new test file.

At the top of the test file, `routes.spec.js`, add:

```javascript
const chai = require('chai');
const should = chai.should();
const chaiHttp = require('chai-http');
const server = require('../app.js');

chai.use(chaiHttp);

describe('Client Routes', () => {

});

describe('API Routes', () => {

});
```

Run the test suite with the command `NODE_ENV=test mocha --exit` (you'll have to have mocha installed globally to run this command in the terminal). The test output should be something like:

```shell

0 passing (3ms)

```

This makes sense because we don't have any tests yet, but now we're all setup to add tests!

*Note:* You may or may not need the `--exit` flag.

### before and beforeEach

Server-side tests should run in isolation and each test should not leave artifacts in the database. For instance, the first test in the test file should not influence what happens with the fifth test. Therefore, we need to run migrations before we run the test suite and reset the database before each test.

If you're using a "real" database like postgreSQL with knex, you will typically need to:

 1. Before all tests, run the migrations for your test environment and seed the test database
 2. Before each test:
  * Clean out the database (delete records in all tables)
  * Seed your database with records

With our testing structure, we have built-in methods called `before` and `beforeEach`, and they run before all tests and before each test in the describe block they are scoped in, respectively. There is also `after` and `afterEach`, but there is a caveat with `afterEach`. If a test fails, the `afterEach` will _not_ run after that test, which can leave your database in a bad state. So be sure to put your database in a good state for every test even if one fails.

Let's write these methods within the `describe('API Routes', ...` block.

```javascript
before(() => {
  // Run migrations and seeds for test database
  database.migrate.latest()
  .then(() => done())
  .catch((error) => {
    throw error;
  })
  .done();
});

beforeEach((done) => {
  // Would normally run run your seed(s), which includes clearing all records
  // from each of the tables
  database.seed.run()
  .then(() => done())
  .catch((error) => {
    throw error;
  })
  .done(); // Need to call the done function because this is not a promise/async
});
```

### Happy Path

The happy path is a test case we write for when we expect everything to go well. This includes a well-formed request and an appropriate response.

As a basic test, let's test the root endpoint to our app, `localhost:3000/`, or just `/`. In the `routes.spec.js` file. Use chai-http to make the request inside of the test.

The test for the route `/` becomes:

```javascript
describe('Client Routes', () => {
  it('should return the home page with text', () => {
    return chai.request(server)
    .get('/')
    .then((response) => {
      response.should.have.status(200);
      response.should.be.html;
    })
    .catch((error) => {
      throw error;
    });
  });
});
```

Here is the breakdown of the test:

1. Start a request to the server
2. For a specific route, use the request verb
3. When you get the response from the server, test what the response contains
- If you cannot return a promise from the test, then you need to use the `done()` function to tell mocha that the test has completed (or else the test will timeout and fail - we'll see this later in the lesson)

The tests are written using `should`, but you can choose to use `expect` or `assert` - just be consistent. See the [chai docs](http://chaijs.com/api/) for more info.

### Sad Path

Let's test a route that doesn't exist in our app. All we have to do is make a request to a garbage endpoint and we then expect a standard 404 response. Here is what our tests look like:

```javascript
describe('Client Routes', () => {

  it('should return the home page with text', () => {
    return chai.request(server)
    .get('/')
    .then((response) => {
      response.should.have.status(200);
      response.should.be.html;
    })
    .catch((error) => {
      throw error;
    });
  });

  it('should return a 404 for a route that does not exist', () => {
    return chai.request(server)
    .get('/sad')
    .then((response) => {
      response.should.have.status(404);
    })
    .catch((error) => {
      throw error;
    });
  });

});
```

The status code is the very least we can test for. If you have a custom 404 error page, then you can also test for the contents of the page.

When you run the tests with `NODE_ENV=test mocha --exit`, you should see something like:

```shell

Test Express is running on 3000.
  Client Routes
    ✓ should return the homepage with text
    ✓ should return a 404 for. a route that does not exist


  2 passing (46ms)
```

Great! We have some basic routes tested, both a happy and sad path. Let's start testing the API routes.

Right now, this is what the entire test file looks like:

```javascript
const chai = require('chai');
const should = chai.should();
const chaiHttp = require('chai-http');
const server = require('../app.js');


chai.use(chaiHttp);

describe('Client Routes', () => {

  it('should return the home page with text', () => {
      return chai.request(server)
      .get('/')
      .then((response) => {
        response.should.have.status(200);
        response.should.be.html;
      })
      .catch((error) => {
        throw error;
      });
    });

    it('should return a 404 for a route that does not exist', () => {
      return chai.request(server)
      .get('/sad')
      .then((response) => {
        response.should.have.status(404);
      })
      .catch((error) => {
        throw error;
      });
    });

});

describe('API Routes', () => {

});
```


### Setup for API routes

So you have access to your database, add at the top of the `routes.spec.js` file:

```javascript
const environment = process.env.NODE_ENV || 'test';
const configuration = require('../knexfile')[environment];
const database = require('knex')(configuration);
```

#### Create and Setup Database

Use the following commands to create your test database:

```shell
psql
CREATE DATABASE secrets_test;
```

Migrate your secrets_test with:

```shell
knex migrate:latest --env test
```

Create a new directory under seeds called `test`, and touch `secrets.js` - this should contain the exact same thing that your `secrets.js` inside of the `dev` seed file.

Seed your secrets_test with:

```shell
knex seed:run --env test
```

### Test an API Call (GET Request)

From our basic server-side tests above, you can see how we might test our API. The first test is for the `/api/secrets/:id` route. A GET request to this endpoint should return a single secret.

Let's write the test. In the `API Routes` describe block:

```javascript
describe('API Routes', () => {

  describe('GET /api/secrets/:id', () => {

    it('should return the secret by ID', () => {
      return chai.request(server)
        .get('/api/secrets/1')
        .then((response) => {
          response.should.have.status(); //what status code should come back?
          response.should.be....; //what format do you expect your response to come in as?
          response.body.should.be.a('data-type'); //what data type?
          response.body.length.should.equal(length); //how many elements?
          response.body[0].should.have.property('property-name'); //key
          response.body[0].[property].should.equal(value-of-property); //value
          //repeat for all properties
        })
        .catch((error) => {
          throw error;
        });
    });

  });
});
```

Run the tests with `NODE_ENV=test mocha --exit`. Because we already have the route set up in our `server.js` file, you should see something like:

```shell

Test Express is running on 3000.
  Client Routes
    ✓ should return the homepage with text
    ✓ should return a 404 for. a route that does not exist

  API Routes
    GET /api/secrets/:id
      ✓ should return the secret by ID


  3 passing (61ms)

```

### Test a POST Request

For a post request, we need to not only send the request to the correct endpoint, but we also need to give some information in the body of the post request.

In another `describe` block, let's write the test first:

```javascript
describe('POST /api/secrets', () => {

  it('should add a secret', () => {
    return chai.request(server)
      .post('/api/secrets')
      .send({
        message: "I am in love with Mr. Wigglesworth."
      })
      .then((response) => {
        response.should.have.status();
        response.body.shoud...
        //you write the rest!
      })
      .catch((error) => {
        throw error;
      });
  });

});
```

### POST Sad Path

What if we make a POST request and don't specify all of the properties of a secret (in this case, the message)? An example with multiple properties would be an endpoint that requires lastname, program, and enrolled. In the request body if we specify `{lastname: 'Knuth', program: 'FE'}`, but we leave out the `enrolled` property and value, the new record should not be created. We don't want unintended null values in our database!

We should have designed our server so that it does not accept this kind of situation with missing data; now we need to test that!

```javascript
it('should not add a secret if message is not provided', () => {
  return chai.request(server)
    .post('/api/secrets')
    .send({}) // Missing the message property
    .then((response) => {
      response.should.have.status(expected status code);
    })
    .catch((error) => {
      throw error;
    });
});
```


### What Could Go Wrong? More Sad Paths

There are many more possibilities for route sad paths. Some could be:

* The resource requested at the endpoint does not exist (`/api/secrets/5`, but secret #5 does not exist in the database)
* For a POST request, the request does not contain all of the necessary data in the body (missing properties or null data)
* For a PUT request, the request body has missing properties or null data
* For a PUT request, a user tries to change a property of a record that does not exist in the database
* A user tries to change the primary key of a record
* A user submits duplicate data for table columns that must have unique record values
* And others!

### File summary

By the end of it all, this is what the `routes.spec.js` file looks like:

```javascript
const chai = require('chai');
const should = chai.should();
const chaiHttp = require('chai-http');
const server = require('../app.js');
const environment = process.env.NODE_ENV || 'test';
const configuration = require('../knexfile')[environment];
const database = require('knex')(configuration);

chai.use(chaiHttp);

describe('Client Routes', () => {

  it('should return the home page with text', () => {
    return chai.request(server)
    .get('/')
    .then((response) => {
      response.should.have.status(200);
      response.should.be.html;
    })
    .catch((error) => {
      throw error;
    });
  });

  it('should return a 404 for a route that does not exist', () => {
    return chai.request(server)
    .get('/sad')
    .then((response) => {
      response.should.have.status(404);
    })
    .catch((error) => {
      throw error;
    });
  });

});

describe('API Routes', () => {

  before((done) => {
    database.migrate.latest()
      .then(() => done())
      .catch(error => {
        throw error;
      })
      .done();

  });

  beforeEach((done) => {
    database.seed.run()
      .then(() => done())
      .catch(error => {
        throw error;
      })
      .done();
  });

  describe('GET /api/secrets/:id', () => {

    it('should return the secret by ID', () => {
      return chai.request(server)
        .get('/api/secrets/1')
        .then((response) => {
          response.should.have.status(200);
          response.should.be.json;
          response.body.should.be.a('array');
          response.body.length.should.equal(1);
          response.body[0].should.have.property('id');
          response.body[0].id.should.equal(1);
          response.body[0].should.have.property('message');
          response.body[0].message.should.equal('I hate mashed potatoes');
        })
        .catch((error) => {
          throw error;
        });
    });

  });

  describe('POST /api/secrets', () => {

    it('should add a secret', () => {
      return chai.request(server)
        .post('/api/secrets')
        .send({
          message: "I am in love with Mr. Wigglesworth."
        })
        .then((response) => {
          response.body.should.be.a('array');
          response.body[0].should.have.property('id');
          response.body[0].id.should.equal(4);
          response.body[0].should.have.property('message');
          response.body[0].message.should.equal('I am in love with Mr. Wigglesworth.');
        })
        .catch((error) => {
          throw error;
        });
    });

    it('should not add a secret if message is not provided', () => {
      return chai.request(server)
        .post('/api/secrets')
        .send({})
        .then((response) => {
          response.should.have.status(422);
        })
        .catch((error) => {
          throw error;
        });
    });
  });

});

```

## Checks for Understanding

* What libraries do we use to test server-side endpoints?
* What is the difference between happy and sad path tests?
* What about a response should we test?

## Interview Question

* Tell me two advantages of testing your code.
