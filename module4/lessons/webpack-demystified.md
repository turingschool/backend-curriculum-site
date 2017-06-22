---
title: Webpack DeMystified
subheading: And why even build?
---

### Game Plan:
- Part 1:
  - Understand what Webpack is, and why it is useful
- Part 2:
  - Find your way around Webpack and its config
- Part 3:
  - Be able to use Webpack for development, testing and production

### Quick note about Webpack 2

It's here. This lesson requires a little bit of reworking if we wanted to upgrade. For now, Webpack 1 works great, but keep the versions in mind when you're googling around for answers.

### Part 1: Big Picture

#### The Purpose of Build Tools

Let's say you're building a game in JavaScript and you're new to this whole coding thing. Then let's say that your HTML file looks like this:  

```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Webpack Demystified</title>
</head>
<body>
  <h1>Luke, I am your father.</h1>
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

All of the CSS files need to be applied to your HTML, but not until the SASS compiler has done it's job.  

And don't forget about the images or static asset files - those need to be pulled from the CSS files or maybe from the HTML code and stuck in their appropriate places relative to where the browser will render them.  

All of that is a lot of stuff to worry about not only for the developer, but also for the browser. Debugging what went wrong can result in a bad time. Luckily for us, a variety of build tools have been developed that do all of the organizing for us.

Some of the main buzz words of you may have heard tossed around include Gulp, Grunt, or Webpack. These can have various labels like "Package Manager", "Bundler", or "Task Runner". There are quite a few differences between them, but they all share a primary responsibility: **Scan through all of your projects' dependencies, handle any task that needs to be done prior to production, and ship it off in a neat little package that is easy for a browser to digest.**


#### How do our needs differ in different environments

We've talked about development, test and production environments before. The environment that's best for us to code in is not the best environment for the browser to execute our code. Let's dive into how we treat each of these environments differently.

**Our Wants**

- We love whitespace
- CSS is kind of cumbersome. Would love to use SASS or LESS.
- We use other people's code
- We write tests

**Browser Needs**

- Has to download files
- Can only process CSS and ES6, in some cases only ES5. JS is evolving faster than browsers are implementing it
- There's lots of browsers, and their needs differ

#### How build tools bridge the gap

Let's talk about some of the ways build tools (like Webpack and like the Asset Pipeline) translate from development to production

- Transpilers, like Babble, translate our easier to maintain code into code that the browser can interpret
- CSS Preprocessors, like SASS or LESS, evaluate our SCSS files and write CSS the browser can interpret
- Minifiers remove whitespace, and can reduce variable name length
- They also combine everything into one file, which is better for HTTP/1.1

#### So What is Webpack?

Webpack is a node package that digs through your asset files, finds any dependencies, and spits out a single JS file that is ready for production.

What sets it apart is that it isn't limited to only handling your JavaScript files, it thinks of everything else like a module as well. With Webpack you have access to "Loaders" which pre-process your assets (like Fonts, SASS, Images, CSS, SVGs etc) and output exactly what your browser needs to know in the smallest package possible.

It also has some really cool features like `webpack-dev-server` which executes Webpack whenever you refresh your browser, or a thing called `hot-module-replacement` which tells your project to keep an eye on any changes, automatically refreshing your browser whenever it detects action.

Big picture, Webpack finds the starter file you've told it to use and crawls through the tree of dependencies in the appropriate order keeping track of dependencies. It then minifies, optimizes, and loads anything it needs to make the browser happy.

#### Checks for understanding

1. Name a few things that build tools do? Why do we need those things.
2. What are some build tools you've used before? Think about code that has been translated between environments.
3. What kinds of things would we be forced to do in development if we didn't have build tools?

### Part 2: Webpack Tour

#### Install Some Command Line Tools

We'll need to install some tools both locally and globally so we have access to them everywhere all the time. Let's start with global installation of Webpack itself, the Webpack Dev Server which will let us spin up a local server, and Mocha to kick start our testing suite.

`npm install -g webpack webpack-dev-server mocha`

This will allow us to type `webpack`, `webpack-dev-server`, and `mocha` directly in our terminal whenever we need access to them.

(*PROTIP: To see what modules you have globally installed on your machine, type `npm list -g --depth=0` at any time in your terminal*)

#### Clone down your starter kit

`git clone https://github.com/turingschool-examples/quantified-self-starter-kit webpack-lesson`

