# Testing your Express App

### Goals

By the end of this lesson, you will:

* Test a simple Express app that implements all of the basic CRUD methods

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

### Packages we will use to test

We will use the following packages to write and run our tests:

- [mocha](https://mochajs.org/) is used to actually run the tests
- [chai](http://chaijs.com/) gives us the ability to make assertions
- [chai-http](https://github.com/chaijs/chai-http) lets us make requests to our own server to check what the endpoints return

```shell
npm install -D mocha chai chai-http
```

Use your publications app or you can clone down this [one](https://github.com/turingschool-examples/publications). Then, create a directory called tests and inside of it, touch a file called `routes.spec.js`. At the top of the `routes.spec.js` file, add:

```js
const chai = require('chai');
const should = chai.should();
const chaiHttp = require('chai-http');
const server = require('../server');

chai.use(chaiHttp);

describe('Client Routes', () => {

});

describe('API Routes', () => {

});
```

Run the test suite with the command `mocha` (you'll have to have mocha installed globally to run this command in the terminal). The test should output something like:

```shell
0 passing (3ms)
```

This makes sense because we don't have tests, but now we are all setup to add tests! If you are getting an error about app.address - make sure you are exporting your app in `server.js` with `module.exports = app`.

Note: If your tests are running, but “hanging” and not exiting (you have to enter control + c to exit the tests), then you might have to add --exit to your mocha command. To run the tests, enter `mocha --exit`.

### Happy Path

The happy path is a test case we write for when we expect everything to go well. This includes a well-formed request and an appropriate response.

As a basic test, let’s test the root endpoint to our app, localhost:3000/, or just /. In the routes.spec.js file. Use chai-http to make the request inside of the test.

The test for the route / becomes:

```js
describe('Client Routes', () => {
  it('should return the homepage with text', done => {
    chai.request(server)
    .get('/')
    .end((err, response) => {
      response.should.have.status(200);
      response.should.be.html;
      response.res.text.should.equal('Hello Publications!');
      done();
    });
  });
});
```

Here is the breakdown of the test:

- Start a request to the server
- For a specific route, use the appropriate request verb
- When you get the response from the server, test what the response contains
- We use the `done()` function to tell mocha that the test has completed (or else the test will pass prematurely or it could timeout and fail)

The tests in this lesson are written using should, but you can choose to use expect or assert - just be consistent. See the chai docs for more info on different ways to make test assertions.

### Sad Path

Let’s test a route that doesn’t exist in our app. All we have to do is make a request to a garbage endpoint and we then expect a standard 404 response. Here is what our tests look like:

```js
  it('should return a 404 for a route that does not exist', done => {
    chai.request(server)
    .get('/sad')
    .end((err, response) => {
      response.should.have.status(404);
      done();
    });
  });
```

The status code is the very least we can test for. If you have a custom 404 error page, then you can also test for the contents of the page.

When you run the tests with mocha, you should see something like:

```shell
Test Express is running on localhost:3000.
  Client Routes
    ✓ should return the homepage with text
    ✓ should return a 404 for a route that does not exist


  2 passing (39ms)
```

Great! We have some basic routes tested, both a happy and sad path. Let’s start testing the API routes.

## before and beforeEach

Server-side tests should run in isolation and each test should not leave artifacts in the database. For instance, the first test in the test file should not influence what happens with the fifth test. Therefore, we need to run migrations before we run the test suite and reset the database before each test.

If you’re using a “real” database like postgreSQL with knex, you will typically need to:

Before all tests, run the migrations for your test environment and seed the test database
Before each test:
Clean out the database (delete records in all tables)
Seed your database with records
For this lesson, we’re not using a real database, so we can just reset app.locals to the original data from the students.js file.

With our testing structure, we have built-in methods called before and beforeEach, and they run before all tests and before each test in the describe block they are scoped in, respectively. There is also after and afterEach, but there is a caveat with afterEach. If a test fails, the afterEach will not run after that test, which can leave your database in a bad state. So be sure to put your database in a good state for every test even if one fails.

Let’s write these methods within the describe('API Routes', ... block.

```js
  before((done) => {
    database.migrate.latest()
      .then(() => done())
      .catch(error => {
        throw error;
      });
  });

  beforeEach((done) => {
    database.seed.run()
      .then(() => done())
      .catch(error => {
        throw error;
      });
  });
```

Don't forget to bring in your environment, configuration, and database variables into this file, just like you did in `server.js`.

## Test an API Call (GET Request)

From our basic server-side tests above, you can see how we might test our API. The first test we’ll write is for the /api/v1/papers route. A GET request to this endpoint should return a collection all of the papers.

Let’s write the test. In the API Routes describe block:

```js
describe('GET /api/v1/papers', () => {
 it('should return all of the papers', done => {
    chai.request(server)
      .get('/api/v1/papers')
      .end((err, response) => {
        response.should.have.status(200);
        response.should.be.json;
        response.body.should.be.a('array');
        response.body.length.should.equal(1);
        response.body[0].should.have.property('title');
        response.body[0].title.should.equal('Fooo');
        response.body[0].should.have.property('author');
        response.body[0].author.should.equal('Bob');
        response.body[0].should.have.property('publisher');
        response.body[0].publisher.should.equal('Minnesota');
        done();
      });
    });
  });
```

Run the tests with mocha. Because we already have the route set up in our server.js file, you should see something like:

```shell
Test Express is running on localhost:3000.
  Client Routes
    ✓ should return the homepage with text
    ✓ should return a 404 for a route that does not exist

  API Routes
    GET /api/v1/papers
      ✓ should return all of the students


  3 passing (76ms)
```

### Test a POST Request

For a post request, we need to not only send the request to the correct endpoint, but we also need to give some information in the body of the post request.

In another describe block, let’s write the test first:

```js
  describe('POST /api/v1/papers', () => {
    it('should create a new paper', done => {
      chai.request(server)
      // Notice the change in the verb
        .post('/api/v1/papers')
        // Here is the information sent in the body or the request
        .send({
          title: 'Waterfall Wow',
          author: 'Amy'
        })
        .end((err, response) => {
          // Different status here
          response.should.have.status(201);
          response.body.should.be.a('object');
          response.body.should.have.property('id');
          done();
        });
    });
  });
```

Seems like everything should work…right? However, if we console.log() the request.body in the route, we get undefined. Turns out Express needs help parsing the body of a request. There is a package called, you guessed it, body-parser that can help us with this. It’s already in the package.json file so you don’t need to install it - just bring it in to the server file.

Add this line to the server.js file:

```js
const bodyParser = require('body-parser');
app.use(bodyParser.json());
```

We’re using .json() because we expect the content in the body to be JSON. Run the tests again, and everything should pass.

### POST Sad Path

What if we make a POST request and don’t specify all of the properties of a student? For instance, in the request body if we specify {lastname: 'Knuth', program: 'FE'}, but we leave out the enrolled property and value, the new record should not be created. We don’t want unintended null values in our database!

We need to design our server so that it does not accept this kind of situation with missing data. Let’s write the test!

```js
    it('should not create a record with missing data', done => {
      chai.request(server)
        .post('/api/v1/papers')
        .send({
          title: 'Waterfall Wow' //missing author property
        })
        .end((err, response) => {
          response.should.have.status(422);
          response.body.error.should.equal(
            `Expected format: { title: <String>, author: <String> }. You're missing a "author" property.`
          );
          done();
        });
      });
    });
```

## What Could Go Wrong? More Sad Paths

There are many more possibilities for route sad paths. Some could be:

* The resource requested at the endpoint does not exist (/api/v1/students/5, but student #5 does not exist in the database)
* For a POST request, the request does not contain all of the necessary data in the body (missing properties or null data)
* For a PUT request, the request body has missing properties or null data
* For a PUT request, a user tries to change a property of a record that does not exist in the database
* A user tries to change the primary key of a record
* A user submits duplicate data for table columns that must have unique record values
* And others! So much sadness.


## In true TDD style...
Add tests for these requests, and then implement the routes:

- GET request to retrieve the footnotes of a specified paper - api/v1/papers/:id/footnotes
- PUT request to change the title of a paper
- DELETE request to destroy a paper
