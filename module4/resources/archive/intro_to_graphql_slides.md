footer: Intro to GraphQL
slidenumbers: true

# GraphQL

---

# Learning Goals

- Explain what GraphQL is and the benefits of using it over REST
- Write an Express/GraphQL server
- Interact with a GraphQL API using Graph_i_QL

---

# Warm Up

Write your answer to the following:
- Why do we use APIs?
- What makes an API RESTful?
- Why do we commonly see `/api/v1/` included in RESTful API endpoints?

---

# LinkedIn for Puppies

We are building a LinkedIn for Puppies. Let's brainstorm properties each puppy-user would have ...

^ Ideas: company, title, education, favorite treat, parents names, best friends.

---

# LinkedIn for Puppies - JSON

With a partner, whiteboard the JSON response from `api/v1/users/:id`

^ Circulate as groups develop answers, keep track of consistencies/differences. Call on groups to share out.

---

# Activity

- Each person should have a sheet of paper with one puppy-user attribute written on it.
- The class needs to group together like a big JSON object.

^ Once the group is together like a JSON object on one side of the room, instructor is on other side of the room.
Over-Fetching: Instructor says: I need the puppy-user name - what are you going to send me, server? (The whole group should walk over together.) Well, I didn't want all of you, but I guess I can just weed the rest of you out. I need the puppy-user name and favorite toys. What are you going to send me? (The whole group should walk over.) I didn't want everyone!
STAMP the idea: We are currently OVER-FETCHING. Only want one thing but get a bunch back.
Under-Fetching: Instructor says: Now I need the name and location of the company that the pet works at. What are you going to do server? (I get the whole JSON object, including the companyId). Now I have to make another request to get all the companies info. STAMP the idea: We are currently UNDER-FETCHING, making a request to the restful API, get a company id, and now have to go back out to another endpoint and ask for it. Ugh.

---

# Turn & Talk

What isn't ideal about both of these situations?
- If I want a puppy's name ...
- If I want a puppy's company's name ...

^ This is just giving students a chance to say out loud the points that the instructor brought up in activity.

---

# Disadvantages to REST

- Deciding on URL schema gets tough with heavily nested relationships
- Sometimes it takes too many HTTP requests to get the data we need (under-fetching)
- It's common to over-fetch data (getting everything back when we only needed one property)

^ The second and third bullets especially cause problems as over 60% of internet users are on mobile devices.

---

# A Solution - GraphQL

![inline](https://miro.medium.com/max/1372/1*EOMP0V69RZ5xChG5pRoFyA.png)

^ When Facebook was re-building their native mobile applications in 2012, they ran into some problems - server queries written didn't match what they wanted in their apps, and there was a considerable amount of code needed to parse data had to be written on both server and client side. So, they invented GraphQL. In 2015, Facebook released it to the public.

---

# A Solution - GraphQL

Some of it's features:
* Defines a data shape
* Strongly Typed
* Protocol, not storage
* Introspective
* Version free

---

# LinkedIn for Puppies

![inline](http://backend.turing.edu/assets/images/lessons/intro_to_graphql/rest_diagram.png)

---

# LinkedIn for Puppies

![inline](http://backend.turing.edu/assets/images/lessons/intro_to_graphql/graph_diagram.png)

---

# LinkedIn for Puppies

![inline](http://backend.turing.edu/assets/images/lessons/intro_to_graphql/query.png)

---

# Building a GraphQL Server

To dig into working with GraphQL, we will build it with Express.

Server libraries for GraphQL exist in  most languages - Elixir, Go, PHP, Python, Scala, Ruby & more.

___

# Starter Repo

* Clone down the repo in your channel
* Follow directions in README
* Start perusing the files

___

# Familiarize Yourself with Starter Repo

- What do you have at localhost:3000? 4000? Where are those things coming from?
- `package.json` - what has been installed, and what job do you think each dependency has?
- `db.json` - familiarize yourself with our initial data.
- `server.js` - this is an Express server built _with_ GraphQL, so you'll still see some of the things you're familiar with!
- `schema.js` - this file is where we will be doing all our work today.

___

# Root Query

Key Points:

-  a Root Query is the `entry` point into a graph. You can have queries on as many nodes as you'd like.
- a Root Query is a GraphQLObjectType - which require two arguments - `name` and `fields`.

___

# Types

Key Points:

- a Type defines the properties of a given object.
- the resolve function determines what is returned from that type (it talks to our DB)

___

# Pet-Company Relationship

Key Points:

- Pet can have foreign key of companyId, and company can also have the list of pets - convenient!

___

# Mutations

Key Points:

- Creating, updating and deleting are ALL under the category of mutations.

___

# Refactoring

The schema file is getting a little lengthy - can you pull each type, the RootQuery, and the mutation out into their own files and maintain functionality?

___

# GraphQL vs. RESTful APIs

With your partner, create a poster that compares/contrasts GraphQL and REST, and highlights the key points that we learned today.

___
