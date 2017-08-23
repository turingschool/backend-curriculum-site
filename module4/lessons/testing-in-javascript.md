---
layout: page
title: Test-Driving AJAX
---

## Learning Goals

* Students remember AJAX
* Students can comfortably write integration tests using outside resources
* Students can incorporate integration tests into a webpack based environment

## Libraries Covered

-   [Mocha](https://mochajs.org/) - A test runner
-   [Chai](http://chaijs.com/) - An assertion library
-   [Selenium](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/lib/webdriver_exports_WebDriver.html) - Browser automation and inspection
-   [Webpack](https://webpack.github.io/) - Build tool for asset management

## AJAX Refresher

AJAX == Asynchronous JavaScript and XML. This should probably be renamed to AJAJ (Async JS and JSON), though.

Essentially, AJAX allows us to _asynchronously_ interact with most anything, but predominantly other servers (think APIs). The asynchronous bit here means that we could make a request and not need to wait for its response before moving on to execute other lines of code. The request will come back and be handled when it's ready without needing to halt our program waiting for it.

We'll learn more about asynchronicity in JavaScript later in the module, but for now, let's think of AJAX as the tool that will allow us to make client-side requests to an API.

[jQuery AJAX](https://api.jquery.com/category/ajax/) requests come in all shapes and sizes, but for reference, here's a common structure:

```js
function() {
  // make a GET request
  // returning immediately since this AJAX call
  // with chained handling is technically all one line
  return $.ajax({
    type: "GET",
    url: "http://localhost:3000/api/v1/posts"
  })
  // JS Promise is returned, if successful, handled by `.then`
  // JSON response is passed to anonymous function, here named `posts`
  .done(function(posts){
    // we're within this block if things went well,
    // so do something with the data!
  })
  .fail(function(error){
    // only here if there was an error,
    // so handle error if there is one
  });
}
```

Here's a very similar structure, using a bit of syntactic sugar:

```js
function() {
  return $.getJSON("http://localhost:3000/api/v1/posts")
  .then(function(posts){
  })
  .fail(function(error) {
  })
}
```

### Turn and Talk

-   What are some use cases for AJAX? Name some cards from your current project that will require an AJAX request to complete.
-   What information do you need before you can make an AJAX request?
-   How do you access the response from the request?

## Selenium Setup

What about when we want to test user interactions with the application. We're going to bring in a new tool called [Selenium](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/lib/webdriver_exports_WebDriver.html).

Selenium solves a similar problem to Capybara. It allows you to visit pages, interact with them, and inspect the page in order to assert things against your application.

Capybara has its own built in assertions with `expect`, but we'll continue to use Chai for our assertions. Instead, we extract values from the page with Selenium, and then write assertions against those

I've added the packages you need to your package.json file already (chromedriver, webdriverjs and selenium-webdriver), but Selenium runs on java, and you may need to install the JDK. If `javac -version` in your terminal succeeds, you're good to go. If it fails, [download the JDK here](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

### Setup

We'll be working with a front-end repository. This will be our client that will communicate with an API via AJAX. For this lesson, we'll be using [JSONPlaceholder](https://jsonplaceholder.typicode.com/) as our API, serving us dummy data. For our projects, this back-end would be a separate repository running its own server.

```
git clone git@github.com:turingschool-examples/ajax-testing-fe.git
cd ajax-testing-fe
npm install
npm start
npm test
```

## Let's Integrate

We have one passing test already.

Let's walk through that test and break down the pieces.

```js
var assert    = require('chai').assert;
var webdriver = require('selenium-webdriver');
var until = webdriver.until;
var test      = require('selenium-webdriver/testing');
var frontEndLocation = "http://localhost:8080"

test.describe('testing my simple blog', function() {
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

-   `webdriver` is really where the magic happens. We're going to be calling a lot from this object.
-   `test` kind of replaces Mocha for us. We use selenium's `test` object because it handles asynchronous code better, but it's still technically running within Mocha.
-   I've saved the url of my front end so I can easily use it throughout the tests, and change it in the future.

Moving on:

```js
// ...
test.describe('testing my simple blog', function() {
  var driver;
  this.timeout(10000);
});
// ...
```

-   Since we're using Selenium's test runner, we have to preface our `describe()` and `it()` with `test`.
-   We're setting up a variable `driver` for the whole block. This is the thing that actually interacts with the browser.
-   I've set host as a variable so I can easily change it when the environment changes
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

Here we're starting Chrome before each test, and quitting it after each test. I've found this yeilds the most consistent test results.

```js
test.it("lists all the entries on load", function() {
    driver.get(`${frontEndLocation}`)
    driver.wait(until.elementLocated({css: "#entries .entry"}))
    driver.findElements({css: "#entries .entry"})
    .then(function (entries) {
      assert.lengthOf(entries, 100);
    })
  })
});
```

#### driver.get(url)

This just visits a page in Selenium.

#### driver.wait(until...)

We're frequently going to be looking for things that don't exist at page load, because they have to be loaded via AJAX. These wait commands tell the test to wait until they can find some element on the page. You want to give it something that would only exist after the AJAX has loaded.

#### driver.findElements()

My preference is to use CSS selectors to select elements.  `driver.findElement({css: '#id-name'})`.
You may also select an element by id: `driver.findElement({id: 'id-name'})`

Because of some decisions made by the Selenium team, almost everything is a promise. This means instead of returning values, these functions return promises, and the only way to get the values is to call `then()` on them, and name the variable for the value in the anonymous function parameters. But once you get the pattern, it's pretty straight forward.

There is also a `findElement()` if you only expect there to be one, and don't want to mess with an array.

#### Checks for Understanding

We have more practice to do, but let's check in on where you're at.

- How is Selenium like tools you've used in the past? What's different and new?

### A POST test

Great! We've broken down an existing test for an existing feature. Let's see if we can test drive another feature. We want to be able to create a new `Entry` in our blog. The HTML form already exists, but it isn't wired up.

Before we write our tests, let's go over a few more methods of the `driver` object:

#### click()

Called as a method off of `findElement()`. After selecting an element you can then call `click()` on that element

#### sendKeys(string)

Called as a method of `findElement()`. After selecting an element, usually one with an `<input>` tag, you can then call `sendKeys(string)` to fill in the input field.

#### getText() and getAttribute()

```js
driver.findElement({id: 'ideaname'}).getText()
.then(function(textValue) {
  assert.equal(textValue, "a new title");
});
```

These are just a few of the functions you can use, but at least enough for us to write our next test. There are a lot more [in the docs](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/index_exports_WebDriver.html). The docs seem intimidating at first, but stick with them. They're consistent and have little snippets throughout.

Alright, we're ready to write our test.

```js
test.it("posts an entry", function() {
  driver.get(`${frontEndLocation}`);
  driver.wait(until.elementLocated({css: "#entries .entry"}));
  driver.findElement({id: 'author-field'}).sendKeys("Lauren");
  driver.findElement({id: 'body-field'}).sendKeys("A new entry");
  driver.findElement({css: 'input[type="submit"]'}).click();
  driver.wait(until.elementLocated({css: "div[data-id='101']"}));
  driver.findElements({css: "#entries .entry"})
  .then(function (entries) {
    assert.lengthOf(entries, 101);
  });
});
```

### Checks for Understanding

- What are some similarities and differences between this library and integration tests you've written in the past?
- What kind of challenges do you think you'll have when writing integration tests in JavaScript? What resources will you use to overcome those challenges?

## Your Turn

Using your new found Selenium knowledge, and your refreshed AJAX knowledge, write a test for, and then implement, the following feature:

```
As a user, when I click "Delete" under a entry, that entry is removed from the app without a refresh. When I refresh, the entry will not reappear.
```

## Wrap Up

### Notes for Working with Selenium

-   Don't forget to run your front-end server in another terminal session before you run your tests.
-   When googling, make don't google "selenium" or even "selenium javascript". You'll just get stuff in other languages. Put "webdriverjs" in your search query.
-   You might be missing something like a Database Cleaner. Since the back-end API is your datasource, and your tests don't have direct access to the database, you will want to make requests to the API to set up and teardown your data.
