---
layout: page
title: JavaScript Outside of the Browser
subheading: with node.js
---

Javascript Does It's Thing
------------------

Traditionally JavaScript is executed client-side, or in the browser on the consumers own computer. This is made possible by a browsers JavaScript Engine. Firefox's engine is called SpiderMonkey, and Chrome's is called V8.

### Let's look at V8:

*   First version released with first version of chrome in 2008
*   Compiles JS to native machine code

### Today, We'll look into node.js. What is it?

According to [nodejs.org](nodejs.org) node, in it's most basic form, "is a JavaScript runtime built on Chrome's V8 JavaScript engine."

#### aside: NPM

NPM (Node Package Manger) allows for organization of outside packages much like Ruby Gems.

### Installing Node:

*   Jump over to [https://nodejs.org/en/](https://nodejs.org/en/) and download node.
*   Done

When you download node - you also get npm

### What Can We Do With Node?

With node.js, we can execute basic JavaScript code in the terminal. Think back to Module 1 when we did this with ruby. We can also spin up a server to listen to a specific port, but today we're just focusing on executing JavaScript outside of the browser.

Basic Examples:

The first example we're going to look at is our basic HelloWorld.

*   Navigate to a location that you want to put these examples.

```terminal
mkdir node-sandbox
touch node-sandbox/hello-world.js
cd node-sandbox
```

next open the `hello-world.js` file in your text editor. Inside that file we will add the following code:

```js
console.log("I'm being executed in the terminal!!!")

var helloWorld = "Hello World!!"

console.log(helloWorld)
```

Run your file:

```terminal
$ node hello-world.js
```

Your output should look a little like this:

```terminal
$ node hello_world.js
hello world
```

Pretty simple, right? Remember V8? V8 is leveraged by node and is what allows us to execute JavaScript outside of the browser and in the terminal.

I think you get the point already, but lets look at one more basic example.

```terminal
touch add.js
```

Open `add.js` in your editor and add this code:

```js
function add(num1, num2){
  return num1 + num2
};

console.log( add(1,3) )
```

Now, execute the code:

```terminal
$ node add.js
```

Your output should look a little like this:

```terminal
$ node add.js
4
```

Pair Up!
----------

### Test that Node!

Let's test our JavaScript file!

Export the function from the `add.js` file.

```js
function add(a, b) {
  return a + b
}

module.exports = add
```

We also need to create a test file. Let's make a new test directoy `mkdir test` and inside of that directory `touch test/add-test.js`.

We will also need a few npm packages for this.

`npm i mocha`

`npm i chai`

Let's setup our `add-test.js` file.

```js
const assert = require('chai').assert
```

This will allow us to use the `chai` library.

Next, let's add the module that we exported from `add.js`.

```js
const assert = require('chai').assert
const add = require('../add')
```

In the above snippet, we are using the constant that has the same name as our exported function and finding the file via its file path.

Now we are ready to write a test!

```js
const assert = require('chai').assert
const add = require('../add')

describe('add functionality', function() {
  context('add function', function(){
    it('it can add two numbers', function(){
      assert.equal(addNumbers(7,8), 15)
    })
  })
})
```

To run the tests, type `mocha test/add-test.js`. If all is set up correctly, we should have a passing test!

### Let's work on a few challenges:

*   [Character Count](https://github.com/turingschool/challenges/blob/master/character_count.markdown)
*   [fibonacci](https://github.com/turingschool/challenges/blob/master/fibber.markdown)
