---
layout: page
title: Intro to React.JS
length: 180
tags: javascript, front-end framework, react
---

## Learning Goals

- Students can define basic React vocabulary (Component, JSX, Prop, State)
- Students are able to create and use React components with heavy guidance from samples and documentation

## Warm Up

* What do you know thus far about React?
* Why do front-end frameworks / libraries exist?
* How do we currently understand elements to be added to and removed from our browser's viewport?

## React's Take on Front-End Development

React's big innovation is that it gives us a way to utilize
the efficiently re-render our browser's display when manipulating the DOM.

Using React, we'll define __components__ -- individual pieces of our UI
that handle the data related to them. We'll give each
component a key __render__ function, which tells React how to
re-generate the portion of the DOM controlled by that component
_in terms of its data._

Then, whenever anything changes, React can walk down the component tree,
re-rendering components in terms of their associated data (which may or may not have changed).

### What's the Benefit?

But what about the performance problems of DOM repaints?

React gets around the efficiency problem of re-rendering the DOM by implementing a separate, in-memory model of the current DOM, called a **virtual DOM**. When things need to be re-rendered,
React can (very quickly) re-generate its virtual representation of the DOM. Then,
it actually uses an algorithm to isolate those elements that _actually changed_,
and sends real DOM updates to only those elements.

So when we said React allows us to continuously re-render the entire UI in response
to data changes, we were oversimplifying. In reality, React itself does end up
sending selective updates to the DOM.

