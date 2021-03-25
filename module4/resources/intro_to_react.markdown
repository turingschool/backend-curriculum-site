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


## What is React

People will define React in many ways, but at it's core,

> React is a client-side JavaScript library that allows you to easily and efficiently manipulate the DOM based on application data and how it changes in response to user interaction

### The Virtual DOM
We mentioned previously that a big benefit of React is how well it can handle DOM manipulations in an easy and efficient way. This is done through the use of a Virtual DOM. A Virtual DOM is a JavaScript object that represents a copy of a DOM structure. This provides us with a huge performance benefit, because accessing and updating a JavaScript object is much faster than accessing the true DOM directly.

React lets us alter this virtual DOM first, then renders the change for us - making the smallest amount of true DOM manipulations possible. React will only render the deltas of what actually needs to be changed, rather than making a massive DOM manipulation to elements on the page that aren't actually changing.

### JSX

JSX is a special syntax that allows you to write HTML in your JavaScript, and JavaScript in your HTML. It's technically XML, but you can just think of it as HTML and JavaScript working together to create that Virtual DOM. The same way Babel converts ES6 into ES5, Webpack converts JSX into JavaScript and HTML.

JSX syntax takes some getting used to, and it might seem to fly in the face of what you know about "separation of concerns" - but after a bit of practice you'll find it becomes more intuitive. In the early days when we talked about separation of concerns, we thought: split up your HTML (content) from your CSS (presentation) from your interactivity (JavaScript). Now when we think about separating our concerns, we do it in a slightly more semantic, user-centric way. We're not bothered by mashing up our HTML, CSS and JavaScript in a single file, if all of that logic works together to create a single application feature. Our separation of concerns is now much more focused on the concerns of our users, rather than concerns about our file structure. We'll see this demonstrated a bit further later on in this lesson.

First, let's take a look at the JSX syntax:

```jsx
let listItems = [{ name: 'peaches' }, { name: 'raspberries' }, { name: 'mint' }];

const groceryList =
  <div className="grocery" onClick={ someFunction }>
    <h1>A Grocery List</h1>
    <ul>
      {
        listItems.map((item) => {
          return <li>{ item.name }</li>
          })
      }
    </ul>
  </div>
```
What looks familiar? What looks different? You might notice the curly braces around things like onClick={someFunction}. These curly braces are allowing us to interpolate JavaScript in our HTML. Think about how you may have used template strings in vanilla JavaScript in the past: we use the ${} syntax to denote that this particular chunk of the string is a dynamic value that should be evaluated and parsed as a dynamic JavaScript value, rather than plain text. The curly braces in React give us similar functionality. Anywhere in our JSX where we want to tell our application "This is JavaScript, so don't render it character by character like HTML, we can wrap that code in curly braces to signal that.

### Components

Components are reusable pieces of code that represent templates for a particular instance of a UI element. Components can take in parameters that might vary from instance to instance, allowing us to create unique elements with a shared structure and style. The main benefit of components is how modular they are - they can snap or nest together to create complete pages and applications.

If we take a look at a website like Twitter, we can start to flesh out what components might be making up the entire page, and how they're being reused:

![](/assets/images/lessons/react-in-theory/twitter-components.png)

You'll hear the term 'component' used in many different areas of programming, and it might mean slightly different things depending on the context. In React, components have the following characteristics:

* they are either functions or an extended ES6 class
* they return one, single JSX element (remember, functions can only return one thing!)
* there are two types of components: stateless and stateful

We'll start investigating these characteristics by practicing with stateless components.

#### Stateless Components

Stateless components are components that simply need to render content to the DOM, and do not need to be aware of any application data that might be changing. They are sometimes called "dumb" components. Stateless components are just functions that return the HTML you want rendered to the DOM. Examine the following example:

```js
import React from 'react';

export default App = () => {
  return (
    <div>
      Hello World
    </div>
  );
}
```
#### Stateful Components

Stateful components are ES6 classes that extend an abstract 'Component' class, given to us by default by React. They each have a render method that allows us to specify what should be rendered to the DOM, and they keep track of some sort of application data.

### Props and State

Props and state are how we manage and share information among components in React. We will dig into exactly how that works when we see it in action later in the lesson. It will be important for you to know what responsibility each has, and the difference between the two.

## Discussion

Now that you've had a little introduction into React, discuss the following with your partner:

