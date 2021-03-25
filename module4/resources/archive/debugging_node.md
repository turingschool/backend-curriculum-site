---
layout: page
title: Debugging node.js
subheading: and non-client side JavaScript
---

We will use this repo later in the lesson:

`git clone git@github.com:turingschool-examples/debugging-non-clientside.git`

### Getting Started

As we've experienced outside of the JavaScript world, it's often necessary to troubleshoot, or debug, some code we've written. The same hold true when working in JavaScript too. Unfortunately all of the tools we're used to in Ruby will not work with JavaScript. There are however other tools we can use.

Today we're going to look at a few of these debugging tools:

* Trusty Ole' `console.log()`
* [Node Debugger](https://nodejs.org/docs/v6.6.0/api/debugger.html). Be careful to select the docs for the version of node you are using.
* [Node Inspector](https://github.com/node-inspector/node-inspector) * May be in the deprecation/transition process
* [Pry.js](https://github.com/blainesch/pry.js)

### Debugging? WTF is that?

Turn to your neighbor and talk about what you know about debugging.
What tools have you used in the past?
What are some of your favorite strategies?

Let's get back together and discuss.

### Node Debugger

[Node Debugger](https://nodejs.org/docs/v6.6.0/api/debugger.html) is a built in tool to help us debug JavaScript in the terminal.

make sure you check your version of node and read that documentation.

check node version:

```terminal
$ node -v
```

* then head [here](https://nodejs.org/docs/) and select the docs for your version.
* next, navigate to the section on debugging

Read the documentation for node debugger.
Record any questions or interesting observations you may have.

Let's get back together to discuss.

### Let's give it a shot!

code along

### Challenges

Open the project from the top of this lesson.

Debug!
