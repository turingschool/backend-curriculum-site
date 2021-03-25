# Pets GraphQL Walkthrough Queries

### Creating the Schema

The schema is going to hold the instructions for how we interact with our data. We start by defining the _types_ of objects that we will be returning and then the _RootQuery_. The _RootQuery_ is the entry point for a query request and will hold the directions for how to _resolve_ the request.

Start by making the schema file.

`touch lib/schema/schema.js`

Next require the `graphql` package at the top of our file, so that we can use it to define our object types that we will be using.

```javascript
const graphql = require('graphql');
```

Let's start by defining the `PetType`.

```javascript
const PetType = new GraphQLObjectType({
  name: 'Pet',
  fields: () => ({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    animal_type: {type: GraphQLString},
    breed: {type: GraphQLString},
    age: {type: GraphQLInt},
    favorite_treat: {type: GraphQLString}
  })
});
```

We will need to require the `GraphQL` datatypes from `graphql`, so let's update our schema file. It should now look like this:

```javascript
const graphql = require('graphql');
const {
  GraphQLObjectType,
  GraphQLString,
  GraphQLID,
  GraphQLInt
} = graphql;

const PetType = new GraphQLObjectType({
  name: 'Pet',
  //It is important that the fields is a function when we add our relationship later.
  fields: () => ({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    animal_type: {type: GraphQLString},
    breed: {type: GraphQLString},
    age: {type: GraphQLInt},
    favorite_treat: {type: GraphQLString}
  })
});
```

We've defined the `PetType` which is telling our user what type of information that they can ask for, but we have yet to give them a way to ask for it. Let's do that next. We will write a query to return all our pets.

```javascript
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields:{
    pets: {
      type: new GraphQLList(PetType),
      resolve(parent, args){
        return database('pets').select()
      }
    },
  }
})
```

We are using another `GraphQL` datatype so we will want to add it to our list at the top of the page. `GraphQLList` will return for us a list of graphql objects. Also, since we are using our database to get back information we will also need to add that connection too. Our schema file should now look like this:

```javascript
const environment = process.env.NODE_ENV || 'development';
const configuration = require('../../knexfile')[environment];
const database = require('knex')(configuration);

const graphql = require('graphql');
const {
  GraphQLObjectType,
  GraphQLString,
  GraphQLID,
  GraphQLInt,
  GraphQLList
} = graphql;

const PetType = new GraphQLObjectType({
  name: 'Pet',
  //It is important that the fields is a function when we add our relationship later.
  fields: () => ({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    animal_type: {type: GraphQLString},
    breed: {type: GraphQLString},
    age: {type: GraphQLInt},
    favorite_treat: {type: GraphQLString}
  })
});

const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields:{
    pets: {
      type: new GraphQLList(PetType),
      resolve(parent, args){
        return database('pets').select()
      }
    },
  }
});
```

Alright we are almost ready to check out our query, but first we need to export our schema so that our `index.js` file can access it. We will also need to add one last thing to our  `GraphQL` datatypes list, `GraphQLSchema`.

```javascript
module.exports = new GraphQLSchema({
  query: RootQuery
})
```

Double check that your file looks like this:
```javascript
const environment = process.env.NODE_ENV || 'development';
const configuration = require('../../knexfile')[environment];
const database = require('knex')(configuration);

const graphql = require('graphql');
const {
  GraphQLObjectType,
  GraphQLString,
  GraphQLID,
  GraphQLInt,
  GraphQLList,
  GraphQLSchema
} = graphql;

const PetType = new GraphQLObjectType({
  name: 'Pet',
  //It is important that the fields is a function when we add our relationship later.
  fields: () => ({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    animal_type: {type: GraphQLString},
    breed: {type: GraphQLString},
    age: {type: GraphQLInt},
    favorite_treat: {type: GraphQLString}
  })
});

const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields:{
    pets: {
      type: new GraphQLList(PetType),
      resolve(parent, args){
        return database('pets').select()
      }
    },
  }
});

module.exports = new GraphQLSchema({
  query: RootQuery
})
```

### Update index.js

We will need to require our schema in our file and update the object passed to `graphqlHTTP()`. The `index.js` file should now look like this:

