---
layout: page
title: Fetch Refresher
length: 120 mins
---

## Instructor Notes

At this point, students should understand that JavaScript is synchronous but browser APIs allow it to work asynchronously.

Some of the students probably used fetch or ajax in their mod 3/4 personal project as well, so much of this won't be brand new to some students.

### Prep

Have the following tabs open in browser:
- Hedgehog Party in development to show them how the GET request is working.
- Hedgehog Party Repo
- CSS Tricks article on Error Handling - https://css-tricks.com/using-fetch/#article-header-id-5

Prep a message to cohort with Hedgehog Party Repo - https://github.com/turingschool-examples/fetch-hedgehog-party

## Slides

* Available [here](../slides/fetch)

## Learning Goals

By the end of this lesson, you will ...

- explain what a Promise is
- explain the advantages of using the Fetch API and Promises
- be able to write GET, POST, and DELETE requests using the Fetch API
- be familiar with patterns to organize/refactor fetch requests

## Warm Up

SLIDE:

With a partner, use prior knowledge/educated guesses to discuss what you see happening at each line of this function. Also jot down any questions that arise from look at this.

```js
const fetchDiscussions = () => {
  fetch('/api/v1/discussions')
  .then((response) => response.json())
  .then((rawDiscussions) => cleanDiscussions(rawDiscussions))
  .catch((error) => console.error({ error }));
}
```

DISCUSS:

- ask 4 different students what is happening at lines 1-4
- response.json() - parses it from response stream to a JSON object
- cleanDiscussions - we can assume that's a helper function somewhere else in the project

## Promises

SLIDE:

> A Promise is an object that represents the eventual completion or failure of an asynchronous operation, and it's returning value.

3 states of Promises:

- Pending
- Resolved/Fulfilled (with a return value from your async operation)
- Rejected (with an error message from your async operation)

SAY:

Knowing the three states is helpful when debugging

## Why Use Promises?

SLIDE:

Promises allow you to multi-task a bit in JavaScript. They provide a cleaner and more standardized method of dealing with tasks that need to happen in sequence. With Promises, we have more control over what happens with the outcomes of our async processes.

SAY:

Promises are a mechanism to handle async JS.

## When to use Promises

SLIDE:

The short answer: whenever you're handed a promise by an API you didn't write, where the author chose to use promises. This includes many modern web APIs such as `fetch`.

SAY:

When you read the documentation for a library that uses promises, one of the first sentences will likely say 'this is a promise-based library'. There are some APIs that still use callbacks rather than promises (the `geolocation` API, for example). You'll want to read the documentation closely to see if the library expects you to use a promise or callback. So for once, we don't really have to be in charge of making a decision here -- we can let the tools and technologies we're using dictate whether or not we should be using promises.

### Advantages of Promises

SLIDE:

- You are getting an IOU that you're holding on to rather than giving your code away as you would with callbacks.
- Error handling is less broken. It's not a silver bullet. Synchronous functions either `return` or throw an error. In a similar vein, your promises will either become *resolved* by a value or become *rejected* with an error.
- You can catch errors along the way and deal with them in a way that is *similar* to synchronous code.
- Chaining promises is easy and does not result in callback hell.

SAY:

So besides the obvious syntactical benefits, what are some of the others advantages of promises?

SLIDE:

But wait, there's more.

- `Promise.all` takes an array of promises and waits until all of the promises are resolved. This solves the nastiness involved in doing this with callbacks.
- `Promise.race` takes an array of promises and resolves as soon as any one of them fulfill. This would allow you to hit 3 API endpoints and then move on when we heard back from whichever one came back first.

SAY:

There are two common methods used - I would be shocked if you could complete QS without using Promise.all (hint hint).

## Promises with Fetch Requests

SLIDE:

Handling the response of a fetch request might look something like this:

```js
fetch('/api/v1/discussions')
  .then(response => response.json())
  .then(discussions => renderDiscussions(discussions))
  .catch((error) => console.error({ error }))
```

SAY:

Every fetch request we make will return a Promise object that contains our response data. This allows us to easily react to the type of response we get once it's available.

While we wait for the server to return our response, the rest of our application can continue executing other code in the meantime. Once the response object is available, our first `.then()` block will fire. The response object returns a lot of extra information that we don't necessarily need. All we want in this scenario is a JSON object of our discussions data which we can get by calling `response.json()`.

