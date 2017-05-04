---
title: "Express with Knex"
length: 1.5 hours
tags: node, express, knex, database, SQL, http
---

### Pre-reqs

We're going to start from the end of the [Building and Testing with Express lesson](http://backend.turing.io/module4/lessons/building_and_testing_with_express)

If you need it, you can clone this repo, which represents the completed lesson:

```
git clone https://github.com/turingschool-examples/1611-express-lesson-codez
```

## Learning Goals

By the end of this lesson, you will:

*   Understand how to execute raw SQL in node
*   Understand how to use promises to retrieve data from postgres in node
*   Understand how to made code organization decisions without a framework

You wouldn't want to immediately jump to writing raw SQL in any production application, but being able to write SQL is a must on the job. Whether it's for queries that are too complex for whatever ORM or library you're using, or it's using SQL to interact with the database directly.

## Application Goals

What we have after the previous lesson:

-   Namespaced API
-   RESTful API
-   Serves JSON
-   Consumes JSON
-   Full test coverage
-   Persists data (as long as you don't restart the server)

What we want after this lesson:

-   Data that persists to a database
-   Migrations for our data
-   Seeds for our data
-   An app that will deploy to Heroku
-   Separate test, development and production environments
-   A model like module that can be used in controllers and tests
-   A controller like module to clean up our server.js

What you'll be left to do on your own:

-   Put the *UD* in *CRUD*
-   Serve multiple resources
-   Any additional refactoring and DRYing out you'd like to do (you could refactor all day)

## Some housekeeping

If you're using git, add a .gitignore, and add `node_modules`. Since these get installed from npm, you typically don't commit them.

Rewrite your `scripts` section like the following:

```
"scripts": {
    "test": "NODE_ENV=test mocha test/*-test.js",
    "start": "nodemon server.js",
    "debug": "NODE_ENV=test mocha debug test/*-test.js"
  }
```

Install nodemon as a development dependency:

```
npm install nodemon --save-dev
```

Install knex and pg (postgres):

```
npm install knex pg --save
```

And install knex globally so we can use it on the command line:

```
npm install knex -g
```

## What is Knex?

Knex is a great library for working with many kinds of databases. It isn't a full ORM like ActiveRecord, but it includes features like data migrations and seeds, which is great for us. The documentation isn't excellent, but that's fine, because we're only going to be using one command: `.raw()`

## Setting Up the Database

Make sure Postgres is installed and running. We will prep our app by creating two databases in Postgres. Don't forget the semicolons in the the CREATE DATABASE command!

```js
$ psql
CREATE DATABASE secrets;
CREATE DATABASE secrets_test;
```

We will use a knexfile to configure our database for all of our environments. Create that file using the below command with some default values:

```
→ knex init
Created ./knexfile.js
```

### Database Configuration

This generated a really nice configuration file that we are going to tweak.

```js
module.exports = {
  development: {
    client: 'pg',
    connection:'postgres://localhost/secrets',
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
    connection:'postgres://localhost/secrets_test',
    migrations: {
      directory: './db/migrations'
    },
    seeds: {
      directory: './db/seeds/test'
    },
    useNullAsDefault: true
  },

  production: {
    client: 'pg',
    connection: process.env.DATABASE_URL,
    migrations: {
      directory: './db/migrations'
    },
    seeds: {
      directory: './db/seeds/production'
    },
    useNullAsDefault: true
  }
};
```

### Migrations

```
knex migrate:make create-secrets-table
```

This created a `migrations` directory and added a time stamped file with the name of the migration at the end. The new file should look something like this:

```js
exports.up = function(knex, Promise) {

};

exports.down = function(knex, Promise) {

};
```

For every `up` there must be an equal and opposite `down` that will allow us to rollback those changes. `up` defines what should happen when we do the migration. `down` is the reverse. If we want to roll back to a previous version, then `down` undoes whatever `up` did.

You may be used to migrations with a `change` method. `change` has an implied `down` for every `up`, but we're using the more explicit methods here.

Using SQL, we can define our secrets table. We've been using strings as ids, which you can totally do in postgres, but let's go ahead and bring integer ids back.

```js
exports.up = function(knex, Promise) {
  let createQuery = `CREATE TABLE secrets(
    id SERIAL PRIMARY KEY NOT NULL,
    message TEXT,
    created_at DATETIME
  )`;
  return knex.raw(createQuery);
};

exports.down = function(knex, Promise) {
  let dropQuery = `DROP TABLE secrets`;
  return knex.raw(dropQuery);
};
```

But, why is `Promise` passed in as a second argument? Knex is expecting that these methods return a promise of some sort. All Knex methods return a promise, so we fulfilled our end of the bargin in the example above. `Promise.all` allows you to do multiple things and return one promise. Knex passes us a reference to `Promise`, because it's not natively supported in some previous versions of Node. We're not using it at this moment, but we will in a second.

### Seeds

Seeds are some default data. This will be useful when we first start developing our application. To create our seed files, type the following in your terminal

```
knex seed:make secrets
```

This will create a `secrets.js` in the `seeds/dev` folder. They'll contain the default seed template:

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

We're going to need to modify this a bit.

```js
exports.seed = function(knex, Promise) {
  return knex.raw('TRUNCATE secrets RESTART IDENTITY')
  .then(() => {
    return Promise.all([
      knex.raw(
        'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
        ["I hate mashed potatoes", new Date]
      ),
      knex.raw(
        'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
        ["I love rap music", new Date]
      ),
      knex.raw(
        'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
        ["I hate game shows", new Date]
      )
    ]);
  });
};
```

You'll notice that I used `Promise.all` this time. It's because I wanted to do three things (i.e. insert each of my fake secrets). `Promise.all` will resolve when all three of my inserts resolve.

Also notice that `.raw()` is taking two parameters. Whenever you are passing dynamic values to a query, you want to add them as a second parameter. They will replace any `?` you have in your query in order. These values aren't technically dynamic, but it's good to just keep the same pattern that we'll be using later.

### Running the Migrations and Seeding the Database

We configured everything. Now, we just need to run our migration and seed the database.

```
knex migrate:latest
knex seed:run
```

This will run all of the migrations up to and including the most recent one. (We only have one, so this is pretty straightforward for us.) Next, we will run all the seed files under the dev directory to insert our two owners and three secrets that belong to those owners so that we have something to work with in the next step.

## Fetching From the Database

Let's create a little spike file to get our heads around knex and SQL. I love spike files. I create spike files all the time.

`database-spike.js`:

```js
const environment = process.env.NODE_ENV || 'development';
const configuration = require('./knexfile')[environment];
const database = require('knex')(configuration);

process.exit();
```

This is just enough code to get connected to postgres. A couple notes:

1.  We want to know if we're in a development, testing, or production environment. If we don't know, we'll assume we're in development.
2.  Based on that environment, we'll fetch the database configuration from `knexfile.js` for whatever environment we're in.
3.  `process.exit()` just tells node that we're done.

Go ahead and run this just to make sure your configuration is good, and you don't get any errors.

```
node database-spike.js
```

Good! Let's try to actually pull out some data. Add the following in place of the `process.exit()`

```js
  database.raw('SELECT * FROM secrets')
  .then( (data) => {
    console.log(data)
    process.exit();
  });
```

Holy Hash Batman!

If we dig around a little, we see that the data we want is in a property called `rows`. Very useful. Let's modify our console.log to output `data.rows`. Then run the spike again. Ignore the `anonymous`. I still don't know what it means, but they behave like normal objects.

Also try throwing in a `debugger;` and then run `node debug database-spike.js`. Here's a quick [intro to debugging in node](https://spin.atomicobject.com/2015/09/25/debug-node-js/)

Let's also try creating a new record. Add another query before your existing one:

```js
database.raw(
  'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
  ["fUIDsPF", "I open bananas from the wrong side", new Date]
).then( () => {
  database.raw('SELECT * FROM secrets')
  .then( (data) => {
    console.log(data.rows)
    process.exit();
  });
});
```

We've chained our promises above to ensure that the new record gets created before we query for all of our records.

## New GET Test

Let's rewrite our test for `/api/secrets/:id`

-   We need to add our database require statements to the top.
-   We need to modify our `beforeEach` to manipulate the database instead of `app.locals`.
-   Let's clear out the database when we're done.

```js
beforeEach((done) => {
  database.raw(
    'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
    ["I open bananas from the wrong side", new Date]
  ).then(() => done());
})

afterEach((done) => {
  database.raw('TRUNCATE secrets RESTART IDENTITY')
  .then(() => done());
})
```

And the test itself:

1.  Let's make the assertions more explicit. We're building a JSON API after all.
2.  We're using integer ids instead of string ids.

```js
it('should return 404 if resource is not found', (done) => {
  this.request.get('/api/secrets/10000', (error, response) => {
    if (error) { done(error) }
    assert.equal(response.statusCode, 404)
    done()
  })
})

it('should return the id and message from the resource found', (done) => {
  this.request.get('/api/secrets/1', (error, response) => {
    if (error) { done(error) }

    const id = 1
    const message = "I open bananas from the wrong side"

    let parsedSecret = JSON.parse(response.body)

    assert.equal(parsedSecret.id, id)
    assert.equal(parsedSecret.message, message)
    assert.ok(parsedSecret.created_at)
    done()
  })
})
```

Don't forget to migrate your test database. Run `knex -h` to find out how to set the environment.

## Your Turn

Rewrite the current `/api/secrets/:id` route. Use `npm`

Then we'll go over a working implementation.

## Pushing to Heroku

Now that we are all wired up with Knex in our local dev environment, it's time to look towards big and better things... the wonderful world of production. Because it doesn't matter how awesome your endpoints are if you can't show the world.

We've already done a lot of prep without even knowing it, but there are a few catchyas left to conquer. Before we can config production fully, we need to create our production app with Heroku. If you haven't already, go ahead and create an account with Heroku. Then login in your terminal:

```js
heroku login
```

To create an app with Heroku:

```js
heroku create app-name // app-name can be whatever you want as long as there isn't another app named it. If you don't give it a name Heroku will name it something super badass like misty-acorn-valleys9292
```

Then you can push your code to Heroku like so:

```js
git push heroku master // Make it a practice to only push to production from master. master is your Master. Obey it as your production overlord. Many things will be happening in your terminal but the main thing to look for is if the build succeeds or fails.
heroku open // Opens your app in a browser
```

Aaaaaaaand...... error screen. Wah wah wah. Welcome to getting things up in production. The MOST IMPORTANT thing to learn about production is reading error logs from Heroku:

```js
heroku logs
heroku logs --tail // Get the last error message
```

First step is to add a Procfile. This lets Heroku know to fire up your server.

```js
touch Procfile

// In the Procfile
web: node server.js
```

Node applications don't come with databases by default. We'll have to [manually add it to our application](https://devcenter.heroku.com/articles/heroku-postgresql#provisioning-the-add-on):

```
heroku addons:create heroku-postgresql:hobby-dev
```

In our `knexfile.js`, we set our production database to `process.env.DATABASE_URL`. You can see that we now have this environment variable set by running `heroku config`

The last step is adding some seed data, which I'll just copy from seeds/dev to seeds/production. Commit all those changes and push it up to Heroku. To migrate and seed with Heroku:

```js
heroku run 'knex migrate:latest'
heroku run 'knex seed:run'
```

It should give you some feedback that it worked. Now do heroku open and magic! You have data.

## More Your Turn

Okay cool we can get data from the database, but how do we create? Modify the test and implementation for `POST /api/secrets`.

Check this [stack overflow question](https://stackoverflow.com/questions/2944297/postgresql-function-for-last-inserted-id) for a good way to get the `id` for a newly created record

Then we'll go over a working implementation.

## Milestone

Hey! You built:

-   a RESTful API in Node
-   that uses postgres
-   and works in your 3 main environments

Not too shabby! And you've got the knowledge to add all the routes and tables you like. But, things may start getting out of control soon. How big should your `server.js` really be anyway?

## Faux Models and Controllers

Let's do some refactoring. Right now our implementation has a couple problems:

-   Our code is hard to read.
-   Our methods are doing too much, in tests and in server.js
-   We're repeating ourselves with this SQL

We don't need a framework to have well organized code!! Let's create some folders and some modules!

## Faux Models

Take 3 minutes to answer the following questions with a partner:

-   What that we have written should live in a model?
-   How could you extract that code in to a function or functions?
-   If you had to extract this code to another file, what questions would you have?

Let's start by extracting SQL out of our test hooks (`beforeEach` & `afterEach`). We'll just create some global functions at the top of our application to start.

```js
function makeSecret() {
  return database.raw(
    'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
    ["I open bananas from the wrong side", new Date]
  )
}

function emptySecretsTable() {
  return database.raw('TRUNCATE secrets RESTART IDENTITY')
}

...

beforeEach((done) => {
  makeSecret()
  .then(() => done())
})

afterEach((done) => {
  emptySecretsTable()
  .then(() => done())
})

```

Promises can be passed around as parameters and return values. Since our functions return our knex promises, you can chain `.then()` right on to the end of them.

`makeSecret` works great for this use case, but let's see if we can write something a little more flexible:

```js
function createSecret(message) {
  return database.raw(
    'INSERT INTO secrets (message, created_at) VALUES (?, ?)',
    [message, new Date]
  )
}

...

beforeEach((done) => {
  createSecret("I open bananas from the wrong side")
  .then(() => done())
})
```

Great! Now we just need to put this code somewhere else. Create a `/lib/models` folder and a `secret.js` file inside. Move our two new functions into this file, along with our three configuration lines that we use to connect to the database. Check your relative paths when you do.

We're really close to being able to run our tests again. We need to export our functions. Add this to the bottom of our new model file:

```js
module.exports = {
  create: createSecret,
  destroyAll: emptySecretsTable
}
```

As long as we're refactoring, you can rename the functions, or even define them in the exports object, but we've at least moved our SQL out of our test file.

Last step is to use this new module and it's functions in our test file. Add a new require to the top, and rewrite our hooks as such:

```js
const Secret = require('../lib/models/secret')

...

beforeEach((done) => {
  Secret.create()
  .then(() => done())
})

afterEach((done) => {
  Secret.destroyAll()
  .then(() => done())
})
```

### Your Turn

-   Can you extract the rest of the SQL from your tests and `server.js`?
-   Can you use promise chaining to extract the `rows` property from in model?
-   Can you do the same to extract a single resource for your `.find` method?

## Faux Controller

Our `server.js` is getting bulky. Could we get it to behave more like a `routes.rb` file from Rails?

Take 3 minutes and discuss with a partner:

-   What code from our `server.js` looks like it might belong in a controller?
-   How could you extract that code in to a function or functions?
-   If you had to extract this code to another file, what questions would you have?

### Your Turn

Given that the second parameter of your `.get()` and `.post()` methods are just functions, try to extract them to a module in `lib/controllers`. Then require and reference them in `server.js`

## Related Resources

Most databases and their counterpart APIs have more than one resource. And there are almost always relationships between those resources. Now that we've taken away your `has_many` and `belongs_to`. How would you add these related resources?

Some things to consider:

-   Although they aren't necessary, postgres (and most relational databases) have explicit foreign key designations. If you're gonna do it right, these should be added to your migrations.
-   Don't try to build `has_many` and `belongs_to`. Not right off the bat at least.
-   Feel free to play around with `JOIN` statements in your spike file to remember how they work.
-   We haven't been using classes, so there's no instance of a `Secret`. Only functions. It's like a class with only class methods. Ultimately, classes are the way to go, but could you serve related resources with only functions?
