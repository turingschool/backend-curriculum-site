---
layout: page
title: Event Bubbling and Delegation
length: 90
tags: javascript, dom, browser, events
---

## Learning Goals

* Understand event bubbling
* Learn to use event bubbling to set event listeners

## Vocabulary

* event
* DOM
* DOM node
* event listener
* capture, target, bubble
* child, parent, grandparent

## Warm Up

* When thinking about front-end interactions, what is an event?
* What are some events that typically take place on a webpage?##
* What is the DOM?

## Event Basics

Events are happening all the time in the browser. When the browser has finished loading the page, an event is fired. Every time the user moves their mouse, hovers over an element, clicks or taps, submits a form, presses down on a key or takes their finger off that key — an event is fired. Some of these events are very easy to spot when they occur (e.g. the user clicks on a hyperlink), but many go by completely unnoticed.

It is, however, possible for us to use JavaScript to set up listeners for events that interest us. Our listeners wait patiently on a DOM node until the event they're waiting for is fired. Then, they spring into action, running an appropriate function to respond to the event as required, or whatever else you deem appropriate.

For a review of how to set event listeners, please refer to the [Introduction to JavaScript III - Intro to DOM Manipulation](http://frontend.turing.edu/lessons/module-1/js-3-dom-manipulation.html)


## Things to know

Event propagation is an important yet misunderstood topic/term when talking about events. Event propagation is an overarching term that includes the three different phases of DOM Events: capturing, targeting, and bubbling. Event propagation is bi-directional (starts at the window... goes to the target... and ends at the window) and is often improperly used as a synonym for event bubbling. Every time an event occurs, event propagation is occurring behind the scenes.

* **Event capture phase** - When an event occurs in the DOM, notification of the event is passed starting at the top of the DOM tree and passing down through all parent element nodes all the way to the target node where the event occurred.
* **Event target phase** - After the capturing phase occurs, the Target phase occurs. The target phase only includes a notification of Node where the event took place.
* **Event bubbling phase** - This is the final phase to occur, although many people think this is the first phase. In the bubbling phase a notice is passed from the target Node up through all of the parent Nodes all the way back to the top root of the DOM


## Event Bubbling

Now we've talked about the very basics of events, let's turn our attention to event bubbling, which refers to the ability of events set on DOM nodes to "bubble up" and also apply to children of those nodes. We'll start with a quick experiment.

### Experiment

In the following code pen, we have three nested HTML elements in `index.html`:

<p data-height="265" data-theme-id="0" data-slug-hash="pLvGMM" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="Event Bubbling" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/pLvGMM/">Event Bubbling</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### Small Group Practice

Visit the [this page][codepen] and fork the CodePen.

[codepen]: https://codepen.io/ameseee/pen/pLvGMM

Follow your group's directions, then answer the following questions:
*   What is the result when you click on the button?
*   What is is the result when you click the `.parent` element?
*   What is is the result when you click the `.grandparent` element?

Refactor any code you wrote.

Draw a diagram to explain what is happening and write your code out on your poster!

**Groups 1, 4:**
*   Add a click event to the button that logs or alerts:
  * `this`
  * event.target
  * event.currentTarget

**Groups 2, 5:**
*   Add a click event to the `.parent` element that logs or alerts:
  * `this`
  * event.target
  * event.currentTarget

**Groups 3, 6:**
*   Add a click event to the `.grandparent` element that logs or alerts:
  * `this`
  * event.target
  * event.currentTarget


### Partner Experiment

You may have noticed that the event listeners on a parent element are fired whenever the action occurs on one of its children.

When an event occurs, the browser checks the element to see if there are any event listeners registered. After it checks the element where the event occurred, the browser works its way up the DOM tree to see if any of the parents have a listener registered, then grandparents, and so on. It checks every element all the way up to the root (see `event.path`). This process is known as _event bubbling_.

Try out the following code in your forked CodePen:

```js
  $('.grandparent').on('click', function(event) {
    console.log('Grandparent');
  });

  $('.parent').on('click', function(event) {
    console.log('Parent');
  });

  $('#click-me').on('click', function(event) {
    console.log('Button');
  });
```

#### Turn & Talk
- What happens when the button is clicked, and why? What technical vocabulary help you explain that.
- What happens when the grandparent is clicked? Why is that all that happens?

### Why Do We Care?

![inline](./assets/event_example.png)

In the screenshot above, the "Recent Selections" card has a table-like structure, where each row has data and several buttons. What can't be illustrated in a screenshot is that the row itself can be clicked on to be expanded. Turing, Imperatives, and the two icons on the right can also be clicked on to navigate to another screen.

In your notebook, write your answers/sketch out:
- What relationship does the row have to the icons?
- Which nodes need an event listener?
- Where may event bubbling cause a problem? What would the experience be like for the user?

### The Event Object

The anonymous function passed to `$(selector).on('click', function(){})` takes an optional argument, which it assigns an `Event` object to. In the case of the click event we've been using as an example, this is a `MouseEvent`. You can visit [the MDN page for `Event`](https://developer.mozilla.org/en-US/docs/Web/API/Event) to explore the full list of supported event types.

Each type of event supports a number of different properties. `MouseEvent` has information about the `x` and `y` coordinates where the mouse was clicked. `KeyboardEvent` has information about which key was pressed. The `target` and `currentTarget` properties on the `Event` object can be useful during the event bubbling phase.

The `target` property represents the node that actually triggered the event, whereas `currentTarget` is the node that is *listening* for the event. Sometimes, `target` and `currentTarget` are the same node, but not *always*.

For example, if a `div` listens for a `click` event, a child `button` of the
`div` is clicked, the `target` would be the `button`, and the `currentTarget`
would be the `div`.

```html
<!-- index.html -->
<div class="container">
  <button class="submit">Submit</button>
</div>
```

```js
// scripts.js
$(".container").on("click", function (event) {
    console.log(event.currentTarget); // With only one event listener registered,
      // this will always be the div.container node

    console.log(event.target); // if you click the button, this will be the
      // button.submit node
      // if you click outside of the button, but still in the .container space,
      // it will log the div.container node
  });
```

Let's make some changes to the code from earlier. Instead of logging a description of each element where an event was triggered, either by a click or through event bubbling, let's log the `target` and `currentTarget` of the event.

```js
$('.grandparent').on('click', function (event) {
  console.log("target", event.target);
  console.log("currentTarget", event.currentTarget);
});

$('.parent').on('click', function (event) {
  console.log("target", event.target);
  console.log("currentTarget", event.currentTarget);
});

$('#click-me').on('click', function (event) {
  console.log("target", event.target);
  console.log("currentTarget", event.currentTarget);
});
```

## STOP & REFACTOR

Just because we are in JavaScriptopolis doesn't mean we have to write WET ("Woo! Extra Typing!") code! In the interest of always keeping an eye out for repetitive tasks, let's see that previous snippet refactored with a `forEach` call:

```js
const selectors = [".grandparent", ".parent", "#click-me"];

selectors.forEach(function (selector) {
  $(selector).on("click", function (event) {
      console.log("target", event.target);
      console.log("currentTarget", event.currentTarget);
    });
});
```

## Back to Events

### Adding and Removing Event Listeners

A common obstacle that many JavaScript developers struggle with is understanding the timing in which they bind event listeners to DOM nodes. When we add event listeners to DOM nodes, we're only adding them to the nodes that are currently on the page. We are _not_ adding listeners to nodes that may be added to the page in the future.

### Experiment

<p data-height="265" data-theme-id="0" data-slug-hash="pLvYrj" data-default-tab="js,result" data-user="ameseee" data-embed-version="2" data-pen-title="Events: Event Delegation" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/pLvYrj/">Events: Event Delegation</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

You should see 2 tasks in our To-do List labeled "Task 1" and "Task 2" as well as a button for adding new tasks to our list.

1.  Click each of the tasks in our list and verify that each one fires an `alert` notifying you that the `li` element has in fact been clicked.
2.  Add an additional task using the "Add new task" button.
3.  Click on the new task and observe the results.

What did you notice? What is your prediction about why this is happening?

The event listeners are only bound to the li elements that were present when the page code was first loaded. The li elements we added later were not around when we added the listeners.

**What could we do to fix this?**

Work with your partner to modify the function that adds new buttons so that it adds an event listener to the element before appending it to the page. Some googling will probably be involved.

## Event Delegation

Setting event listeners on specific newly created DOM nodes is one way to set event listeners. However, if you're not careful, you may end up setting multiple listeners on the same node.

Also, you can cause a [memory leak](http://javascript.crockford.com/memory/leak.html) if an event listeners are not unbound from an element when it is removed from the DOM.

Rather than manage the addition and removal of event listeners, there is a methodology you can use called *__event delegation__*.

In *__event delegation__*, we take advantage of the fact that events bubble in the event loops by setting an event listener on one parent. This event listener analyzes bubbled events to find a match in its child elements.

From the jQuery documentation: "Event delegation refers to the process of using event propagation (bubbling) to handle events at a higher level in the DOM than the element on which the event originated. It allows us to attach a single event listener for elements that exist now or in the future."

Event delegation in tandem with `target` and `currentTarget` allows you to have more articulate control over what events actually execute your JavaScript.


## Extra: Enough with the Bubbles

You have already come across `event.preventDefault()`, which does exactly what its name implies.

In the context of event bubbling and delegation, there is another function on the `Event` object that is useful for controlling event flow:

```js
event.stopPropagation();
```

As you might expect, this prevents the event from traveling up the ancestral node path.

This is helpful if a parent and child both have listeners, but should be executed in different contexts.

> I never thought I would ever say the words "ancestral node path".

Coming back to this generic logging example, what happens if you stop propagation after the `console.log()` lines?

```js
const selectors = [".grandparent", ".parent", "#click-me"];

selectors.forEach(function (selector) {
  $(selector).on("click", function (event) {
      console.log("target", event.target);
      console.log("currentTarget", event.currentTarget);
      event.stopPropagation();
    });
});
```

Click around the DOM to see the results.


## Review

* What is the DOM?
* List two different events that can occur on the DOM.
* What is an event listener?
* When an element is bound to a listener, what besides that element can trigger an event?
* What does event bubbling or event propagation mean?
