---
layout: page
title: Fetch Refresher
---

## Learning Goals

By the end of this lesson, you will ...

- explain what a Promise is
- explain the advantages of using the Fetch API and Promises
- be able to write GET, POST, and DELETE requests using the Fetch API
- be familiar with patterns to organize/refactor fetch requests

## JavaScript - synchronous or asynchronous?

- Only one block of code can run at a time (in the order that it is written/appears)
- JS is only asynchronous in the sense that it can perform some asynchronous operations (non-blocking)
- Tasks that can not be completed immediately are going to complete asynchronously

See the [Async JS lesson](http://backend.turing.io/module4/lessons/asynchronicity-in-javascript) for a deeper dive!

This means that our code is read and executed line-by-line in the order that it's written:

```js
thisFunctionWillExecuteFirst();
thisFunctionWillExecuteSecond();
thisFunctionWillExecuteThird();
thisIsGoingToTakeForever();
iHaveToWaitOnAllTheseOtherSlowPokesAboveMe();
```

### WHEN might we want our code to operate in an async manner?

The most common example of an async process we will run into on the client-side is a network request. Making a trip to the server can take a significant amount of time, and our applications would be painfully slow if they stopped the rest of our code from executing.

Asynchronous JavaScript will be processed in the background - it will not block the execution of the code that follows it. This comes in handy when we want to pull a slow or expensive operations out of the default synchronous flow of execution.

The hot way to do this right is by using [Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise), which handle asynchronous JavaScript.

## Explore

With a partner, use prior knowledge/educated guesses to discuss what you see happening at each line of this function. Also jot down any questions that arise from look at this.

```js
const fetchDiscussions = () => {
  fetch('/api/vi/discussions')
  .then((response) => response.json())
  .then((rawDiscussions) => cleanDiscussions(rawDiscussions))
  .catch((error) => console.error({ error }));
}
```

## A Typical Fetch Request

```js
const postDiscussions = () => {
  fetch('/api/vi/discussions', {
    method: 'POST',
    body: JSON.stringify({
      discussionName: 'Foo',
      totalPoints: 100,
    });
  });
}
```

What differences do you notice between a GET and POST?

`fetch()` takes TWO arguments:

- URL or API endpoint (always)
- object of configuration settings for the request. This may contain what kind of request we're making and any data we might need to pass along with it (optional)

## Promises

3 states of Promises:

- Pending
- Resolved/Fulfilled (with a return value from your async operation)
- Rejected (with an error message from your async operation)

Every fetch request we make will return a Promise object that contains our response data. This allows us to easily react to the type of response we get once it's available.

Handling the response of a fetch request might look something like this:

```js
fetch('/api/v1/discussions', {
  method: 'POST',
  body: JSON.stringify({
    discussionName: 'Foo',
    totalPoints: 100,
  });
})
.then(response => response.json())
.then(discussions => renderDiscussions(discussions))
.catch((error) => console.error({ error }))
```

While we wait for the server to return our response, the rest of our application can continue executing other code in the meantime. Once the response object is available, our first `.then()` block will fire. The response object returns a lot of extra information that we don't necessarily need. All we want in this scenario is a JSON object of our discussions data which we can get by calling `response.json()`.

Converting the body to a JSON data structure with `response.json()` actually returns another Promise. (Converting the data to a particular type can take significant time, which is why we have this additional Promise step before we can begin working with out data.) Because we're getting another Promise object back, we can simply chain another `.then()` block where we actually receive our project data. We can then render it to the DOM with our imaginary `renderDiscussions()` function. Notice how we are using another `.then()` statement. This is called Promise Chaining. We do this because each `.then()` results in a new Promise.


If for any reason the request failed, the `.catch()` block will be fired and we will log the error to the console.

[Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch)


## Error Checking

Check out the example below. Our second button makes an unsuccessful request with a 404 response so why does it seem to still succeed? Read more about error handling [here](https://css-tricks.com/using-fetch/#article-header-id-5).

<p data-height="348" data-theme-id="0" data-slug-hash="aEvBvz" data-default-tab="js,result" data-user="kat3kasper" data-embed-version="2" data-pen-title="Fetch Error Handling" class="codepen">See the Pen <a href="https://codepen.io/kat3kasper/pen/aEvBvz/">Fetch Error Handling</a> by Katelyn Kasperowicz (<a href="https://codepen.io/kat3kasper">@kat3kasper</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

The promise returned from `fetch()` will only reject on network failure or if anything prevented the request from completing. This means it won't reject on a response of 404 or 500 from the server but will return a `status.ok` status set to false.

To handle responses that do not return a successful status, we can create a response handler. If the response is `ok` we continue processing the data as we did above. If it is not we use `Promise.reject` to trigger our catch handler and pass it an error object with the `status`, `statusCode` and any addition json information we get from the server.

```js
function handleResponse(response) {
  // Convert the readable stream to json
  return response.json()
    .then(json => {
      if (!response.ok) {
        // if the response returns a status code outside of 200-299 throw an error
        const error = {
          status: response.status,
          statusText: response.statusText,
          ...json
        }
        return Promise.reject(error)
      }
      // if the response is ok return the json object
      return json
    })
}

fetch('http://localhost:3000/api/v1/posts')
  .then(handleResponse)
  .then(data => {
    // Now data is in a format we are more used to i.e. {"posts": [{"title": "Fetch Refresher", "author": "Katelyn Kasperowicz"},..]}
  })
  .catch(error => {
    // When there is an error in the handleResponse function we can access the error object given to us by the Promise reject
  })
```


## Organizing Fetch Requests

In the examples above, the success or failure of our `fetch()` requests are handled by anonymous functions. By changing these, we can start to organize and DRY up our code.

I'd suggest grouping all of these to-be-named functions together (...hint, hint...in a file...).

Let's refactor this example:

```js
fetch('http://localhost:3000/api/v1/posts')
  .then(handleResponse)
  .then(posts => {
    posts.forEach(function(post){
      $(".posts-box").append(post)
    })
  })
  .catch(error => {
    console.error(error)
  })
```

Say we created one function responsible for appending posts and another to log our error to the console:

```js
const appendPosts = (posts) => {
  posts.forEach(function(post){
    $(".posts-box").append(post)
  })
}

const errorLog = (error) => {
  console.error(error)
}
```

We could then slim down our `fetch()` call to just this:

```js
fetch('http://localhost:3000/api/v1/posts')
  .then(handleResponse)
  .then(appendPosts)
  .catch(errorLog)
```

Notice how we still need to handle the call with `.then()` and `.catch().`

### Going Further - Organizing Requests as Event Handlers

It's very likely you'll be using `fetch()` requests as event handlers.

For example, on submit of a form, we make a POST request with the form data.

Just like we organized our `fetch()` handlers above, we can organize our event handlers similarly.

If we were working with form data like this:

```js
$('form').on('submit', function(event){
  event.preventDefault()
  return fetch('http://example.com/articles', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(article)
  })
    .then(handleResponse)
    .then(appendArticle)
    .catch(errorLog)
})
```

We can refactor that so our event bindings live together, our `fetch()` calls live together, and our `fetch()` handlers live together.

```js
// event bindings live nicely as one liners
$('form').on('submit', postArticle)

const requestOptions = {
  method: 'post',
  headers: { 'Content-Type': 'application/json'},
  body: JSON.stringify(article)
}

// Fetch call is nice and tidy on its own
const postArticle = (event) => {
  event.preventDefault()
  return fetch('http://example.com/articles', requestOptions)
    .then(handleResponse)
    .then(appendArticle)
    .catch(errorLog)
}
```

## CFU

Pair up with your Quantified Self partner and practice answering the following interview questions:

* What are the advantages of using fetch?
* What are promises used for? Can you give an example of when you've used one?

Be ready to share you answer(s) with the class when we wrap up.

## Work Time

Pair up with your Quantified Self partner and discuss the following:

-   What are some use cases for `fetch()`? Name some cards from your project that will require an `fetch()` request to complete.
-   What information do you need before you can make an `fetch()` request?
-   How do you access the response from the request?

Once you've answered those, work to implement the variety of `fetch()` requests necessary to GET, POST, DELETE, etc. to the Quantified Self API.


## Additional Resources
* [David Walsh fetch API](https://davidwalsh.name/fetch)
* [CSS Tricks Using Fetch](https://css-tricks.com/using-fetch/)

Be aware that AJAX can also be used to make client side request to a server. Fetch has become more poplar in recent years as it is built into Javascript, works on almost all browsers, and doesn't require jQuery. If you want to learn more check out this old lesson [AJAX Refresher](./archive/organize-an-express-app)