- What parts of Quantified Self could have been easier with React?
- Draw out a sketch of one of the QS views - how would you break it out into components, and what semantic names would you give those components?

And then let's come back as a group and report out your answers.

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
import FurFriend from './FurFriend';
import '../styles/App.css';

const App = () => {
  return (
    <div className="list-of-names">
      <h1 className="title">Well hello...</h1>
      <FurFriend />
      <FurFriend />
      <FurFriend />
    </div>
  )
}

export default App;
```

First we import React and specifically the Component class from React. We can also import images, svg files and css. Then we define our main `App` component / module.

How does our App component get added to our view?

Open your `./index.js` file.

ReactDOM is React's object for interacting with the DOM. You can see we create an instance of our `<App />` and add it to our root element which can be found in our `public/index.html` page.

Open `./src/components/FurFriend.js`

Let's walk through this...

```jsx
import React, { Component } from 'react';
import '../styles/FurFriend.css'

const FurFriend = () => {
  return (
    <div className="greeting">
      <p>✨fur friend✨</p>
      <p>10</p>
      <button className="increase-score">+1</button>
    </div>
  )
}

export default FurFriend;
```
Head back to your browser. Open up the console, click on the React tab, Expand the `<App>` component and you'll see we have our `<FurFriend />` component. Take a minute to dig in and see what comes up in our sidebar.

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

We are currently re-using the FurFriend component three times. This is a common pattern in React and should be utilized as much as possible. However, it's not dynamic, so this doesn't look like much right now. Remember how we saw that empty props object in the React Dev Tools a minute ago? We need to change that by passing some props to the FurFriend component.

### Props

We mentioned that components are reusable pieces of code, that allow us to create unique instances of certain UI elements. We can do this by passing props to each of our components. Think about how you create new instances of ES6 Classes - they share the same base, but you pass in different arguments every time you create a new instance, which allows each instance to vary slightly.

Props allow us to pass information from parent components to child components. We can pass strings, numbers, booleans, arrays, objects, functions, pretty much any piece of data we want access to in our child component. We can name them whatever we'd like, as long as we're consistent and semantic with the names that we choose.

When we pass props down to a child component, it comes through as a simple JavaScript object with key value pairs.

Let's start in App, the parent component of the FurFriend component:

```jsx
import React, { Component } from 'react';
import FurFriend from './FurFriend';
import '../styles/App.css';

const App = () => {
  return (
    <div className="list-of-names">
      <h1 className="title">Well hello...</h1>
      <FurFriend name="Shih-Tzu"/> // PROPS
      <FurFriend name="Shar-Pei"/> // BEING
      <FurFriend name="Hedgie"/>   // PASSED
    </div>
  )
}

export default App;
```

Now, rather than just rendering three FurFriend components that are exactly the same, we are rendering three FurFriend components, each of which now have the property of `name`.

Check out your React dev tools again. Select the `<FurFriend />`, what do you see under props?

Now, let's access those props within the FurFriend component.

```jsx
import React, { Component } from 'react';
import '../styles/FurFriend.css'

const FurFriend = (props) => {
  return (
    <div className="greeting">
      <p>✨{props.name}✨</p>
      <p>10</p>
      <button className="increase-score">+1</button>
    </div>
  )
}

export default FurFriend;
```

Note that the word `name` here is completely arbitrary. It can be whatever you want to refer to that value as in your component. We could have put `<FurFriend jellyfish="Shih-Tzu"/>` and within our JSX, accessed `{this.props.jellyfish}`.

### Turn and Talk

* Are App and FurFriend stateless or stateful components?
* How did FurFriend get the props of `name`?

### Action Time - Stateful Components

Currently, our button does not do anything. We want each Furry Friend to keep track of it's rating, so we need this FurFriend component to be `stateful`.

State is slightly different than props: state holds data that represents the actual state of our application. State can be changed and mutated through user interactions, whereas props should remain immutable.

One of the more confusing things about React is when to make a component stateful. A general rule of thumb to keep in mind is that, if you're not sure if a component should be stateless or stateful, start with a stateless component. Add state if you find that you need it. Stateful components are a lot heavier than stateless component. Keep your app as lean as possible!

```jsx
class FurFriend extends Component {
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
class FurFriend extends Component {
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

Notice the difference between the className and onClick. onClick was assigned to an expression wrapped in `{ }` braces. We had to call the incrementCount function with `this` because we want to refer to the incrementCount() function that is part of this FurFriend class.

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
