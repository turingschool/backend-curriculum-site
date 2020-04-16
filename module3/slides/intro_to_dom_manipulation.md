# DOM Manipulation

---

## Warmup

Review with your neighbor everything you know about JavaScript objects

---

## Learning Goals

1. Introduction to Client-side JavaScript
2. Understand what the Document Object Model (DOM) is
3. Practice manipulating the DOM with JavaScript

---

## Client-side and Server-side JavaScript

- With the person next to you discuss:
1. How is client-side JavaScript different from server-side JavaScript.
2. Why is client-side JavaScript useful?
3. Why would we want to use server-side JavaScript?

---

### Client-side
Code that is run on the user's computer
  - When a webpage is viewed, the page's client-side code is downloaded, then executed and displayed in the browser.

---

### Server-side
Code that is run on a Server
  - The code is executed on the server, then downloaded and displayed in the browser

---

## The DOM!

When you view a website in the browser, the browser interprets the HTML and CSS and renders the style, content, and structure of the page.

In order to do this, the browser creates a representation of the HTML document known as the Document Object Model or the DOM.

---

## The DOM!
The DOM is a representation of the HTML source code that allows you to use javascript to access the elements of the HTML as objects.

The document object model:
- is an object that has many properties and methods.
- we use its properties and methods to access and modify the elements of the html document.
- We use dot notation to access the objects, their properties, and their methods.

---

## Turn and Talk
With your neighbor discuss:
1. How is the DOM different than HTML source code?
2. When will the DOM look different than the HTML source code?

---

## Accessing elements in the DOM

There are many ways to access elements in the DOM. Below are a few methods we will discuss:


- `getElementById()`
- `getElementsByClassName()`
- `querySelector()`
- `querySelectorAll()`

---

`getElementById()`

- selects a single element in the DOM by it's unique id

---

`getElementsByClassName()`

- selects on or more specific elements in the DOM by it's class.
- returns an array-like object of DOM elements

---

`querySelector()`

- selects a single element with a matching selector

---

`querySelectorAll()`

- selects all of the elements with a matching selector
- returns an array-like object of DOM elements

---

## Let's practice!
  - https://github.com/turingschool-examples/vacation-spots

---

  1. Change the color of the Paris H3 text to pink
  2. Change the color of all of the H3 text to pink
  3. Change the background color of the ".background" div to a different color

---

Some additional resources for manipulating the DOM:
- [Understanding the Document Object Model](https://www.digitalocean.com/community/tutorial_series/understanding-the-dom-document-object-model)
- [Set and Get CSS styles of elements](https://plainjs.com/javascript/styles/set-and-get-css-styles-of-elements-53/)
- [Selecting DOM Elements](https://plainjs.com/javascript/selecting/)

---

## Further learning and Exploration

Adding Javascript To Rails:
http://railsapps.github.io/rails-javascript-include-external.html

Intro to jQuery:
https://backend.turing.io/module3/lessons/jquery_and_dom

Intro to Fetch:
https://backend.turing.io/module3/lessons/fetch_in_javascript

---
