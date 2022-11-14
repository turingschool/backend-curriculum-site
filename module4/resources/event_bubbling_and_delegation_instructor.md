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

## Materials

- Pairs
- Groups of 2-3 for poster activity, ideally someone not in pair
- 6+ anchor charts (suggested to mark posters with group number and button/parent/grandparent to avoid confusion - see Small Group Practice)
- markers
- Possible - PollEverywhere account and questions prepped (see Review at end of lesson)
- Students will need notebooks, pens, and laptops

## Warm Up

Have students write or talk through responses to the following questions:

* When thinking about front-end interactions, what is an event?
* What are some events that typically take place on a webpage?##
* What is the DOM?

## Event Basics

Quick overview - Instructor talks

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

NOTE - students will use this code pen for the small group practice.

In the following code pen, we have three nested HTML elements in `index.html`:

<p data-height="265" data-theme-id="0" data-slug-hash="pLvGMM" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="Event Bubbling" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/pLvGMM/">Event Bubbling</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### Small Group Practice

Provide instructions verbally, then let them get into the lesson resource and read this as a reference.

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

#### Turn & Talk
- What happens when the button is clicked, and why? What technical vocabulary help you explain that.
  * Answer: The event `bubbles` up to all parent nodes, so all three event listeners are triggered and we get all three console.logs.
- What happens when the grandparent is clicked? Why is that all that happens?
  * Answer: Only the grandparent's listener is triggered. The event bubbles up and there are not listeners on parents of the grandparent node.

### Why Do We Care?

This section was added in recently to address the exact question - cool, but when will I actually need to use/know this?

There is a decent chance our students won't run into issues because of bubbling, but it's nice to provide them with some context/an example of unexpected behavior.

![inline](./assets/event_example.png)

In the screenshot above, the "Recent Selections" card has a table-like structure, where each row has data and several buttons. What can't be illustrated in a screenshot is that the row itself can be clicked on to be expanded. Turing, Imperatives, and the two icons on the right can also be clicked on to navigate to another screen.

In your notebook, write your answers/sketch out:
- What relationship does the row have to the icons?
- Which nodes need an event listener?
- Where may event bubbling cause a problem? What would the experience be like for the user?

### The Event Object

Read through and discuss this section.

Common questions - is event a keyword? NO - but developers typically either use `event` or `e` to communicate it.

## Back to Events

### Adding and Removing Event Listeners

A common obstacle that many JavaScript developers struggle with is understanding the timing in which they bind event listeners to DOM nodes. When we add event listeners to DOM nodes, we're only adding them to the nodes that are currently on the page. We are _not_ adding listeners to nodes that may be added to the page in the future.

### Experiment

Have students work through codepen with the following directions:

You should see 2 tasks in our To-do List labeled "Task 1" and "Task 2" as well as a button for adding new tasks to our list.

1.  Click each of the tasks in our list and verify that each one fires an `alert` notifying you that the `li` element has in fact been clicked.
2.  Add an additional task using the "Add new task" button.
3.  Click on the new task and observe the results.

Make sure students really dig into this question:
- What did you notice? What is your prediction about why this is happening?

The answer:
- The event listeners are only bound to the li elements that were present when the page code was first loaded. The li elements we added later were not around when we added the listeners.

**What could we do to fix this?**

Now, push students to do some thinking/research to solve this with a partner:
- Work with your partner to modify the function that adds new buttons so that it adds an event listener to the element before appending it to the page. Some googling will probably be involved.

## Event Delegation

This section should stamp their discoveries from the experiment with the to-do list.

## Extra: Enough with the Bubbles

If time permits, chat about this. If not, recommend students read up on this on their own.

## Review

NOTE - This can be done in written form in notebooks, google form submission, etc. Another great option is creating a poll with these questions in [PollEverywhere](https://www.polleverywhere.com) (accounts are free). All students answer at the same time (anonymously or with a screen name), then you can view and/or show the results to the class to identify trends and address any misconceptions immediately.

* What is the DOM?
* List two different events that can occur on the DOM.
* What is an event listener?
* When an element is bound to a listener, what besides that element can trigger an event?
* What does event bubbling or event propagation mean?
