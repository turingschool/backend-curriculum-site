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

We've briefly touched on quite a few JavaScript concepts, now is our time to dive deeper and ensure we're all on the same page about some concepts in particular. 

## JavaScript Objects

What do we mean when we say "JavaScript object"? An object in JavaScript is a collection of properties, and a property is an association between a name (or key) and a value. A property's value can be a function, in which case the property is known as a method.

How do we create new objects in JavaScript land? You can define an object in a few different ways. First of all, you can define an object literal by simply creating what may look like a Ruby hash:

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

What else can we add to an object's properties? We can add functions as properties.

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

What if I want to return a value dynamically depending on the properties Penelope has? 

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

Define a variable called "pizza" in your console. Set it's value equal to an object that contains a property for "type" and "size." Give each property whatever you'd like. Next, add a property that returns the object's details like so: "This is a [type] pizza that is [size] inches long." For example, I should be able to call the following methods on the object you've defined and get the following return values (based on what values you've set to type and size).

```js
pizza.type
// Cheese

pizza.size
// 10

pizza.details()
// This is a Cheese pizza that is 10 inches long.

```

## What is `this`?

Why is this important?
When do we want to leverage this in our code?

## jQuery vs JavaScript

Recap: what's the difference between JavaScript and jQuery?

jQuery makes this (written in raw JS):

```js
var elements = document.getElementsByTagName("img");

for (var i = 0; i< elements.length; i++) {
  elements[i].style.display = "none";
 }
 ```
 
Turn into the following:

```js
$('img').hide();
```

#### Review: What is jQuery?

- javaScript library (most popular)
- open-source
- easy DOM manipulation
- simple methods for reading and interacting with your HTML
- gives us more control over our DOM

#### What are some popular jQuery methods?

* `find()`
* `hide()` & `show()`
* `html()`
* `prepend()` & `append()`
* `on()`
* `css()`

#### Small Group Discussion

* Why would we want to use jQuery over raw JavaScript? 
* When might we want to use JavaScript instead of jQuery?

#### You Do

In your notebooks, translate the following from JS to jQuery. If you're stuck, ask whomever you're sitting next to or the interwebs! 

```js
var clickMeButton = document.getElementById('click-me');

clickMeButton.addEventListener('click', function () {
  console.log('You clicked me!');
});
```

## Bind events to jQuery selectors to manipulate the DOM

What's an event? What's the DOM?
How do we select an DOM element using jQuery? 

## Array prototype methods

As you know, Ruby has many enumerable methods available to make your life as a developer more convenient. JavaScript has some similar methods available for Arrays. Research popular Array prototype methods and answer the following questions:

* What do you notice about Array prototype methods?
* How are they similar/different from Ruby enumerables?
* What do you think a prototype is

## Additional Resources

* [Calling functions in JS](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/02-functions/01-calling-functions.md)
* [Event Basics](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/04-events/01-basic-events.md)
* [Intro to OOJS](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/03-object-oriented-javascript/01-introduction-to-object-oriented-javascript.md)
* [Array Prototype Methods](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/01-array-prototype-methods/README.md)
* [What is this?](https://github.com/mdn/advanced-js-fundamentals-ck/blob/gh-pages/tutorials/02-functions/02-what-is-this.md)

