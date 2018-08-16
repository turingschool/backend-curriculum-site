# Building & Testing an Express App

### Goals

By the end of this lesson, you will:

* Understand when and why to use Express.js (Express) in the back-end of an application
* Build and test a simple Express app that implements all of the basic CRUD methods
* Understand how to create database migrations, seed files & create/retrieve data using knex

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

![inline](http://frontend.turing.io/assets/images/lessons/express/node-only-flow.png)

When we add Express, there are a couple of additional steps added to the flow of a request:

![inline](http://frontend.turing.io/assets/images/lessons/express/express-flow.png)

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

Let's explore Express at it's most basic level - using `app.locals` for data, before we connect to a database. Read through the server.js file in [this repo](https://github.com/turingschool/chatbox) and answer the following:
- What packages are we bringing in and what are they doing for us?
- How are we grabbing info from the request?
- How do we send HTTP statuses?
- What else do you oberve? Find interesting? What questions do you have?


# Knex and Postgres

## What is Knex?
Straight from the docs, Knex.js is a "batteries included" SQL query builder for Postgres, MSSQL, MySQL, MariaDB, SQLite3, and Oracle designed to be flexible, portable, and fun to use. It features both traditional node style callbacks as well as a promise interface for cleaner async flow control, a stream interface, full featured query and schema builders, transaction support (with savepoints), connection pooling and standardized responses between different query clients and dialects.

What Knex really is is Javascript instead of raw SQL.

## Getting Started

Make sure Postgres is installed and running. We will prep our app by creating a single database in Postgres. Don't forget the semicolons in the the CREATE DATABASE command!

```js
$ psql
CREATE DATABASE publications;
```

Create a new directory and cd into it, then run `npm init --yes`. Install knex globally and in your project, and pg (postgres) in your project from npm:

```
npm install -g knex
npm install knex --save
npm install pg --save
```

We will use a knexfile to configure our database for all of our environments. Create that file using the below command with some default values:

```
→ knex init
Created ./knexfile.js
```

## Configuring the Database

This generated a really nice configuration file that we are going to tweak. Take a look at what it stubbed in for us:

### Multiple Environments

You'll notice at the top level of this file we have three keys: development, staging, and production. These each represent different environments we may be running our app in. Our database setup is going to vary slightly between environments. We'll see how in just a bit.

Let's get rid of the staging and production environment configurations for now and just focus on the development one.

### Client

First we will change our development environment to use Postgres instead of mySql. This is considered the 'client' and because Knex supports multiple clients, we want to explicitly tell it to use Postgres:

```client: 'pg'```

### Connection

Next we'll update this connection value. Every database system has a slightly different way of establishing a connection. We have postgres running on our machines, and we need to connect to it by using what's called a connection string. (You'll notice the stubbed-in sqlite3 required a connection file.) The format for this string is just:

```connection: postgres://localhost/<name of database>```

Let's name our database 'publications' and update that configuration value.

*Note: think back to when we had that staging and production environment configuration in here. Do you think this connection string would work when we deploy our apps to production? Which part would have to change?*

### useNullAsDefault

This is just an option that will take any undefined keys or values in our database and set them equal to `null` rather than having to specify a default value for each one. So if you have an array of research papers in one of your postgres tables, and each paper has an optional subtitle field, we don't want to set a default subtitle on every paper - we just want it to be blank by using `null`.

---

Your configuration file should now currently look like this:

```js
module.exports = {
  development: {
    client: 'pg',
    connection: 'postgres://localhost/publications',
    useNullAsDefault: true
  }
};
```

We're not quite done here, but let's switch gears for a bit and talk about **migrations**.

## Migrations

Migrations are kind of like version control for databases. They are single, timestamped files that each represent a change to your database schema. Migrations attempt to have as little effect on pre-existing data as possible, but sometimes it's hard to avoid. For example if you have a migration that deletes a column from a table, any data in that column might be destroyed along with it.

### Configuring a Migrations Directory

Let's hop back into our knex configuration file and tell knex where we're going to store our migrations: 

```js
module.exports = {
  development: {
    client: 'pg',
    connection: 'postgres://localhost/publications',
    migrations: {
      directory: './db/migrations'
    },
    useNullAsDefault: true
  }
};
```

### Making a Migration

We can create a migration by running the following command:

```
knex migrate:make initial
```

This created a `migrations` directory at the root of the project and added a time stamped file with the name of the migration at the end. 

The `initial` word here is just a descriptor of what the migration is doing. (Think of git commit messages, the first one in your repo is `Initial Commit`, the rest of them should describe exactly what's happening.) So if we wanted to drop a column from our table we might run `knex migrate:make drop-some-column`

The file created should look something like this:

```js
exports.up = function(knex, Promise) {

};

exports.down = function(knex, Promise) {

};
```

`up` defines what should happen when we run the migration. (i.e. What changes do we want to make to our database?)

`down` is the reverse. If we want to roll back to a previous version, then `down` undoes whatever `up` did.

**For every `up` there must be an equal and opposite `down` that will allow us to rollback those changes, and we have to explicity write it.**

To see all the different options on building and modifying a table, review [the Knex docs.](http://knexjs.org/)

Let's edit the migration to create a `papers` table and a `footnotes` table. We will work with a one-to-many relationship here, where one paper can have many footnotes, but a footnote can only belong to one paper:

```js
exports.up = function(knex, Promise) {
  return Promise.all([
    knex.schema.createTable('papers', function(table) {
      table.increments('id').primary();
      table.string('title');
      table.string('author');

      table.timestamps(true, true);
    }),

    knex.schema.createTable('footnotes', function(table) {
      table.increments('id').primary();
      table.string('note');
      table.integer('paper_id').unsigned()
      table.foreign('paper_id')
        .references('papers.id');

      table.timestamps(true, true);
    })
  ])
};


exports.down = function(knex, Promise) {
  return Promise.all([
    knex.schema.dropTable('footnotes'),
    knex.schema.dropTable('papers')
  ]);
  ```

But, why is `Promise` passed in as a second argument? Knex is expecting that these methods return a promise of some sort. All Knex methods return a promise, so we fulfilled our end of the bargin in the example above. `Promise.all` allows you to do multiple things and return one promise. Knex passes us a reference to `Promise`, because it's not natively supported in some previous versions of Node. We're not using it at this moment, but we will in a second.

### Running Your Migrations

You can run all of your migrations to the latest point with the following command:

`knex migrate:latest`


### Updating Your Schema with Migrations

Now what if we realized we made a mistake in our schema and we wanted to add a column to the papers table for a publisher? We can't go directly into our initial migration file and edit it because it's already been made and run - it's already set in stone. So what do we have to do? Create another migration:

`knex migrate:make add-publisher`

And in this particular migration we'll want to add a column on the `up`, and drop it on the `down`:

```js
exports.up = function(knex, Promise) {
  return Promise.all([
    knex.schema.table('papers', function(table) {
      table.string('publisher');
    })
  ]);
};

exports.down = function(knex, Promise) {
  return Promise.all([
    knex.schema.table('papers', function(table) {
      table.dropColumn('publisher');
    })
  ]);
};
```

Go ahead and run this migration and then we'll add some seed data to our tables that we've just set up.


## Seeds

Seeds are some default data. Sometimes it's nice to populate your database with some fake data just so you can work on other functionality while you wait for everything else to come together.

### Configuring a Seeds Directory

Similar to migrations, we need to tell knex where to look for our seed data. Back in our knex configuration file, let's update it to the following:

```js
module.exports = {
  development: {
    client: 'pg',
    connection: 'postgres://localhost/publications',
    migrations: {
      directory: './db/migrations'
    },
    seeds: {
      directory: './db/seeds/dev'
    },
    useNullAsDefault: true
  }
};
```

### Making a Seed File

We can make a seed file with the following command:

```bash
knex seed:make papers
```

Again, this creates a default file for you that we'll want to configure with our own tables and data:

```js
exports.seed = function(knex, Promise) {
  // Deletes ALL existing entries
  return knex('table_name').del()
    .then(function () {
      return Promise.all([
        // Inserts seed entries
        knex('table_name').insert({id: 1, colName: 'rowValue1'}),
        knex('table_name').insert({id: 2, colName: 'rowValue2'}),
        knex('table_name').insert({id: 3, colName: 'rowValue3'})
      ]);
    });
};
```

You'll notice the seed file starts off by deleting any records in the database. This is just so we can ensure we're starting with a clean slate any time we run our seed file.

Because we are working with papers **and** footnotes, we need to:

1. Clear out both tables (footnotes first, as they depend on papers existing)
2. Add a paper => return the paper's id => add footnotes with that paper id
3. Add a paper => return the paper's id => add footnotes with that paper id

The logic here gets a little hairy, but ultimately will end up looking like this:

```js
exports.seed = function(knex, Promise) {
  // We must return a Promise from within our seed function
  // Without this initial `return` statement, the seed execution
  // will end before the asynchronous tasks have completed
  return knex('footnotes').del() // delete all footnotes first
    .then(() => knex('papers').del()) // delete all papers

    // Now that we have a clean slate, we can re-insert our paper data
    .then(() => {
      return Promise.all([
        
        // Insert a single paper, return the paper ID, insert 2 footnotes
        knex('papers').insert({
          title: 'Fooo', author: 'Bob', publisher: 'Minnesota'
        }, 'id')
        .then(paper => {
          return knex('footnotes').insert([
            { note: 'Lorem', paper_id: paper[0] },
            { note: 'Dolor', paper_id: paper[0] }
          ])
        })
        .then(() => console.log('Seeding complete!'))
        .catch(error => console.log(`Error seeding data: ${error}`))
      ]) // end return Promise.all
    })
    .catch(error => console.log(`Error seeding data: ${error}`));
};
```
*Note on return statements: In our seed files, we often have to return Promises rather than just calling them. Without the return statements, the asynchronous code in our seed file will be kicked-off, but knex will not necessarily know to wait for it to resolve before it says 'I'm done seeding your data'. The same thing applies at any nested level of .thens() in our code. If your seeding doesn't seem to be working, but you're not receiving any error messages, double-check if you're missing any return statements for the asynchronous operations you're writing.*

### Running Your Seeds

You can run your seeds (again, similar to migrations) with:

```bash
knex seed:run
```

### Seeding Large Datasets - A Note

When you have a large dataset that needs to be seeded, you'll often want to simplify your code by iterating over your dataset and inserting each record and any of its dependents, rather than having to manually write an `insert` for each one. This can get a little hairy when we're using Promises. We can't simply nest Promises within a `forEach` loop because our code will run through the loop without recognizing that it needs to wait for each insertion promise to resolve before ending the seed execution. 

To get around this, we can break our insertion logic out into a separate function. For example, given the following dataset:

```js
let papersData = [{
  author: 'Amy',
  title: 'Lorem Ipsum',
  footnotes: ['one', 'two', 'three']
},
{
  author: 'Cory',
  title: 'Dolor Set Amet',
  footnotes: ['four', 'five', 'six']
}]
```

We could write a function that appropriately seeds a paper into the `papers` table and all of it's footnotes into the `footnotes` table:

```js
const createPaper = (knex, paper) => {
  return knex('papers').insert({
    title: paper.title,
    author: paper.author
  }, 'id')
  .then(paperId => {
    let footnotePromises = [];

    paper.footnotes.forEach(footnote => {
      footnotePromises.push(
        createFootnote(knex, {
          note: footnote,
          paper_id: paperId[0]
        })
      )
    });

    return Promise.all(footnotePromises);
  })
};

const createFootnote = (knex, footnote) => {
  return knex('footnotes').insert(footnote);
};

exports.seed = (knex, Promise) => {
  return knex('footnotes').del() // delete footnotes first
    .then(() => knex('papers').del()) // delete all papers
    .then(() => {
      let paperPromises = [];

      papersData.forEach(paper => {
        paperPromises.push(createPaper(knex, paper));
      });

      return Promise.all(paperPromises);
    })
    .catch(error => console.log(`Error seeding data: ${error}`));
};
```

## Fetching From the Database

Let's write some express code to interact with our newly seeded database. Set up a simple express server and we'll add some configuration to work with the knex database:

```js
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

app.get('/', (request, response) => {
  response.send('Hello, Publications');
});

app.listen(app.get('port'), () => {
  console.log(`${app.locals.title} is running on ${app.get('port')}.`);
});
```
There are a few things going on in the code above (the second chunk specifically):

1. We want to know if we're in a development, testing, or production environment. If we don't know, we'll assume we're in development.
2. Based on that environment, we'll fetch the database configuration from `knexfile.js` for whatever environment we're in and now our express app will be able to connect to it.

### Retrieving Data from the Database

To make a selection for all the papers in the database, we can use `database('papers').select()`. This will return an array of all the papers we've added to the paper table:


```js
app.get('/api/v1/papers', (request, response) => {
  database('papers').select()
    .then((papers) => {
      response.status(200).json(papers);
    })
    .catch((error) => {
      response.status(500).json({ error });
    });
});
```
If we check this in Postman we should get back an array of all our papers that looks something like this:

```js
[{
  id: 1,
  author: 'Amy',
  title: 'Lorem Ipsum',
  publisher: 'University of Minnesota'
},
{
  id: 2,
  author: 'Cory',
  title: 'Dolor Set Amet',
  publisher: 'University of Michigan'
}]
```

Now let's say we decided we *didn't* need that publisher column, and we wanted to get rid of it. We could rollback that change to our schema by running:

```bash
knex migrate:rollback
```
Our GET request would now return the same array without publisher columns:

```js
[{
  id: 1,
  author: 'Amy',
  title: 'Lorem Ipsum'
},
{
  id: 2,
  author: 'Cory',
  title: 'Dolor Set Amet'
}]
```

#### On Your Own

Write a GET request to retrieve all footnotes. Verify it works using Postman.


### Adding Data to the Database

Now let's add a new paper to the database. We can do this with a POST request and use our database `insert` method:

```js
app.post('/api/v1/papers', (request, response) => {
  const paper = request.body;

  for (let requiredParameter of ['title', 'author']) {
    if (!paper[requiredParameter]) {
      return response
        .status(422)
        .send({ error: `Expected format: { title: <String>, author: <String> }. You're missing a "${requiredParameter}" property.` });
    }
  }

  database('papers').insert(paper, 'id')
    .then(paper => {
      response.status(201).json({ id: paper[0] })
    })
    .catch(error => {
      response.status(500).json({ error });
    });
});
```

#### On Your Own

Write a POST request to add a new footnote that belongs to a pre-existing paper. Verify it works with Postman.


### Querying Data for a specific Resource

What if we want to only retrieve a single, specific paper? We can do this by passing in an `id` through our request params. With our database selection, we need to limit our `select()` with a `where` clause that matches on the id field: 

```js
// GET a specific paper
app.get('/api/v1/papers/:id', (request, response) => {
  database('papers').where('id', request.params.id).select()
    .then(papers => {
      if (papers.length) {
        response.status(200).json(papers);
      } else {
        response.status(404).json({ 
          error: `Could not find paper with id ${request.params.id}`
        });
      }
    })
    .catch(error => {
      response.status(500).json({ error });
    });
});
```

*How does this query compare to the raw SQL you'd write to get this resource?*

#### On Your Own

Write a GET request to retrieve all footnotes for a pre-existing paper. Verify it works with Postman.


# Testing your Express App

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

In publications, create a directory called tests and inside of it, touch a file call `routes.spec.js`. At the top of the `routes.spec.js` file, add:

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

Run the test suite with the command `mocha` (you'll have to have omcha installed globally to run this command in ther terminal). The test should output something like:

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

- GET request to retieve the footnotes of a specified paper - api/v1/papers/:id/footnotes
- PUT request to change the title of a paper
- DELETE request to destroy a paper
