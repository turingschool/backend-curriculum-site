---
layout: page
title: Testing with Jest
---

## Learning Goals
- Understand how to set-up Jest in an Express app
- Be able to write an integration test using Jest

## Warm Up
- What are the steps necessary to writing a good test?
- What is the difference between an integration test and a unit test?

## Testing with Jest

Today we are going to be working with our `arcade` app to set-up Jest.

First, make a new branch:
```bash
  git checkout branch jest-testing
```

Next we want to ensure that the server is not within the `app.js` file. _If you are using the express generator it should be within `bin/www`._ If the server is within `app.js` you will need to make a separate file, such as `server.js`. We do this because if it is left in the file that we are testing, then our project will try to start the server each time we run our tests and we do not want that to happen.

Below is an example of separating out `server.js` and `app.js`.

```javascript
//server.js
const app = require('./app')

app.set('port', 3000);
app.listen(app.get('port'), () => {
  console.log(`App is running on http://localhost:${app.get('port')}`)
});
```

```javascript
//app.js
const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// All endpoints are here

module.exports = app;
```


### Setting up for Jest

First, globally install jest: `npm install jest -g`. Now, we can install the packages we want to use in our project.

```bash
npm install babel-jest supertest shelljs -D
```

`babel-jest` is used to compile our JavaScript. `supertest` is a testing library which allows us to make requests to our API within our test files. `shelljs` is what we will use in our setup and teardown methods to execute shell scripts.

After that has successfully installed, let's add a test script to the `package.json` file, so that we can simply run our tests with `npm test`,

It should look like this:

```javascript
//package.json
"scripts": {
  "start": "node ./bin/www",
  "test": "jest --watch"
},
```

Yay! Our set-up is complete and we can now write our tests!

### Writing Tests with Jest

Create an `app.spec.js` file to put our tests in. We are going to write a simple test to test our root path first.

```javascript
//app.spec.js
var shell = require('shelljs');
var request = require("supertest");
var app = require('./app');

describe('Test the root path', () => {
  test('It should respond to the GET method', () => {
    return request(app).get("/").then(response => {
      expect(response.statusCode).toBe(200)
    })
  });
});
```

This test should pass. Let's write another test for the game index endpoint `/api/v1/games`. This endpoint interacts with out database, so we need to think about how we can create a testing database. To do this we are going to include a `beforeAll`, `beforeEach`, and an `afterEach` inside our test file. These should be within a `describe` block that will wrap our tests.

The beforeAll is responsible for creating the test database. The beforeEach is responsible for running the migrations and seeding the tables. The afterEach is responsible for reversing all the migrations. We do this so that each test will begin with the same information and each test will not be affected by any other test. The `app.spec.js` file should now look like this:

```javascript
//app.spec.js

var shell = require('shelljs');
var request = require("supertest");
var app = require('./app');

describe('api', () => {
  beforeAll(() => {
    shell.exec('npx sequelize db:create')
  });
  beforeEach(() => {
      shell.exec('npx sequelize db:migrate')
      shell.exec('npx sequelize db:seed:all')
    });
  afterEach(() => {
    shell.exec('npx sequelize db:migrate:undo:all')
  });

  describe('Test the root path', () => {
    test('should return a 200', () => {
      return request(app).get("/").then(response => {
        expect(response.statusCode).toBe(200)
      })
    });
  });
});
```

Let's add our test for `/api/v1/games`. This is going to be similar to our root path test, but not only do we want to check the response status, we also want to check that we are getting back an array of game objects. So our test should look like this:

```javascript
  describe('Test GET /api/v1/games path', () => {
    test('should return a 200 status', () => {
      return request(app).get("/api/v1/games").then(response => {
        expect(response.status).toBe(200)
      });
    });
    test('should return an array of game objects', () => {
      return request(app).get("/api/v1/games").then(response => {
        expect(response.body.length).toEqual(4),
        expect(Object.keys(response.body[0])).toContain('title')
        expect(Object.keys(response.body[0])).toContain('price'),
        expect(Object.keys(response.body[0])).toContain('releaseYear'),
        expect(Object.keys(response.body[0])).toContain('active')
      })
    });
  });
```

_On your Own:_ Try writing tests for the remainder of the `/api/v1/games` endpoints.
