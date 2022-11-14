# Frontend JavaScript Refresher

## Learning Goals

- Understand what is the DOM
- Understand how to target HTML Elements
- Understand how to add event listeners

## Warm Up

- Have you written any Frontend JavaScript?
- If yes, what functionality did you write?

## What is the DOM?

DOM stands for Document Object Model
Let's break that down a little bit more:

- Document: the HTML document that makes up the view
- Object: every HTML element is parsed into an object by the browser
- Model: refers to how objects are laid out in a tree structure

The DOM consists of:
    * Parent nodes
    * Child nodes
    * Sibling nodes

With a partner, review the following html and identify the relationships of the elements as parent, child, or sibling:

```html
<html>
  <head>
    <title>Example WebSite</title>
  </head>
  <body>
    <section>
      <nav>
        <ul>
          <li>Home</li>
          <li>More Info</li>
          <li>FAQs</li>
        </ul>
      </nav>
    </section>
    <section>
      <article>
        <h2>First Header</h2>
        <p>This is the first paragraph!</p>

        <h3>Second Header</h3>
        <p>This is the second paragraph!</p>
      </article>
    </section>
  </body>
</html>
```

## Targeting Nodes

There are a few ways to target particular elements on a page.

- document.getElementById('target-id')
  Returns the element with matching id.

- document.getElementsByClassName('target-class-name')
  _Notice that it is `Elements` and not `Element` like the last function._
  Returns an HTML Collection of all elements with that class.

- document.getElementsByTagName('p')
  Returns and HTML Collection of all elements matching that html tag.

- We can do the same thing as the above using one function like so:
    - document.querySelector('#target-id')
    - document.querySelector('.target-class-name')
    - document.querySelector('target-tag')
  You must specify the type of selector you are targeting by including the `#` for ids or the `.` for classes.
  This function will return the first element that matches the selector.

- document.querySelectorAll()
  Returns a node list with all elements matching the selector

_Fun Fact you can search for elements by other attributes using `querySelector` with bracket notation ex) `document.querySelector('[role="navigation"]')`_

HTML collections and node lists look similar to arrays, but you cannot use array functions on them like `forEach` or `map`. In order to use array functions you must convert them into arrays. Here is an example of how you might do this:

```javascript
var allDivs = document.querySelectorAll('div')
var divArray = Array.from(allDivs)
```


#### Why you need `document.ready()`

Before we can successfully target elements in the DOM we must first ensure that the browser has created it. We do this by using the function `document.ready(() => { #your JavaScript code here })`.
If we forget to wrap our code with `document.ready()` the return for targeting our elements will be `null`.

## JavaScript Events

We usually target elements in the DOM because we want some action to occur when an _event_ takes place. For instance, maybe we want the text to change colors when we _mouseover_ it, or perhaps we want to send off information to an API when we _click_ a submit button for a form.
Both _click_ and _mouseover_ are events. Other events include: _mouseout_, _keypress_, _keydown_, _change_, etc. Google JavaScript events to find more.


## Adding an Event Listener

In order for an action to take place when an event occurs the element needs to know what event to _listen_ for and how to handle that event. First, you would target the element on which you want the event to occur and then `addEventListener()`. `addEventListener()` takes two arguments, the first argument is the event and the second is a function defining what action should occur.

JavaScript might look something like this:

```javascript
var targetElement = document.getElementById('target-id')
targetElement.addEventListener(event, (e) => console.log(e))
```

## Practice

Visit the [Mod 4 page](https://backend.turing.edu/module4/)
Open the inspect tools _if in chrome the hot key is cmd+option+i_
View the HTML elements that are available and in your console try the following:

  1. Return an element by targeting it's id
  2. Return all elements by targeting it's class
  3. Return all elements by targeting it's HTML tag
  4. Add an event listener to 3 elements on the page

### Bonus

Try navigating to elements by using, parentNode, childNodes, nextSibling, etc.
See the _Related Topics_ section of this [page](https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes)