This will clone down the same repo that you'll be using for your project, but will put it in a folder you can play around with for this lesson.

`npm install`

This will install all of the dependencies needed for development. Let's peek into `package.json` to see what packages we've asked to be installed. Some you know about, some we're about to talk about. What looks new?

#### What about the files?

Let's look at some of the files and directories we've created, and talk briefly about how we're going to be using them.

- `webpack.config.js`
- `index.html` and `foods.html`

#### Webpack Config

So what does Webpack configuration look like?

At its most basic level, you'll see something like this:

```
module.exports = {
  entry: {
    main: "./index.js",
  },
  output: {
    filename: "main.bundle.js"
  },
  module: {
    loaders: [
      {test: /\.js$/, loaders: ['babel'], exclude: /node_modules/},
    ]
  }
}
```

This chunk of code tells Webpack to start at the `entry` point and create a `main` bundle which we define as `index.js`. This is where we will write our code and require any other `.js` files that we need in our project. It will follow the tree of nested files and concatenate/minify/work some webpack magic and `output` one single manageable file with the name of `main.bundle.js` which is what you'll include in `<script>` tags in your `index.html` file.

#### What about the `module: { loaders: ...}` part?

A loader is a per-file processor that deals with individual file types for you in the same way it handles `.js` files. Essentially Webpack thinks of everything in your project like a JavaScript module.

This means that you can tell Webpack to go find any SASS files and turn them into CSS (then also concatenate, minify, and bundle up for production). Or go find any image file and compress it before pushing it up to the browser. Or compile the CoffeeScript that you blacked out while writing into JS before production. And so on.

Think of Loaders like a middle step. This makes it possible for you as a developer to write your code in whatever language makes you happy, then when you're ready to fire up your project Webpack is like "hang on a sec...let me organize all of this for you" and transpiles everything into a neat little bundle that your browser can render.

#### Breaking Down Loaders

Loaders take an array of objects that use regex to specify what file extensions to look for and what loaders are needed to make things happen.

```
module: {
  loaders: [
    {test: /\.js$/, loaders: ['babel'], exclude: /node_modules/},
    {test: /\.css$/, loaders: ['style', 'css']},
    {test: /\.scss$/, loader: "style!css!sass" },
  ],
}
```

*PRO TIP: Loaders run from right to left! So it will run the "sass" loader first, then the "css" loader, then  the "style" loader and do all the things.*

#### HTML files

As we're mentally organizing our project with webpack, it's important to know that webpack is not involved at all in your HTML. The benefit that webpack gives us is a single JS file that we can load into our HTML. So let's open up `index.html` and see what that looks like.

Notice the single `<script>` tag located before the closing `</body>` tag. This is the epicenter of webpack. Any `.js` file we write will be bundled along with any dependencies and sent to production as `bundle.js`.

`foods.html` is very similar. We'll talk about `test.html` after this quick demo of Webpack in action.

### Brief Demo: Webpack In Action

Make a new file in your `lib` directory called `alert.js` and export a simple alert function.  

`touch lib/alert.js`

*alert.js*

```js
module.exports = function() {
  alert('ITS A TRAP!!!!!!!!!');
}
```

Then require said file and call the function in our entry `index.js` file.

*index.js*

```js
var newAlert = require('./alert');
newAlert();
```

Now open up index.html

`open index.html`

....buzzkill. No alert. But this shouldn't be a surprise because we haven't actually told Webpack to bundle our stuff yet. Do that now:

`webpack`

This will run webpack using the defined config, and modify our `main.bundle.js`. Then try refreshing the page, or just type `open index.html` again.

#### Time to Automate!

