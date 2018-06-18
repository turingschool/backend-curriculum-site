# Fetch Refresher

---

# Warmup

* What do we mean when we say that JavaScript is asynchronous?

---

# Synchronous or Asynchronous?

- Only one block of code can run at a time (in the order that it is written/appears)
- JS is only asynchronous in the sense that it can perform some asynchronous operations (non-blocking)
- Tasks that can not be completed immediately are going to complete asynchronously

---

# Synchronous

```js
thisFunctionWillExecuteFirst();
thisFunctionWillExecuteSecond();
thisFunctionWillExecuteThird();
thisIsGoingToTakeForever();
iHaveToWaitOnAllTheseOtherSlowPokesAboveMe();
```

---

# Asynchronous Behavior

Using a callback:

```javascript
$('#clickity-click').click(() => {
  doSomething();
});
```

---

# Problems with Callbacks

* No guarantee that your code will execute when you expect.
* Executing callbacks in parallel is tricky.
* Executing callbacks in series is tricky.
* Error handling is inherently broken.
  * Pass two callbacks—successful/fail.
  * Use the Node.js "error-first" style of callbacks where the first argument is always an error object, which is typically set to `null` in the event that we reached a successful outcome.

---

# Promises

* Cleaner/more standardized way to deal with tasks that need to happen in sequence.
* More control over what happens with the outcomes of our async processes.

---

# Network Request Using jQuery

With a callback:

```js
$.getJSON('/api/v1/students.json', (students) => {
  console.log(students);
}, (error) => {
  console.error(error);
});

// No more access to students out here.
```

---

# Network Request Using jQuery

Using a promise:

```js
const students = $.getJSON('/api/v1/students.json');

students
  .then((students) => doSomethingWithStudents(students))
  .catch((error) => console.error({ error }));

// somewhere else, possibly further down in our code:
students
  .then((students) => doAnotherThingWithStudents(students));
```

---

# Callbacks in Sequence

```js
// get the student data
$.getJSON('/api/v1/students.json', (students) => {

  // get the projects for all students
  getProjectsForStudents(students, (projects) => {

    // get the grades for each project
    getGradesForProjects(projects, (grades) => {

      // finally, do something with all our student/project/grade data
      doSomethingImportantWithAllThisData(students, projects, grades);

    // handle errors getting student data
    }, (error) => {
      console.error({ error });
    })

  // handle errors getting project data
  }, (error) => {
    console.error({ error });
  })

// handle errors getting grade data
}, (error) => {
  console.error({ error });
});

```

---

# Callback Hell

![callback hell street fighters](https://pbs.twimg.com/media/COYihdoWgAE9q3Y.jpg)

---

# Promises in Sequence

```js
$.getJSON('/api/students.json')
   .then(students => getProjectsForStudents(students))
   .then(projects => getGradesForProjects(projects))
   .then(grades => doSomethingImportantWithAllThisData(grades))
   .catch(error => console.error({ error }));
```

*Note: Going forward, it is best to use the `fetch` API for making network requests. Using `getJSON` in this lesson is purely to demonstrate the difference between a callback implementation and promise implementation. `fetch` can only be used with Promises and is steadily becoming the industry standard.*

---

# 3 states of Promises

- Pending
- Resolved/Fulfilled (with a return value from your async operation)
- Rejected (with an error message from your async operation)

---

# Advantages of Promises

- Error handling is less broken.
    * It's not a silver bullet.
    * Synchronous functions either `return` or throw an error.
    * Promises will either become *resolved* by a value or become *rejected* with an error.
- Chaining promises is easy and does not result in callback hell.

---

# Advantages of Promises (continued)

But wait, there's more.

- `Promise.all` takes an array of promises and waits until all of the promises are resolved.
- `Promise.race` takes an array of promises and resolves as soon as any one of them fulfill.
    * Would allow you to hit 3 API endpoints and then move on when we heard back from whichever one came back first.

---

# GET vs POST

`fetch()` takes TWO arguments:

- URL or API endpoint (always)
- Object of configuration settings for the request (optional). May contain:
    * what kind of request we're making
    * data we may need to pass along with it.

---

# Explore: Fetch GET

```js
const fetchDiscussions = () => {
  fetch('/api/vi/discussions')
  .then((response) => response.json())
  .then((rawDiscussions) => cleanDiscussions(rawDiscussions))
  .catch((error) => console.error({ error }));
}
```

---

# Fetch POST

```js
const postDiscussions = () => {
  fetch('/api/vi/discussions', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      discussionName: 'Foo',
      totalPoints: 100,
    });
  });
}
```

---

# Fetch Promises

* Every fetch request we make will return a Promise object that contains our response data.
* Allows us to easily react to the type of response we get once it's available.

---

# Handling Fetch Response

```js
fetch('/api/v1/discussions', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    discussionName: 'Foo',
    totalPoints: 100,
  })
})
.then(response => response.json())
.then(discussions => renderDiscussions(discussions))
.catch((error) => console.error({ error }))
```

---

# Organizing Fetch Requests

* Examples above have used anonymouse functions each step of the way.
* Naming things can be a powerful tool to refactor.

---

# Organizing Fetch Reqeusts (continued)

How might you refactor the code below?

```js
fetch('http://localhost:3000/api/v1/posts')
  .then(handleResponse)
  .then((posts) => {
    posts.forEach((post) => {
      $(".posts-box").append(post)
    })
  })
  .catch(error => {
    console.error(error)
  })
```

---

# Organizing Fetch Requests (continued)

```js
const appendPosts = (posts) => {
  posts.forEach((post) => {
    $(".posts-box").append(post)
  })
}

const errorLog = (error) => {
  console.error(error)
}

fetch('http://localhost:3000/api/v1/posts')
  .then(handleResponse)
  .then(appendPosts)
  .catch(errorLog)
```

---

# Organizing Requests as Event Handlers

What opportunities for refactor do you see in the code below?

```js
$('form').on('submit', (event) => {
  event.preventDefault()
  return fetch('http://example.com/articles', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(article)
  })
    .then(handleResponse)
    .then(appendArticle)
    .catch(errorLog)
})
```

---

# Event Handlers Refactored

```js
// event bindings live nicely as one liners
$('form').on('submit', postArticle)

const requestOptions = {
  method: 'post',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(article)
}

// Fetch call is nice and tidy on its own
const postArticle = (event) => {
  event.preventDefault()
  return fetch('http://example.com/articles', requestOptions)
    .then(handleResponse)
    .then(appendArticle)
    .catch(errorLog)
}
```

---

# Interview Questions

Pair up with your Quantified Self partner and practice answering the following interview questions:

* What are the advantages of using fetch?
* What are promises used for? Can you give an example of when you've used one?

Be ready to share you answer(s) with the class when we wrap up.

