---
layout: page
title: React Integration
tags: javascript, front-end framework, react
---

## Learning Goals

- Students can refactor an existing vanilla JS application to use React

## Integrating React with Existing Client Application

### Installing Modules

[Per the React docs](https://facebook.github.io/react/docs/installation.html), we'll need a few things:

```bash
# within root of project directory
npm install --save react react-dom
npm install --save-dev babel-cli babel-preset-react babel-preset-es2015
echo '{ "presets": ["react", "es2015"] }' > .babelrc
```

### Project Integration

Hop into your project's `index.js` and add your React imports:

```js
// index.js
import React from 'react'
import ReactDOM from 'react-dom';
```

Assuming there is a `#root` element in your markup:

```js
ReactDOM.render(<h1>Hello, world!</h1>, document.getElementById('root'))
```

Navigate to your page in the browser - voilà!

You're ready to start searching down elements of your UI to transform into components.

### Components

The easiest place to start with components would be to find an element of your UI that could almost be plucked out and put back into place. Think buttons, avatars, feeds, comments, etc.

Imagine your markup including a list of food / calorie information:

```html
<li class="food-row" data=id=`${food.id}`>
  <p class="food-name">${food.name}</p>
  <p class="food-calories">${food.calories}</p>
</li>
```

As a React component, that would look something like:

```js
// Food.js
import React, { Component } from "react"

class Food extends Component {
  render() {
    return (
      <li className="food-row" data=id={props.food.id}>
        <p className="food-name">{props.name}</p>
        <p className="food-calories">{props.calories}</p>
      </li>
    )
  }
}

export default Food
```

Great! You're set to continue transforming UI elements into components.

## Code along

Congrats - you've got a transformed React app!

## Related Resources

- [Add React to an Existing Application](https://facebook.github.io/react/docs/installation.html)
