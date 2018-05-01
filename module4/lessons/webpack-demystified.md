---
title: Webpack Demystified
---

## Learning Goals:

By the end of this lesson, students:

  - understand what Webpack is and why it is useful
  - can find their way around Webpack and its config
  - are able to use Webpack for development, testing and production

## Slides

Available [here](../slides/webpack)

## Part 1: Big Picture

### The Purpose of Build Tools

Let's say you're building a game in JavaScript and you're new to this whole coding thing. Then let's say that your HTML file looks like this:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Webpack Demystified</title>
</head>
<body>
  <h1>Hello, World.</h1>
  <script src="bundle.js"></script>
  <script src="game.js"></script>
  <script src="thing.js"></script>
  <script src="jquery.js"></script>
  <script src="bootstrap.js"></script>
  <script src="other-thing.js"></script>
  <script src="something-else.js"></script>
  <script src="stuff.js"></script>
  <script src="ridiculous.js"></script>
  <script src="ughhhhh.js"></script>
</body>
</html>
```

All of these JS files need to be loaded by your browser in a certain order, after the HTML is ready to go, or maybe before, depending on some details.

All of the CSS files need to be applied to your HTML, but not until the Sass compiler has done its job.

And don't forget about the images or static asset files - those need to be pulled from the CSS files or maybe from the HTML code and stuck in their appropriate places relative to where the browser will render them.

All of that is a lot of stuff to worry about not only for the developer, but also for the browser. Debugging what went wrong can result in a bad time. Luckily for us, a variety of build tools have been developed that do all of the organizing for us.

Some of the main buzz words of you may have heard tossed around include Gulp, Grunt, or Webpack. These can have various labels like "Package Manager", "Bundler", or "Task Runner". There are quite a few differences between them, but they all share a primary responsibility: **Scan through all of your projects' dependencies, handle any task that needs to be done prior to production, and ship it off in a neat little package that is easy for a browser to digest.**

### Different Needs in Different Environments

We've talked about development, test and production environments before. The environment that's best for us to code in is not the best environment for the browser to execute our code. Let's dive into how we treat each of these environments differently.

**Developer Wants**

- We like whitespace
- CSS is cumbersome we'd love to use Sass or LESS
- We use libraries of code others have written
- We write tests

**Browser Needs**

- Has to download files
- Can only process CSS and ES6, in some cases only ES5
  - JS is evolving faster than browsers are implementing it
- There are lots of browsers and their needs differ

### How Build Tools Bridge the Gap

Let's talk about some of the ways build tools (like Webpack and the Asset Pipeline) translate from development to production

- Transpilers, like Babel, translate our easier-to-maintain code into code that the browser can interpret
- CSS preprocessors, like Sass or LESS, evaluate our SCSS files and write CSS the browser can interpret
- Minifiers remove whitespace, and can reduce variable name length

### So What is Webpack?

Webpack is a Node package that digs through your assets, finds dependencies, and spits out a single JS file that is ready for production.

What sets it apart is that **it isn't limited to only handling your JavaScript files**. It thinks of everything else like a module as well. With Webpack you have access to **loaders** which preprocess your assets (like fonts, Sass, images, CSS, SVGs etc) and output exactly what your browser needs to know in the smallest package possible.

It also has some really cool features like `webpack-dev-server` which executes Webpack whenever you refresh your browser, or a thing called `hot-module-replacement` which tells your project to keep an eye on any changes, automatically refreshing your browser whenever it detects action.

Big picture: Webpack finds the starter file you've told it to use and crawls through the tree of dependencies in the appropriate order. It then minifies, optimizes, and loads anything it needs to make the browser happy.

## Checks for Understanding

1. Name a few things that build tools do. Why do we need those things?
2. What are some build tools you've used before? Think about code that has been translated between environments.
3. What kinds of things would we be forced to do in development if we didn't have build tools?

## Part 2: Webpack Tour

### Install Some Command Line Tools

We'll need to install some tools both locally and globally so we have access to them everywhere all the time. Let's start with global installation of Webpack itself, the Webpack Dev Server which will let us spin up a local server, and Mocha to kick-start our testing suite.

`npm install -g webpack webpack-dev-server mocha`

This will allow us to type `webpack`, `webpack-dev-server`, and `mocha` directly in our terminal whenever we need access to them.

> To see what modules you have globally installed on your machine, type `npm list -g --depth=0` at any time in your terminal

### Setup Starter Kit

```bash
git clone git@github.com:turingschool/qs-frontend-starter.git webpack-lesson
```

This will clone down the same repo that you'll be using for your project, but will put it in a folder you can play around with for this lesson.

```bash
npm install
```

This will install all of the dependencies needed for development. Let's peek into `package.json` to see what packages we've asked to be installed. Some you know about, some we're about to talk about. What looks new?

### Get Oriented

Let's look at some of the files and directories we've created, and talk briefly about how we're going to be using them.

- `webpack.config.js`
- `index.html` and `foods.html`

### Webpack Config

`webpack.config.js` is a file used to house all of your Webpack configurations.

At its most basic level, you'll see something like this:

```js
module.exports = {
  entry: {
    main: "./index.js",
  },
  output: {
    filename: "main.bundle.js"
  },
  module: {
    loaders: [
      { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader' },
      { test: /\.css$/, loader: "style!css" },
      { test: /\.scss$/, loaders: ["style-loader", "css-loader", "sass-loader"] },
    ]
  }
}
```

This chunk of code tells Webpack to start at the `main` `entry` point and we've defined as `./index.js`. This is where we will write our code and require any other `.js` files that we need in our project. It will follow the tree of nested files and concatenate/minify/work some Webpack magic and `output` one single manageable file with the name of `main.bundle.js` which is what you'll include in `<script>` tags in your `index.html` file.

### What About `module: { loaders: ...}`?

A [loader](https://webpack.js.org/concepts/loaders/) is a per-file processor that deals with individual file types for you in the same way it handles `.js` files. Essentially Webpack thinks of everything in your project like a JavaScript module.

Think of loaders like a middle step. They make it possible for you as a developer to write your code in whatever language makes you happy, then when you're ready to fire up your project, Webpack is like "hang on a sec...let me translate and organize all of this for you" and transpiles everything into a neat little bundle that your browser can render.

### HTML files

As we're mentally organizing our project with Webpack, it's important to know that Webpack is not involved at all with your HTML. The benefit that Webpack gives us is a single JS file that we can load into our HTML. So let's open up `index.html` and see what that looks like.

Notice the single `<script>` tag located before the closing `</body>` tag. This is the epicenter of Webpack. Any `.js` file we write will be bundled along with any dependencies and sent to production as `bundle.js`.

## Demo: Webpack In Action

Make a new file in your `lib` directory called `alert.js` and export a simple alert function.

`touch lib/alert.js`

*alert.js*

```js
module.exports = function() {
  alert('Webpack, heck yeah!');
}
```

Then require said file and call the function in our entry `index.js` file.

*index.js*

```js
var newAlert = require('./alert');
newAlert();
```

Now open up `index.html`

`open index.html`

....buzzkill. No alert. But this shouldn't be a surprise because we haven't actually told Webpack to bundle our stuff yet. Do that now:

`webpack`

This will run Webpack using the defined config, and modify our `main.bundle.js`. Then try refreshing the page, or just type `open index.html` again.

### Time to Automate!

We're getting closer, but think about our development flow. Do we want to have to run `webpack` and refresh the page every time we want to see our code changes in the browser?

Luckily, there's a handy helper called `webpack-dev-server` that we mentioned earlier. This will boot up a development server and run our configuration file and reload our changes anytime we refresh our browser. Try it out!

`webpack-dev-server`

Then visit `http://localhost:8080`

Make a change to your `alert.js` file and go back to your browser.

### Styling

Webpack also allows you to require styling, like `.css` and `.scss` files the same way you would any other `.js` file. Behind the scenes, it's taking all your CSS and appending it to your HTML at the time the JS file is read in. It's kind of a hack, but it allows you to have just a single `.js` file that loads all your logic and styling in one go.

#### You Do: Loading Styles with Webpack

Try creating a really simple `styles.scss` file in your `lib` folder that contains the following:

```css
body {
  background-color: tomato;
}
```

Now require it in `lib/index.js`. You don't need to assign the return value of require to anything. You just need that require line for Webpack to load it:

```js
require('./styles.scss')
```

Check out that webpack magic in the browser!

### Deployment

Let's look at the [GitHub Pages Section](https://github.com/turingschool/qs-frontend-starter#github-pages-setup) of the starter kit README.

## Checks for Understanding

1. What steps do you need to take before you can start developing with Webpack?
2. What is your development process once Webpack is setup?
3. What is your deployment process when using Webpack?

### Bonus: Using package.json Scripts

`package.json` makes it easier to run commands. Let's make a few changes so we can keep shortcut some terminal commands.

```js
// package.json
...
"scripts": {
  "start": "./node_modules/webpack-dev-server/bin/webpack-dev-server.js  --hot --inline",
  "build": "./node_modules/webpack/bin/webpack.js",
  "test": "./node_modules/mocha/bin/mocha --compilers js:babel-core/register"
},
...
```

This lets us use handy `npm` commands such as `npm start` to fire up webpack-dev-server, `npm run build` to package everything for production, and `npm test` to execute our testing suite.

The `--hot --inline` flags tell npm to watch for any changes and reload automatically.

Why `npm run build` instead of just `npm build`? [NPM has a built in build command](https://stackoverflow.com/questions/29939697/npm-build-doesnt-run-the-script-named-build-in-package-json), which is not what we want to run in this case.

## Additional Resources

*   [Webpack Docs](https://webpack.js.org/)
*   [Awesome Webpack Blog Post](http://code.tutsplus.com/series/introduction-to-webpack--cms-983)
*   [Comparing Browserify/Grunt/Gulp/Webpack](https://npmcompare.com/compare/browserify,grunt,gulp,webpack)
*   [Another Webpack Tutorial](http://survivejs.com/webpack/developing-with-webpack/getting-started/)
