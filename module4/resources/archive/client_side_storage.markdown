---
layout: page
title: Client-side Storage
length: 90 minutes
tags: local storage, session storage, firebase
---

# Client Side Storage

## Lesson Goals

* Understand the Web Storage API for storing data in browsers
* Know the use cases for local storage vs. session storage
* Implement Client Side storage using local storage


## Warm Up

Let's say you're hired by a client to create a little game using JavaScript, HTML and maybe a little bit of CSS for a client's marketing campaign. 

They plan to have a laptop set up at a booth at a trade show and allow people visiting the booth to play a game.

Your client wants to make the game interesting by allowing the user to keep a high score across everyone who plays the game at the booth.

Your first reaction to this request might be to store the high score in your database for easy persistance - but the client refuses to pay for internet at the conference, and they won't give you their laptop to set up a local server. 

**There are several ways to actually store data when you're not running a server that you can use for this problem - depending on what the client requirements are for a high score.**

## Pair/Share

* Write up what you know, what you can assume, and what you don't know, about browser based storage
* Discuss with someone sitting next to you
* Research browser based storage


# HTML5 & the Web Storage API

HTML5 introduced a _storage object_ to help users store data in the browser. 

The Web Storage API provides mechanisms by which browsers can store **key/value pairs**, in a much more intuitive fashion than using cookies.

## Web Storage API mechanisms

* `sessionStorage`: maintains a separate storage area for each given origin that's available for the duration of the page session (as long as the browser is open, including page reloads and restores)
* `localStorage`:  does the same thing, but persists even when the browser is closed and reopened

## How do you access `localStorage` and `sessionStorage`?

These mechanisms are available via the following properties:

* `window.sessionStorage`
* `window.localStorage`

Let's see how we can access these storage mechanisms and how to get/set values in our browser.

## Limitations to the Web Storage API

* Storing more than 5MB of data will cause the browser to ask the user if they want to allow the site to store that much data.
* `localStorage` can be vulnerable to XSS attacks (cross-site scripting) because the data is accessible to JavaScript (i.e. scripts can be run from `localStorage`). You need to escape and encode all untrusted data that can be set in `localStorage`.

For security reasons, the browser limits you to only sharing local or session data with websites of the same domain, you must match for following:

* Same domain: `turing.edu` cannot access data on `github.com/turing`
* Same subdomain: `today.turing.edu` cannot access data on `turing.edu`
* Same protocol: no mixing http and https
* Same port: `localhost:3000` cannot access data on `localhost:8080`

# Before HTML5: Cookies

* Before HTML5 was introduced, the primary mechanism for storing information in the browser was cookies.
* Cookies have some limitations:
	* Not able to hold a lot of data (a limit of 4095 bytes)
	* Sent to the server every time you request a page from that domain
	* Not considered secure. Cookies are vulnerable to cross-site request forgery (CSRF)

# When to use cookies vs client side storage

Cookies and local storage serve pretty different purposes. Cookies are primarily for reading server-side, local storage can only be read client-side. Who needs the data you're trying to store - the client or the server?

If it's your client (your JavaScript), then you should probabl use local storage. It's expensive to send all your data in each HTTP header.

If it's your server, local storage isn't so useful because you'd have to forward the data along somehow (probably with AJAX or hidden form fields). 

Note: If you want to read the internet's opinions of cookies vs. web storage you can do so [here](http://stackoverflow.com/questions/3220660/local-storage-vs-cookies)


# Let's Store Some Data

Clone this [Example Repo](https://github.com/turingschool-examples/client-side-storage)

Open the index page and play around with the application.

You'll notice that the app generates a high score when a button is clicked.


## Code Along

Using `localStorage` or `sessionStorage`, update the application so that:

-   The high scores along with the user's name persist when the users page is refreshed
-   The user can clear all high scores by clicking a button
-   BONUS: The user can clear only high scores associated with their name


## Questions?
