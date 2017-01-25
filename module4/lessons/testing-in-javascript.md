---
layout: page
title: Testing in Javascript
tags: Unit and Integration testing libraries
---

## Goals

- Can write unit tests in javascript
- Can write integration tests in javascript

## Libraries covered

  - [Mocha](https://mochajs.org/) - A test runner
  - [Chai](http://chaijs.com/) - An assertion library
  - [Selenium](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/lib/webdriver_exports_WebDriver.html) - Browser automation and inspection
  - [Webpack](https://webpack.github.io/) - Build tool for asset management

## Test Type Review

- Why test at all?
- What are the different types of tests?
- Why would we use one over the other?

## Mocha - the test runner

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
describe("Something that I'm describing", function(){
  context("That thing under some context", function(){
    it("does a thing", function(){

    });
  });
});
```

For future reference: If you're familiar with ES6 [Arrow Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions), these will make your callbacks slightly less verbose. I'm not going to bother with them for this lesson.

Save the above text in a file named `test.js`. Then run

```
mocha test.js
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

1. `describe()` and `context()` are not necessary. Typically, you'll want at least a `describe()` block to tell us what it is you're testing, but can omit context if you don't think it's necessary.
2. `assert` is a "node module". It doesn't come pre-loaded, so we have to require it. In node, as opposed to Ruby, you have to capture the return value of a `require`.
3. Like RSpec, I can have an optional message as part of my assertion which will be displayed if the assertion fails. If `true` is somehow false, something has seriously gone wrong.

Node's built in `assert` module isn't very fully featured. A popular assertion library for JavaScript is called [Chai](http://chaijs.com/). This is what we're going to use. You can install it by typing the following in your terminal.


```
curl http://chaijs.com/chai.js -o chai.js
```

This just downloads the latest version of `chai.js` to your current folder. In the future, you'll just want to add it to your NPM package file, but this gets us up and running without a lot of fuss.

Modify your `test.js` to the following:

```js
assert = require('./chai').assert;

it("can assert true", function(){
  assert(true, 'TRUE IS FALSE! UP IS DOWN! DAY IS NIGHT!');
});
```

And `mocha test.js` should return the same output as when we were using Node's assertion library. Let's try out a few more of Chai's assertions.

```js
assert = require('./chai').assert;

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

it("can compare two arrays that contain the same values", function(){
  var actualArray = [1,2,3,4];
  assert.deepEqual(actualArray, [1,2,3,4]);
})

it("can compare two objects that contain the same key/value pairs", function(){
  var actualObject = {name: "Nate", module: 4};
  assert.deepEqual(actualObject, {name: "Nate", module: 4});
})
```

## Putting it together in Webpack

This has been a good introduction to Mocha and Chai on their own, but you'll be using them in conjunction with Webpack. Let's see how that works.

Start by cloning a fresh copy of the Quantified Self Starter Kit:

```bash
git clone https://github.com/turingschool-examples/quantified-self-starter-kit testing-in-javascript
```

Mocha is already installed globally, and and Chai is included in the package.json file. if you run `npm install`, it will install Chai, and all the other necessary packages, into a `node_modules` folder.

Let's copy all of our tests from our sandbox into `test/index.js`, with one small change. Since we're loading Chai from `node_modules` instead of as a local file, we'll require it slightly differently. Here's the whole sandbox with the modified require:

```js
assert = require('chai').assert;

describe("Chai Assertions Sandbox", function(){
  it("can assert true", function(){
    assert(true, 'TRUE IS FALSE! UP IS DOWN! DAY IS NIGHT!');
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

  it("can compare that two arrays contain the same values", function(){
    var actualArray = [1,2,3,4];
    assert.deepEqual(actualArray, [1,2,3,4]);
  })

  it("can compare that two objects contain the same key/value pairs", function(){
    var actualObject = {name: "Nate", module: 4};
    assert.deepEqual(actualObject, {name: "Nate", module: 4});
  })
});
```

Now we can run our tests using `npm test`. By default, mocha runs all javascript files in the `test/` folder. You should get the same out put as before.

### Testing our own modules

When using Webpack, you typically organize your code into "modules". Each js file under `/lib` has to contain some kind of `module.exports` for you to be able to access that code from another file. Whatever you set `module.exports` to will be the return value when you `require` that file. Let's test drive a very simple module to see this in action.

Let's start with a test for a function that simply returns the square of a number you pass it. Create a new file `test/square-test.js`:

```js
assert = require('chai').assert;
square = require('../lib/square');

describe("We can square a number", function(){
  it("returns 4 when I pass it 2", function(){
    assert.equal(square(2), 4);
  });
});
```

Now create a `lib/square.js` file, and try to get this test to pass.

**The answer is below. See if you can use TDD to get the above to pass**

```
I

am

an

annoyingly

large

section

of

the

page
```

So you should have filled in `lib/square.js` with something like:


```js

module.exports = function(n) {
  return n*n;
};

```

If you had simply defined the function `square()` like:

```js
function square(n) {
  return n*n;
}
```

it would not be available in your test file. Only things that are exported are available.

### A few more useful mocha features

- Just like RSpec, and even Minitest, Mocha supports `before()`, `beforeEach()`, `after()` and `afterEach()` inside of a `describe()` or `context()`.
- If you'd like to skip a test, you can mark it as pending by changing `it()` to `xit()`.


## Let's integrate

What about when we want to test user interactions with the application. We're going to bring in a new tool called [Selenium](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/lib/webdriver_exports_WebDriver.html).

Selenium solves a similar problem to Capybara. It allows you to visit pages, interact with them, and inspect the page in order to assert things against your application.

Capybara has it's own built in assertions with `expect`, but we'll continue to use Chai for our assertions. Instead, we extract values from the page with Selenium, and then write assertions against those

I've added the packages you need to your package.json file already (chromedriver, webdriverjs and selenium-webdriver), but selenium runs on java, and you may need to install the JDK. If `javac -version` in your terminal succeeds, you're good to go. If it fails, [download the JDK here](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

Now that you know the basics of mocha and chai, let's look at a full selenium test, and break it down:

```js
var assert    = require('chai').assert;
var webdriver = require('selenium-webdriver');
var test      = require('selenium-webdriver/testing');

test.describe('testing ideabox', function() {
  var driver;
  this.timeout(10000);

  test.beforeEach(function() {
    driver = new webdriver.Builder()
      .forBrowser('chrome')
      .build();
  })

  test.afterEach(function() {
    driver.quit();
  })


  test.it('should allow me to add a title and a description', function() {

    driver.get('http://idea-box-jhun.herokuapp.com/');

    var title = driver.findElement({id: 'idea-name'});
    var description = driver.findElement({id: 'idea-body'});
    title.sendKeys('this is a title');

    title.getAttribute('value').then(function(value) {
      assert.equal(value, 'this is a title');
    });

    description.sendKeys('this is a description');

    description.getAttribute('value').then(function(value) {
      assert.equal(value, 'this is a description');
    });

  });

  test.it('should allow me to create an idea', function() {

    driver.get('http://idea-box-jhun.herokuapp.com/');

    var title = driver.findElement({id: 'idea-name'});
    var description = driver.findElement({id: 'idea-body'});
    var submitButton = driver.findElement({id: 'create-idea'});

    title.sendKeys('a new title');
    description.sendKeys('a new description');
    submitButton.click();

    driver.sleep(1000);

    driver.findElement({id: 'ideaname'}).getText().then(function(textValue) {
      assert.equal(textValue, "a new title");
    });

    driver.findElement({id: 'delete-idea'}).click();

  })

});
```

Let's start with our `require`s

```js
var assert    = require('chai').assert;
var webdriver = require('selenium-webdriver');
var test      = require('selenium-webdriver/testing');
// ...
```

- You should recognize that we're using Chai's assertions again.
- `webdriver` is really where the magic happens. We're going to be calling a lot from this object.
- `test` kind of replaces Mocha for us. We use selenium's `test` object because it handles asynchronous code better, but it's still technically running within Mocha.

Moving on:

```js
// ...
test.describe('testing ideabox', function() {
  var driver;
  this.timeout(10000);
// ...
```

- Since we're using selenium's test runner, we have to preface our `describe()` and `it()` with `test`.
- We're setting up a variable `driver` for the whole block
- The default timeout is 2000 milliseconds, which we'll run out of quickly with all the browsing we're going to be doing.

```js

test.beforeEach(function() {
  driver = new webdriver.Builder()
    .forBrowser('chrome')
    .build();
})

test.afterEach(function() {
  driver.quit();
})

```

Here we're starting Chrome before each test, and quitting it after each test. I've found this gives me the most consistent test results.

Then there's the tests themselves. The structure should look pretty familiar, but let's cover some of these functions.

#### driver.get()

This just visits a page in selenium.

#### driver.findElement()

This allows you to actually select elements on the page. In some docs/tutorials/snippets, you'll see something like `driver.findElement(By.id('some-id'))`, but I've used the "hash syntax" in my tests.

#### click() and sendKeys()

These are used to actually interact with elements on the page

#### getText() and getAttribute()

```js
driver.findElement({id: 'ideaname'}).getText().then(function(textValue) {
  assert.equal(textValue, "a new title");
});
```

This is how you get some information about your elements. Because of some decisions made by the selenium team, basically everything is a promise. This means instead of returning values, these functions return promises, and the only way to get the values is to call `then()` on them, and name the variable for the value in the anonymous function parameters. But once you get the pattern, it's pretty straight forward.


These are just a few of the functions you can use, but probably the most common ones. There are a lot more [in the docs](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/index_exports_WebDriver.html). The docs seem intimidating at first, but stick with them. They're consistent and have little snippets throughout.


### Notes for working with selenium

- When googling, make don't google "selenium" or even "selenium javascript". You'll just get stuff in other languages. Put "webdriverjs" in your search query.
- You might be missing something like a Database Cleaner. You can [use selenium to execute](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/index_exports_WebDriver.html#executeScript) `localStorage.clear()`, maybe in your `beforeEach()`.
