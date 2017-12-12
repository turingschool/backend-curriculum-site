---
layout: page
title: AJAX Refresher
---

## Learning Goals

* Students are comfortable using AJAX to make RESTful requests

## AJAX...What's That Again?

`AJAX` == Asynchronous JavaScript and XML. This should probably be renamed to `AJAJ` (Async JS and JSON), though.

Essentially, AJAX allows us to _asynchronously_ interact with most anything, but predominantly other servers (think APIs). The asynchronous bit here means that we could make a request and not need to wait for its response before moving on to execute other lines of code. The request will come back and be handled when it's ready without needing to halt our program waiting for it.

We'll learn more about asynchronicity in JavaScript later in the module, but for now, let's think of AJAX as the tool that will allow us to make client-side requests to a different server (API).

## GET Example

[jQuery AJAX](https://api.jquery.com/category/ajax/) requests come in all shapes and sizes, but for reference, here's a common structure:

```js
// make a GET request
$.ajax({
  type: "GET",
  url: "http://localhost:3000/api/v1/posts"
})
// if successful, request is handled by `.then`
// JSON response, here named `posts`, is passed to anonymous function
.then(function(posts){
  // we're within this block if things went well,
  // so do something with the data!
})
.catch(function(error){
  // only here if there was an error,
  // so handle error if there is one
});
```

Here's a very similar structure, using a bit of jQuery AJAX's syntactic sugar:

```js
$.get("http://localhost:3000/api/v1/posts")
  .then(function(posts){
  })
  .catch(function(error){
  })
```

jQuery AJAX comes with many built-in and readable methods similar to `$.get()` for POST, DELETE, etc requests. Make sure to read their [docs](https://api.jquery.com/category/ajax/) to learn how to use them correctly.

## Organizing AJAX Requests

In the examples above, the success or failure of our AJAX requests are handled by anonymous functions. By changing these, we can start to organize and DRY up our code.

I'd suggest grouping all of these to-be-named functions together (...hint, hint...in a file...).

Let's refactor this example:

```js
$.get("http://localhost:3000/api/v1/posts")
  .then(function(posts){
    posts.forEach(function(post){
      $(".posts-box").append(post)
    })
  })
  .catch(function(error) {
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

We could then slim down our AJAX call to just this:

```js
$.get("http://localhost:3000/api/v1/posts")
  .then(appendPosts)
  .catch(errorLog)
```

Notice how we still need to handle the call with `.then()` and `.catch().`

### Going Further - Organizing Requests as Event Handlers

It's very likely you'll be using AJAX requests as event handlers.

For example, on submit of a form, we make a POST request with the form data.

Just like we organized our AJAX handlers above, we can organize our event handlers similarly.

If we were working with form data like this:

```js
$('form').on('submit', function(event){
  event.preventDefault()
  return $.post('http://example.com/articles', "article")
    .then(appendArticle)
    .catch(errorLog)
})
```

We can refactor that so our event bindings live together, our AJAX calls live together, and our AJAX handlers live together.

```js
// event bindings live nicely as one liners
$('form').on('submit', postArticle)

// AJAX call is nice and tidy on its own
const postArticle = (event) => {
  event.preventDefault()
  return $.post('http://example.com/articles', "article")
    .then(appendPost)
    .catch(errorLog)
}
```

## Work Time

Pair up with your Quantified Self partner and discuss the following:

-   What are some use cases for AJAX? Name some cards from your project that will require an AJAX request to complete.
-   What information do you need before you can make an AJAX request?
-   How do you access the response from the request?

Once you've answered those, work to implement the variety of AJAX requests necessary to GET, POST, DELETE, etc. to the Quantified Self API.