We're getting closer, but think about our development flow. Do we want to have to run `webpack` and refresh the page every time we want to see our code changes in the browser?

Luckily, there's a sweet deal called `webpack-dev-server` that we mentioned earlier. This will boot up a development server and run our configuration file and reload our changes anytime we refresh our browser. Try it out!

`webpack-dev-server`

Then visit `http://localhost:8080`

Make a change to your alert.js file go back to your browser.

#### Writing Tests

In `test/index.js`, write a simple test.

```
const assert = require('chai').assert

describe('our test bundle', function () {
  it('should work', function () {
    assert(true)
    })
  })
```

#### Running Tests

At this point, you can just run `mocha` from your terminal. Mocha automatically looks for `.js` files in the `test/` directory, and runs them. You don't even really need webpack involved. However, there are some times when you want your tests to run in the browser instead of in node. They are different JavaScript environments after all.

With your `webpack-dev-server` running, visit `http://localhost:8080/test.html`. This will run the same tests, but in the browser environment instead. Let's poke around `test.html` to see if we can figure out how this works.

Also note that just like in your `lib/index.js` file, you can require other test files within the entry point `test/index.js` file and Webpack will bundle for you. Simply use `require('./other-test-file')` like you would in any other context.  This is important since keeping test files simple and elegant is crucial to writing maintainable code.

Other than that, organize your tests however you like. As long as they all get required in `test/index.js`, then you can run your tests from the browser or from the terminal.


#### Using package.json scripts

`package.json` makes it easier to run commands. Let's make a few changes so we can keep shortcut some terminal commands.

```
// package.json
...
"scripts": {
  "start": "webpack-dev-server --hot --inline",
  "build": "webpack",
  "test": "mocha"
},
...
```
This lets us use the commands `npm start` to fire up webpack-dev-server, `npm run build` to package everything for production, and `npm test` to execute our testing suite.  

The `--hot --inline` flags tell npm to watch for any changes and reload automatically so we can stop typing stuff into our temrinal.  

#### Styling

As a quick note, webpack also allows you to require styling, like `.css` and `.sass` files the same way you would any other js file. Behind the scenes, it's taking all your CSS, and appending it to your HTML at the time the JS file is read in. It's kind of a hack, but it allows you to have just a single `.js` file that loads all your logic and styling in one go.

Try creating a really simple `.css` file in your `lib` folder, and requiring it in `lib/index.js`. You won't need to assign the return value of require to anything. You just need that require line for webpack to load it.

#### Deployment

Let's look at the [Github Pages section](https://github.com/turingschool-examples/quantified-self-starter-kit#github-pages-setup) of the starter kit README.

### Checks for understanding

Answer the following in the context of using Webpack:

1. What is your development process? What steps do you need to take before you can start developing?
2. What is your test process?
3. What is your deployment process?

### Further Reading

Beyond this basic Webpack configuration, there are countless ways to use Webpack to your advantage. For further reading some of the additional tricks for later use include:  
[Tree Shaking](https://medium.com/modus-create-front-end-development/webpack-2-tree-shaking-configuration-9f1de90f3233#.rlpftvy03): Letting Webpack scan your code for anything unused or superfluous before it packages everything up for production.  
[Code Splitting](https://webpack.github.io/docs/code-splitting.html): Loading only the code needed when you need it, not your entire app.  
[Chunks](http://survivejs.com/webpack/advanced-techniques/understanding-chunks/): Sections of code that are organized to maximize performance. (ie: Test chunks vs Production chunks, we don't necessarily need to run the test chunks every time we load our app in the browser)

### Additional Resources

[Webpack Documentation](https://webpack.github.io/docs/)  
[Awesome Webpack Blog Post](http://code.tutsplus.com/series/introduction-to-webpack--cms-983)  
[Comparing Browserify/Grunt/Gulp/Webpack](https://npmcompare.com/compare/browserify,grunt,gulp,webpack)  
[Another Webpack Tutorial](http://survivejs.com/webpack/developing-with-webpack/getting-started/)  
