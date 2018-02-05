# Organizing an Express App

---

# Warmup

Given the code that you currently have in the `/api/secrets.js` file:

* Walk through each line of code and describe what it's doing.
* How might you split the code in that function into smaller functions?
* How might you split it into separate files?

---

# Creating a Secret Model

With a partner see if you can extract methods to create a Secret model.

* What will this file be called?
* Where will you put it?
* What are its responsibilities?
* Are there things currently in `secrets.js` that are specifically *not* the responsibility of the model?
* Go ahead and see if you can move your code and ensure that everything still works.

---

# Share

---

# `destroyAll`

```js
// secret.js
const destroyAll = () => {
  return database.raw('TRUNCATE secrets RESTART IDENTITY')
}

module.exports = {
  create,
  destroyAll,
}
```

---

# Creating a Secrets Controller

With a partner see if you can extract methods to create a Secrets Controller.

* What code from our `app.js` looks like it might belong in a controller?
* How could you extract that code in to a function or functions?
* If you had to extract this code to another file, what questions would you have?
* Go ahead and see if you can move your code and ensure that everything still works.

---

# Share

---

# Questions

Express is not as opinionated as Rails when it comes to orgnizing our app.

* Can you think of another way to organize these responsibilities?
* What advantages/disadvantages do you see to an unopinionated framework over a more opinionated framework?

---

# Going Further

See lesson plan.

