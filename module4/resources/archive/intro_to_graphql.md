---
title: Intro to GraphQL
tags: api, graphql
---

## Learning Goals

- Explain what GraphQL is and the benefits of using it over REST
- Write an Express/GraphQL server
- Interact with a GraphQL API using GraphiQL

[Slides](./intro_to_graphql_slides)

## Warmup

Write your answer to the following:
- Why do we use APIs?
- What makes an API RESTful?
- Why do we commonly see `/api/v1/` included in RESTful API endpoints?

## Why GraphQL?

Let's say we are building LinkedIn for Puppies. Each puppy-user would have a name, company, title, education, favorite treat, parent names, and best friends.

With a partner, whiteboard the JSON response from `api/v1/puppy/:id`.

Considering this response (and we can pretty easily imagine what the JSON response for `api/v1/puppy-users` would look like),
- What would a developer need to do to access a list of all the puppy names?
- What would a developer need to do to access a list of puppies, and the name of their company (assuming that's a property on the company)?
- What _isn't ideal_ about both of these situations?

### Disadvantages to REST

- Deciding on URL schema gets tough with heavily nested relationships
- Sometimes it takes too many HTTP requests to get the data we need
- It's common to over-fetch data (getting everything back when we only needed one property)

The second and third bullets especially cause problems as over 60% of internet users are on mobile devices.

### Another Solution - GraphQL

When Facebook was re-building their native mobile applications in 2012, they ran into some problems - server queries written didn't match what they wanted in their apps, and there was a considerable amount of code needed to parse data had to be written on both server and client side. So, they invented GraphQL. In 2015, Facebook released it to the public.

Some of it's features:
* Defines a data shape
* Hierarchical
* Strongly Typed
* Protocol, not storage
* Introspective
* Version free

Read more on these [here](https://code.fb.com/core-data/graphql-a-data-query-language/).

## LinkedIn for Pets APIs

The Rest API could be visualized with something like this:
![inline](/assets/images/lessons/intro_to_graphql/rest_diagram.png)

The Graph for this data would look something like this:
![inline](/assets/images/lessons/intro_to_graphql/graph_diagram.png)

This is the query (and response) that we would have to write in GraphQL!
![inline](/assets/images/lessons/intro_to_graphql/query.png)


## Building a GraphQL Server

To get started, clone down [this repo](https://github.com/ameseee/graphql-pets) and follow the directions on the README.

### Familiarize yourself with the boilerplate code & servers

- What do you have in localhost:3000? 4000? Are you clear on where those are coming from? If not (yet), that's ok.
- First, investigate the dependencies in the `package.json` - what has been installed, and what job do you think each dependency has?
- As mentioned in the README of the repo, a JSON DB is being used to avoid time spent on setting up databases on machines for this lesson. Take a look at `db.json` to familiarize yourself with our initial data.
- Now, let's take a look at `server.js` - this is an Express server built _with_ GraphQL, so you'll still see some of the things you're familiar with!
- Lastly, let's check out `schema.js` - this file is where we will be doing all our work today.
- Now, are you clear on what you have in localhost:3000 and 400 and where those are coming from?

### Building our Schema - Root Query

We know a little bit about what the `graph` looks like - but where is the starting point? The cool thing about GraphQL is, we get to decide what we want out starting point(s) to be. The purpose of a Root Query is to jump and land on a very specific piece of data in the graph.

In `schema.js`, create a `RootQuery` object:

```js
const RootQuery = new GraphQLObjectType({

});
```

The GraphQLObjectType has two required properties:
- `name` - will always be a string that describes the type being defined. By convention, we would use 'Pet' here (notice the capital P)
- `fields` - an object that tells GraphQL about all of the properties on this type. For a RootQuery,

```js
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',   // name is a required property
  fields: {                // fields is a required property

  }
});
```

Let's start by building a Root Query for a specific pet, so someone can jump into the graph and land right on a specific pet's data.

```js
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields: {
    pet: {                                // an object
      type: PetType,                      // indicating the type of object that will be given back
      args: { id: { type: GraphQLString }}// expects an argument of ID
    }
  }
});
```

We've _almost_ instructed GraphQL that it can jump into the graph and get a pet's data. Everything we've written up until now tells us what the data looks like, but we need to DO something with it. The last required property on our pet field is the `resolve` function and it does the magic:

```js
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields: {
    pet: {
          type: PetType,
          args: { id: { type: GraphQLString } },
          resolve(parentValue, args) {
            return axios.get(`http://localhost:3000/pets/${args.id}`)
              .then(response => response.data);
          }
    }
  }
});
```

In the code above, we are using the id property from `args` which was whatever argument was passed in the request; in this case, the ID. We are making an HTTP request to our JSON database to that endpoint, then cleaning with with `response.data`.

**On your own,** add a `company` field on the RootQuery.


### Building our Schema - Types

Let's start by instructing GraphQL about what our Pet and Company data will look like, by building Object Types.

In `schema.js`, create a `PetType` object:

```js
const PetType = new GraphQLObjectType({

});
```

The GraphQLObjectType has two required properties:
- `name` - string that describes the type
- `fields` - an object that tells GraphQL about all of the properties on this type. Keys are names of properties, and values should indicate what type of data the properties hold.

```js
const PetType = new GraphQLObjectType({
  name: 'Pet',
  fields: () => ({
    id: { type: GraphQLString },
    firstName: { type: GraphQLString },
    age: { type: GraphQLInt }
  })
});
```

**On your own** build out the `CompanyType` - reference the `db.json` to find out what properties it should have.

### What about the Pet-Company Relationship?

As of now, pets don't know about companies and companies don't know about pets - we have not told our schema anything about their relationship. We treat associations exactly like any other field, with a type:

```js
const PetType = new GraphQLObjectType({
  name: 'Pet',
  fields: () => ({
    id: { type: GraphQLString },
    firstName: { type: GraphQLString },
    age: { type: GraphQLInt },
    company: { type: CompanyType }  // add in the name of field and type
  })
});
```

..but we **also** need to define a resolve function, so GraphQL knows how to find the company that is associated with a given pet.

```js
const PetType = new GraphQLObjectType({
  name: 'Pet',
  fields: () => ({
    id: { type: GraphQLString },
    firstName: { type: GraphQLString },
    age: { type: GraphQLInt },
    company: {            // company !== companyId which our model has - why we need to resolve
      type: CompanyType,  // expecting a CompanyType when we get the data back
      resolve(parentValue, args) {
        return axios.get(`http://localhost:3000/companies/${parentValue.companyId}`)
          .then(response => response.data);
      }
    }  
  })
});
```

Not sure what `parentValue` is giving us or where it comes from? Do some console.logging to figure it out! (Remember, the console.log will only trigger if this resolve function is called, so you need to make a nested query in GraphiQL for a users' company).

At this point, we should be able to go to GraphiQL and make a query. Make sure you've run `npm run dev` and visit `http://localhost:4000/graphql`.

