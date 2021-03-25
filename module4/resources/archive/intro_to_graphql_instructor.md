---
title: Intro to GraphQL
tags: api, graphql
---

## Materials

- 1 marker per student
- 1 sheet of printer paper per student
- Slide deck
- White boards around room (for Why GraphQL? activity)
- Posters (for closing activity)
- Print outs of each situation - probably 3 of each (for closing activity)

## Learning Goals

- Explain what GraphQL is and the benefits of using it over REST
- Write an Express/GraphQL server
- Interact with a GraphQL API using GraphiQL

[Slides](./intro_to_graphql_slides)

## Vocab
- Graph
- GraphQL
- REST, RESTful APIS

## Warmup

Write your answer to the following:
- Why do we use APIs?
- What makes an API RESTful?
- Why do we commonly see `/api/v1/` included in RESTful API endpoints?

## Why GraphQL? ACTIVITY

Let's say we are building LinkedIn for Puppies. Each puppy-user would have a name, company, title, education, favorite treat, parent names, and best friends.

- With a partner, whiteboard the JSON response from `api/v1/puppy/:id`.
- Class should come back together and discuss very quickly.
- Instructor needs to give directions to facilitate the following:
- Each person should have a sheet of paper with one puppy-user attribute written on it. (Instructor will need to assign so we don't overlap. Make sure you have something like `company` - where we'd get an ID back then need to make another request)
- The class needs to group together like a big JSON object.
- Once the group is together like a JSON object on one side of the room, instructor is on other side of the room.
  - Over-Fetching: Instructor says: I need the puppy-user name - what are you going to send me, server? (The whole group should walk over together.) Well, I didn't want all of you, but I guess I can just weed the rest of you out. I need the puppy-user name and favorite toys. What are you going to send me? (The whole group should walk over.) I didn't want everyone!STAMP the idea: We are currently OVER-FETCHING. Only want one thing but get a bunch back.
  - Under-Fetching: Instructor says: Now I need the name and location of the company that the pet works at. What are you going to do server? (I get the whole JSON object, including the companyId). Now I have to make another request to get all the companies info. STAMP the idea: We are currently UNDER-FETCHING, making a request to the restful API, get a company id, and now have to go back out to another endpoint and ask for it. Ugh.
- Now that you have explain and illustrated the ideas of under and over fetching, have a turn-and-talk where students have to say these things back to each other (there is a slide for this).

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

- Show images of REST visualization, vs GraphQL visualization, and an example query.


## Building a GraphQL Server

To get started, clone down [this repo](https://github.com/ameseee/graphql-pets) and follow the directions on the README.

### Familiarize yourself with the boilerplate code

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

Try adding a pet in GraphiQL. Think about how your mutation request might need to be different from a query. If you're stuck on this - [read this blog](https://hackernoon.com/mutations-in-graphql-9ac6a28202a2). If you run into errors - read carefully as they are usually quite helpful.

**On your own,** write the mutations to editPet and deletePet. Test out in GraphiQL.

### Refactoring

The schema file is getting a little lengthy - can you pull each type, the RootQuery, and the mutation out into their own files and maintain functionality?

## Complete GraphQL Server

Congrats, you've written your first GraphQL server and tested it out in GraphiQL! You can see it takes a bit of setup, but the long term benefits are something many companies seeing are very much worth it.


## Closing Activity

Split the class into three groups (or more), each group gets one topic and 6-8 minutes to plan a pitch and poster/whiteboard to use as a visual.

Once time is up, have each group present their pitch!

### Making the case for GraphQL

Your manager is thinking about moving to GraphQL. Whatever you think about it in real life today, in this situation, you are on a mission to convince her that your company should move to it.

What's your pitch?

### Prevent Disaster

Your manager is thinking about moving to GraphQL. Whatever you think about it in real life today, in this situation, you are on a mission to make sure this horrible decision is not make because REST is the best.

What's your pitch?

### Educator

Your manager is thinking about moving to GraphQL. It's so much of a buzzword that it seems like some people on your team are all excited about it for that reason only.

Your job is to educate the team on what the purpose and benefits of GraphQL are, and how this compares to REST.
