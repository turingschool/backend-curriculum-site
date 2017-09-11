---
layout: page
title: React Part 2 - Axios
tags: javascript, front-end framework, react
---

## Learning Goals

- Students can implement Axios in their React applications
- Students can refactor an existing vanilla JS application to use React

## Why Axios?

[Axios](https://github.com/mzabriskie/axios) is a promise-based library used with Node.js and your browser for making asynchronous JavaScript HTTP requests.

When we think "promise-based" and "asynchronous HTTP requests" with JavaScript, everything we'd done to accomplish this had been done using jQuery's AJAX.

While we _could_ add jQuery to our React application, we'd sort of be going against React by doing so. Remember, jQuery is wonderful for DOM manipulation. Since React is handling everything within its virtual DOM, there's really no longer a need for jQuery.

Thus, Axios becomes the more natural solution to handle our HTTP requests.

### Installing Axios

Simple.

```bash
# within project directory
npm instal axios --save
```

### Working with Axios

Also simple. We already know jQuery's AJAX syntax. Axios really isn't much different.

For example, if we wanted to make a GET request to the Quantified Self API's `foods` route, with Axios, it'd look like this:

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
