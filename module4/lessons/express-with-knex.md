---
title: "Express with Knex"
length: 1.5 hours
tags: node, express, knex, database, SQL, http
---

### Pre-reqs

* Download Postgresql with `brew install postgres`
* Clone down the Monstertorium repo (this is a completed lesson from earlier)
  * `git clone https://github.com/turingschool/mostertorium`

### Goals

By the end of this lesson, you will:

* Understand how to create database migrations and seed files using knex
* Understand how to create, retrieve, update and delete data within a database using knex

## What is Knex?

Straight from the docs: Knex.js is a "batteries included" SQL query builder for Postgres, MSSQL, MySQL, MariaDB, SQLite3, and Oracle designed to be flexible, portable, and fun to use. It features both traditional node style callbacks as well as a promise interface for cleaner async flow control, a stream interface, full featured query and schema builders, transaction support (with savepoints), connection pooling and standardized responses between different query clients and dialects.

What Knex really is is Javascript instead of raw SQL.

## Setting Up the Database

Make sure Postgres is installed and running. We will prep our app by creating two databases in Postgres. Don't forget the semicolons in the the CREATE DATABASE command!

```js
$ psql
CREATE DATABASE monsters;
CREATE DATABASE monsters_test;
```

Install knex and pg (postgres) from npm:

```
$ npm install knex pg --save
```

And install knex globally so we can use it on the command line:

```
$ npm install knex -g
```

We will use a knexfile to configure our database for all of our environments. Create that file using the below command with some default values:

```
$ knex init
Created ./knexfile.js
```

### Database Configuration

This generated a really nice configuration file that we are going to tweak. First we will change our development environment to use Postgres instead of mySql. This allows us to use the same database across all environments which is good practice. We also want to set our migration and seed directory for each environment.

```js
module.exports = {
  development: {
    client: 'pg',
    connection:'postgres://localhost/monsters',
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
    connection:'postgres://localhost/monsters_test',
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
$ knex migrate:make initial
```

This created a `migrations` directory at the root of the project and added a time stamped file with the name of the migration at the end. The `initial` part is totally arbitrary, it could be anything, but it should be something descriptive. If you're creating a migration that adds an "name" column to the "monsters" table, you probably want to go with something along the lines of `add-name-to-monsters-table`.

The file should look something like this:

```js
exports.up = function(knex, Promise) {

};

exports.down = function(knex, Promise) {

};
```

Migrations are kind of like version control for databases. For every `up` there must be an equal and opposite `down` that will allow us to rollback those changes. `up` defines what should happen when we do the migration. `down` is the reverse. If we want to roll back to a previous version, then `down` undoes whatever `up` did. Rails gives you a `change` which implies a down from an up, but knex just makes you do the work.

I edited the migration to create a monsters table.

```js
exports.up = function(knex, Promise) {
  return Promise.all([
    knex.schema.createTable('monsters', function(table) {
      table.increments('id').primary();
      table.string('name');
      table.integer('level');

      table.timestamps();
    })
  ])
};

exports.down = function(knex, Promise) {
  return Promise.all([
    knex.schema.dropTable('monsters')
  ])
};
```

But, why is `Promise` passed in as a second argument? Knex is expecting that these methods return a promise of some sort. All Knex methods return a promise, so we fulfilled our end of the bargin in the example above. Our schema is simple, and we only have one table, but this is not usually the case. `Promise.all` allows you to do multiple things and return one promise. Knex passes us a reference to `Promise`, because it's not natively supported in some previous versions of Node. We're not using it at this moment, but we will in a second.

### Seeds

Seeds are some default data. This will be useful when we first start developing our application. To create our seed files, type the following in your terminal

```
$ knex seed:make monsters
```

This will create a `monsters.js` in the `seeds/dev` folder. They'll contain the default seed template:

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

We're going to need to modify this a bit for our two files.

For monsters.js:

```js
exports.seed = function(knex, Promise) {
  return knex('monsters').del()
  .then(() => {
    return Promise.all([
      knex('monsters').insert({
        id: 1,
        name: 'Alex Tideman',
        created_at: new Date
      }),
      knex('monsters').insert({
        id: 2,
        name: 'Bob Barker',
        created_at: new Date
      }),
      knex('monsters').insert({
        id: 3,
        name: 'Martha Stewart',
        created_at: new Date
      })
    ]);
  });
};

```
You'll notice that I used `Promise.all` this time. It's because I wanted to do three things (i.e. insert each of my monsters). `Promise.all` will resolve when all three of my inserts resolve.

