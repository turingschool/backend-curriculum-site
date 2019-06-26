---
title: Asynchronicity in JavaScript
layout: page
---

## Learning Goals

- Students understand how JavaScript executes synchronously vs asynchronously
- Students can read and explain JavaScript that executes asynchronously
- Students are able to explain how asynchronous JavaScript can be handled

[Instructor Materials](./asynchronous_js_instructor)

## Vocabulary

- synchronous
- asynchronous
- call stack
- queue
- Web APIs
- Event Loop
- JS Engine/runtime

## Warm Up

* What is your version of a ten second history of JavaScript? Where did it start?
* Review the code below:

```js
function waitTwoSeconds() {
  console.log("I am starting to wait...");
  setTimeout(function() {
    console.log("I've waited two seconds");
  }, 2000);
  console.log("Done waiting.")
}

waitTwoSeconds();
```

* What do you expect the output to be?
* Type the code into a file called `async.js` and run it using `node async.js`
* What happens? How could you use this behavior to your advantage? What might be some pitfalls?

### Synchronous vs. Asynchronous

#### Synchronous JavaScript

Let's talk about the drive-thru at Starbucks.

#### Asynchronous JavaScript

Let's talk about ordering inside the store at Starbucks.


### When Will We Need This?

The concepts we're going to talk about happen most often in the following situations:

- Loading external data (APIs, files, databases)
- Events (clicks, keydowns, scrolls, etc)

Asynchronous code allows us to keep up with the expectations of users. If we could only run synchronous code in the browser, we couldn’t keep up with what users expect from applications. Say hello to asynchronous code, brought to you by your browser!

#### The Event Loop

We now know that JavaScript runs synchronously.

JavaScript's **call stack** is a data structure that keeps track of where we are in the sense of this synchronous thread of execution.

> "If we step into a function, we step into the stack. If we return from a function, we pop off the top of the stack." - Philip Roberts

Asynchronous processes are able to run concurrently because, while the JS runtime can only execute a single thread, your browser provides more threads for you. Async takes advantage of this and passes processes to JavaScript's **queue**, and one by one, once the async process is finished, the **event loop** will grab from the queue and put the process back onto the **stack**.

Let's watch Philip Roberts further explain: [Philip Roberts, JSConf EU 2014](https://www.youtube.com/watch?v=8aGhZQkoFbQ)

## Application of Knowledge

### Experiments in Ordering

With your partner, take your assign chunk of code and try to predict what interactions will happen. **Then** run the code in your browser's console to verify your assumptions.

1. Snack Time

```js
var hungry = "very";
console.log(hungry);

setTimeout(function() {
  hungry = "not anymore";
  console.log(`async hungry is ${hungry}`);
}, 1000);

console.log(hungry);
```

2. Ballon

```js
var balloon = "empty";
console.log(balloon);

$('body').on('click', function() {
  balloon = "filled";
  console.log(`async balloon is ${balloon}`);
});

console.log(balloon);
```

3. Repos

```js
var repos = [];
console.log(repos);

fetch("https://api.github.com/users/turingschool/repos")
  .then(response => response.json())
  .then(allRepos => {
    repos = allRepos[0]
    console.log(repos);
  });

console.log(repos);
```

4. Dinner Time

```js
var hungry = "very";
console.log(hungry);

setTimeout(function() {
  hungry = "a little";
  console.log(`async hungry is ${hungry}`);
}, 1000);

setTimeout(function() {
  hungry = "stuffed";
  console.log(`async hungry is ${hungry}`);
}, 5000);

console.log(hungry);
```

Once you've made sense of why this worked the way it did, whiteboard (or make a poster) a visual to show what happened with the call stack in the code snippet you chose.

### Callbacks

Callbacks, by nature are not asynchronous. They are, however, used widely by asynchronous code.

As a refresher, a `callback` is a second function that is being passed as a parameter to a first function and will be invoked by the original function.

For example:

```js
function doubleNumber(num) {
  console.log(num * 2);
}

[1,2,3].forEach(doubleNumber);
```

#### Callbacks with Events

You've seen callbacks before in array prototypes (think, Ruby enumerables), but also in event listeners. Take this example:

```js
$("#my-button").on('click', function() {
  alert("You clicked my button!");
})
```

You've probably seen a click event handled like this before. You pass a function to be executed later upon a `'click'` event. I want to frame this in a slightly different way to help you understand how JavaScript interprets this. I'm going to write the same thing in without jQuery to help illustrate.

```js
document.getElementById('.my-button').addEventListener('click', function() {
  alert("You clicked by button!");
})
```

The method `addEventListener()` does a better job of telling you what's actually happening. When writing asynchronous JavaScript, it can sometimes feel like your code is being run out of order. JavaScript is still being read from top to bottom. When it gets to the `addEventListener()`, it does just that. It adds a listener to the element, and it moves on to its next instruction. It's not that JavaScript comes back to this code later. You packed it up and sent it off. Your callback function now exists all alone, waiting to be invoked by the browser upon a 'click' event.

#### Wrap Up

Write your answers to the following in your notebook:

- When an asynchronous function is called, what does the JavaScript engine do with it?
- When you get asked in an interview: "What do you know about asynchronous JavaScript?" - what will you say? Don't paraphrase, literally prepare yourself for how you will answer that (pretty big) question!

## Going Further

Here's a couple JavaScript concepts you'll sometimes see associated with asynchronicity. They're worth glancing over to avoid being completely confused when you come across them.

**[Generators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*)**

A lot of the same "running code at a later time" can be done using generators. You know you're working with a generator when the function has a `*` at the end, and the keyword `yield` is used inside the function.

**[Async and Await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)**

These are a pair of keywords defined in ES7. They're just another way to ensure that things happen in a given order, but not necessarily at any given time.
