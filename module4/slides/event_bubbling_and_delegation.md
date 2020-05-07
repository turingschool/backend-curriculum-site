# Object Bubbling & Delegation

---

# Warmup

* What is an event?
* If you clicked on the text inside a button, would you assume that you had clicked the button?
* If you clicked on a button, have you clicked on the page?

---

# Event Basics

* Events happen all the time
* Page finished loading
* Mouse moves
* Mouse hovers
* Mouse click
* Some easy to spot
* Others completely unnoticed

---

# Events & JS

* Can use JS to listen for events
* Attach event listeners to elements
* Find the element
* Specify event
* Indicate what we'd like to do when the event fires

---

# Syntax Refresher

```
// $(css selector).on(event, callback(event));
// For example

$('.buttons').on('click', function(event) {
    console.log('Clicked!')
    })
```

* Link to setting event listeners without JQuery in the lesson.

---

# Bubbling Experiment

* Find the link to the codepen in the lesson and fork it.
* Follow the instructions for your group.
* Answer the following questions.
    * What is the result when you click on the button?
    * What is is the result when you click the `.parent` element?
    * What is is the result when you click the `.grandparent` element?
* Draw a diagram to explain what is happening and write your code out on your poster!

---

# Bubbling

* Based on the results, work with a partner to create your own definition of event bubbling.
* What is the difference between `event.target` and `event.currentTarget`?

---

# With Your Pair

So far we have added event listeners to existing elements.

JS also allows us to add elements to the DOM dynamically.

* What do you think happens when we add an element to the DOM dynamically that needs an event listener?

---

# Experiment

Open and fork the second Codepen from the lesson plan.

1.  Click each of the tasks in our list and verify that each one fires an `alert` notifying you that the `li` element has in fact been clicked.
2.  Add an additional task using the "Add new task" button.
3.  Click on the new task and observe the results.

* What did you notice?
* How can we fix this?

---

# Delegation

* Instead of adding event listeners to each element directly, add an event listener to an element higher up the DOM.
* Use `event.target` in your callback to determine child element specifically was clicked.
* Use information from that element to determine what to do in your JS callback.

---

# Delegation Example

* See if you can adjust the second Codepen to make it so that an alert fires when new `li` elements are clicked.

---

# Just in Case

* `event.stopPropagation()`

```js
const selectors = [".grandparent", ".parent", "#click-me"]

selectors.forEach(function (selector) {
  $(selector).on("click", function (event) {
    console.log("target", event.target)
    console.log("currentTarget", event.currentTarget)
    event.stopPropagation()
  })
})
```

---

# Lies I've Told You

* Event propagation is slightly more complicated than I've indicated.

![inline](images/event_flow.png)

---

# Review

* When an element is bound to an event listener, what besides that element can trigger the event?
* How does this relate to "event bubbling"?
* When do we want to utilize event delegation?
* What is the difference between `target` and `currentTarget`?

---

# Interview Question

* What does event bubbling or event propagation mean?
