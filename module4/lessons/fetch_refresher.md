---
layout: page
title: Intro to Fetch
---

## Intro to using Fetch
Every fetch request we make will return a Promise object that contains our response data. This allows us to easily react to the type of response we get once it's available.

Handling the response of a fetch request might look something like this:

```js
fetch('https://jsonplaceholder.typicode.com/posts')
  .then(response => response.json())
  .then(result => console.log(result))
  .catch((error) => console.error({ error }))
```

While we wait for the server to return our response, the rest of our application can continue executing other code in the meantime. Once the response object is available, our first `.then()` block will fire. The response object returns a lot of extra information that we don't necessarily need. All we want in this scenario is a JSON object of our discussions data which we can get by calling `response.json()`.

Converting the body to a JSON data structure with `response.json()` actually returns another Promise. (Converting the data to a particular type can take significant time, which is why we have this additional Promise step before we can begin working with out data.) Because we're getting another Promise object back, we can simply chain another `.then()` block where we actually receive our project data. We can then render it to the DOM with our imaginary `console.log` function. Notice how we are using another `.then()` statement. This is called `Promise Chaining`. We do this because each `.then()` results in a new Promise.

If for any reason the request failed, the `.catch()` block will be fired and we will log the error to the console. In most cases, the `catch` will not fire off unless the server returns an error code that denotes complete failure. This usually means the `catch` won’t be reached unless it’s a 500 level error. 


## Hedgehog Party
Head over to the [Hedgehog Party Repo](https://github.com/turingschool-examples/fetch-hedgehog-party) and take a quick look at the README. Once you understand how the API works, we’ll need to do one more thing. 

Remember that All your Express base are belong to us [All your Express base are belong to us](https://github.com/turingschool-examples/all-your-base) repo? Let’s use that again and clone it down. We’ll use that repo to understand how fetch works with an external API. Since we’ll be using an Express backend to request information from the Hedgehog Party API, we’ll need to pull in a new NPM package called `node-fetch`. You can find how to download this [right here](https://www.npmjs.com/package/node-fetch). 

Once you have that setup and ready to go, let’s try to hit the first endpoint from the Hedgehog Party repo and grab all of the invites. 