Use your browser's element inspector to inspect what's happening in this [React example](https://codepen.io/gaearon/pen/gwoJZk?editors=0010) vs [jQuery example](https://codepen.io/laurenfazah/pen/EwzeYY).

### Other Benefits of React

*   __Lightweight__ -- does a specific thing and does it pretty well
*   __Very modular__ -- easy to drop in for a small portion
of your UI without having to rewrite everything in React
*   __Easy to learn__ -- As we will see shortly, there's
not much to it. Learn the basics for setting up components
as well as a few core lifecycle methods, and you're ready to start
building your own UI.

## Discussion

Now that you've had a little introduction into React, discuss the following with your partner:

- What parts of Quantified Self could have been easier with React?
- When do you think you would use React? What is not a good use case for React?

And then let's come back as a group and report out your answers.

#### Quick Aside: JSX

A big trait of React that is worth mentioning is its use of JSX vs plain old JavaScript. JSX itself exists as a statically-typed spin-off of JavaScript that can be used on its own outside of React. However, you'll likely mostly encounter it within React apps.

JSX

- is a syntax extension of JavaScript
- is statically-typed, but can infer the type set to variables based on their initial declaration
- integrates HTML within JavaScript
  - this means that most elements and DOM manipulation in React will happen through JS (you will barely touch `index.html`)
- can be typed within `.js` files within React, but `.jsx` extensions can also be used
  - if using `.jsx`, remember to tack that extension onto the end of the file you're importing

Read more about its use in React [here](https://facebook.github.io/react/docs/introducing-jsx.html).

## Likes Counter Code Along

We ultimately want to create something like this:

![](/assets/images/lessons/react-in-theory/final-image.png)

Let's break this up so we can develop individual components.

If you were dividing this UI into sections, what would your sections be?

### Install Some Tools

Install the [react dev tools]( https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en). It will give you additional information about your React application in the Chrome dev tools.

Then we're going to use a tool from Facebook called [Create React App](https://github.com/facebookincubator/create-react-app). It configures webpack and babel for us, so we don't need to worry about them and can focus on React.

Some terminal commands:

```
npm install -g create-react-app
create-react-app awesome-counter
cd awesome-counter
npm start
```

Let's navigate to `http://localhost:3000/`.

Look at that - we have our React dev environment set up!

### Explore the app

Open a new tab in Terminal and open up your project with your text editor.

Open `./src/App.js`

Let's walk through this...

```jsx
import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}

export default App;
```

First we import React and specifically the Component class from React. We can also import images, svg files and css. Then we define our main `App` component / module.

How does our App component get added to our view?

Open your `./index.js` file.

ReactDOM is React's object for interacting with the DOM. You can see we create an instance of our `<App />` and add it to our root element which can be found in our `public/index.html` page.

#### Capitalized React Component Convention

Take note of how `<App />` is capitalized.

From the [React docs](https://facebook.github.io/react/docs/jsx-in-depth.html):

> Capitalized types indicate that the JSX tag is referring to a React component. These tags get compiled into a direct reference to the named variable, so if you use the JSX <Foo /> expression, Foo must be in scope.
> When an element type starts with a lowercase letter, it refers to a built-in component like <div> or <span> and results in a string 'div' or 'span' passed to React.createElement. Types that start with a capital letter like <Foo /> compile to React.createElement(Foo) and correspond to a component defined or imported in your JavaScript file.
> We recommend naming components with a capital letter. If you do have a component that starts with a lowercase letter, assign it to a capitalized variable before using it in JSX.

### Time to Make a New Component!

Let's start by creating the template for the Like / Dislike button. Create an `ActionButton` class above our `App` class in `index.js`:

```jsx
class ActionButton extends Component {
  render() {
    return (
      <button className="action-button">
        Submit
      </button>
    )
  }
}

...

class App extends Component {
  ...
}
```

Let's add the new component to our `App` component. Replace everything inside the `App` `div` with the `ActionButton` component:

```jsx
<div className="App">
  <ActionButton />
</div>
```

Head back to your browser. Great, we have our button! Open up the console, click on the React tab, Expand the `<App>` component and you'll see we have our `<ActionButton />` component. Take a minute to dig in and see what comes up in our sidebar.

```
Props
  Empty Object
```

### Props

Props are crucial attributes of React components. A `prop` is an immutable property that holds data to be passed down to the component.

Right now the text within our button is hardcoded to be 'Submit'; let's change it to be dynamic via props.

```jsx
class ActionButton extends Component {
  render () {
    return (
      <button className="actionButton">
        {this.props.text}
      </button>
    )
  }
}
```

Now, let's pass our text into our instantiation of our `ActionButton`.

`<ActionButton text="Submit"/>`

Check out your React dev tools again. Select the `<ActionButton />`, what do you see under props?

Note that the word `text` here is completely arbitrary. It can be whatever you want to refer to that value as in your component. We could have put `<ActionButton jellyfish="Submit"/>` and within our JSX, accessed `{this.props.jellyfish}`.

### Refactor (3-5 minutes)

Work with a partner to refactor your `ActionButton` component out of `App.js.` I'd recommend you create a `components` directory within `src` to start housing these components in.

### Action Time

Currently, our button does not do anything. Let's add an action. Add an `onClick` property to your button element.

```jsx
<button
    className="actionButton"
    onClick={() => alert(this.props.text)}>

  {this.props.text}
</button>
```

Cool, now let's make our button a more customizable by passing in our action.

First, modify your `ActionButton`'s `render` function.

```jsx
<button
    className="actionButton"
    onClick={this.props.onClick}>

  {this.props.text}
</button>
```

Inside your `App.js` file, pass in a function to your instantiated `ActionButton`.

```jsx
<ActionButton
    text="Submit"
    onClick={this.handleClick}/>
```

Finally, add a `handleClick` function to your `App` component.

```jsx
class App extends Component {
  handleClick() {
    alert('you clicked me!')
  }
  render() {...}
}
```

### Synthesize: Passing Actions as Props

You might be wondering why we're passing a `handleClick` function as a prop from `App` to our child component, `ActionButton`.

We absolutely could be defining this method within `ActionButton`, but if we're learning it this way, there's got to be a benefit (trust us).

#### "Data Down, Actions Up"

Components in React can pass information down to their children, but there isn't really a way for children to pass data back up to the parent. This is because the parent knows about the child (because it's in the render function), but the child component doesn't have any way to access its parent.

The convention the React community (and Ember community before them) has adopted is passing actions down as data and allowing them to bubble back up.

Just remember: **data down, actions up**

In our app, since the action handler is defined as a method of its parent component, it has access to everything that the parent component has access to. As long as the child component uses the handler that was passed down, the parent is the one who is actually handling the action.

Read more about how this works in React [here](https://facebook.github.io/react/docs/lifting-state-up.html).

### Build our View (15-20 minutes)

Let's create a new component called `LikesCounter`. This component should have two `ActionButton`s: one saying "Like" and one saying "Dislike". When you click "Like" or "Dislike", an alert of which one was clicked should appear. Build this component in a new file, `components/LikesCounter.js`

After you create your `LikesCounter`, replace the `ActionButton` in your `App` with a `LikesCounter`.

Anticipate the following error:

```
Error in ./src/LikesCounter.js
Syntax error: Adjacent JSX elements must be wrapped in an enclosing tag
```

This is important. React components can only render one _root level_ element, which simply means that you have to structure your JSX so that everything is contained within a single element.

Let's fix this by wrapping our adjacent `ActionButton` components in a `div`.

```jsx
return (
  <div>
    <ActionButton
      text="Like +1"
    />
    <ActionButton
      text="Dislike -1"
    />
  </div>
)
```

### Props vs State

Now that our HTML is in place, it's time to add some behavior to the buttons.

Let's about what we're trying to accomplish here:

When the page loads, we want the initial value of Likes to be 0. Then when we click "Like", we want to add 1 to the value of Likes, and remove 1 when we click "Dislike".

Let's rephrase. On page load we want to set the *initial* state of our `LikesCounter` to have a count of 0, in other words we want to "initialize" our component to have some values. Sounds like a constructor!

Along with sending the `props` through our custom HTML element, we can also define an initial `state` on our components that can be mutated based on user interaction and changes to our data.

From [React](https://facebook.github.io/react/docs/state-and-lifecycle.html):

> State is similar to props, but it is private and fully controlled by the component.

Our state machine needs to get that information from somewhere, so let's start with passing in an `initialLikes` property to our `<LikesCounter />` instance:

`<LikesCounter initialLikes="0" />`

Now we can add a constructor to our `LikesCounter` component. In our constructor, we will set the initial state of our component.

Underneath the class declaration for `LikesCounter`, let's add our constructor function.

A standard component's constructor function takes `props` as an argument and calls `super(props)`. In an ES6 child class constructor, `this` cannot be used until `super` is called.

```jsx
constructor(props) {
  super(props)
  this.state = {
    likes: props.initialLikes
  }
}
```

We can now access a dynamically changing `likes` state value within our LikesCounter as so:

```jsx
render() {
  return(
    <div>
      <p>Likes: {this.state.likes}</p>
    ...
  )
}
```

At this point your `LikesCounter` should look something like this:

```jsx
import React, { Component } from 'react';
import ActionButton from './ActionButton'

class LikesCounter extends Component {
  constructor(props) {
    super(props);
    this.state = {
      likes: props.initialLikes
    };
  }

  handleDislike() {
    alert('Dislike');
  }

  handleLike() {
    alert('Like');
  }

  render () {
    return (
      <div>
        <div>Likes: {this.state.likes}</div>
        <ActionButton
            text="Like +1"
            onClick={this.handleLike.bind(this)} />

        <ActionButton
            text="Dislike -1"
            onClick={this.handleDislike.bind(this)} />

      </div>
    )
  }
}

export default LikesCounter
```

Read more about why we're binding `this` [here](https://facebook.github.io/react/docs/handling-events.html).

Open up the console and look at what information is available within the `<LikesCounter />` component.

Last step - hook up the buttons to change the state!

Let's modify our two our Like and Dislike functions to change our state. To modify our state, we pass in a new state object to `this.setState(newState)`


```jsx
handleLike() {
  this.setState({
    likes: this.state.likes + 1
  });
}

handleDislike() {
  this.setState({
    likes: this.state.likes - 1
  });
}
```

This is where the magic of React comes in. We are essentially throwing out the old information and replacing it with fresh, up-to-date information.

You can verify this state change by switching over to your browser and opening your React dev tools. Check out what happens when you click a button.

Good work!

Note: you may need to use `parseInt()` in order to update the state when you're handling updating the like count.

### Refactor

Our `handleDislike` and `handleLike` functions look very similar. Let's create a new function `modifyLikes` that takes a modification parameter and updates our states likes.

```jsx
  handleLikeClick () {
    this.modifyLikes(1);
  }

  handleDislikeClick () {
    this.modifyLikes(-1);
  }
```

## CFUs

On your own, fill out the Intro to React Checks for Understanding questions [here](https://goo.gl/forms/6n82Ft7qC0lnipK13).

## Going Further

If you're enjoying what we've seen so far with React, I'd highly recommend reading their section of documentation called [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html).

This article walks you through their best practices for approaching a new application using React. Since component-based / data down, actions up paradigms are fairly new to us, it'll be a worthy read for you.

## Resources and Additional Learning Materials

[React & Rails Tutorial](https://github.com/applegrain/creact)

[Render vs Return](https://facebook.github.io/react/docs/component-specs.html)

[React Classes vs extend Component](https://toddmotto.com/react-create-class-versus-component/)

[9 Things Every React Dev Should Know](https://camjackson.net/post/9-things-every-reactjs-beginner-should-know)

[React Tutorial by Facebook](https://facebook.github.io/react/docs/tutorial.html)
