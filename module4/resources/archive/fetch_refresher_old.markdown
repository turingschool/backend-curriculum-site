
---
layout: page
title: Fetch Refresher
---

## Learning Goals

* Students are comfortable using `fetch()` to make RESTful requests
* Students can use jQuery to manipulate the DOM

## Fetch...What's That Again?

Essentially, `fetch()` allows us to _asynchronously_ interact with most anything, but predominantly other servers (think APIs). The asynchronous bit here means that we could make a request and not need to wait for its response before moving on to execute other lines of code. The request will come back and be handled when it's ready without needing to halt our program waiting for it.

We'll learn more about asynchronicity in JavaScript later in the module, but for now, let's think of `fetch()` as the tool that will allow us to make client-side requests to a different server (API).

## GET Example

[Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) requests come in all shapes and sizes, but for reference, here's a common structure:

```js
// make a GET request
fetch('http://localhost:3000/api/v1/posts')
  // if successful, request is handled by `.then`
  .then(response => {
    // we're within this block if things went well,
    // so do something with the data!
  })
  .catch(error => {
    // only here if there was an error,
    // so handle error if there is one
  })
```

Since `fetch()` responses are returned as a readable stream, you will often need to use methods provided by `Response` to convert the stream into data you wish to consume. We will be using `response.json()`, but other [methods](https://developer.mozilla.org/en-US/docs/Web/API/Response) like `blob()`, `formData()` and `text()` are available.

```js
fetch('http://localhost:3000/api/v1/posts')
  .then(response => response.json())
  .then(data => {
    // Now data is in a format we are more used to i.e. {"posts": [{"title": "Fetch Refresher", "author": "Katelyn Kasperowicz"},..]}
  })
  .catch(error => {
  })
```

## POST Example

Sending data with `fetch()` is also pretty easy. `fetch()` allows us to set an optional parameter with an `Request` object which allows us to control a number of parameter. The attributes we will focus on are `method`, `headers` and `body`. You can view more options [here](https://developer.mozilla.org/en-US/docs/Web/API/Request). The default request method is `get` so we need to set our method to `post`. Since we will mostly be working with JSON content we need will need to set the `Content-Type` in headers to `application/json` and make sure we use `JSON.stringify` before sending our data.

```js
// Data we wish to send to the API endpoint
const newPost = {title: 'Hello Wisconsin', author: 'Eric Forman'}

fetch('http://localhost:3000/api/v1/posts', {
  method: 'post',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify(newPost)
})
//.then().....
```

## Error Checking

Check out the example below. Our second button makes an unsuccessful request with a 404 response so why does it seem to still succeed? Read more about error handling [here](https://css-tricks.com/using-fetch/#article-header-id-5).

<p data-height="348" data-theme-id="0" data-slug-hash="aEvBvz" data-default-tab="js,result" data-user="kat3kasper" data-embed-version="2" data-pen-title="Fetch Error Handling" class="codepen">See the Pen <a href="https://codepen.io/kat3kasper/pen/aEvBvz/">Fetch Error Handling</a> by Katelyn Kasperowicz (<a href="https://codepen.io/kat3kasper">@kat3kasper</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

The promise returned from `fetch()` will only reject on network failure or if anything prevented the request from completing. This means it won't reject on a response of 404 or 500 from the server but will return an `ok` status set to false.

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
    $('.posts-box').append(post)
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
$('form').on('submit', function(event) {
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
// event bindings live nicely as one liners:
$('form').on('submit', postArticle);

const requestOptions = {
  method: 'post',
  headers: { 'Content-Type': 'application/json'},
  body: JSON.stringify(article);
}

// Fetch call is nice and tidy on its own:
const postArticle = (event) => {
  event.preventDefault()
  return fetch('http://example.com/articles', requestOptions)
    .then(handleResponse)
    .then(appendArticle(article))
    .catch(errorLog);
}

// DOM manipulation is abstracted:
const appendArticle = (article) => {
  $('.container').append(`
    <p>${article}</p>
  `);
}
```

## Work Time

Pair up with someone... and write the Post request and necessary jQuery to invite a new Hedgehog to the party::

-   Fork the [Hedgehog Party](https://codepen.io/ameseee/pen/rKqaLE?editors=1010) into your own CodePen (create an account if needed - it's free!)
-   Write the Post request and necessary jQuery to invite a new Hedgehog to the party.
- Write the Delete request and necessary jQuery to uninvite a Hedgehog from the party.


## Additional Resources
* [David Walsh fetch API](https://davidwalsh.name/fetch)
* [CSS Tricks Using Fetch](https://css-tricks.com/using-fetch/)

Be aware that AJAX can also be used to make client side request to a server. Fetch has become more poplar in recent years as it is built into Javascript, works on almost all browsers, and doesn't require jQuery. If you want to learn more check out this old lesson [AJAX Refresher](./archive/organize-an-express-app)

[Instructor Materials](https://github.com/ameseee/fetch-hedgehog-party/blob/complete/public/index.js)
