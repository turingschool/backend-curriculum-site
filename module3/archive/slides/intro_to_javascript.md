# Introduction To JavaScript

---

## Warmup

1. What are your thoughts about JavaScript?

---

## Learning Goals

1. Understand how client-side JavaScript is useful
2. Understand what the DOM is and how to manipulate it
3. Explore using the jQuery library to perform DOM traversal and manipulation

---

## What is Javascript

- Javascript is an object-oriented scripting language made to run inside in a host environment such as a web browser and provide programatic control over the objects of that environment
- Javascript is the [most commonly used language on Github](https://madnight.github.io/githut/#/pull_requests/2019/2)

---

## Client-side JavaScript
- Javascript is run on the user's computer
- When a webpage is viewed, the javascript is downloaded from the server, then run in the browser where the results are displayed.

---

## The DOM
- The host environment we will focus on today is the browser.
- Because Javascript is a dynamic language that allows objects to be modified during run-time, dynamically updating content is possible, i.e. animating images, interactive maps, updating content without refreshing the screen
- In the browser the objects that can be manipulated are a part of the Document Object Model (DOM)

---

## What Is The DOM?

Take 10 minutes to read this article:
https://www.digitalocean.com/community/tutorials/introduction-to-the-dom#what-is-the-dom

With the person next to you discuss:
1. What is the DOM?
2. How is it different from the HTML source code?
2. How do you target DOM elements?

---

## What is the DOM?

- DOM - Document Object Model
- A virtual representation of you html document

---

## How do you target things in the DOM

- Elements are objects with properties
- The DOM tree is traversable using dot notation

---
## Quick and Dirty Intro To Javascript Syntax

- Variable declaration
  - var, let, const
  - ex:
    - var vegetable = 'lettuce';
    - var number = 1;
    - let me = 'alex';

- Function definition

```
  function name(parameter1, parameter2, parameter3) {
  // code to be executed
  }
```
  - `function` keyword
  - name of function
  - parenthesis
  - code to be executed is placed inside curly brackets
  - you must explicitly return code with a `return` statement
  - ex:
    ```
      function myFunction(a, b) {
        return a * b;             // Function returns the product of a and b
      }
    ```

- Function declaration

```
  var x = myFunction(4, 3);   // Function is called, return value will be assigned to x

```

- objects
  - consists of name/value pairs (vs. key/value pairs in ruby)
  - name/value pairs can consists of
    - properties of any datatype (i.e. strings, numbers, booleans) and methods
    - methods - functions contained within an object
  - objects can be created using an object literal or the object constructor
  - object properties and methods can be accessed by dot and bracket notation

- object literal

```
  let salad = {
    lettuce: 'romaine',
    dressing: 'ranch'
    croutons: true,
    addMeat: function() {
      return 'Bacon added!';
    }
  }
```
- object constructor

```
 let salad = new Object();

 salad.lettuce = 'romaine';
 salad.dressing = 'ranch';
 salad.croutons = true;
 salad.addMeat = function() {
   return 'Bacon added';
 }

```

---

## Let's practice!
- https://github.com/turingschool-examples/vacation-spots

1. Select the H3 with innerText of ‘Paris’
2. Change the color of the Paris H3 text to pink
3. Change the background color of the ".background" div to a different color
4. On click of the button, make the H3 disappear

Some additional resources for manipulating the DOM:
- [Set and Get CSS styles of elements](https://plainjs.com/javascript/styles/set-and-get-css-styles-of-elements-53/)
- [Selecting DOM Elements](https://plainjs.com/javascript/selecting/)

Do this in the console of the browser first!
- Open the vacation_spots.html page in the browser.
- Right click on the page and select `Inspect` to open the Chrome dev tools
- View the DOM tree in the `Elements` tab
- Play around with manipulating the DOM nodes in the console first.

Transition code from the console to the `vacationSpots.js` file once you know it works.

---

## Is the DOM ready?

- The browser must download content from the server (html, css, JavaScript, images etc.)
- We must wait for the content to be fully downloaded and the DOM tree to be built before we can access DOM nodes and manipulate the content.

---

# The lifecycle of an HTML document

- Three important Events in the lifecycle of an HTML page:
1. *DOMContentLoaded* - the browser has fully loaded the HTML, and the DOM tree is built, but external resources like pictures <img> and stylesheets may not be loaded yet.
2. *load* - the browser has fully loaded the HTML, DOM tree, and external resources i.e. images, stylesheets
3. *beforeunload/unload* - the user is leaving the page

---

```
document.addEventListener("DOMContentLoaded", function(event){
  doSomeThings();
});
```

```
window.onload = function() {
  doAllTheThings();
}
```

```
window.onunload = function() {
  doSomethingElse();
}
```

---
## jQuery!

- A javascript library that makes DOM manipulation easier and faster
- Follow this [tutorial](https://backend.turing.io/module3/lessons/jquery_and_dom) to learn more about jQuery

---

## Adding Javascript to Rails

1. Logically organize your scripts in the `app/assets/javascripts/` folder.
3. Let the Rails asset pipeline combine them all in one minimized `application.js` file.
4. List scripts in the `app/assets/javascripts/application.js` manifest.
5. Add additional js files to precompile to `config/initializers/assets.rb` file
`Rails.application.config.assets.precompile += %w( <file name>.js )`
5. In your view include a javascript file with a javascript include tag:
`<%= javascript_include_tag "<file name>" %>`

For more information: http://railsapps.github.io/rails-javascript-include-external.html

---

## Further Learning and Exploration

Intro to Fetch:
https://backend.turing.io/module3/lessons/fetch_in_javascript

---
