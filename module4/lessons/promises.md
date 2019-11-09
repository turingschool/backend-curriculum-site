---
layout: page
title: Intro to Promises
---

## Promises
> A Promise is an object that represents the eventual completion or failure of an asynchronous operation, and its returning value.

The three primary states of Promises are the following:

- Pending
- Resolved
- Rejected

## What do Promises Give Us?

By using a Promise object, a function does two things:

1. It automatically becomes asynchronous, allowing it to run in the background and giving the rest of our code a chance to continue execution.
2. It gives us access to two methods - `.then` and `.catch`

## Why Use Promises?
Promises allow you to multi-task a bit in JavaScript. They provide a cleaner and more standardized method of dealing with tasks that need to happen in sequence. With Promises, we have more control over what happens with the outcomes of our async processes.

## When to use Promises
The short answer: whenever you're handed a promise by an API you didn't write, where the author chose to use promises. This includes many modern web APIs such as `fetch`.

When you read the documentation for a library that uses promises, one of the first sentences will likely say 'this is a promise-based library'. There are some APIs that still use callbacks rather than promises (the `geolocation` API, for example). You'll want to read the documentation closely to see if the library expects you to use a promise or callback. So for once, we don't really have to be in charge of making a decision here -- we can let the tools and technologies we're using dictate whether or not we should be using promises.

### Advantages of Promises

So besides the obvious syntactical benefits, what are some of the others advantages of promises?

- You are getting an IOU that you're holding on to rather than giving your code away as you would with callbacks.
- Error handling is less broken. It's not a silver bullet. Synchronous functions either `return` or throw an error. In a similar vein, your promises will either become *resolved* by a value or become *rejected* with an error.
- You can catch errors along the way and deal with them in a way that is *similar* to synchronous code.
- Chaining promises is easy and does not result in callback hell.

But wait, there's more.

- `Promise.all` can take an array of promises and waits until all of the promises are resolved. This solves the nastiness involved in doing this with various callbacks. You can read more about it [right here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/all).

## But you promised me
Let’s use this time to play around with some basic ideas and concepts with Promises. 

#### Getting started

Before we get started, let’s pull down a super basic repo that we can use to play around with Promises. You can find that [repo here](https://github.com/corywest/base_js). Once you have that repo cloned down, we’ll open up the `scripts.js` file and start writing some basic JS. We’ll go over exactly what we need to write in this file, so don’t worry!  

#### A basic Promise

Write a basic promise in JS is really simple. In our `scripts.js` file, let’s write the following below:

```javascript 
promise = new Promise()
```

If we return to our terminal and type in `open index.html`, a browser window will open with our new JS code loaded into the DOM. The way we can see this is if we type in `command option i`. This will open up up your inspector tool. 

Once you have this open, you’ll probably encounter an error message like:

```javascript 
Uncaught TypeError: Promise resolver undefined is not a function
at new Promise (<anonymous>)
at <anonymous>:1:15
(anonymous) @ VM77:1

```

Not off to a good start. This error a bit cryptic but luckily we know what’s missing. The Promise wants to be passed a function as its first argument, so let’s do that first and see what happens. 

```javascript 
promise = new Promise(() => {
});
```

Let’s reload our browser page and checkout what promise returns to us. What do we see when we type in and run `promise` into our inspector tool? 

#### Using a Promise

Let’s go a little further and see what we can actually do with promises. Remember that Promises have a few states that a Promise can be in. What were those again? 

`Pending`
`Resolved`
`Rejected`

Promise can actually take additional arguments when you create one. The first argument if often called `resolve` while the second argument is often called `reject`. If we use one of those arguments in the Promise itself, we can actually change the state of the Promise instantaneously. Let’s try this:

```javascript 
promise = new Promise((resolve, reject) => {
  resolve();
});
```

As you can see here, we are taking the first argument and invoking it with the parenthesis. What happens when we checkout this promise in our inspector tool again? 

Now let’s do the same with the `reject` argument as well. What happens with that? 

#### Then and Catch

Both, `then` and `catch` are functions that come along with Promises. They let us do something when the Promise comes in. If you were create a Promise and resolve it, we could easily continue to do work with it. Let’s try this bit of code below: 

```javascript
promise = new Promise((resolve, reject) => {
  resolve();
});

promise.then(() => {
  console.log("The promise was resolved!")
});
```

A cool thing about using `.then` is that we can chain more of them together. 

```javascript
promise = new Promise((resolve, reject) => {
  resolve();
});

promise.then(() => {
  console.log("This ran first")
}).then(() => {
  console.log("I was also ran!")
});
```

If we want to see the `.catch` runs, what would we need to do? You’ll need to reject the Promise. A `.catch` won’t run unless the Promise has been completely rejected. We can see this happen below:

```javascript
promise = new Promise((resolve, reject) => {
  reject();
});

promise.then(() => {
  console.log("This ran first")
}).then(() => {
  console.log("I was also ran!")
}).catch(() => {
	console.log("My promise was rejected!")
});
```

As you can see, the other messages in the `.then`’s never fired off. This is because of the Promise rejection. 

#### Beyond the basics

So how do we usually use these things? All that Promise stuff is cool, but we need a way to actually use them. This is where `fetch` comes into play. In the next lesson, we’ll start digging into how to use `fetch` and why Promises play an important role in how we can make our JS code a bit more performant and dynamic.
