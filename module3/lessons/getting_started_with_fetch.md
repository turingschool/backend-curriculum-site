---
title: Getting Started With Fetch
length: 180
tags: JavaScript, fetch, APIs, front-end, async, asynchronous
---

### Learning Goals

*   Understand the difference between synchronous and asynchronous operations
*   Make all CRUD functionality fetch requests.
*   Access APIs from client side JavaScript using standard HTTP verbs.
*   Explain the difference between client-side and server-side.

## JavaScript Refresh  
Talk with a partner about the following:  

* How do you declare and assign a variable?  
* How do you access the developer tools in your browser?  
* What are two debugging tools?  
  (Think, what is similar to puts and pry?)

### Variables

Variables are declared with `var <variableName>` in `camelCase`. ES6 introduced the keywords `let` or `const`, which behave slightly differently, but we won't get into that today.  

### Debugging in Javascript

Debugging JavaScript is a different beast than debugging Ruby. Because JS is run entirely in the browser, the technique for troubleshooting broken code is more complicated than `binding.pry`. Luckily, modern browsers are aware of this and give us a collection of options for digging into your code.

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

#### 3. Debugging In the Console

Debugger is the `pry` of JS. Stick `debugger;` within a function to pause the browser from running the script when it hits a particular part of your code.

```
// index.js
$('#search-ideas').on('keyup', function() {
  var currentInput = this.value.toLowerCase();

  $ideas.each(function (index, idea) {
    var $idea = $(idea);
    var $ideaContent = $idea.find('.content').text().toLowerCase();
    debugger;
  });
```

In the browser, if we open up the dev tools, navigate to the console and try to search for something.  The program will freeze on the line `debugger`. This lets us type stuff into our `console` to see what's going on.

*NOTE - The console must be open for debugger to catch, otherwise the app will look normal and you won't get any error messages - if you get stuck, refresh your page while the console is open and go from there.*

For more details and information about other ways to dig into your js, check out the [Chrome Documentation](https://developer.chrome.com/devtools/docs/javascript-debugging).  
### Functions  

There are multiple types of functions in JavaScript.  
In ES5, there are function expressions and function declarations.

function expression:  
(where an anonymous function is saved to a variable, can only be called after it is set to a variable)  
```
var myFunction = function(param) {
  do a thing with the param;
};
```  
function declaration:  
(a function with a name, can be called form anywhere)  
```
function myFunction(param) {
  do a thing with the param;
};
```

## Asynchronous JavaScipt

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

We know `console.log`s are quick, but what if that second one was a network request that was going to take a second or two? The third `console.log` would not run until the previous line of code was executed. This presents a problem on the front-end.

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

`setTimeout()` is actually an asynchronous function, which executes its callback after waiting for the allotted time to expire.

#### Example 2:

* **Synchronous:**

```
|<----A---->||<-----B--------->||<----C-------------->|
```

* **Asynchronous:**
```
|<-----------------A---------------------------->|
     |<------------B---------------------------------->|
             |<----C-------------->|
```


#### Questions:

* Why are async operations necessary?
* How would you explain synchronous vs. asynchronous to a 5 year-old?

## `fetch()`

## Promises


## Practice Time!


## Wrap Up

Where would you use AJAX as a tool within a Rails Context?  
What are some use cases for AJAX vs a page refresh?  
What are three keys you might include in an AJAX Post request?

### Additional Resources

*   [How to use $.ajax()](http://www.sitepoint.com/use-jquerys-ajax-function/)
*   [Basics of Jquery AJAX](http://www.i-programmer.info/programming/jquery/8895-getting-started-with-jquery-ajax-the-basics.html)
*   [jQuery Promises and Deferred](http://www.i-programmer.info/programming/jquery/4788-jquery-promises-a-deferred.html)
*   [MDN AJAX](https://developer.mozilla.org/en-US/docs/AJAX)
*   [MDN Getting Started with AJAX](https://developer.mozilla.org/en-US/docs/AJAX/Getting_Started)
*   [jQuery $.ajax()](http://api.jquery.com/jquery.ajax/)

### Readings

*   [AJAX: History](http://www.phpasks.com/articles/historyajax.html)
*   [More AJAX History](http://www.softwareengineerinsider.com/programming-languages/ajax.html#context/api/listings/prefilter)
*   [Client Side vs Server Side](http://www.codeconquest.com/website/client-side-vs-server-side/)
*   [More Client Side vs Server Side](http://skillcrush.com/2012/07/30/client-side-vs-server-side/)

### Video

*   [Video](https://vimeo.com/131025914)
