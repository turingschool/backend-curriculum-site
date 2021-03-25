---
title: Module Exporting and Require
layout: page
---

*TL;DR*: Javascript doesn’t export/import files automatically for you. You’ll have to understand how to use `require` and `module.exports` in order to connect everything. 

### How things are connected

In Javascript, files are not explicitly connected as they are in Rails. In Rails, we are given something called ActiveSupport, which gives us the ability to have access to various files in our application. 

Let’s say we have a `greetings.js` file, where we want to simply print “Hello!” 

```javascript
// In greetings.js
function hello() {
	console.log("Hello!")
}
```

Now let’s say we want to use this function in another file called `app.js`

```javascript
// In app.js
hello();
```

What happens when we do this? It doesn’t look like we have access to this function! So what can we do? We have a special thing called `module.exports`

### Discussion and research: What is module.exports? 

Now that we know more about `module.exports`, let’s use it! 

```javascript
// In greetings.js
function hello() {
	console.log("Hello!")
}

module.exports = hello;
```

Let’s `console.log` what module.exports returns. After you’re finished, try to call `hello()` again. What happens? 

To pull your new `hello()` function into `app.js`, we’ll need to use the `require` function. 

```javascript
// In app.js
var hello = require("./greetings.js")

hello();
```

### Discussion and research: What is the require function? 

So what happens if we want to export multiple functions? 

```javascript
// In greetings.js
function hello() {
	console.log("Hello!")
}

function bye() {
	console.log("Bye!")
}


module.exports = hello;
module.exports = bye;
```

What happens when we export both of these functions? Console log what `module.exports` returns. 

Instead, we can pass each of our new functions into an object that can be exported.  

```javascript
// In greetings.js
function hello() {
	console.log("Hello!")
}

function bye() {
	console.log("Bye!")
}


module.exports = {
	hello: hello,
	bye: bye
}
```

Now try to use `require` in your `app.js` file. What happens again? Let’s change some things around so that we can use both functions. 

```javascript
// In app.js
var greetings = require("./greetings.js")

greetings.hello();
greetings.bye();
```


### Discussion: How can you export and require files within other folders?
