# Introduction to Node/Express

---

# Warmup

Using the internet:

* What is Node.js?
* What is Express?

---

# What is Node?

* Open source
* Cross-platform
* JavaScript run-time environment
* for executing JavaScript code server-side
* built on Chrome's V8 JavaScript engine

What does this all mean?

---

# What is Express?

* Fast
* Unopinionated
* Minimalist
* Web application framework
* for Node.js

What does this all mean?
What are other examples of web application frameworks?

---

# Install Express Generator

```
$ npm install express-generator -g
$ npm install nodemon -g
```

---

# Express Generator CLI

* What options are available to you when you're using the generator?

---

# Create and Explore: New Express App

* `express --view ejs --css sass --git secret-box`
* Start the app
    * `npm start` OR `nodemon bin/www`
* Review the files that the Express generator creates
    * What does it seem like each file does?
    * Can you create a new route?
    * Can you create a new template and serve that from your new route?

---

# Share

---

# Parts of app.js

* Require outside resources
* Set configuration variables
* Tell app about middleware to use
    * Logging, cookies, Sass, etc.
    * Routing itself is middleware!
* Export the app

---

# Routes

* Require express
* Set up the router
* Define routes
* Export the router

---

# Views

* Hold view templates
* Can use multiple templating language

---

# Other Parts of the App

* `bin/www`
* `public`
* `views`

---

# Things to Ponder

* What do you like about Express so far?
* How does it compare to other tools you have used?