A possible query:

```
{
  pet(id:"2") {
    firstName
  }
}
```

Did you get the following error?

```
{
  "errors": [
    {
      "message": "Query root type must be provided."
    }
  ]
}
```

What are we missing? We haven't told the schema that we are exporting to include the RootQuery. At the bottom of the file, add:

```js
module.exports = new GraphQLSchema({
  query: RootQuery
});
```

Now, press the play button in GraphiQL and you should get a response. Play around with different sets of data that you ask for!

**On your own,** make sure the CompanyType knows about it's association with pets. Back to GraphiQL - make sure you can start at both pet and company, and can access information about all the pets from one company, etc.

### Mutations - the rest of CRUD

Now that we are successfully querying what we already have in our database, how do we add, delete, and change records? We will use `mutations` for all of these operations.

Let's start by creating a new GraphQLObjectType:

```js
const mutation = new GraphQLObjectType({

});
```

As we've seen in the RootQuery and Types, the required properties are `name` and `fields`:

```js
const mutation = new GraphQLObjectType({
  name: 'Mutation',
  fields: {

  }
});
```

Each field will be our actions - let's start with `addPet` to post a new pet to the database. It will have a type, args, and resolve function. The following is not complete, but will get you started:

```js
const mutation = new GraphQLObjectType({
  name: 'Mutation',
  fields: {
    addPet: {
      type: PetType,
      args: {
        firstName: , // indicate what type of argument is expected
        age: ,       // indicate what type of argument is expected
        companyId: , // indicate what type of argument is expected
      },
      resolve(parentValue, args) {
        // make a post request with axios
      }
    }
  }
});
```

How can we require all of these arguments? Let's create a new GraphQLNonNull object when we declare the types of arguments:

```js
args: {
  firstName: { type: new GraphQLNonNull(GraphQLString) },
  age: { type: new GraphQLNonNull(GraphQLInt) },
  companyId: { type: GraphQLString }
},
```

And lastly, your resolve should look like:

```js
resolve(parentValue, { firstName, age, companyId }) {
  return axios.post(`http://localhost:3000/pets`, { firstName, age, companyId })
    .then(response => response.data);
}
```

NOTE: Make sure you understand why we didn't use the parameter name `args` and how we got access to those firstName, age, and companyId variables.

Before you can test this out in GraphiQL, we have to export the mutation!

```js
module.exports = new GraphQLSchema({
  query: RootQuery,
  mutation
});
```


In GraphiQl, make a mutation query with something like this:

```
mutation {
  addPet(firstName: "Buddy", age: 10) {
    id
  }
}
```

Try adding a pet in GraphiQL. Think about how your mutation request might need to be different from a query. If you're stuck on this - [read this blog](https://hackernoon.com/mutations-in-graphql-9ac6a28202a2). If you run into errors - read carefully as they are usually quite helpful.

**On your own,** write the mutations to editPet and deletePet. Test out in GraphiQL.

### Refactoring

The schema file is getting a little lengthy - can you pull each type, the RootQuery, and the mutation out into their own files and maintain functionality?

## Complete GraphQL Server

Congrats, you've written your first GraphQL server and tested it out in GraphiQL! You can see it takes a bit of setup, but the long term benefits are something many companies seeing are very much worth it.

## Wrap Up Activity 

Your instructor will assign to you to small group and an "opinion" to pitch. Spend the alotted time to make a poster and develop a pitch you will give you to your engineering team. 

Instructor - see [the instructor guide](http://backend.turing.edu/module4/lessons/intro_to_graphql_instructor) for specific directions.

