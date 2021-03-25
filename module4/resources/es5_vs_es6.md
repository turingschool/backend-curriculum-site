---
layout: page
title: ES5 vs ES6
subheading: Guided Tutorial
---

# ES5 vs ES6

## Learning Goals
* Students differentiate between JavaScript written in ES5 and ES6
  * Style regarding semi-colons
  * `var` vs. `let` and `const`
  * Template literals and string interpolation
  * `function` notation and `=>` notation
  * Lexical `this`
  * Class/Prototype constructors
* Students translate between JavaScript written in ES5 and ES6

## Structure

| 5  | Warm Up  |
| 20 | Overview |
| 5  | Pomodoro |
| 25 | Examples (fist to five after each) |
| 5  | Pomodoro |
| 50 | Independent Practice |
| 10 | Review   |

## Warm Up
* What do you know so far about ES6?
* What's the most frustrating part of JavaScript syntax?

## Overview

What is ECMAScript? A language standardized by ECMA International and overseen by the TC39 committee (the committee that evolves JavaScript). This term is usually used to refer to the standard itself.

JavaScript is what everyone calls the language, but that name is trademarked (by Oracle, which inherited the trademark from Sun). Therefore, the official name of JavaScript is ECMAScript. That name comes from the standards organization Ecma, which manages the language standard. Since ECMAScript’s inception, the name of the organization has changed from the acronym “ECMA” to the proper name “Ecma”.

What is ES5 (ECMAScript 5)? The 5th edition of ECMAScript, standardized in 2009. This standard has been implemented fairly completely in all modern browsers.

What is ES6 (ECMAScript 6)? The 6th edition of ECMAScript, standardized in 2015. This standard has been partially implemented in most modern browsers. 

### Activity: ES5 vs ES6

There's quite a few differences between ES5 and ES6. It'd be impossible to cover all the differences, but let's talk about some of the neat features of ES6. 

