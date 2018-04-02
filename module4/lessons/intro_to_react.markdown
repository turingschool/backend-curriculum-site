---
layout: page
title: Intro to React
length: 180
tags: javascript, front-end framework, react
---

## Learning Goals

Students will be able to ...
- Provide a high level explanation of FE libraries/frameworks, specifically React and it's benefits
- Students can define and use basic React vocabulary (Component, JSX, Prop, State)
- Build an application with stateful and stateless components

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

## Fur Friends Greeting

We ultimately want to create something like this:

![](/assets/images/lessons/react-in-theory/fur-friends-final.png)

Let's break this up so we can develop individual components.

If you were dividing this UI into sections, what would your sections be?

### Install Some Tools

Install the [react dev tools]( https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en). It will give you additional information about your React application in the Chrome dev tools.

Then we're going to clone down a repo already set up for us.

When you create your own React application, it is recommended to use a tool from Facebook called [Create React App](https://github.com/facebookincubator/create-react-app). It configures webpack and babel for us, so we don't need to worry about them and can focus on React.

After cloning the repo, let's navigate to `http://localhost:3000/`.

### Explore the app

Open a new tab in Terminal and open up your project with your text editor.

Open `./src/components/App.js`

Let's walk through this...

```jsx
import React, { Component } from 'react';
import Greeting from './Greeting';
import '../styles/App.css';

const App = () => {
  return (
    <div className="list-of-names">
      <h1 className="title">Well hello...</h1>
      <Greeting />
      <Greeting />
      <Greeting />
    </div>
  )
}

export default App;
```

First we import React and specifically the Component class from React. We can also import images, svg files and css. Then we define our main `App` component / module.

How does our App component get added to our view?

Open your `./index.js` file.

ReactDOM is React's object for interacting with the DOM. You can see we create an instance of our `<App />` and add it to our root element which can be found in our `public/index.html` page.

Open `./src/components/App.js`

Let's walk through this...

```jsx
import React, { Component } from 'react';
import '../styles/Greeting.css'

const Greeting = () => {
  return (
    <div className="greeting">
      <p>✨fur friend✨</p>
      <p>10</p>
      <button className="increase-score">+1</button>
    </div>
  )
}

export default Greeting;
```
Head back to your browser. Open up the console, click on the React tab, Expand the `<App>` component and you'll see we have our `<ActionButton />` component. Take a minute to dig in and see what comes up in our sidebar.

```
Props
  Empty Object
```

#### Capitalized React Component Convention

Take note of how `<App />` is capitalized.

From the [React docs](https://facebook.github.io/react/docs/jsx-in-depth.html):

> Capitalized types indicate that the JSX tag is referring to a React component. These tags get compiled into a direct reference to the named variable, so if you use the JSX <Foo /> expression, Foo must be in scope.
> When an element type starts with a lowercase letter, it refers to a built-in component like <div> or <span> and results in a string 'div' or 'span' passed to React.createElement. Types that start with a capital letter like <Foo /> compile to React.createElement(Foo) and correspond to a component defined or imported in your JavaScript file.
> We recommend naming components with a capital letter. If you do have a component that starts with a lowercase letter, assign it to a capitalized variable before using it in JSX.

### Time to Render Fur Friends with Names!

We are currently re-using the Greeting component three times. This is a common pattern in React and should be utilized as much as possible. However, it's not dynamic, so this doesn't look like much right now. Remember how we saw that empty props object in the React Dev Tools a minute ago? We need to change that by passing some props to the Greeting component.

### Props

Props are crucial attributes of React components. A `prop` is an immutable property that holds data to be passed down to the component.

Let's start in App, the parent component of the Greeting component:

```jsx
import React, { Component } from 'react';
import Greeting from './Greeting';
import '../styles/App.css';

const App = () => {
  return (
    <div className="list-of-names">
      <h1 className="title">Well hello...</h1>
      <Greeting name="Shih-Tzu"/> // PROPS
      <Greeting name="Shar-Pei"/> // BEING
      <Greeting name="Hedgie"/>   // PASSED
    </div>
  )
}

export default App;
```

Now, rather than just rendering three Greeting components that are exactly the same, we are rendering three Greeting components, each of which now have the property of `name`.

Check out your React dev tools again. Select the `<Greeting />`, what do you see under props?

Now, let's access those props within the Greeting component.

```jsx
import React, { Component } from 'react';
import '../styles/Greeting.css'

const Greeting = (props) => {
  return (
    <div className="greeting">
      <p>✨{props.name}✨</p>
      <p>10</p>
      <button className="increase-score">+1</button>
    </div>
  )
}

export default Greeting;
```

Note that the word `name` here is completely arbitrary. It can be whatever you want to refer to that value as in your component. We could have put `<Greeting jellyfish="Shih-Tzu"/>` and within our JSX, accessed `{this.props.jellyfish}`.

### Turn and Talk

* Are App and Greeting stateless or stateful components?
* How did Greeting get the props of `name`?

### Action Time

Currently, our button does not do anything. We want each Furry Friend to keep track of it's rating, so we need this Greeting component to be `stateful`.


```jsx
class Greeting extends Component {
  constructor() {
    super()
    this.state = {
      count: 10
    }
  }

  render() {
    return (
      <div className="greeting">
        <p>✨{this.props.name}✨</p>
        <p>{this.state.count}</p>
        <button
          className="increase-score">
          +1
        </button>
      </div>
    )
  }
}
```

Nothing should look different in the browser - feel free to change the default state to another number, and you should see that reflected in your browser!

Let's make this button actually do it's job! We need to give it an event listener (this will look a little different from what we're used to seeing in jQuery). On that click, let's call a function that's inside of this class/component.

```jsx
class Greeting extends Component {
  constructor() {
    super()
    this.state = {
      count: 10
    }
  }

  incrementCount() {
    // do something
  }

  render() {
    return (
      <div className="greeting">
        <p>✨{this.props.name}✨</p>
        <p>{this.state.count}</p>
        <button
          className="increase-score"
          onClick={() => this.incrementCount()}>
          +1
        </button>
      </div>
    )
  }
}
```

Notice the difference between the className and onClick. onClick was assigned to an expression wrapped in `{ }` braces. We had to call the incrementCount function with `this` because we want to refer to the incrementCount() function that is part of this Greeting class.

We are still aren't actually incrementing. React gives us an important function:

#### `setState()`

`setState()` can be called on the instance of the component. This function takes an object as an argument - the part of the state that you would like to set, or change.

```js
incrementCount() {
  this.setState({ count: this.state.count + 1 })
}
```

### Turn and Talk

* What is the difference between state and props?
* How, and where, do we update state?


## Interview questions
* I saw on your resume you have used React on a couple of projects. What did you like/dislike about working in React?
* What are some of the advantages and disadvantages of working in React?

## CFUs
On your own, fill out the Intro to React Checks for Understanding questions [here](https://goo.gl/forms/SHYac3wCF8yFxmrq2).

## Going Further

If you're enjoying what we've seen so far with React, I'd highly recommend reading their section of documentation called [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html).

This article walks you through their best practices for approaching a new application using React. Since component-based / data down, actions up paradigms are fairly new to us, it'll be a worthy read for you.

## Resources and Additional Learning Materials

[React & Rails Tutorial](https://github.com/applegrain/creact)

[Render vs Return](https://facebook.github.io/react/docs/component-specs.html)

[React Classes vs extend Component](https://toddmotto.com/react-create-class-versus-component/)

[9 Things Every React Dev Should Know](https://camjackson.net/post/9-things-every-reactjs-beginner-should-know)

[React Tutorial by Facebook](https://facebook.github.io/react/docs/tutorial.html)
