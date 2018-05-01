# Webpack & NPM

---

# Warmup

* What's happening in the code below?
* Advantages/disadvantages?

```html
<body>
  <h1>Hello, World.</h1>
  <script src="bootstrap.js"></script>
  <script src="jquery.js"></script>
  <script src="runner.js"></script>
  <script src="game.js"></script>
  <script src="player.js"></script>
  <script src="enemies.js"></script>
</body>
```

---

# Learning Goals

* understand what Webpack is and why it is useful
* can find their way around Webpack and its config
* are able to use Webpack for development, testing and production

---

# Part 1: Big Picture

---

# Primary Responsibilities of a Build Tool

* Scan through all of your projects' dependencies
* Handle any task that needs to be done prior to production
* Ship it off in a neat little package that is easy for a browser to digest

---

# Developer Wants

* Whitespace
* Better CSS (Sass/Less)
* Libraries from other devs
* Tests

---

# Browser Needs

* Has to download files
* Can only process CSS and ES6, in some cases only ES5
* There are lots of browsers and their needs differ

---

# Tasks a Build Tool May Perform

* JS Transpilers: e.g. Babel
* JS Concatenation
* CSS preprocessors: e.g. Sass or LESS
* Minifiers: remove whitespace, can reduce variable name length

---

# Examples and Buzzwords

* Examples
    * Gulp
    * Grunt
    * Webpack
* Labels
    * package manager
    * bundler
    * task manager

---

# Webpack

* Node package
* Digs through assets/dependencies
* Creates single JS file

---

# Webpack: Loaders

* Preprocess other assets
    * fonts
    * Sass
    * images
    * CSS
    * SVGs, etc.

* Output files for browser in the smallest package possible.

---

# Webpack: Other Features

* `webpack-dev-server`: executes webpack whenever you refresh your browser.
* `hot-module-replacement`: watches for changes to your files.

---

# Main Takeaways

* Webpack:
    * Finds starter file
    * Crawls through dependencies in appropriate order
    * Minifies/optimizes/loads

---

# With a Neighbor

1. Name a few things that build tools do. Why do we need those things?
2. What are some build tools you've used before? Think about code that has been translated between environments.
3. What kinds of things would we be forced to do in development if we didn't have build tools?

---

# Part 2: Webpack Tour

---

# Install Tools

* `npm install -g webpack webpack-dev-server mocha`

---

# Setup QS Starter Kit

```bash
$ git clone git@github.com:turingschool-examples/quantified-self-starter-kit.git webpack-lesson
$ cd webpack-lesson
$ npm install
```

---

# With a Partner

What do you see in the following files:

* `package.json`
* `webpack.config.js`
* `foods.html`, `index.html`

---

# Exploration: Webpack In Action

---

# Share

---

# Deployment

* [GitHub Pages Section](https://github.com/turingschool/qs-frontend-starter#github-pages-setup) of the starter kit README.

---

# With a Partner

1. What steps do you need to take before you can start developing with Webpack?
2. What is your development process once Webpack is setup?
3. What is your deployment process when using Webpack?
