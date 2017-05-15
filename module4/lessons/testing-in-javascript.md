---
layout: page
title: Integration Testing in Javascript
tags: Integration testing libraries
---

Goals
----------

-   Understand the value of integration tests
-   Comfortable writing integration tests using with help from the internet
-   Can incorporate integration tests into a webpack based environment 

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
-   Given, When, Then

Let's integrate
-------------

What about when we want to test user interactions with the application. We're going to bring in a new tool called [Selenium](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/lib/webdriver_exports_WebDriver.html).

Selenium solves a similar problem to Capybara. It allows you to visit pages, interact with them, and inspect the page in order to assert things against your application.

Capybara has it's own built in assertions with `expect`, but we'll continue to use Chai for our assertions. Instead, we extract values from the page with Selenium, and then write assertions against those

I've added the packages you need to your package.json file already (chromedriver, webdriverjs and selenium-webdriver), but selenium runs on java, and you may need to install the JDK. If `javac -version` in your terminal succeeds, you're good to go. If it fails, [download the JDK here](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

I've also included chromedriver in the root of the project, you are going to need to move that into your /usr/bin/local/ directory, if you don't have it installed.  You can check by running `chromedriver -v`

Before we write our feature story, lets talk about some of the test setup.

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
});
```

Let's start with our `require`s

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

The feature I want is to add an idea title and description, to my list of ideas.  We are going to use Jhun's ideabox site at [Jhun's Ideabox](http://idea-box-jhun.herokuapp.com/)
Now lets write our feature story using the Given, When, Then syntax. The product manager who is often the person creating feature stories to add value to the business,
asks you to allow a user to add create a new idea with a description for ideabox.

#### driver.get(url)

This just visits a page in selenium.

#### driver.findElement()

My preference is to use css selectors to select elements.  `driver.findElement({css: '#id-name'})`

#### click() 

After selecting an element you can then call `click()` on that element

#### sendKeys(string)

After selecting an element, usually one with an `<input>` tag, you can then call `sendKeys(string)` to fill in the input field.

#### getText() and getAttribute()

```js
driver.findElement({id: 'ideaname'}).getText().then(function(textValue) {
  assert.equal(textValue, "a new title");
});
```

This is how you get some information about your elements. Because of some decisions made by the selenium team, basically everything is a promise. This means instead of returning values, these functions return promises, and the only way to get the values is to call `then()` on them, and name the variable for the value in the anonymous function parameters. But once you get the pattern, it's pretty straight forward.


These are just a few of the functions you can use, but probably the most common ones. There are a lot more [in the docs](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/index_exports_WebDriver.html). The docs seem intimidating at first, but stick with them. They're consistent and have little snippets throughout.

#### Search idea feature

Write an integration test that can search for the idea titled "Yo dude", by typing in only the letter "y" in the search field.

#### Integrating with webpack

So far we've been running our tests using the npm script `npm test`.  Anyone notice anything interesting about the output of our tests?

CFU
-------------

-  What is an integration test?
-  Why are integration tests valuable?
-  Why do we want integration tests to make up a small percentage of our tests?
-  What do the Given, When, and Then repersent in a test?

### Notes for working with selenium

-   I've been visiting a production link for proof of concept, but usually you'll want to run your tests on your dev server. Don't forget to run your dev server in another tab before you run your tests.
-   When googling, make don't google "selenium" or even "selenium javascript". You'll just get stuff in other languages. Put "webdriverjs" in your search query.
-   You might be missing something like a Database Cleaner. You can [use selenium to execute](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/index_exports_WebDriver.html#executeScript) `localStorage.clear()`, maybe in your `beforeEach()`.
