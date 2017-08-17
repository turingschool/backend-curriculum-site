---
layout: page
title: JavaScript Outside of the Browser
subheading: with node.js
---

Javascript Does It's Thing
------------------

Traditionally JavaScript is executed client-side, or in the browser on the consumers own computer. This is made possible by a browsers JavaScript Engine. Firefox's engine is called SpiderMonkey, and Chrome's is called V8.

### Today, We'll look into node.js. What is it?

According to [nodejs.org](nodejs.org) node, in it's most basic form, "is a JavaScript runtime built on Chrome's V8 JavaScript engine."

#### aside: NPM

NPM (Node Package Manger) allows for organization of outside packages much like Ruby Gems. We'll cover it in more depth later on.

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
I'm being executed in the terminal!!!
Hello World!!
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


Test that Node!
--------------

Mocha - the test runner
-------------

Mocha has one job, to run your tests. It doesn't even do assertions. We'll get to that in a minute.

To install mocha for use in your terminal, run:

```bash
  npm install mocha -g
```

The `-g` installs a package globally, and for use on the command line. So let's write some mocha tests.

Mocha gives you a few functions right off the bat. You might recognize them if you're used to using RSpec:

```js
  describe()
  context()
  it()
```

They're used similarly to RSpec. The biggest different how you pass a block to the function. Since there isn't a `do...end` in JavaScript, we pass a "callback" function:

```js
describe("Something that I'm describing", function() {
  context("That thing under some context", function() {
    it("does a thing", function() {

    });
  });
});
```

For future reference: If you're familiar with ES6 [Arrow Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions), these will make your callbacks slightly less verbose. I'm not going to bother with them for this lesson.

Save the above text in a file named `test/test.js`. Then run

```bash
mocha test/test.js
```

You should see something like

```
Something that I'm describing
  That thing under some context
    ✓ does a thing


1 passing (8ms)
```

The test passes, because there aren't any assertions that fail. Although Mocha doesn't handle assertions, it's built on Node, which does have some [built in simple assertions](https://nodejs.org/api/assert.html). Here's a simple test using built in Node based assertions:

```js
assert = require('assert');

it("can assert true", function(){
  assert(true, 'TRUE IS FALSE! UP IS DOWN! DAY IS NIGHT!');
});
```

A couple things to note about the test above:

1.  `describe()` and `context()` are not necessary. Typically, you'll want at least a `describe()` block to tell us what it is you're testing, but can omit context if you don't think it's necessary.
2.  `assert` is a "node module". It doesn't come pre-loaded, so we have to require it. In node, as opposed to Ruby, you have to capture the return value of a `require`.
3.  Like RSpec, I can have an optional message as part of my assertion which will be displayed if the assertion fails. If `true` is somehow false, something has seriously gone wrong.

Node's built in `assert` module isn't very fully featured. A popular assertion library for JavaScript is called [Chai](http://chaijs.com/). This is what we're going to use. You can install it by typing the following in your terminal.

```bash
npm install chai
```

You can confirm that chai installed properly by looking for it in the `node_modules` folder. If npm didn't create this folder for you, go ahead and `mkdir node_modules` and try the install command again.

Now, modify your `test.js` to the following:

```js
assert = require('chai').assert;

it("can assert true", function(){
  assert(true, 'TRUE IS FALSE! UP IS DOWN! DAY IS NIGHT!');
});
```

And `mocha test/test.js` should return the same output as when we were using Node's assertion library. Let's try out a few more of Chai's assertions.

```js
assert = require('chai').assert;

describe("Chai Assertions Sandbox", function(){
  it("can assert true", function(){
    assert(true);
  });

  it("can assert 1 is 1", function(){
    assert.equal(1, 1);
  });

  it("can assert 2 is not 3", function(){
    assert.notEqual(2, 3);  
  });

  it("can assert that something is a given data type", function(){
    assert.isNumber(42);
    assert.isObject({answer: 42});
    assert.isArray([1,2,3,4]);
    var thingIHaventDefined;
    assert.isUndefined(thingIHaventDefined);
  });
});
```

#### `equal`, `strictEqual` and `deepEqual`

Equality in JavaScript is funky. `1 == true` but not `1 === true`. `'3' == 3` but not `'3' === 3`. `assert.equal` will compare using double equals (`==`), and `assert.strictEqual` will compare using triple equals(`===`).

`deepEqual` is used for arrays and objects. In the deep underpinnings of JavaScript, each time you define an array, it's a different array. So `[1,2,3,4] == [1,2,3,4]` will always return false. `deepEqual` will compare each value in an array, or each key/value pair in an object. Let's add the following to our sandbox:

```js
    it("can compare two arrays that contain the same values", function() {
      var actualArray = [1,2,3,4];
      assert.deepEqual(actualArray, [1,2,3,4]);
    })

    it("can compare two objects that contain the same key/value pairs", function() {
      var actualObject = {name: "Nate", module: 4};
      assert.deepEqual(actualObject, {name: "Nate", module: 4});
    })
```

### Testing our Code

Let's test our JavaScript file!

Export the function from the `add.js` file.

```js
function add(a, b) {
  return a + b
}

module.exports = add
```

Let's create a test file just for this module.

```
touch test/add-test.js
```

Let's setup our `add-test.js` file. We'll add `chai` as well as the module that we exported from `add.js`.

```js
const assert = require('chai').assert
const addNumbers = require('../add')
```

In the above snippet, we are using the constant that has the same name as our exported function and finding the file via its file path.

Now we are ready to write a test!

```js
const assert = require('chai').assert
const addNumbers = require('../add')

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

Do the following challenges in the same `node-sandbox` folder. Try to write tests for each challenge.

*   [Character Count](https://github.com/turingschool/challenges/blob/master/character_count.markdown)
*   [fibonacci](https://github.com/turingschool/challenges/blob/master/fibber.markdown)