### Running the Migrations and Seeding the Database

We configured everything. Now, we just need to run our migration and seed the database.

```
$ knex migrate:latest
$ knex migrate:latest --env test
$ knex seed:run
```

This will run all of the migrations up to and including the most recent one for both dev and test. Next, we will run all the seed files under the dev directory to insert our three monsters to development. We don't want this data in our test table, however, since we'll be creating the data we need in our tests.

## Fetching From the Database

Naturally, we'll need to rewrite our test before we can write an implementation. Add the following to the top of your test file:

```js
const environment = process.env.NODE_ENV || 'test';
const configuration = require('../knexfile')[environment];
const database = require('knex')(configuration);
```

Then, lets write our `beforeEach()` and `afterEach()` hooks inside our get test:

```js
  let monster = { id: 1, name: 'Steve', level: 2 , created_at: null, updated_at: null}

  beforeEach(() => {
    return database('monsters').insert(monster)
  });

  afterEach(() => {
    return database('monsters').del()
  });
```

Remember that knex methods always return a promise. Mocha has a couple ways to deal with asynchronous code, and one of them is to return a promise. So we throw a `return` in front of each to ensure that Mocha will wait for them to resolve.

In order to run the tests, set the `NODE_ENV` to `test` so that both the server and test file run in the correct environment.

Let's make it work. In your server.js:

```js
// This is very slightly different because knexfile is in a different relative location
const environment = process.env.NODE_ENV || 'development';
const configuration = require('./knexfile')[environment];
const database = require('knex')(configuration);

...
// Modify your get request to use the database instead
app.get('/api/v1/monsters', (request, response) => {
  database('monsters').select()
    .then(function(monsters) {
      response.status(200).json({monsters: monsters});
    })
    .catch(function(error) {
      console.error('somethings wrong with db')
    });
})
```

There are a few things going on in the code above.

1. We want to know if we're in a development, testing, or production environment. If we don't know, we'll assume we're in development.
2. Based on that environment, we'll fetch the database configuration from `knexfile.js` for whatever environment we're in.
3. Finally, we'll ask the database for everything in the `monsters` table and serve it as JSON to our `api/v1/monsters` endpoint.

If you run `npm start`, you should see our three monsters when you visit /api/v1/monsters.

Great! We can get data from the database, but how do we create and edit and delete?? First, our test:

```js
describe('POST /api/v1/monsters', () => {

  beforeEach(() => {
    return database('monsters').del()
  });

  it('should create a new monster', (done) => {
    const monster = { name: 'Steve', level: 2 };

    request(app)
      .post('/api/v1/monsters')
      .send({ monster: monster })
      .expect(201)
      .end(() => {
        database('monsters').where(monster).then((monsters) => {
          assert.equal(monsters.length, 1);
          done();
        })
      });
  });
});
```

I really only had to change the `beforeEach` and find the new monster in the database after the request completes.

And the implementation:

```js
app.post('/api/v1/monsters', (request, response) => {
  const monster = request.body.monster;

  database('monsters').returning('*').insert(monster)
    .then(function(new_monster) {
      response.status(201).json(new_monster);
    })
    .catch(function(error) {
      console.error(error)
    })
});
```

### Your turn (10 minutes)
Implement a PUT and DELETE route for a monster

### Pushing to Heroku
Now that we are all wired up with Knex in our local dev environment, it's time to look towards big and better things... the wonderful world of production. Because it doesn't matter how awesome your endpoints are if you can't show the world.

We've already done a lot of prep without even knowing it, but there are a few catchyas left to conquer. Before we can config production fully, we need to create our production app with Heroku.

To create an app with Heroku:

```
$ heroku create app-name
```

Then you can push your code to Heroku like so:

```
$ git push heroku master
$ heroku open
```

Aaaaaaaand...... error screen. Wah wah wah. So let's look at the logs:

```
$ heroku logs --tail
```

First step is to add a Procfile. This lets Heroku know to fire up your server.

```
$ touch Procfile

# In the Procfile
web: node server.js
```

