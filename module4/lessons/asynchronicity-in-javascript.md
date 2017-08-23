---
title: Asynchronicity in JavaScript
layout: page
---

## Learning Goals

- Students can use promises and callbacks to execute logic asynchronously
- Students can read and explain code that uses callbacks and promises to execute asynchronous logic

## Intro

### When Will We Need This?

The concepts we're going to talk about happen most often in the following situations:

- Loading external data (APIs, files, databases)
- Events (clicks, keydowns, scrolls, etc)
- Enumerables (forEach, map, filter)

### Synchronous Vs Asynchronous

- [What is Asynchronous JavaScript?](https://www.youtube.com/watch?v=YxWMxJONp7E)

#### The Event Loop

We now know that JavaScript runs synchronously.

JavaScript's "call stack" is a data structure that keeps track of where we are in the sense of this synchronous thread of execution.

"If we step into a function, we step into the stack. If we return from a function, we pop off the top of the stack." - [Philip Roberts, JSConf EU 2014](https://www.youtube.com/watch?v=8aGhZQkoFbQ)

Asynchronous processes are able to run concurrently because, while the JS runtime can only execute a single thread, your browser provides more threads for you. Async takes advantage of this and passes processes to the "event loop", where it will take the time it needs to execute and pop back onto the call stack once it's complete.
<!--
## How JS implements asynchronicity

### Packing up code for later

Part of understanding asynchronicity is knowing how to pack up code to execute upon some later event. Packing up code and passing it around isn't actually all that foreign if you're coming from Ruby. Think about this code:

```ruby
[1,2,3].each do |num|
    puts num * 2
end
```

Between the `do` and `end`, you're actually passing a code block to the `each` enumerable. The code in that block will be executed, multiple times.

We've talked about it already, but packing up code for later is done with functions in JavaScript.

```javascript
function doubleNumber(num) {
    console.log(num * 2);
}
[1,2,3].forEach(doubleNumber);

// Or with an inline anonymous function expression

[1,2,3].forEach(function(num) {
    console.log(num * 2);
});
```

#### Checks for Understanding

Discuss the following with the person next to you:

- What are some instances where you would pass a function?
- What is the syntax for passing a function?
- What is the syntax for invoking a function?
- When passing a function as a parameter, how are the arguments of the passed function used? -->

### Callbacks

A callback is a second function that is being passed as a parameter to a first function and will be invoked by the original function.

For example:

```js
function doubleNumber(num) {
  console.log(num * 2);
}

[1,2,3].forEach(doubleNumber);
```

#### Callbacks and Events

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

`setTimeout()` is another function that takes a callback. It's an easy way to play around with asynchronicity. It is also tied to an event, but that event happens to be "some number of milliseconds passed".

```js
setTimeout(function() {
  alert("1 second has passed");
}, 1000);
```

After 1000 milliseconds (2nd parameter), the callback function (1st parameter) is added the the event loop.

### Promises

Promises solve a similar problem as callbacks. They're all about executing code upon some later event. A couple things to keep in mind about promises while we're seeing them in action:

- A `Promise` is yet another data type in JavaScript. You assign it to a variable, it has methods and you can create new instances of it.
- The methods of `Promise` (specifically `.then()`) make more sense in the context of "executing things in order" rather than "packing up code for later"

Let's take this callback example and refactor it to use promises.

<https://repl.it/Hcsi/2>

#### Promise Chaining

Each `.then()` returns another instance of `Promise`. Which means you can chain your `.then()`s. Let's refactor the promise we just made to use promise chaining.

Another refactor example would be to use our `.then()`s to keep things in order. If you had one AJAX call that had information you needed for a second call, which has information you need for a third call:

<https://repl.it/HcuB/2>

#### Error handling

In addition to `.then()`, you can also add `.catch()` to the chain. Then, if any error is thrown in the chain, you can call a different function to handle the error.

<https://repl.it/HdHR>

#### Checks for Understanding

Discuss the following with the person next to you:

- How are callbacks and promises the same?
- How are callbacks and promises different?
- What's something you can do with promises that you can't do with callbacks?
- How do you know what arguments your callback function will be called with?
- How do you know what arguments your promise function will be called with? (it's the same answer)

## Application of Knowledge

### Experiments in ordering

For each of these, read through the code, and think about what is going to happen. Then run the code in your browser's console to verify your assumptions.

```js
var balloon = "empty";

setTimeout(function() {
  balloon = "filled";
}, 1000)

console.log(balloon);
```

```js
var balloon = "empty";

$('body').on('click', function() {
  balloon = "filled";
})

console.log(balloon);
```

## Speaking asynchronously

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
  $.get("https://api.github.com/users/neight-allen/repos")
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

## Stuff we haven't covered

Here's a couple JavaScript concepts you'll sometimes see associated with asynchronicity. I just want you to file this in a dusty part of your mind so you aren't completely confused when you see them.

**[Generators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*)**

A lot of the same "running code at a later time" can be done using generators. You know you're working with a generator when the function has a `*` at the end, and the keyword `yield` is used inside the function.

**[Async and Await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)**

These are a pair of keywords defined in ES7. They're just another way to ensure that things happen in a given order, but not necessarily at any given time.

## What's next for you?

In the Quantified Self project, you'll be using callbacks and/or promises for the following:

**Database Queries**

The database is an external data source. JS doesn't have time to wait for the DB to do it's thing, so it's an asynchronous interaction.

**Integration Testing**

When you learn how to test your application with Selenium, you'll often have to wait for the browser to react to your actions, or complete some task before you can check the state of things. So the selenium library is heavily asynchronous.

**AJAX**

When you integrate your front end JS with your back end JS, you'll be using AJAX to pass data back and forth. JS won't wait for the whole HTTP across the internet thing, so we use asynchronicity to keep our logic in order.
