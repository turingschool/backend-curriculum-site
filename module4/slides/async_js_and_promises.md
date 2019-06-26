# Asynchronous JavaScript

---

# Warm Up

* What is your version of a ten second history of JavaScript? Where did it start?
* Review the code in the warmup section of the lesson online.
    * What do you expect the output to be?
    * Type the code into a file called `async.js` and run it using `node async.js`
    * What happens? How could you use this behavior to your advantage? What might be some pitfalls?

---

# Synchronous vs. Asynchronous

* Synchronous: Runs in order. Method calls block future method calls.
* Asynchronous: Reads in order. Doesn't block future method calls.

---

# Exploration

Clone [this repository](https://github.com/s-espinosa/js_async_exploration) referenced in the lesson.

* Read the code in each example file.
* Walk through each line with your partner and describe what it will do.
* Run the code using `node filename.js` from your command line.

---

# Share

---

# Callbacks

```
console.log("BEFORE")
setTimeout(printNotification, 1000)
console.log("AFTER")

function printNotification() => {
  console.log("Notification Printed")
}
```

* Pitfall: be sure that when you pass a named function as an argument that you don't invoke it.

---

# Promises

* Also allow us to provide code for JS to run after a task is complete.
* Have three separate states:
    * Pending
    * Resolved/Fulfilled (with a return value from the async operation)
    * Rejected

---

# Then/Catch

* If promise is resolved, `.then` runs.
* If promise is rejected, `.catch` runs.

Can chain `.then` calls if the function within one returns another promise.

---

# When to Use

* When using an existing promise-based library.
* Can write them yourself, but likely less common at this point.

---

# Promise.all

* Makes an array of promises and waits until all of the promises are resolved. This solves the nastiness involved in doing this with callbacks.

---

# More Methods with Multiple Promises

* Promise.race()
* Promise.any()
* Promise.allSettled()

---

# Wrap Up

* What is a callback?
* How are callbacks used in JavaScript with asynchronous code?
* What is a Promise in JavaScript?
* What are the different states that a Promise can have?
* What functions can you call on a Promise to handle cases when it is fulfilled or rejected?
* Interview Question: What do you know about asynchronous JavaScript?

