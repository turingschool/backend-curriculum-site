---
title: Asynchronicity in JavaScript
layout: page
---

## Learning Goals

- Students can execute logic asynchronously with callbacks and AJAX requests
- Students understand how JavaScript executes synchronously vs asynchronously
- Students can read and explain JavaScript that executes asynchronously
- Students are exposed to JS Promise structure for writing asynchronous JS

## Intro

### When Will We Need This? (5 mins)

The concepts we're going to talk about happen most often in the following situations:

- Loading external data (APIs, files, databases)
- Events (clicks, keydowns, scrolls, etc)
- Enumerables (forEach, map, filter)

### Synchronous Vs Asynchronous (45 mins)

Watch: [What is Asynchronous JavaScript?](https://www.youtube.com/watch?v=YxWMxJONp7E)

#### The Event Loop

We now know that JavaScript runs synchronously.

JavaScript's **call stack** is a data structure that keeps track of where we are in the sense of this synchronous thread of execution.

"If we step into a function, we step into the stack. If we return from a function, we pop off the top of the stack." - Philip Roberts

Asynchronous processes are able to run concurrently because, while the JS runtime can only execute a single thread, your browser provides more threads for you. Async takes advantage of this and passes processes to the **event loop**, where it will take the time it needs to execute and pop back onto the call stack by way of a **queue** once it's ready.

Let's watch Philip Roberts further explain: [Philip Roberts, JSConf EU 2014](https://www.youtube.com/watch?v=8aGhZQkoFbQ)

### Callbacks (20 minutes)

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

You've seen callbacks before in enumerables, but also in event listeners. Take this example:

```js
$("#my-button").on('click', function() {
  alert("You clicked my button!");
})
```

You've probably seen a click event handled like this before. You pass a function to be executed later upon a `'click'` event. I want to frame this in a slightly different way to help you understand how JavaScript interprets this. I'm going to write the same thing in without jQuery to help illustrate.

```js
document.getElementById('my-button').addEventListener('click', function() {
  alert("You clicked by button!");
})
```

The method `addEventListener()` does a better job of telling you what's actually happening. When writing asynchronous JavaScript, it can sometimes feel like your code is being run out of order. JavaScript is still being read from top to bottom. When it gets to the `addEventListener()`, it does just that. It adds a listener to the element, and it moves on to its next instruction. It's not that JavaScript comes back to this code later. You packed it up and sent it off. Your callback function now exists all alone, waiting to be invoked by the browser upon a 'click' event.

#### Callbacks with Asynchronicity

`setTimeout()` is another function that takes a callback. It's an easy way to play around with asynchronicity. It is also tied to an event, but that event happens to be "some number of milliseconds passed".

```js
setTimeout(function() {
  alert("1 second has passed");
}, 1000);
```

`setTimeout()` sends its callback function to the event loop. After 1000 milliseconds (2nd parameter), the callback function (1st parameter) is then added back to the queue, ready to be added back to the stack once the stack is free.

### [Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) (10 minutes)

Promises solve a similar problem as callbacks. They execute an asynchronous processes and can handle both the finished success or failure of said process. A couple things to keep in mind about promises while we're seeing them in action:

- A `Promise` is yet another data type in JavaScript. You can assign it to a variable, it has methods and you can create new instances of it.
- The methods of `Promise` (specifically `.then()`) make more sense in the context of "executing things in order" rather than "packing up code for later"

Let's take a few minutes to read through MDN's [Promise documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise). Pay attention to the structure you see implemented in their examples.

#### Promise Chaining

Let's look at an example of a `Promise` in action: [https://repl.it/KWQp/4](https://repl.it/KWQp/4)

Notice how `.then()` controls the flow of the data returned from the successful `Promise` resolution.

Thus, `.catch()` would only be triggered had the `Promise` not resolved successfully.

Where have we seen something like this before?

### AJAX Deferred Objects === Promises? (20 minutes)

We've seen the chainable `.then()` and `.catch()` quite often thanks to AJAX. But are AJAX requests returning Promises to us?

Surprisingly, they're technically not. jQuery AJAX requests actually return to us [`Deferred` objects](https://api.jquery.com/category/deferred-object/). They look like `Promises`, they act like `Promises`, but technically they are not `Promises`.

Regardless of what they technically are, these `Deferred` objects are likely your most common use-case for asynchronous JavaScript.

Think back to the original reason we use AJAX - we want to request something (usually data) from somewhere else, but we're not sure how long it'll take to get that response.

AJAX is able to take advantage of the concurrency / event loop we were speaking about earlier to allow our program to continue running while our AJAX request resolves.

#### Chainable AJAX Examples

Let's look through a few examples:

[AJAX with Callbacks](https://repl.it/KWjo/latest)

[Successful AJAX with `.then()`](https://repl.it/KWkD/latest)

[Erroneous AJAX with `.catch()`](https://repl.it/Hcsi/latest)


#### Checks for Understanding (10 minutes)

Discuss the following with the person next to you:

- How are callbacks, promises and deferred objects similar?
- How are they different?
- What's something you can do with promises that you can't do with callbacks?
- How would you describe asynchronicity to a 5 year old?

## Application of Knowledge

### Experiments in Ordering (10 minutes)

For each of these, read through the code, and try to predict what interactions will happen. Then run the code in your browser's console to verify your assumptions.

```js
var balloon = "empty";

setTimeout(function() {
  balloon = "filled";
  console.log(`async balloon is ${balloon}`);
}, 1000)

console.log(balloon);
```

```js
var balloon = "empty";

$('body').on('click', function() {
  balloon = "filled";
  console.log(`async balloon is ${balloon}`);
});

console.log(balloon);
```

## Speaking Asynchronously (25 minutes)

Talk through the following code snippets with your partner. Answer the following questions:

- What is happening on each line?
- What are some of today's new concepts that are being used in the snippet?
- How could you reuse the functions that have been defined in another case?

### In Pairs

Alternate who takes the lead in answering the questions for the following 4 snippets:

1.
  ```js
  function callbackSandwich(callbackFunction) {
    console.log('Top piece of bread.');
    callbackFunction();
    console.log('Bottom piece of bread.');
  }

  callbackSandwich(function () {
    console.log('American cheese.')
  });
  ```
2.
  ```js
  function printClickTarget(event) {
    alert("You clicked " + event.target.id + "!");
  }

  document.getElementById('my-button').addEventListener('click', printClickTarget)
  ```
3.
  ```js
  $.get("https://api.github.com/users/turingschool/repos")
    .then(function(repos) {
      return repos[0]
    }).then(function(repo){
      console.log(repo.name);
    }).catch(function(){
      console.log("something went wrong");
    })
  ```
4.
  ```js
  var randomMerchantRevenue;
  $.get("/api/v1/merchants/random.json", function(merchant) {
    $.get("/api/v1/merchants/" + merchant.id + "/revenue.json", function(revenue) {
      randomMerchantRevenue = revenue.total_revenue;
    })
  })

  console.log(randomMerchantRevenue)
  ```

## Going Further

Here's a couple JavaScript concepts you'll sometimes see associated with asynchronicity. They're worth glancing over to avoid being completely confused when you come across them.

**[Generators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*)**

A lot of the same "running code at a later time" can be done using generators. You know you're working with a generator when the function has a `*` at the end, and the keyword `yield` is used inside the function.

**[Async and Await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)**

These are a pair of keywords defined in ES7. They're just another way to ensure that things happen in a given order, but not necessarily at any given time.
