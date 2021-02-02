---
layout: page
title: Testing Graphql with Jest and Supertest
---

## Learning Goals
- Understand how to set-up Jest & Supertest in an Express app and test GraphQL endpoints.
- Understand a bit more about Crates architecture.

## Warm Up
- What are the steps necessary to writing a good test?
- What are some differences between GraphQL and REST?
- Are there any parallels that can be drawn between an express/Node application and a Rails application?

## Setting up a Test DB

- In Rails, we have `RAILS_ENV` which allows us to execute code in specific environments, similarly, Node has `NODE_ENV`. When we are running our specs we need to make sure that we are running against a `TEST` database, and not our `development` or `production` database. So, let's get started:
```
$ cd <path_to_crate>
$ git checkout -b <a_new_testing_branch>
```
If you `cd` into the `crate/code/api/src/config` directory, you will notice a few files that configure our express application. The one we are interested in at this point is `database.json`. If you open up that file, you should see:
```js
{
  "development": {
    "username": "postgres",
      "password": null,
      "database": "crate",
      "host": "127.0.0.1",
      "dialect": "postgres",
      "seederStorage": "sequelize"
  },
    "production": {
      "username": "postgres",
      "password": null,
      "database": "crate",
      "host": "127.0.0.1",
      "dialect": "postgres",
      "seederStorage": "sequelize"
    }
}
```
This file is where we setup our `development` and `production` databases; however, since Crate has no tests, we don't have a block for our `test` ENV. This can be problematic if we have specs that modify or delete data, since we don't want to touch or modify our development database. So, let's add another block:
```js
{
  "development": {
    "username": "postgres",
      "password": null,
      "database": "crate",
      "host": "127.0.0.1",
      "dialect": "postgres",
      "seederStorage": "sequelize"
  },
  "test": {
    "username": "postgres",
      "password": null,
      "database": "crate_testing", <== Note: This needs to be a different name than our development or production database, otherwise psql will get confused.
      "host": "127.0.0.1",
      "dialect": "postgres",
      "seederStorage": "sequelize"
  },
    "production": {
      "username": "postgres",
      "password": null,
      "database": "crate",
      "host": "127.0.0.1",
      "dialect": "postgres",
      "seederStorage": "sequelize"
    }
}
```
Now that we have a test configuration in our `database.json`, let's create the database:
```bash
$ psql
psql (13.1)
Type "help" for help.

<YOUR_NAME_OR_POSTGRES_USER_NAME>=# CREATE DATABASE crate_testing;
CREATE DATABASE
\l; # <= Check to make sure the DB was created
<A LIST OF DATABSES>
\q # <= Quit psql
```
Great! Now we have a test db, so let's add some data to it:

```bash
$ NODE_ENV=test npm setup:db
```
If we look at our `package.json` file, we will notice a `scripts` block. You can think of these like `Rake` commands. So, anything in here we can run via `npm`. Now that we have migrated our test db and added some data to it, we should make sure it worked:
```bash
$ psql crate_testing
<crate_testing>=# SELECT * FROM USERS;
<...SOME USER DATA...>
```
Great, we now have a test database and seeded some data to use in our tests. Note: This may be a slightly different workflow than say a Rails App, where we create/destroy data per test, but for now, this will get us up and running!


## Setting up Jest and Supertest
In Rails, we have RSpec--or less often, MiniTest--, in Node we have...lots of options; for this lesson, we are going to use Jest for our testing library, as well as Supertest, which allows us to mock our server. So, let's get started.

```bash
$ npm install --save-dev jest
$ npm install --save-dev supertest
```
Here, the `save-dev` flag puts these libraries into our development dependencies; that is, they won't be compiled and added to our production JS build. We can see this in our `package.json` file:
```js
 ...,
  "devDependencies": {
    "@babel/cli": "7.11.6",
    "@babel/core": "7.11.6",
    "@babel/node": "7.10.5",
    "@babel/plugin-transform-runtime": "7.11.5",
    "@babel/preset-env": "7.11.5",
    "jest": "^26.6.3",
    "nodemon": "2.0.4",
    "supertest": "^6.0.1"
  },
 ...
```
Alright, now we have our testing libraries installed, so let's write a test! In Node applications, you will traditionally see specs nested within the actual code directories themselves, as opposed to a seperated directory like `spec` in Rails. This is all up to you on how you want to structure your spec files, but for this exercise, lets add them directly to our code. Our file structure will end up looking like this:
```
 code
  | api
    | src
      | modules
        | <module_name>
          | tests
            | our tests
```
Jest will look for any file that ends with `.test.js`, so we can begin with our User model and test there.

```
 $ cd code/api/src/modules/user
 $ mkdir tests
 $ cd tests
 $ touch query.test.js
```
Open that file and we will write a spec for our `getAll` users query.

