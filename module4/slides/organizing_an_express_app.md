# Organizing an Express App

---

# Warmup

Given the code that you currently have in the `index.js` file:

* Walk through each line of code and describe what it's doing.
* How might you split the code in the routing functions into smaller functions?
* How might you split it into separate files?

---

# Creating a Paper Model

With a partner see if you can extract methods to create a Paper model.

* What will this file be called?
* Where will you put it?
* What are its responsibilities?
* Are there things currently in the routing functions that are specifically *not* the responsibility of the model?
* Go ahead and see if you can move your code and ensure that everything still works.

---

# Share

---

# Creating a Papers Controller

With a partner see if you can extract methods to create a Papers Controller.

* What code from our `app.js` looks like it might belong in a controller?
* How could you extract that code in to a function or functions?
* If you had to extract this code to another file, what questions would you have?
* Go ahead and see if you can move your code and ensure that everything still works.

---

# Share

---

# Routes

```js
# lib/routes/api/v1/footnotes.js

const express = require('express');
const router  = express.Router();
const footnotesController = require('../../../controllers/footnotes_controller')

router.get('/', footnotesController.index);

module.exports = router

# index.js
const footnotes = require('./lib/routes/api/v1/footnotes')

app.use('/api/v1/footnotes', footnotes)
```




---

# Questions

Express is not as opinionated as Rails when it comes to orgnizing our app.

* Can you think of another way to organize these responsibilities?
* What advantages/disadvantages do you see to an unopinionated framework over a more opinionated framework?

---

# Going Further

See lesson plan.

