# (More) Advanced JS Concepts

## Learning Goals

* Create and interact with JavaScript objects and explain their purpose
* Utilize functions as methods on JavaScript objects
* Understand the scope of `this` in JavaScript
* Explain the difference between JavaScript and jQuery
* Bind events to jQuery selectors to manipulate the DOM
* Research Array protoype methods

## Warm Up

* How do you invoke a function in JavaScript?
* What is the equivalent of `document.querySelector('#important-information')` in jQuery?
* What does `$` stand for when writing jQuery?
* In your own words, describe an `event` in JavaScript. Give an example.

## Overview

We've briefly touched on quite a few JavaScript concepts, now is our time to dive deeper and ensure we're all on the same page moving forward.

## JavaScript Objects

What do we mean when we say "JavaScript object"? An object in JavaScript is a collection of properties, and a property is an association between a name (or key) and a value. A property's value can be a function, in which case the property is known as a method.

How do we create new objects in JavaScript? You can define an object in a few different ways. First of all, you can define an object literal by simply creating what may look like a Ruby hash:

```js
var penelope = { firstName: "Penelope", age: 88 }

penelope
// Object {firstName: "Penelope", age: 88}
```

You could also use the JavaScript keyword `new`.

```js
var penelope = new Object()
penelope.firstName = "Penelope"
penelope.age = 88

penelope
// Object {firstName: "Penelope", age: 88}
```

How do we interact with our newly created objects? We can access an object's properties/values by using dot or bracket notation.

```js
penelope.firstName
// "Penelope"

penelope["firstName"]
// "Penelope"
```

*Reflect*: Why do we want to encapsulate properties/functions in objects?

What else can we add to an object's properties? Functions!

```js
var penelope = {
                firstName: "Penelope",
                age: 88,
                sayHi: function() {
                  return "Hello!"
                }
               }

 penelope.sayHi()
 // "Hello!"

```

What if I want to return a value dynamically depending on Penelope's properties?

```js
var penelope = {
                firstName: "Penelope",
                age: 88,
                sayHi: function() {
                  return "Hi! I'm " + this.firstName
                }
               }

 penelope.sayHi()
// "Hi! I'm Penelope"
```

Within the scope of a function set as a property on an object, `this` refers to the object itself. More on this to come!

## You Do

Define a variable called "pizza" in your console. Set its value equal to an object that contains a property for "type" and "size." Give each property whatever you'd like. Next, add a property that returns the object's details like so: "This is a [type] pizza that is [size] inches long." For example, I should be able to call the following methods on the object you've defined and get the following return values (based on what values you've set to type and size).

```js
pizza.type
// Cheese

pizza.size
// 10

pizza.details()
// This is a Cheese pizza that is 10 inches long.

```

## What is `this`?

At a high level, `this` is a special property in JavaScript. `this` is not only very hard to talk about in English, it's also a confusing to many new (and experienced) JavaScript developers.

The short version is that `this` refers to the context in which a function was invoked in JavaScript. Keep in mind that this is different from where it was defined.

Thankfully, we have a few rules to follow.

By default, `this` refers to the global object in all global code. In the context of your browser, this would be the `window`.


```js
function logThis() {
  console.log(this)
}

logThis()
// global object
```

Secondly, `this` refers to the parent object inside function code, if the function is called as a property of the parent. In this context, think of `this` as a self-reflective pronoun of sorts. Almost like Ruby's `self`!


```js
var penelope = {
  name: "Penelope",
  whatIsThis: function() {
    console.log(this)
  }
}

penelope.whatIsThis()
// Object { name: 'Penelope', whatIsThis: [Function: whatIsThis] }

```

Lastly, `this` in function code invoked using the new operator refers to the newly created object. For example:

```js
function Car (make, name) {
  this.make = make
  this.name = name
}

var jeepWrangler = new Car('Jeep Wrangler', ‘DangerZone’)

console.log(jeepWrangler.name)
// DangerZone
```

We'll talk more about using constructor functions and classes to create objects in a future lesson.

*Note*: as you can see, `this` can be confusing and changes depending on the context we're in. `this` can also be explicitly set using other JS methods like `apply`, `call`, and `bind`. These methods are outside the scope of this lesson, but we encourage you to dive deeper if you're interested.

### Small Group Discussion

* When do we want to leverage `this` in our code?
* What are some situations where having access to `this` may be helpful?
* In your own words, how would you describe `this`?

## jQuery vs JavaScript

Recap: what's the difference between JavaScript and jQuery?

jQuery makes this (written in raw JS):

```js
var elements = document.getElementsByTagName("img");

elements.forEach((element) => {
  element.style.display = "none";
})
```

Turn into the following:

```js
$('img').hide();
```

### Review: DOM Manipulation

* What's an event?
* What's the DOM?
* How do we select an DOM element using jQuery?

### Review: jQuery

* JavaScript library (most popular)
* open-source
* allows for easy DOM manipulation
* simple methods for reading and interacting with your HTML

#### Some Popular jQuery methods:

* `hide()` & `show()`
* `html()`
* `text()`
* `prepend()` & `append()`
* `on()`
* `addClass()`, `toggleClass()` and `removeClass()`

### Small Group Discussion

* Why would we want to use jQuery over raw JavaScript?
* When might we want to use JavaScript instead of jQuery?

### Practice

In your notebooks, translate the following from JS to jQuery. If you're stuck, ask whomever you're sitting next to (or the internet).

```js
var clickMeButton = document.getElementById('click-me');

clickMeButton.addEventListener('click', function () {
  console.log('You clicked me!');
});
```

## Practice: Let's play around with some jQuery!

Clone [this](https://github.com/turingschool-examples/jQuery-playground) repository. Navigate to the `basic-jQuery` directory.

You can open its `index.html` in the browser from your command using:

```bash
open basic-jQuery/index.html
```

We can refresh on basic jQuery using this playground.

Try working through the HTML sections and adding DOM manipulations for each button.

If you work through those and want more, try these:

* Can you change the font with the click of your mouse?
* Can you change the background color of the page when the spacebar is clicked?

## Array.prototype Methods

As you know, Ruby has many enumerable methods available to make your life as a developer more convenient. JavaScript has some similar methods available for Arrays. [Research popular Array prototype methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/prototype) and answer the following questions:

* What do you notice about Array prototype methods?
* How are they similar/different from Ruby enumerables?
* What do you think a prototype is?

## Additional Resources

* [Calling functions in JS](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/02-functions/01-calling-functions.md)
* [Event Basics](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/04-events/01-basic-events.md)
* [Intro to OOJS](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/03-object-oriented-javascript/01-introduction-to-object-oriented-javascript.md)
* [Array Prototype Methods](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/01-array-prototype-methods/README.md)
* [What is this?](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/02-functions/02-what-is-this.md)