```javascript
const express = require('express');
const app = express();
// Allows express to understand graphql and interact with graphql API
// It is used as middleware for a single route
const graphqlHTTP = require('express-graphql')
const schema = require('./lib/schema/schema')


app.use('/graphql-pets', graphqlHTTP({
  schema: schema,
  //graphiql allows us to query from our browser
  graphiql: true
}))


app.listen(3001, ()=> {
  console.log("Listening for requests on port 3001")
});

```

### Pets Query
Now spin up your server and visit `localhost:3001/graphql-pets`. Our browser should now allow us to send queries and when hit play to see the response from our server.
The only data we can query at the moment is a list of pets.
Create an object with pets at the root and then include the fields that you want to see in your response.

```javascript
//query format
{
  pets{
    id
    name
    animal_type
    breed
    age
    favorite_treat
  }
}
```

#### Expected Response
```javascript
{
  "data": {
    "pets": [
      {
        "id": "1",
        "name": "Fluffy",
        "animal_type": "cat",
        "breed": "long-hair",
        "age": 7,
        "favorite_treat": "catnip"
      },
      {
        "id": "2",
        "name": "Bubbles",
        "animal_type": "dog",
        "breed": "Boston Terrier",
        "age": 3,
        "favorite_treat": "blueberries"
      },
      {
        "id": "3",
        "name": "Fiona",
        "animal_type": "dog",
        "breed": "Mini Australian Shepherd",
        "age": 1,
        "favorite_treat": "pepperoni"
      },
      {
        "id": "4",
        "name": "Scooby",
        "animal_type": "dog",
        "breed": "Great Dane",
        "age": 4,
        "favorite_treat": "peanut butter"
      },
      {
        "id": "5",
        "name": "Wiley",
        "animal_type": "guinea pig",
        "breed": "Teddy",
        "age": 1,
        "favorite_treat": "oranges"
      }
    ]
  }
}
```

__Hooray!__ we can query for pets.

### Add query for single pet

Now we are going to add to the _RootQuery_ so that we can retrieve a single pet.

```javascript
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields:{
    pet: {
      type: PetType,
      args: {id: {type: GraphQLID}},
      resolve(parent, args){
        return database('pets').where(id: args.id).first()
      }
    },
    pets: {
      type: new GraphQLList(PetType),
      resolve(parent, args){
        return database('pets').select()
      }
    },
  }
});
```

Notice that we include `args` here because we need our user to specify which pet they want with their query. We then pass the args to our resolver to find the specific pet.

### Pet Query

When you are in graphql you now need to pass pet the argument of id like so.

```javascript
{
  pet(id: 1){
    id
    name
    animal_type
    breed
    age
    favorite_treat
  }
}
```

### Including Owners for pets

* Define Owner type first

```javascript
const OwnerType = new GraphQLObjectType({
  name: 'Owner',
  fields: () => ({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    age: {type: GraphQLInt},
    }
  })
});
```

* Adjust the PetType

```javascript
const PetType = new GraphQLObjectType({
  name: 'Pet',
  //It is important that the fields is a function when we add our relationship later.
  fields: () => ({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    animal_type: {type: GraphQLString},
    breed: {type: GraphQLString},
    age: {type: GraphQLInt},
    favorite_treat: {type: GraphQLString}
    owner: {
      type: OwnerType,
      resolve(parent, args){
        return database('pets')
          .join('owners', {'pets.owner_id': 'owners.id'})
          .where('owner.id', parent.owner_id)
          .first()
      }
    }
  })
});
```

We can now include the owner when querying for a pet.

### Query for Pet's Owner

```javascript
{
  pet(id: 1){
    id
    name
    animal_type
    breed
    age
    favorite_treat
    owner{
      name
    }
  }
}
```

### Practice

* Add _owners_ as a field to the `RootQuery` to return a list of all owners

* Add _owner_ as a field to the `RootQuery` to return a single owner based on the id

* Adjust `OwnerType` so that it includes a field of pets that will return a list of pets for that owner

#### Bonus

* Try to refactor the database queries to a Pet and Owner model

Completed Example [here](https://github.com/turingschool-examples/pets_gql/tree/graphql-queries)
Completed Example refactored [here](https://github.com/turingschool-examples/pets_gql/tree/graphql-queries-refactor)
