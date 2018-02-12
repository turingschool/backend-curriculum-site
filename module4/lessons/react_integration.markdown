---
layout: page
title: React Integration
tags: javascript, front-end framework, react
---

## Learning Goals

- Refactor an existing vanilla JS or jQuery application to use React

## Integrating React with Existing Client Application

Let's start by cloning down a repo so we can all problem solve through the same thing together. Once we get a feel for it, you'll have time to work on React-ifying your own Quantified Self project!

[Fork/clone this repo](https://github.com/ameseee/react-integration), then run in your terminal:
```bash
npm install
npm start
```

Make sure the project is up and running in your browser.

### Installing Modules

[Per the React docs](https://facebook.github.io/react/docs/installation.html), we'll need a few dependencies:

```bash
# within root of project directory
npm install --save react react-dom
npm install --save-dev babel-cli babel-preset-react babel-preset-es2015
echo '{ "presets": ["react", "es2015"] }' > .babelrc
```

### Project Integration

Hop into the project's `index.js` and add your React imports:

```js
// index.js
import React from 'react'
import ReactDOM from 'react-dom';
```

Let's just see what kind of power React can have:

On the `<body>` tag in index.html, let's add `id="root"`

In `index.js`, type this under all the imports:

```js
ReactDOM.render(<h1>Hello, world!</h1>, document.getElementById('root'))
```

Navigate to your page in the browser - WHOA!

By targeting the entire `<body>` tag with that `ReactDOM.render()`, we essentially over-wrote everything else. We don't want that. Try creating an `<h1>` tag just below the body tag, and giving that tag the `id="root"` instead. See what happens? We choose WHERE to infuse React Components.

We're ready to start searching down elements of the UI to transform into Components.

### Components

The easiest place to start with components would be to find an element of your UI that could almost be plucked out and put back into place. Think buttons, avatars, feeds, comments, etc.

Let's look at that list of all foods available on the Main Diary page. It's being rendered by:

```js
const renderDiaryFood = (food) => {
  //
}
```

and right above that function, we see that we are forEach-ing over each food.

```js
const getEachDiaryFood = (foods) => {
  return foods.forEach(food => {
    renderDiaryFood(foods)
  })
}
```

THIS is the 🦄PERFECT🦄 opportunity to utilize React as a library for **re-usable components**. We are going to transform each of those 'food rows' into a React component!

We will start out by:

```js
// FoodComponent.js
import React, { Component } from "react";

class Food extends Component {

  render() {
    return (
      <div>
        <p>I am a react component!</p>
      // later, we will iterate over foods and render the HTML/JSX for each food
      </div>
    )
  }
}

export default Food;
```

Before, we were using `ReactDOM.render()` to render an HTML element, and the JSX knew what that meant. We will now be rendering the `<Food />` component, so we will to tell the file that will be rendering it, where it is!

```js
//diaryFoods.js
import Food from '../foodComponent.js';
```

## Code along

Let's make this thing work.

```js
//diaryFoods.js

const getEachDiaryFood = (foods) => {
    renderDiaryFood(foods)
}

const renderDiaryFood = (food) => {
  ReactDOM.render(
    <Food food={food}/>,
    document.getElementById('diary-food-table-info'))
  // just comment out the prepend - it will come in handy soon!
}
```

We talked about the re-usability of React - it's now going to be doing the work of iterating over our collection of foods, so we removed the `forEach()` within our `getEachDiaryFood` function.

Let's talk about props - what props are we passing to our Food component?

```js
// FoodComponent.js
import React, { Component } from "react";

class Food extends Component {
  render() {
    console.log(this.props);    // Use console.logs to make sure you have what you think you have
    return (
      <div>
        <p>I am a react component!</p>
      // later, we will iterate over foods and render the JSX for each food
      </div>
    )
  }
}

export default Food;
```

We should see that this `console.log` gave us an array of foods! It's always a good idea to make 100% you know what you're dealing with before getting messy with logic or anything else. You can use `console.log` and the [React Dev Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en).

Now, let's starting using those props to get our desired result.

```js
class Food extends Component {
  render() {
    let foods = this.props.foods;           // Storing in a variable just keeps things cleaner
    let mappedFoods = foods.map((food) => { // Mapping over the array of foods
      return (
        <article>
          <p>food.name</p>  // Just checking that we are mapping and pulling the name out
        </article>
      )
    })

    return (
      <div>
        { mappedFoods } // Accessing the mappedFoods variable from above
                        // This will render whatever that variable is assigned to;
                        // in this case, a return of that `<article>` and it's contents
      </div>
    )
  }
}

```

In the browser, we should see a list of foods names, but no calories or checkboxes (as expected). Now that we know we are mapping over the array of props correctly, let's get the details in. This is where it's helpful to go back and copy & paste what we were earlier prepending to the DOM.

```js
class Food extends Component {
  render() {
    let foods = this.props.foods;
    let mappedFoods = foods.map((food) => {
      return (
        <article
          className="food-item-row food-item-${food.id}"
          data="food-${food.id}"
        >
          <div className="checkbox-container">
            <input
              id="food-item-${food.id}"
              type="checkbox"
              className="food-item-checkbox"
            >
          </input>
          </div>
          <p className="food-item-name">{ food.name }</p>
          <p className="food-item-calories">{ food.calories }</p>
        </article>
      )
    })

    return (
      <div>
        { mappedFoods }
      </div>
    )
  }
}

```

Check it out in the browser. You should see an some red in your console, with 'Warning: Each child in an array or iterator should have a unique "key" prop.' Anytime we are re-using a component, React needs to have a unique identifier. Why? We talk about how great React is because it only re-renders what needs to be updated on the DOM; that [`key`](https://reactjs.org/docs/lists-and-keys.html) is what allows React to keep track of those. Not providing a key will not break your program, but it will slow it down and is not a good practice. [This](https://giphy.com/gifs/shame-13lTgtSUmqMrlu) is how other developers will react if you don't use keys.

How do we fix it? Give the 'single value' that the render function is returning, (in this case, the `<article>`) a key.

```js
  <article
    className="food-item-row food-item-${food.id}"
    data="food-${food.id}"
    key={ food.id }
  >
```

We're about there! In the Element Dev Tools, check out the class names and data values - we have an issue. React just expects a little bit different of syntax. Try this out, and make similar changes anywhere else it's appropriate:

```js
  <article
    className={`food-item-row food-item-${food.id}`}
    data={`food-${food.id}`}
    key={ food.id }
  >
```

Our application should be working just as it was before we integrated React.

## Partner Time

Suggestions:

On your Quantified Self projects:
* Implement the same changes we just did on this repo, to build in that muscle memory
* Render the meals tables with a React component
* Render the list of foods on foods.html with a React component
* Create a controlled-form component on foods.html to add new foods


## CFU/Interview Questions

- What packages/dependencies allow us to use React?
- When do you have to import a React component into another file?
- Which Dev Tools are used while building a React App? What is the purpose of each?

- What are the advantages and disadvantages of React?

## Related Resources

- [Add React to an Existing Application](https://facebook.github.io/react/docs/installation.html)
