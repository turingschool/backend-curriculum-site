# Fetch Requests in Node

---

# Syntax

```js
const fetch = require('node-fetch');

fetch("https://api.github.com/users/turingschool/repos")
  .then(response => response.json())
  .then(repos => printRepoInfo(repos))
  .catch((error) => console.error({ error }))
```

---

# Scavenger Hunt

* How do you send POST/PATCH/PUT/DELETE requests?
* How do you include information in the headers?
* How do you send data in the body of a request?
* What happens if you get back a 400/500 level response?

Last one might require some experimentation.

---

# Hedgehog Party

* Review the [Hedgehog Party API Documentation](https://github.com/turingschool-examples/fetch-hedgehog-party)
* Create a new `hedgehog.js` file.
* Inside of that file create functions that will:
    * Get a list of all existing hedgehogs.
    * Create a new hedgehog.
    * Delete a hedgehog.
* See if you can refactor your functions for clarity.

---

# Additional Exploration

* If you have additional time:
    * Wrap those functions in a hedgehogService class.
    * Create a runner file that imports the hedgehogService and uses it.
* See if you can use fetch with another API.

---

# Additional Resources
* [David Walsh fetch API](https://davidwalsh.name/fetch)
* [CSS Tricks Using Fetch](https://css-tricks.com/using-fetch/)

Be aware that AJAX can also be used to make client side request to a server. Fetch has become more popular in recent years as it is built into Javascript, works on almost all browsers, and doesn't require jQuery. If you want to learn more check out this old lesson [AJAX Refresher](./archive/ajax-refresher.md)