We'll walk through each of the sections below, showing each version's syntax of a specific concept. Students will find a partner (someone they have NOT worked with on projects yet). After 1-2 minutes of analyzing each code snippet ([es6](https://gist.github.com/tmikeschu/7346d97214d6b47d1a52f9ff8d1d698d) vs [es5](https://gist.github.com/case-eee/54c79fd84445e24cb017b6de17e455fa)), pairs will answer the following questions:

* What are the main differences you see?
* Which syntax do you prefer? Why?
* Come up with an example with your pair (in your console or in a file)

After each section, we'll share out as a large group.

### A quick note on semi-colons

From: https://github.com/rse/es6-features:

"Why does the website default use the "reduced" syntactic sugar style (without semicolons) for ECMAScript 6 and the "traditional" syntactic sugar style (with semicolons) for ECMAScript 5?"

"ECMAScript since its earliest days supported automatic semicolon inference/insertion, of course. But people coding ECMAScript 5 started it in an era where lots of tools (especially source code compressors) had problems when semicolons where left out from the source code. As a consequence, most ECMAScript 5 coders maintained the traditional coding style with semicolons as the syntactic sugar, although in most of the cases they are not necessary. But this era is gone today. Both ECMAScript 6 and all tools (including compressors) perfectly support automatic semicolon inference/insertion nowadays. As a consequence, ECMAScript 6 coders nowadays can get rid of nearly all semicolons and remove clutter from their source code. Ralf S. Engelschall is a strong promoter of reducing source code to its bare minimum. Hence, in his personal opinion ECMAScript 6 should be coded with as less syntactic sugar as possible and hence without semicolons. But if you disagree, just switch the shown style on the website. If you even need to enforce a particular style for both ES6 and ES5 code snippets in your bookmarks, just use one of the following URLs: ES6-Features (reduced style) or ES6-Features (traditional style)."

**tl;dr**

Semi-colons are **not** required, except:

*If a line of code starts with  a `(` or a `{`, you might need to throw in a semi-colon on the previous line to differentiate.*

Other than that, semi-colons are a style choice. Be consistent.

### Declarations  with `var`, `let`, and `const`

JavaScript can exhibit some strange behavior sometimes, especially in regards to variable assignment. In ES6, you should generally not use `var`. Instead, start with `const`. This will throw a linting error if you try to reassign it. If you decide this is behavior you want, change your original 'const' to 'let'. Check out this great [video](https://www.youtube.com/watch?v=sjyJBL5fkp8) for a more thorough and entertaining breakdown.

Recap: always start with `const`, and only change to `let` if the variable should indeed be mutable.

### String Interpolation

As you probably already know, string interpolation in ES5 is pretty painful. In order to interpolate a string, you'd need to do something like this:

```js
var customer = { name: "Foo" };
var card = { amount: 7, product: "Bar", unitprice: 42 };
var message = "Hello " + customer.name + ",\n" +
"want to buy " + card.amount + " " + card.product + " for\n" +
"a total of " + (card.amount * card.unitprice) + " bucks?";
```

With ES6 though, it's much much easier!

```js
const customer = { name: "Foo" }
const card = { amount: 7, product: "Bar", unitprice: 42 }
const message = `Hello ${customer.name},
want to buy ${card.amount} ${card.product} for
a total of ${card.amount * card.unitprice} bucks?`
```

How similar does string interpolation with ES6 look to Ruby's string interpolation?

### Arrow Syntax

When defining functions, ES6 gives us some shortcut syntax (more like syntactical sugar) also known as the arrow syntax. In ES5, defining functions may look like this:

```js
// es5
var evens = [2,4,6,8];

var odds = evens.map(function (v) { 
  return v + 1; 
});

var pairs = evens.map(function (v) {   
  return { even: v, odd: v + 1 }; 
});

var nums = evens.map(function (v, i) { 
  return v + i; 
});

```

In ES6, we can use what's called arrow functions (as seen below). Notice also that some arrow functions don't need explicit return values!

```js
 // es6
const evens = [2,4,6,8]

// One-line return statements can be in-lined.
// If the function's return statement is one line, there is an implicit return
// and {}'s are not needed.

const odds = evens.map(v => v + 1)

// is the same as:

const odds = evens.map(v => {
  return v + 1
})

// Note the lack of curly brackets in the below function.
// This function could also be written in one line,
// but is easier to read this way.

const pairs = evens.map(v => 
  ({ even: v, odd: v + 1 })
)

// 2+ arguments or no arguments require parentheses

const nums = evens.map((v, i) => v + i)

const greeter = () => console.log("Hey!")
```

An important thing to keep in mind is the scope of `this` when using arrow functions. In ES5, if we wanted to persist the value of `this` within a function, we'd need to save it as a variable then use it within the function like so:

```js
this.sendData = function () { ... };

var _this = this
$('.btn').click(function (event) {
  _this.sendData();
});
```

In ES6, `this` does not mutate. `this` will have the same value as the context of the function.

```js
this.sendData = () => { ... }

$('.btn').click(event => {
  this.sendData()
})

// or

$('.btn').click(event => this.sendData())
```

This is great at times, and more challenging at others. If you find yourself in a situation where `this` is not what you expect, you most likely need to call `.bind(this)` the method in which `this` is called.

### Default Parameters

ES6 introduces default parameters which is super awesome! In ES5, we would need to define defaults within the body of the function:

```js
// es5

function addNumbers (x, y, z) {
    if (y === undefined) {
        y = 7;
    }
    if (z === undefined) {
        z = 42;
    }
    return x + y + z;
    // return x + (y || 7) + (z || 42) would also work, but is a little clunky
};

addNumbers(1) === 50;

```

But, ES6 allows us to use default parameters similar to Ruby!

```js
// es6

const addNumbers = (x, y = 7, z = 42) => {
    return x + y + z
}

addNumbers(1) === 50
```

### Class & Prototypes 

We talked about constructor functions recently. If you all remember, we name our constructor function with a capital letter and after we define the function, we can add prototypes one at a time after the definition. 

```js
function Shape (id, x, y) {
    this.id = id;
    this.x = x || 0;
    this.y = y || 0;
};

Shape.prototype.move = function (x, y) {
    this.x = x;
    this.y = y;
};

Shape.prototype.currentPosition = function () {
    return [this.x, this.y];
};

```

ES6 gives us some fancy syntactic sugar to make this feel more similar to other OOP languages (like Ruby):

```js
class Shape {
    constructor (id, x = 0, y = 0) {
        this.id = id
        this.x = x
        this.y = y
    }

    move (x, y) {
        this.x = x
        this.y = y
    }

    currentPosition () {
        return [this.x, this.y]
    }
}

```

Notice, we have this `constructor` property that defines the properties on each instance of the class. Each function defined outside of the `constructor` property is a `prototype`.

Refresher: What's special about prototypes? 

## Independent Practice

Let's convert some code! You'll be working with the code that lives [here](https://gist.github.com/case-eee/7e87e60fd6b8cadd0a46fc8872017614). It's currently written in ES5. Fork the gist and work to convert this code into ES6. To test your code, run it in your console or using node.

## Closing

* Review learning goals (pull sticks)
  * Style regarding semi-colons
  * `var` vs. `let` and `const`
  * Template literals and string interpolation
  * `function` notation and `=>` notation
  * Lexical `this`
  * Class/Prototype constructors

You are encouraged to dive deeper into the differences between ES5 and ES6. You'll most likely see both at some point in your careers as developers. If you see something you're unsure about when reading code written in JavaScript, take a few seconds and do some research to ensure you're fully understanding the code (it may be written in fancy ES6).

## Additional Resources
* [ES6 Features](http://es6-features.org/)
* [Top 10 ES6 Features Every JavaScript Developer Should Know](https://webapplog.com/es6/) 
* [List of ES6 features](https://github.com/lukehoban/es6features)
* [What's new in ES6!](http://exploringjs.com/es6/ch_overviews.html)
* [About ECMAScript 6](http://exploringjs.com/es6/ch_about-es6.html#sec_tc39)
* [ES6 Compatibility Tables](https://kangax.github.io/compat-table/es6/)

