# Introduction To JavaScript

---

## Warmup

1. With the person next to you, share one of your job hunt goals for mod 3 and describe the steps you will/are taking to achieve that goal.

---

## Learning Goals

1. Gain a high level understanding of how Javascript compares to Ruby
2. Understand the difference between server-side and client-side JavaScript
3. Gain familiarity with Javascript Syntax
4. Understand what the DOM is and how to manipulate the DOM within a rails application

---

## What is Javascript

- JavaScript is an object-oriented scripting language made to run inside in a host environment such as a web browser and provide programatic control over the objects of that environment
- Javascript is a dynamic language that allows objects to be modified during run-time
- This makes dynamically updating content possible, i.e. animating images, interactive maps, updating content without refreshing the screen
- Javascript is the most commonly used language on Github: https://madnight.github.io/githut/#/pull_requests/2019/2

---

## History of JavaScript

- Javscript was first released with Netscape 2 in 1996
- Rumor has it that Brendan Eich wrote it in 10 days in 1995 while working as an engineer at Netscape
- The name 'JavaScript' was a marketing push to try to pick up on the momentum of Sun Microsystem's popular language Java
- Unfortunately it lead to many people being confused for a long time about the names of these two mostly unrelated programming languages

---

## Client-side and Server-side JavaScript

- Take 5 minutes to research client-side and server-side JavaScript.
- With the person next to you discuss:
1. How is client-side JavaScript different from server-side JavaScript.
2. Why is client-side JavaScript useful?
3. Why would we want to use server-side JavaScript?

---

## Client-side and Server-side JavaScript
- Client-side: Code that is run on the user's computer
  - When a webpage is viewed, the page's client-side code is downloaded, then run and displayed in the browser.

- Server-side: Code that is run on a Server
  - The code is executed on the server, then downloaded and displayed in the browser

---

## ECMAScript

- The ECMAScript specification was established in 1997 to standardize javascript implementations.
- ECMAScript is on it's *10th* edition (ES2019)
- Most browsers support only the 3rd (ES3) or 5th (ES5) versions of ECMAScript
- Javascript has to be transpiled and polyfilled so that browsers can run it.
- What works on some browsers won't work in others. Internet Explorer :(
- We will learn both ES5 and ES6(ES2015) syntax

---

## How does Javscript compare to Ruby?

---

## How do we write Javascript?

- Let's do some activities!

---

## What is the DOM?

- DOM - Document Object Model
- A virtual representation of you html document

---

## How do you target things in the DOM

- Elements are objects with properties
- The DOM tree is traversable using dot notation

---

## Let's practice!

---

## Is the DOM ready?

- The browser must download content from the server (html, css, JavaScript, images etc.)
- We must wait for the content to be fully downloaded and the DOM tree to be built before we can access DOM nodes and manipulate the content.

---

# The lifecycle of an HTML document

- Three important Events in the lifecycle of an HTML page:
1. DOMContentLoaded
- the browser has fully loaded the HTML, and the DOM tree is built, but external resources like pictures <img> and stylesheets may not be loaded yet.
2. load
- the browser has fully loaded the HTML, DOM tree, and external resources i.e. images, stylesheets
3. beforeunload/unload
- the user is leaving the page

---

```
window.onload = function() {
  doSomethings();
}
```

---

## Adding Javascript to Rails

1. Logically organize your scripts in the `app/assets/javascripts/` folder.
3. Let the Rails asset pipeline combine them all in one minimized `application.js` file.
4. List scripts in the `app/assets/javascripts/application.js` manifest.

for more information: http://railsapps.github.io/rails-javascript-include-external.html

---

## Let's add some javascript to a Rails App!

---

## Wrap Up

1. Why is JavaScript useful?
2. What are some ways that JavaScript is similar to Ruby?
3. What is the DOM?
4. Why don't we want to add <script> tags to the bottom of our views in rails?
