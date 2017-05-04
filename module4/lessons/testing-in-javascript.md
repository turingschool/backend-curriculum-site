---
layout: page
title: Testing in Javascript
tags: Unit and Integration testing libraries
---

Goals
----------

-   Can write unit tests in javascript
-   Can write integration tests in javascript

Libraries covered
---------
-   [Mocha](https://mochajs.org/) - A test runner
-   [Chai](http://chaijs.com/) - An assertion library
-   [Selenium](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/lib/webdriver_exports_WebDriver.html) - Browser automation and inspection
-   [Webpack](https://webpack.github.io/) - Build tool for asset management

Test Type Review
-----------

-   Why test at all?
-   What are the different types of tests?
-   Why would we use one over the other?

Let's integrate
-------------

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

-   You should recognize that we're using Chai's assertions again.
-   `webdriver` is really where the magic happens. We're going to be calling a lot from this object.
-   `test` kind of replaces Mocha for us. We use selenium's `test` object because it handles asynchronous code better, but it's still technically running within Mocha.

Moving on:

```js
// ...
test.describe('testing ideabox', function() {
  var driver;
  this.timeout(10000);
// ...
```


-   Since we're using selenium's test runner, we have to preface our `describe()` and `it()` with `test`.
-   We're setting up a variable `driver` for the whole block
-   The default timeout is 2000 milliseconds, which we'll run out of quickly with all the browsing we're going to be doing.

```js
  test.beforeEach(function() {
    driver = new webdriver.Builder()
    .forBrowser('chrome')
    build();
  });
  test.afterEach(function() {
    driver.quit();
  });
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

-   I've been visiting a production link for proof of concept, but usually you'll want to run your tests on your dev server. Don't forget to run your dev server in another tab before you run your tests.
-   When googling, make don't google "selenium" or even "selenium javascript". You'll just get stuff in other languages. Put "webdriverjs" in your search query.
-   You might be missing something like a Database Cleaner. You can [use selenium to execute](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/index_exports_WebDriver.html#executeScript) `localStorage.clear()`, maybe in your `beforeEach()`.
