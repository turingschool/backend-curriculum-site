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

Today we are going to be working with our `publications` app to set-up Jest.

First, make a new branch:
```bash
  git checkout branch jest-testing
```

Next we want to ensure that the server is not within the `index.js` or `app.js` file. _If you are using the express generator it should be within `bin/www`._ If the server is within `index.js` or `app.js` you will need to make a separate file, such as `server.js`. We do this because if it is left in the file that we are testing, then our project will try to start the server each time we run our tests and we do not want that to happen.

Below is an example of separating out `server.js` and `index.js`.

```javascript
//server.js
const app = require('./index.js')


//This is the code that is removed from index.js or app.js
app.set('port', 3000);
app.listen(app.get('port'), () => {
  console.log(`App is running on http://localhost:${app.get('port')}`)
});
```

```javascript
//index.js
const express = require('express');
const app = express();
const bodyParser = require('body-parser');

const environment = process.env.NODE_ENV || 'development';
const configuration = require('./knexfile')[environment];
const database = require('knex')(configuration);


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.set('port', process.env.PORT || 3000);
app.locals.title = 'Publications';

// All endpoints are here

module.exports = app;
```

Once the server has been split from the `index` or `app` file, the start script in the `package.json` file will need to be updated. It should now look like this:
```
"scripts": {
  "start": "node server.js",
```
_Check your Server_
To make sure we can still get the server up and running type `npm start` in the command line. You should see somthing like `Publications is running on 3000` and the server should be listening.

### Testing Database Set-up

It is also good practice to have a separate database for testing, so that we are not affecting are development database. To do that we will first need to create the test database is `psql`.

From the command line run the following commands:
```bash
psql
CREATE DATABASE publications_test;
\q
```

Next in the `knexfile.js` we will want to update the config settings. Add the test environment so that it points to the `publications_test` database. Once you are done the file should look like this:

```js
//knexfile.js
module.exports = {

  development: {
    client: 'pg',
    connection: 'postgres://localhost/publications_dev',
    migrations: {
      directory: './db/migrations'
    },
    seeds: {
      directory: './db/seeds/dev'
    },
    useNullAsDefault: true
  },
  test: {
    client: 'pg',
    connection: 'postgres://localhost/publications_test',
    migrations: {
      directory: './db/migrations'
    },
    seeds: {
      directory: './db/seeds/dev'
    },
    useNullAsDefault: true
  },
};
```

Next run the migrations for your test environment with the following command:
`knex migrate:latest --env test`

### Setting up for Jest

First, globally install jest: `npm install jest -g`. Now, we can install the packages we want to use in our project.

```bash
npm install babel-jest supertest -D
```

`babel-jest` is used to compile our JavaScript. `supertest` is a testing library which allows us to make requests to our API within our test files.

After that has successfully installed, let's add a test script to the `package.json` file, so that we can simply run our tests with `npm test`,

It should look like this:

```javascript
//package.json
"scripts": {
  "start": "node ./bin/www",
  "test": "jest --config ./jest.config.js --forceExit --coverage --runInBand"
},
```

Lastly create a `jest.config.js` file at the root of the project. In this file include the following:
```
module.exports = {
    testEnvironment: "node"
}
```

Yay! Our set-up is complete and we can now write our tests!

### Writing Tests with Jest

Create a `test` directory and a file named `index.spec.js` to put our tests in. We are going to write a simple test to test our root path first.

```javascript
//index.spec.js
var request = require("supertest");
var app = require('../index');

describe('Test the root path', () => {
  test('It should respond to the GET method', async () => {
    const res = await request(app)
      .get("/");

    expect(res.statusCode).toBe(200);
  });
});

```

This test should pass. Let's write another test for the papers index endpoint `/api/v1/papers`. This endpoint interacts with out database, so we need to think about how we can interact with the testing database. To do this we are going to include a `beforeEach`, and an `afterEach` inside our test file. These should be within a `describe` block that will wrap our tests. We will also need to include connection to our database.

The `beforeEach` is responsible for inserting a paper into the papers table. The `afterEach` is responsible for clearing out the data in the papers table. We do this so that each test will begin with the same information and each test will not be affected by any other test. The `index.spec.js` file should now look like this:

```javascript
//app.spec.js
var request = require("supertest");
var app = require('./app');

//Database connection
const environment = process.env.NODE_ENV || 'test';
const configuration = require('../knexfile')[environment];
const database = require('knex')(configuration);

describe('api', () => {
  beforeEach(async () => {
     await database.raw('truncate table papers cascade');

     let paper = {
       title: 'Alternate Endings for Game of Thrones, Season 8',
       author: 'Literally Anyone',
       publisher: 'Not George R. R. Martin'
     };
     await database('papers').insert(paper, 'id');
  });

  afterEach(() => {
    database.raw('truncate table papers cascade');
  });

  describe('Test the root path', () => {
    it('should return a 200', () => {
      return request(app).get("/").then(response => {
        expect(response.statusCode).toBe(200)
      })
    });
  });
});
```

Let's add our test for `/api/v1/papers`. This is going to be similar to our root path test, but not only do we want to check the response status, we also want to check that we are getting an array of paper objects as well as the keys and the values on the object. So our test should look like this:

```javascript
  describe('Test GET /api/v1/papers path', () => {
    it('happy path', async () => {
      const res = await request(app).get("/api/v1/papers");

      expect(res.statusCode).toBe(200);
      expect(res.body.length).toBe(1);

      expect(res.body[0]).toHaveProperty('title');
      expect(res.body[0].title).toBe('Alternate Endings for Game of Thrones, Season 8');

      expect(res.body[0]).toHaveProperty('author');
      expect(res.body[0].author).toBe('Literally Anyone');

      expect(res.body[0]).toHaveProperty('publisher');
      expect(res.body[0].publisher).toBe('Not George R. R. Martin');
    });
  });
```

_On your Own:_ Try writing tests for the remainder of the `api` endpoints.
