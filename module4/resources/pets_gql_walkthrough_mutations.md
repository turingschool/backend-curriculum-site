# Pets GraphQL Walkthrough Mutations

We will build onto the [pet_gql](https://github.com/turingschool-examples/pets_gql/tree/graphql-queries) with queries repo.

Let's start by adding a `Mutation` similar to our `RootQuery` above `module.exports`. It should look like this:

```javascript
const Mutation = new GraphQLObjectType({
  name: "Mutation"
  fields: {

  }
})
```

Just like `RootQuery` our `Mutation` is a GraphQLObjectType. The fields here will be named in a way so it is clear what action the mutation is doing. Let's start by writing a mutation to add and Owner to our database.

```javascript
const Mutation = new GraphQLObjectType({
  name: "Mutation"
  fields: {
    addOwner: {
      type: OwnerType,
      args: {
        name: {type: GraphQLNonNull(GraphQLString)},
        age: {type: GraphQLNonNull(GraphQLInt)}
      }
      resolve(parent, args){
        return database('owners')
          .returning('*')
          .insert({
            name: args.name,
            age: args.age
          })
        .then(result => result[0])
        .catch(error => error)
      }
    }
  }
})
```

Notice we are using a new GraphQL datatype, `GraphQLNonNull`, so let's add this to our list at the top of the file. It should now looks like this:

```javascript
const {
  GraphQLObjectType,
  GraphQLID,
  GraphQLString,
  GraphQLInt,
  GraphQLList,
  GraphQLSchema,
  GraphQLNonNull
} = graphql;
```
Within the addOwner field, the type is what is being returned from this mutation request, in this case it is an OwnerType.

In our `addOwner` field we are also requiring args for the attributes that an owner should have when created. The `GraphQLNonNull` datatype requires that this argument is included in the mutation request. The argument that is passed to `GraphQLNonNull` indicates the datatype the required value type. For instance, our name arg will require a string value.

Finally we use the resolve function to handle the request and return the necessary information.

Finally we need to add our mutation to our export so that we can test out a mutation request in graphiql.

```javascript
module.exports = new GraphQLSchema({
  query: RootQuery,
  mutation: Mutation
})
```

Start up your server and visit `http://localhost:3001/graphql-pets`.
Now to send a mutation request we need to format it as so:

```javascript
mutation{
  addOwner(name: "Charlie", age: 10){
    id
    name
    age
  }
}
```

It is important to identify that this is a mutation request, so that our backend knows how to process this request. We then pass it the required args and then specify what information we want to be returned.

Now that we can add an Owner let's add the ability to delete an Owner.

Start by updating your mutation:

```javascript
const Mutation = new GraphQLObjectType({
  name: "Mutation",
  fields: {
    addOwner: {
      type: OwnerType,
      args: {
        name: {type: GraphQLNonNull(GraphQLString)},
        age: {type: GraphQLNonNull(GraphQLInt)}
      },
      resolve(parent, args){
        return database('owners')
        .returning('*')
        .insert({
          name: args.name,
          age: args.age
        })
        .then(result => result[0])
        .catch(error => error)
      }
    },
    deleteOwner: {
      type: GraphQLString,
      args: {id: {type: GraphQLNonNull(GraphQLID)}},
      resolve(parent, args){
        return database('owners')
        .where('id', args.id)
        .del()
        .then((result) => {
          if(result == 1){
            return "Success!"
          } else {
            return "Something went wrong, please check the id and try again."
          }
        })
        .catch(error => error)
      }
    }
  }
})
```

Notice that the type that we are returning here is a GraphQLString. Once we have deleted the information from our database we simply want to return a message to our user letting them know whether it was successful of not.

The id is the only required argument so that the correct owner can be found and deleted.

The resolve function checks to see what are the database returns to determine what string should be sent as a response. A return of `1` means that the delete was successful.

Start up the server again and try writing a mutation request to delete an owner.

Need a hint?

<details><summary>Hint</summary>
<p>

```javascript
mutation{
  deleteOwner(id: 1)
}
```

</p>
</details>

Since `deleteOwner` only returns a string we do not specify what information to be returned.

### Practice

Now take some time and practice with a partner or with a friend to see if you can add the following functionality.

* Add _addPet_ as a field to the `Mutation` to return the created Pet Info

* Add _deletePet_ as a field to the `Mutation` to return "Success!"

#### Bonus

* Try to refactor the database mutations into a Pet and Owner model

Completed Example [here](https://github.com/turingschool-examples/pets_gql/tree/graphql-mutations)
Completed Example refactored [here](https://github.com/turingschool-examples/pets_gql/tree/graphql-mutations-refactor)
