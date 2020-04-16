---
title: Getting Started With Fetch
length: 180
tags: JavaScript, fetch, APIs, front-end, async, asynchronous
---

### Learning Goals

*   Understand the difference between synchronous and asynchronous operations
*   Access APIs from client side JavaScript using the Fetch API.
*   Explain the difference between client-side and server-side.

## JavaScript Refresh  
Talk with a partner about the following:  

* How do you declare and assign a variable?  
* What tools are available for debugging in JavaScript?  
* How are functions declared in JavaScript?

### Variables

Variables are declared with `var <variableName>` in `camelCase`. ES6 introduced the keywords `let` or `const` which behave slightly differently, but we won't get into that today.  

### Debugging in Javascript

Debugging JavaScript is a different beast than debugging Ruby. Because JavaScript is run entirely in the browser, the technique for troubleshooting broken code is more complicated than `binding.pry`. Luckily, modern browsers are aware of this and give us a collection of options for digging into your code.

#### 1. Developer Tools

One of the first things you should familiarize yourself with when working with JavaScript (or HTML...or CSS...) are the dev tools. You can find a cool tutorial to dive deeper with  [Code School's Discover-DevTools Tutorial.](http://discover-devtools.codeschool.com/) (Chapters 3 & 4 are particularly helpful)

To open developer tools in Chrome:
-   Mac: `Cmd` + `Opt` + `i` (or `Cmd` + `Opt` + `j`)
-   (or) Right click on the browser window and select `inspect`
-   (or) Select `View` in the navbar, then `Developer`, then `Developer Tools`

When working with JavaScript, it is useful to keep your console open at all times to watch for errors and anything you've told your code to print out. Bringing us to...

#### 2. console.log()

`console.log()` is to JS what `puts` is to Ruby. This line of code will print whatever is provided as an argument to the console.

Given the following function called `printStuff()`, adding console.log() will print the value of `myVariable` to the console.

```js
var printStuff = function(){
  var myVariable = 5 + 5;
  console.log(myVariable);
}

printStuff();
=> 10
```

If you're confused about what a variable or function is returning, throw `console.log()` into your code or directly into the `console` in your browser to confirm/deny suspicions.

#### 3. `debugger;`

Debugger is the `pry` of JS. Stick `debugger;` within a function to pause the browser from running the script when it hits a particular part of your code.

For more details and information about other ways to dig into your JavaScript, check out the [Chrome Documentation](https://developer.chrome.com/devtools/docs/javascript-debugging).  

### Functions  

There are multiple ways we will see functions in JavaScript.  

**function expression:**
(Where an anonymous function is saved to a variable, can only be called after it is set to a variable)  
```
var myFunction = function(param) {
  do a thing with the param;
};
```  

**function declaration:**  
(A function with a name, can be called form anywhere)  
```
function myFunction(param) {
  do a thing with the param;
};
```

**callback:**
(A function that is passed to another function as a parameter)

You're familiar with the array method `.map` in Ruby - JavaScript has an array prototype `.map()` that also iterates through an array and returns an array. Here's an example:

```js
const array = [1, 2, 3, 4];

array.map(function(number) {
  console.log(number)
})
```

This would iterate through the array and `console.log` each element. The **callback** is the parameter of the `map()`:

```js
function(number) {
  console.log(number)
}
```

## Asynchronous JavaScipt IRL

Let's say we're getting ready for the day, and stop at Starbucks on the way to school:

* **Synchronous:** I go through the drive thru window, meaning each car will get it's coffee in order. Even if that means I have to wait extra long because the car in front of me ordered pastries for their whole office 🙄

* **Asynchronous:** I go inside. The guy in front of me ordered a trenta soy caramel latte extra hot, then I ordered a tall Pike. I will get my coffee first, because it was quicker to make! ☕️

#### Example 1: Some `console.log`ging

In what order do we expect to see these three `console.log`s print?
```
console.log("I am first");
console.log("I am second");
console.log("I am last");
```

Check it out in the browser.

We know `console.log`s are quick, but what if that second one was a function making a network request that was going to take a second or two? The third `console.log` would not run until the previous line of code was executed. This presents a problem on the front-end.

<!-- insert quote from jhun on need for speed -->


In what order do we expect to see these three `console.log`s print?
```
console.log("Legen...");

setTimeout(() => {
  console.log("DARY!");
}, 2000);

console.log("Wait for it...");
```

Copy and paste this entire snippet into your console in the browser - see what happens!

`setTimeout()` is actually an asynchronous function, which executes its' callback after waiting for the allotted time to expire. We will dig into the details of how that works under the hood in Mod 4. For now, please just trust me.

#### Example 2:

* **Synchronous:**

```
|<----A---->||<-----B--------->||<----C-------------->|
```

* **Asynchronous:**
```
|<----A---->|
     |<-----B--------->|
        |<----C-------------->|
```


#### Questions:

* Why are async operations necessary?
* How would you explain synchronous vs. asynchronous to a 5 year-old?

## `fetch()`

You may have come across `ajax`, which jQuery gives us. It has it's benefits and is definitely still used, but another great tool to make network requests is the [fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API), which we will focus on implementing today.

From the docs:

_The fetch() method takes one mandatory argument, the path to the resource you want to fetch. It returns a promise that resolves to the response to that request, whether it is successful or not._


```
fetch('https://opentdb.com/api.php?amount=1&category=27&type=multiple')
```

The URL, our one mandatory argument, can be enclosed in quotes or back-ticks (you'll see the advantage of the back-ticks later!)

Next we see that fetch returns a promise that resolves to the response of of our request. We haven't talked about promises yet, but all you need to know for now is that we can call `.then(callback)` which will execute our callback as soon as the response comes in... or in other words... it will wait until we have ALL of the data (or an error) back, `THEN` it will execute whatever we say to do next with that data.

```
fetch("https://opentdb.com/api.php?amount=1&category=27&type=multiple")
  .then((response) => console.log(response))
```

If `then()` is waiting in line like a car in the drive-thru at Starbucks, what about this is A-synchronous? The entire `fetch()` is what's asynchronous; other functions can run in the background while we are making this entire request. It's necessary that the `then()` blocks behave synchronously and wait on resolution of the previous promise in order to do their jobs.

If you plug the code above into your console, you should see the Response object come back. There's one problem however, we can't seem to get the data we want from the Response.body. There's one more step to parse the response (much like you do when pulling things from localStorage). We'll need to use the **`Body.json()`** method that comes with fetch to parse it and call another `.then()`.

From the docs, the `.json()` method returns "A promise that resolves with the result of parsing the body text as JSON. This could be anything that can be represented by JSON — an object, an array, a string, a number..."

In short, it gives us access to the response!

```
fetch("https://opentdb.com/api.php?amount=1&category=27&type=multiple")
  .then((response) => response.json())
  .then((response) => console.log(response))
```

Lastly, we can add in a `.catch()` to account for any errors we may run into.

```
fetch("https://opentdb.com/api.php?amount=1&category=27&type=multiple")
  .then((response) => response.json())
  .then((response) => console.log(response))
  .catch((error) => console.error({ error }))
```

## [Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises)

"A Promise is an object representing the eventual completion or failure of an asynchronous operation"

In our case, we can think of Promises as a placeholder that will do something once it receives a response back from the server.

The great thing about promises is that since they are just objects we can move them around like an object and can return them from functions.

```
function getTrivia(number, categoryId) {
	const root = 'https://opentdb.com/api.php';
	const url = `${root}?amount=${number}&category=${categoryId}&type=multiple`;
	const promise = fetch(url)
	                .then((response) => response.json());

	return promise;
}

getTrivia(10, 27)
.then((response) => console.log(response))
.catch((error) => console.error({ error }));
```

## Practice Time!

Clone down [this repo](https://github.com/turingschool-examples/b3-fetch-intro) and run `npm install` then `npm start`.

We are going to make this color-picker application work! We will need to make two of each of the following requests: GET, POST, and DELETE. We will do one together, then you'll complete the second with people at your table.

## Wrap Up

- What is asynchronous JavaScript?
- What is a callback in JavaScript?
- What is the mandatory argument for `fetch()`? What else might you include in a request, and why?
- What is a promise?
- What considerations do we need to make when we have a front-end and a back-end?

### Additional Resources

*   [MDN Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
*   [MDN Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)
*   [jQuery Promises and Deferred](http://www.i-programmer.info/programming/jquery/4788-jquery-promises-a-deferred.html)
*   [MDN AJAX](https://developer.mozilla.org/en-US/docs/AJAX)

### Readings

*   [David Walsh Blog - Fetch](https://davidwalsh.name/fetch)
*   [AJAX: History](http://www.phpasks.com/articles/historyajax.html)
*   [Client Side vs Server Side](http://www.codeconquest.com/website/client-side-vs-server-side/)
*   [More Client Side vs Server Side](http://skillcrush.com/2012/07/30/client-side-vs-server-side/)

### Video on AJAX

*   [Video](https://vimeo.com/131025914)
