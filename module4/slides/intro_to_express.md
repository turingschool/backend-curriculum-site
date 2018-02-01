# Introduction to Node/Express

---

# What is Node?

---

# What is Express?

---

# Express Generator

Work with your table to:

* Install Express
* Generate a new Express project
    * What options are available to you when you're using the generator?
* Review the files that the Express generator creates
    * What does it seem like the files do?
    * Can you create a new route?
    * Can you create a new template and serve that from your new route?

---

# Share

---

# 











* [Repo](https://github.com/s-espinosa/express-practice)

* `npm install express-generator -g` - Install express generator CLI globally.
* `express -h` - Get help regarding the commands that the express generator gives you.
* `express --view ejs --css sass --git project-name` - creates a new project using EJS as a tempalting language (like ERB), and Sass for stylesheets.
* The generator will prompt you to run two additional commands:
    * `cd project-name && npm install` - To install dependencies.
    * `DEBUG=express-practice:* npm start` - To start your server.i
    * Run each of those commands and visit `localhost:3000` to see that you've properly generated a new site. You should see a site with the message `Welcome to Express`.
* `app.js` includes all sorts of good stuff:
    * `require` statements at the top bringing in dependencies including `express` itself.
    * `require` statements for different routes files that the express generator created.
    * Configurations set by the generator using `app.set`.
    * Middleware that provides the app some additional functionality set using `app.use`.
    * Middleware that tells the application what to use for routing to `/` and to `/users`
    * Middleware that tells the app how to handle a 404.
    * Middleware that tells the app how to handle 500 level errors.
    * A final statement that exports the app itself, which gets required by `bin/www`, which is the entry point for the app (see `package.json`).
* In order to create new routes:
    * Create a new file within the `routes` directory.
    * Within that file:
        * `var express = require('express');`
        * `var router  = express.Router();`
        * Define the routes 
* How to test a thing
    * `npm install mocha -g`
    * `npm install mocha --save-dev`
    * `npm install chai --save-dev`
    * `npm install chai-http --save-dev`
    * in `package.json` add `"test": "mocha"` to the "scripts" section (allows us to run our tests with `npm test`)
    * `mkdir test`
    * `touch test/test-root.js`
    * ``


# Questions for Express Lesson

* How do I create a new Express app?
* How is a new app that I create with the generator organized?
* How do I test my express app?
    * How do I do this?
* How do I add routes?
* How do I serve a static page?

# Questions for Knex Lesson

* How do I add access to a DB?
* Where do I put my models?
* How do I return JSON

# What even goes in the How to Organize lesson?

* Eh?

# Find a Place?

* How do I use a templating language to serve a page with information from my DB?

# Bigger Questions

* Does it make sense to rearrange this to:
    * Intro to Express
    * Intro to Knex
    * Intro to Testing
