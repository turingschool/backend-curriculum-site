---
layout: page
title: React Integration with Axios
tags: javascript, front-end framework, react
---

## Learning Goals

- Students can refactor an existing vanilla JS application to use React
- Students can use Axios in their React applications

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

## Why Axios?

[Axios](https://github.com/mzabriskie/axios) is a promise-based library used with Node.js and your browser to make asynchronous JavaScript HTTP requests.

When we know we need to implement promise-based asynchronous HTTP requests with JavaScript we usually assume jQuery's AJAX is what we'll need to get the job done.

While we _could_ add jQuery to our React application, we'd sort of be going against React by doing so. Remember, jQuery is a wonderful tool for DOM manipulation, but React doesn't care much about the DOM. Since React is handling everything within its own virtual DOM, there's really no longer a need for jQuery.

Thus, Axios becomes a lighter-weight solution to handle our HTTP requests.

### Installing Axios

Fiirst let's install Axios.

Simple.

```bash
# within project directory
npm install axios --save
```

### Working with Axios

Working with Axios? Also simple. We already know jQuery's AJAX syntax -- Axios really isn't much different.

For example, if we wanted to make a GET request to our API's `foods` route, it'd look something like this:

```js
import axios from 'axios'

axios.get('https://quantified-api.herokuapp.com/v1/foods')
  .then((foods) => {
    console.log(foods)
  })
  .catch((error) => {
    console.error(error)
  })
```

What about a POST request? Also similar.

```js
axios.post('https://quantified-api.herokuapp.com/v1/foods', {
  name: "Tofu"
  calories: 120
})
```

Go as far as you can both creating components and whittling away at the need for jQuery altogether.

Congrats - you've got a transformed React app!

## Related Resources

- [Add React to an Existing Application](https://facebook.github.io/react/docs/installation.html)
- [Axios Docs](https://github.com/mzabriskie/axios)