Next up is adding the Postgres add-on in Heroku. After you add this, you will also get an environment variable for the database URL.

![heroku postgres][heroku-postgres]
![heroku database url][heroku-database-url]

[heroku-postgres]: /assets/images/lessons/express-with-knex/heroku-postgres.png
[heroku-database-url]: /assets/images/lessons/express-with-knex/heroku-database-url.png


Now we want to make sure our knexfile has this environment variable for production. You also need to add ?ssl=true at the end of the URL:

```js
  production: {
    client: 'pg',
    connection: process.env.DATABASE_URL + `?ssl=true`,
    migrations: {
      directory: './db/migrations'
    },
    seeds: {
      directory: './db/seeds/production'
    },
    useNullAsDefault: true
  }
```

Now our production code knows where to look to grab production data. The last step is adding some seed data, which I'll just copy from seeds/dev to seeds/production. **Commit all those changes and push it up to Heroku.**

Now, migrate with Heroku:

```
$ heroku run knex migrate:latest
```

If you don't yet have a production seed file, create one. Then, seed with Heroku:

```
$ heroku run knex seed:run
```

It should give you some feedback that it worked. Now run `heroku open` and you have data!


## Relationships

This is great for single table apps, but let's add some complication to the schema, and see how that would work. Let's say each Monster has a Trainer. Let's walk through:

1. Creating a migration for the Trainer
2. Adding some seed data for the trainer
3. Writing a test for the `GET` route

And then you can implement the route in `server.js`

### 0. Diagram

Take a minute to draw out our tables, so we know what changes we need to make

### 1. Migration

We need to create a `trainers` table, but we also need to modify the `monsters` table.

```
$ knex migrate:make add_trainers
```

```js
exports.up = function(knex, Promise) {
  return Promise.all([
    knex.schema.createTable('trainers', function(table) {
      table.increments('id').primary();
      table.string('name');
      table.string('team');

      table.timestamps();
    }),
    knex.schema.table('monsters', function(table) {
      table.integer('trainer_id')
       .references('id')
       .inTable('trainers');
    })
  ]);
};

exports.down = function(knex, Promise) {
  return Promise.all([
    knex.schema.dropTable('trainers'),
    knex.schema.table('monsters', function(table) {
      table.dropColumn('trainer_id');
    })
  ]);
};
```

```
$ knex migrate:latest
$ knex migrate:latest --env test
```

### 2. Seed

```
$ knex seed:make trainers
```

```js
exports.seed = function(knex, Promise) {
  return knex('trainers').del()
  .then(() => {
    return Promise.all([
      knex('trainers').insert({
        id: 1,
        name: 'Ash Ketchum',
        team: 'Yellow'
        created_at: new Date
      }),
      knex('monsters').insert({
        id: 2,
        name: 'Misty',
        team: 'Blue',
        created_at: new Date
      }),
      knex('monsters').insert({
        id: 3,
        name: 'Brock',
        team: 'Rocket'
        created_at: new Date
      })
    ]);
  });
};
```

```
$ knex seed:run
```

And don't forget to add `trainer_id`s to your `monsters` seed file.

### 3. The Test

We want to create a route where you can get all of the monsters for a given trainer. So the route will be `GET /api/v1/trainers/:id/monsters`

```js
describe('GET /api/v1/trainers/:id/monsters', () => {

  let trainer = { id: 1, name: 'Ash' }
  let monster = { id: 1, name: 'Steve', level: 2, trainer_id: 1, created_at: null, updated_at: null}

  beforeEach(() => {
    return Promise.all([
      database('trainers').insert(trainer),
      database('monsters').insert(monster)
    ]);
  });

  afterEach(() => {
    return Promise.all([
      database('monsters').del(),
      database('trainers').del()
    ]);
  });

  it('should return a 200 status code', (done) => {
    request(app)
      .get('/api/v1/monsters')
      .expect(200, done);
  });

  it('should return a set monsters associated with the first trainer', (done) => {
    request(app)
      .get('/api/v1/trainers/1/monsters')
      .expect(200, {monsters: [monster]}, done);
    })

});

```

### 4. Make the test pass

Catch them all! The tests! And by catch, I mean pass!!

### 5. Deploy

Go through the steps to deploy your changes to production, and manually test the routes.
