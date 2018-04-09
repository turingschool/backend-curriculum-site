---
layout: page
title: React Sandbox
tags: javascript, front-end framework, react
---

## Learning Goals

- Build a small app in React
- Explain the difference between stateful and presentational components
- Explain why, when, and how we import and export files


## Brainstorm - How would we build Quantified Self in React?

* For the foods page, what components might we need?
* What would those parent/child relationships be?

## Getting Started with a React App

Let's start by cloning down a repo so we can all problem solve through the same thing together. Once we get a feel for it, you'll have time to map out your plan for your React capstone (or help your friends do so if you aren't using React😊)

[Fork/clone this repo](https://github.com/ameseee/react-sandbox), then run in your terminal:
```bash
npm install
npm start
```

Make sure the project is up and running in your browser.

Check out the file structure - what is similar/different from yesterday's project?

### Imports and Exports

Now that we've mapped out our app and have our initial file structure, let's go ahead and import/export everything we need for today.

### App.js

Like we talked about yesterday, App is our parent-of-all-parent components. This is just convention! It will render all the other components, and hold our biggest piece of data - foods! Because it's hold our data, it needs to be **stateful** - this means it needs to extend the React.Component and have a `constructor` and `render` function. Lifecycle methods are also available to stateful components - we'll get to those soon. Let's set up the basics.

```js
//App.js
import React, { Component } from 'react';   // so we can use React
import './styles/App.css';

class App extends Component {
  constructor(props) {  
    super(props);     // we MUST call super here
    this.state = {    
      foods: []       // we will call our API to get the array of foods (later)
    }
  }

  render() {           //render functions ONLY live in stateful components. It's a must have.
    return(
      <div className="app">
      </div>
    )
  }

}

export default App;   // this is necessary for our index.js to find this file
```

Now we need to GET our foods! Check out the util/requests file - we already have the fetch requests! Let's use `componentDidMount()` to make that call.

```js
//App.js
class App extends Component {
  constructor(props) {  
    super(props);
    this.state = {    
      foods: []       // this won't be empty for long!
    }
  }

  componentDidMount() {
    getFoods()
      .then((foods) => this.setState({ foods: foods }))
      .catch((error) => console.error({ error }))
  }

  render() {
    return(
      <div className="app">
      </div>
    )
  }

}
```

Let's break down what just happened here. We brought in our fetch call, and called it in `componentDidMount()` - this is a [**Lifecycle Method**](https://reactjs.org/docs/react-component.html) that is built into React - it is the most commonly used. Every time the component re-renders (mounts), this function will fire. It will be your best friend. Once we resolved that promise, we are setting that array into our App's `state` - we can now pass it down as a prop to any children components.

#### PAUSE and Check In

* Is App a stateful or presentational component? Why?
* What are the two things we should always see in a stateful component?
* Where did we make our fetch call, and why?


Now, let's render our FoodList and FoodForm!

```js
//App.js
class App extends Component {
  constructor(props) {  
    super(props);
    this.state = {    
      foods: []
    }
  }

  componentDidMount() {
    getFoods()
      .then((foods) => this.setState({ foods: foods }))
      .catch((error) => console.error({ error }))
  }

  render() {
    return(
      <div className="app">
        <FoodList foods={ this.state.foods }/> // passing prop "foods"
        <Food Form />                          // no props, for now
      </div>
    )
  }

}
```

Check your browser - you should see a lot of red.

We have brought in FoodList, but there isn't much in that file right now.

```js
//FoodList.js
class FoodList extends Component {
  render() {
    console.log(this.props)   //make sure we have foods as expected
    return (
      <div className="food-list">
        I AM THE LIST
      </div>
    )
  }
};
```

We should now see that FoodList has the array of foods! Great. Each food will have it's own card component, so we now need to map over all our foods.

```js
class FoodList extends Component {

  let foods = this.props.foods;
  let mappedFoods = foods.map((food) => {
    console.log(food.name)    // just to check!
    return (
      <div>
        I AM THE FOOD
      </div>
    )
  })

  render() {
    return (
      <div className="food-list">
        I AM THE LIST
      </div>
    )
  }
};
```

Now that we know we are grabbing each food, let's write some JSX to make this look a little nicer.

```js
class FoodList extends Component {

  let foods = this.props.foods;
  let mappedFoods = foods.map((food) => {
    return (
      <div className="food-row">
        <p className="food-name">{ food.name }</p>
        <p className="food-calories">{ food.calories }</p>
      </div>
    )
  })

  render() {
    return (
      <div className="food-list">
        <div className="food-row title-row">
          <p className="food-name title">Food</p>
          <p className="food-calories title">Calories</p>
        </div>
        { mappedFoods } /////////////////////////////////////////
      </div>
    )
  }
};
```

What is happening with `{ mappedFoods }`? JSX, this syntax extension to JavaScript, is allowing us to render the return value of the variable `mappedFoods` in the middle of that HTML-like code. This makes conditional rendering possible!

We are SO close! We talked about this `<Card />` component, but aren't using it yet. Instead of rendering all those lines of JSX in the map, let's abstract that out into a re-usable card.

```js
class FoodList extends Component {

  let foods = this.props.foods;
  let mappedFoods = foods.map((food) => {
    return (
      <FoodCard food={ food }/>
    )
  })

  render() {
    return (
      <div className="food-list">
        <div className="food-row title-row">
          <p className="food-name title">Food</p>
          <p className="food-calories title">Calories</p>
        </div>
        { mappedFoods } /////////////////////////////////////////
      </div>
    )
  }
};
```

..now we have to make a FoodCard. This one is easy!

```js
const FoodCard = ({ food, deleteFood }) => {
  return (
    <div
      className="food-row"
      key={ food.id }
    >
      <p className="food-name">{ food.name }</p>
      <p className="food-calories">{ food.calories }</p>
    </div>
  )
}
```

#### PAUSE and Check In

* Is FoodList a stateful or presentational component? Why?
* Is FoodCard a stateful or presentational component? Why?


Now that we realize we don't need state in FoodList, we really should do the right thing and re-factor it into a presentational component. You'll see this done differently - many folks choose to start all components out as stateful; if they need to add in state, they don't need to change much. You can always come back at the end of a project and make things with no state, presentational. This isn't a must-do, BUT it will hopefully illustrate the difference for you.

```js
const createFoodCards = (foods) => {
  return foods.map((food) => {
    return (
      <FoodCard
        key={ food.id }
        food={ food }/>
    )
  })
}

const FoodList = ({ foods }) => {
  return (
    <div className="food-list">
      <div className="food-row title-row">
        <p className="food-name title">Food</p>
        <p className="food-calories title">Calories</p>
      </div>
      { createFoodCards(foods) }
    </div>
  );
}
```

#### PAUSE and Check In

* Partner 1: Explain every line of code in FoodList to your partner.
* Partner 2: Explain every line of code in FoodCard to your partner.

YOU MUST USE THESE WORDS:
import, props, render, key, stateful/presentational, export, single return value


### [Controlled Components](https://reactjs.org/docs/forms.html) - Partner Work Time

We haven't really been able to see the power of state in anything but our App yet. React can control an input form element, and this is called a 'controlled component'. React does this by combining the fact that `<input>`, `<textarea>`, and `<select>` typically maintain their own state and that React state is mutable.

Knowing the very basics of a controlled component, should FoodForm be stateful or presentational?

```js
class FoodForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      // the things we want to keep track of from our form
    }
  }

  render() {
    return (
      <div className="food-form">
        <h2>Add A Food</h2>
        <form className="add-food-form">
          <input
            className="input"
            type="text"
            placeholder="Food Name"
          />
          <input
            className="input"
            type="number"
            placeholder="Calories"
          />
          <button
            className="add-food-btn"
          >
          </button>
        </form>
      </div>
    );
  }
}
```

We already have our form set up, but we need to listen for changes on the input and a click of the button. On those events, let's call a method that lives in the component.

```js
class FoodForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      food: '',
      calories: '',
    }
  }

  updateFood = () => {
    // set the food and calories to state
  }

  addFood = () => {
    // get the current food and calories out of stateful
    // post to DB
  }

  render() {
    return (
      <div className="food-form">
        <h2>Add A Food</h2>
        <form className="add-food-form">
          <input
            className="input"
            type="text"
            placeholder="Food Name"
            onChange={ this.updateFood } // onChange handler
          />
          <input
            className="input"
            type="number"
            placeholder="Calories"
            onChange={ this.updateFood } // onChange handler
          />
          <button
            className="add-food-btn"
            onClick={ this.addFood } //onClick handler
          >
          </button>
        </form>
      </div>
    );
  }
}
```

If we throw a `console.log` in those methods, we should see we are getting into them. Now, comes a lot of the logic we already know!

```js
  updateFood = (key, event) => {  // key is the 'food' or 'calories' passed in
    this.setState({ [key]: event.target.value })
    // this allows us to re-use the same function for both keys to set state
  }

  <input
    className="input"
    type="text"
    placeholder="Food Name"
    onChange={ this.updateFood.bind(this, 'food') }   
    // bind creates a new function, bound to THIS context, with the key of food
  />
  <input
    className="input"
    type="number"
    placeholder="Calories"
    onChange={ this.updateFood.bind(this, 'calories') }
    // bind creates a new function, bound to THIS context, with the key of cal
  />
```

Now that state is sent, let's get this new food into the database!

```js
addFood = (event) => {
  event.preventDefault()
  let food = this.state.food;
  let calories = this.state.calores;

  addFoods(food, calories)
    .then(() => {
      //call a function that will send this food up to App's state of all foods, then re-render so user can see
    })
    .catch((error) => console.error({ error }))
}
```

We need to send this action UP to App - so let's get back into App and add a method, which we will then pass down as a prop to FoodForm.

```js
//App.js
updateFoods = (name, calories) => {
  this.setState({ foods: [...this.state.foods, { name: calories }]})
}

//in render return statement, update <FoodForm /> to:
  <FoodForm updateFoods={ this.updateFoods } />
```

Now we can go back into FoodForm and call that function that was passed as a prop:

```js
//FoodForm.js
  addFoods(food, calories)
    .then(() => this.props.updateFoods(food, calories))
    .catch((error) => console.error({ error }))
  }
```

#### PAUSE and Check In

* Is FoodForm a stateful or presentational component? Why?
* Why were we able to re-use the `updateFoodInfo()` function for both inputs?
* How did FoodForm have access to the `updateFoods()` function?

## Partner Time

If you are building your capstone in React, cool. If you are not, you get to pair up with someone who is!
- Draw out your project (user view) like we did for Quantified Self at the start of class
- Label components on that drawing
- Map out parent/child relationships of those components, start thinking about what props you'll need to pass


## CFU/Interview Questions

- What is the difference between a stateful and presentational component? Explain a use case for each.
- When do you have to import a React component into another file? When do you need to export something?
- Which Dev Tools are used while building a React App? What is the purpose of each?
- How does a component 'get' props, and what can props be?
- What are the advantages and disadvantages of React?