Converting the body to a JSON data structure with `response.json()` actually returns another Promise. (Converting the data to a particular type can take significant time, which is why we have this additional Promise step before we can begin working with out data.) Because we're getting another Promise object back, we can simply chain another `.then()` block where we actually receive our project data. We can then render it to the DOM with our imaginary `renderDiscussions()` function. Notice how we are using another `.then()` statement. This is called Promise Chaining. We do this because each `.then()` results in a new Promise.

If for any reason the request failed, the `.catch()` block will be fired and we will log the error to the console.

[Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch)

## What do Promises Give Us?

By using a Promise object, a function does two things:

1. It automatically becomes asynchronous, allowing it to run in the background and giving the rest of our code a change to continue execution.
2. It gives us access to two methods - `.then` and `.catch`

SLIDE:

![inline](https://wtcindia.files.wordpress.com/2016/06/promises.png?w=605)

SAY:

If the function completes successfully, the Promise object is considered resolved, and our `.then()` block will execute. Within this block, we are automatically given a result that we can work with (e.g. data from an API endpoint). In this example, we are given project data for our students and we’ll render them to the DOM.

If the function fails for any reason, our Promise object is considered rejected, and our `.catch()` block will execute instead. Within this block, we are automatically given an error that we can use to notify the user that something went wrong.

## A Typical Fetch Request

SLIDE:

```js
const fetchDiscussions = () => {
  fetch('/api/v1/discussions')
  .then((response) => response.json())
  .then((rawDiscussions) => cleanDiscussions(rawDiscussions))
  .catch((error) => console.error({ error }));
}
```

```js
const postDiscussions = () => {
  fetch('/api/vi/discussions', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      discussionName: 'Movies',
      totalPoints: 100,
    });
  });
}
```

SAY:

THINK PAIR SHARE: What differences do you notice between a GET and POST?

SLIDE:

`fetch()` takes TWO arguments:

- URL or API endpoint (always)
- object of configuration settings for the request. This may contain what kind of request we're making and any data we might need to pass along with it (optional)

## Hedgehog Party - 20 minutes per step

Clone down the Hedgehog Party Repo. Look through the JavaScript in `public/index.js` - we already have a get request up and running to get, then append, all the hedgies in the database onto the DOM. Make sure you open up the app in the browser and keep your Dev Tools open while working. You should be pairing with your Quantified Self partner for this activity.

**Step 1:** Choose a driver. Together, write the request to POST a new hedgehog. See the README for info on what is expected in the request.

**Step 2:** Now, the other partner should drive. Work together to write the request to DELETE a hedgehog from the invite list.

NOTE: Both tasks require network requests as well as DOM manipulation. This is good practice for Quantified Self😊

## Error Checking

Give students 20 minutes to implement error handling:

Read about error handling [here](https://css-tricks.com/using-fetch/#article-header-id-5), then try to implement similar error handling in our GET request.

For further investigation if it just doesn't make sense to them:

Check out the example below. Our second button makes an unsuccessful request with a 404 response so why does it seem to still succeed?

> codepen snippet here

The promise returned from `fetch()` will only reject on network failure or if anything prevented the request from completing. This means it won't reject on a response of 404 or 500 from the server but will return a `status.ok` status set to false.

To handle responses that do not return a successful status, we can create a response handler. If the response is `ok` we continue processing the data as we did above. If it is not we use `Promise.reject` to trigger our catch handler and pass it an error object with the `status`, `statusCode` and any addition json information we get from the server.

## Organizing Fetch Requests

There probably won't be time to go over this is class; refer students for it for their FE projects as a refactoring opportunity.

## Interview Questions

Pair up with your Quantified Self partner and practice answering the following interview questions:

* What are the advantages of using fetch?
* What do you know about Promises? Can you give an example of when you've used one?

Be ready to share you answer(s) with the class when we wrap up.


## Additional Resources
* [David Walsh fetch API](https://davidwalsh.name/fetch)
* [CSS Tricks Using Fetch](https://css-tricks.com/using-fetch/)

Be aware that AJAX can also be used to make client side request to a server. Fetch has become more poplar in recent years as it is built into Javascript, works on almost all browsers, and doesn't require jQuery. If you want to learn more check out this old lesson [AJAX Refresher](./archive/ajax-refresher.md)
