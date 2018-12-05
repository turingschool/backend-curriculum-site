# Building an Express App

---

# What is Knex

* SQL query builder

---

# Create Your Database

```js
$ psql
CREATE DATABASE publications;
\q
```

---

# Setting Up

```
mkdir publications
cd publications
npm init --yes
npm install knex -g
npm install knex --save
npm install pg --save
```

---

# Create Database Config

```
→ knex init
Created ./knexfile.js
```

---

# Configuring the Database

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

---

# Making a Migration

```
knex migrate:make initial
```

---

# In the Migration File

```js
exports.up = function(knex, Promise) {

};

exports.down = function(knex, Promise) {

};
```

* Up vs. Down
* See lesson plan for file contents

---

# Running Your Migrations

`knex migrate:latest`

---

# Create Another Migration

`knex migrate:make add-publisher`

---

# Update the Migration

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

---

# Seeds

* Configure the directory in your `.knexfile.js`.
* Make a Seed file
* Populate the seed file
* Run your seeds

---

# Setting Up Your Server

See database for starting `server.js` file.

* What do you notice in the `server.js` file?
* What do you think each piece does?

---

# Retrieving Data from the Database

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

* Check the response in Postman

---

# Rolling Back

```bash
knex migrate:rollback
```

---

# On Your Own

Write a GET request to retrieve all footnotes. Verify it works using Postman.

---

# Adding Data to the Database

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

---

# On Your Own

Write a POST request to add a new footnote that belongs to a pre-existing paper. Verify it works with Postman.

---

# Querying Data for a specific Resource

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

---

# On Your Own

Write a GET request to retrieve all footnotes for a pre-existing paper. Verify it works with Postman.
