# Debugging in Node

## Console.log

The first tool you have available to you `console.log()`. This is a lot like `puts` in Ruby. It will just output a string to the terminal. Just put it anywhere in your code like this:

```js
var hello = "world";

console.log(hello);
```

And you should see `world` output to the terminal. As a convenience, you can combine multiple strings and variables by simply passing `console.log()` more parameters. They will be output together, separated by a space.

```js
var hello = "hello";
var world = "world";

console.log("Message:", hello, world);

```

The above will output `Message: hello world`.

## PryJS

Node has pry like functionality built in. You add `debugger;` on it's own line anywhere in the code, and node will stop. Provided that you type `debug` when you run your code in the terminal. Like: `node debug lassie.js`. Adding the additional `debug` command is kind of annoying, and the REPL you get in your terminal is hard to navigate.

I find it's worth installing another package that makes pausing and inspecting your code much easier. We'll use `pryjs`.

```
npm install pryjs
```

And be sure to require it at the top of your file

```js
var pry = require('pryjs');
```

Then, wherever you'd like to pause and inspect your code, write the following:

```js
eval(pry.it);
```

## Even more debugging resources

Here's a link explaining the built in [Node debugger](https://nodejs.org/api/debugger.html).

[Visual Studio Code](https://code.visualstudio.com/) is Regis approved. It's another IDE, but does have some intense functionality.

And you can check out an [atom package](https://github.com/kiddkai/atom-node-debugger) that's supposed to do something similar.

Since Node version 6.3, you can debug your node applications using Chrome's Dev Tools. This offers all kinds of tools that are tough to use in the terminal, but it requires a little bit of setup. [Check out this blog post](https://medium.com/@paul_irish/debugging-node-js-nightlies-with-chrome-devtools-7c4a1b95ae27)
