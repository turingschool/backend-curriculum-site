---
title: jQuery Intro - DOM Traversal, Manipulation, and Events
length: 180
tags: jquery, javascript
---

## Learning Goals

* Student can navigate and select/alter content on an HTML page using jQuery
* Begin recognizing patterns involved with using jQuery
* Explain what jQuery is, and it's benefits

## Vocabulary

- selector
- DOM
- DOM Manipulation
- DOM Traversal

## Warm Up


## What is the DOM?

The DOM, or Document Object Model, represents how HTML is read by the browser. It allows JavaScript to manipulate, structure, and style your website. After the browser reads your HTML document, it creates a representational tree called the `Document Object Model` and defines how that tree can be accessed.

**Manipulating the DOM** refers to changes that are made in the browser, that are prompted but not directly made by the user. If I type my email in a form then click “Submit”, I might see a message like “Thanks for signing up!”. I clicked the button and in response, JavaScript made that message appear. That is an example of DOM manipulation. Today we will learn how to change something on our site based on user interaction.

## Access Elements from the DOM

JavaScript has some built-in functions that allow us to access elements from the DOM. Here’s an example of accessing an h1 element.

```js
var header = document.querySelector('h1');
console.log(header);
//=> "<h1>hello</h1>"
```

Let’s break this down:

* `document` - this tells the computer: please go over to the HTML document
* `.querySelector` - now that the computer is looking at the HTML document, this instruction says: I’d like you to look for something specific
* `('h1')` - this is the argument passed to the .querySelector function. It says: go look in the HTML document for the first h1 that you find.

Since we stored the value of this in the header variable, we can `console.log()` this and see the HTML element.

We can also access elements by **selectors** (classes and IDs). Instead of ('h1') we would need to write something like `('.class-name')` or `('#id-name')`, using the same selectors we would when writing CSS rules for classes or IDs.

## What is jQuery?

jQuery is a _library_ that allows us to access DOM elements on the page and then interact with them. Under the hood, **it's JavaScript**. Since it is just JavaScript, it is executed in the browser. It is used by 97.4% of all the websites whose JavaScript library we know. This is 73.9% of all websites. It is currently being used by Google, Microsoft, Quizlet, Home Depot, and more.

In addition to providing a syntax that makes reading and writing code easier and faster, jQuery is used to improve browser compatibility.

<!-- ## Practical jQuery

### The Swing Between the Client and The Server

Throughout history, there's been some swings between things running on the server, things running on clients, and theres been ideas of thin clients and thick clients and dummy terminals, and all sorts of things. We're going to take a look at this.

In the early days of computing there was just big giant computers. Essentially, if you wanted to run software on the computers, you had to write your code on these punch cards, hand in the cards to the computer technician, and later at some point, you'd get the results of your program. Note: This would really suck if you had a bug in your code. Computers were so slow back then and you had to make an appointment for time for your computer to run. So if you did something wrong in your code, you had to fix it, get it on punch cards, and then make an appointment to run it at some later date. We are truly spoiled by the fact that we can just run our code all day every day and its fine.

As computers got faster, and technology advanced, we got to the point to where we no longer had to make appointments for computer time, computers could essentially time share, so it could be set up so that many people could use a computer at what appeared to them to be at the same time. The first iteration of this were dummy terminals, which were essentially a keyboard and screen connected via a VERY long cable to the server, also known then as possibly a mainframe. The computer wasnt doing multiple things at a time, it was essentially multitasking, but moving so fast that it felt like things were happening simultaneously. And of course, the more people using terminals at the time, the more things would slow down, as a finite number of computing resources are now allocated to more and more users.

We took this approach out to its logical conclusion, as the terminals were able to go further and further away from the mainframe, to the point where terminals were able to connect to the mainframe via phone lines. But then there started a shift with the advent of the personal computer.  Home computers were now more and more prevalent as the cost of computers came down and the machines people had in their homes got more powerful, we see this shift. Instead of running programs on a remote server somewhere, we install software on our computers at home and that does the heavy lifting, freeing up computing power on the mainframe. Who here has installed some kind of software on their computer using floppy disks or CD-ROMs back in the day? This was kind of a consequence of the fact that network speeds were so slow back then. It made time-sense and money sense to offload more things to the desktop as it could handle them.

This was the status quo until the internet became a thing. Not just the internet, but the internet and fast connection speeds and always on internet connections. I recall getting a copy of Microsoft Office, and it was something like six CDs. What do you do now if you want to run a copy of Microsoft Office? You sign up for an account for Office 365, and you log in using your Web Browser. Google Docs, whatever. But the model has changed a bit. We’re not connecting to a single server, we’re connecting to _the cloud_. In OOP terms, what do you think we would call _the cloud_?

#### TIPS
So that’s a brief history of how the architecture and paradigms of doing things on the internet has changed over the years.

Let’s imagine the best web app. You visit `catsarelame.com`.  There’s some text, it reads, “CATS RULE” You click a button on the screen. Now the webpage says, “NO CATS ARE LAME DOGS RULE”.

With the context of the HTTP response cycle, and what you know about rails, take five minutes and diagram out what happens in this scenario.

Take three minutes and in your pair, the person who has the cooler shoes shares first.

#### I want to go fast
![i want to go fast]

Why do we want our websites to go fast?

In the example you discussed, how long do you think that would take to complete? Is that best case scenario? Worst case scenario?

How long do you wait for a web page to load before you give up?

How much do you think Amazon spends on making their website fast. This is literally a situation where each millisecond can cost millions of dollars.

How can we speed up this situation? This is what JavaScript was made for. It ads interactivity and allows you to make changes to the displayed web site all on the browser without having to reach out to the server.
 -->

## First Lines of jQuery

Let's say that we have a page with the following markup:

```html
<h1 class="important-header">Dinosaurs are awesome.</h1>
```

Just like with vanilla JavaScript, jQuery lets us change the text programatically. The neat thing about jQuery, though, is that it significantly reduces the amount of code we have to write.

```js
document.querySelector('h1').innerText = 'I AM A DINOSAUR.');  // vanilla JS
$('h1').text('I AM A DINOSAUR.');                             // jQuery
```

<div class="try-it-section">
  <h2>Try It</h2>
  <p>Play around with the CodePen below using jQuery:</p>
  <ul>
    <li><b>Open the example below in CodePen using the `Edit on CodePen` button in the top right corner.</b></li>
    <li>Change the replacement text to something else.</li>
    <li>Change the <code class="try-it-code">h1</code> selector to <code class="try-it-code">.important-header</code></li>
    <li>Add the following line of code: <code class="try-it-code">$('h1').css('color', '#FC17A5');</code></li>
  </ul>
</div>

<p data-height="265" data-theme-id="0" data-slug-hash="WLoorZ" data-default-tab="html,result" data-user="mikedao" data-pen-title="Dino 1" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/WLoorZ/">Dino 1</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

**Fun Fact**: Accessing DOM elements by ID and element is much faster than by class.

## Responding to User Events

jQuery and, of course, JavaScript are used to change and manipulate web pages. Just like JavaScript, jQuery has the ability to add event listeners based on user interaction.

**DOM Manipulation** is the crux of front-end engineering. We present a user interface and then as the user interacts with the UI, we change and update what the user sees.

Let's take a look at the jQuery syntax and then we'll talk about what's happening.

**Open the example below in CodePen using the `Edit on CodePen` button in the top right corner.**

<p data-height="265" data-theme-id="0" data-slug-hash="dwOOGy" data-default-tab="css,result" data-user="mikedao" data-pen-title="Dino 2" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/dwOOGy/">Dino 2</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

The following things are happening in the example above:

- We're querying for any elements with the class of `change-me`.
- We're adding an `event listener` to those elements. (There is just one in this case.)
- We're listening for a user's mouse click.
- We're providing an anonymous function.
- In this example, the function will add a line through the `h1` and add text to the `h2`.

Now, when a user clicks on that button, the browser will run the function we provided to the event listener!

We can also listen for things other than clicks. Here are some other events from the [jQuery documentation](http://api.jquery.com/Types/#Event):

- `click`
- `contextmenu`
- `dblclick`
- `hover`
- `mousedown`
- `mouseenter`
- `mouseleave`
- `mousemove`
- `mouseout`
- `mouseover`
- `mouseup`

Take a moment to investigate and play with some of them.

## Adding a CSS Class

**Open the example below in CodePen using the `Edit on CodePen` button in the top right corner.**

<p data-height="265" data-theme-id="0" data-slug-hash="aPBBNx" data-default-tab="css,result" data-user="mikedao" data-pen-title="Dino 3" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/aPBBNx/">Dino 3</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

We're using a jQuery method called `toggleClass()`. When the user clicks on the button, it either adds or remove the class `upside-down` depending on whether or not it was already there.

<div class="try-it-section">
  <h2>Try It</h2>
  <p>First, fork this CodePen to your account so you can edit it.</p>
  <ul>
    <li>Can you create some additional CSS classes and toggle them?</li>
    <li>Can you also change the text?</li>
    <li>Try out the following methods: <code class="try-it-code">toggle()</code>, <code class="try-it-code">slideToggle()</code>, <code class="try-it-code">fadeToggle()</code>.</li>
  </ul>
</div>

## Getting Values from the User

We're getting somewhere! We can respond to actions and change elements. It would be cool if we could also get some information from the user. If you recall, HTML provides `<input>` elements for just this kind of situation. jQuery helps out by providing the `.val()` method for getting the value out of a selected `<input>` element.

**Open the example below in CodePen using the `Edit on CodePen` button in the top right corner.**

Let's explore the following example:

<p data-height="265" data-theme-id="0" data-slug-hash="vvyyKL" data-default-tab="css,result" data-user="mikedao" data-pen-title="Dino 4" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/vvyyKL/">Dino 4</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

<div class="try-it-section">
  <h2>Turn & Talk</h2>
  <p>Talk through each line of JavaScript. For the parts that are new - make your best guess as to what the code is doing. For the part that are review - use precise technical vocabulary to explain what the code is doing.</p>
</div>

### A Note on Working with Numbers

JavaScript has two ways of seeing if two values are equal: `==` and `===`. `==` is notoriously weird, so we tend to avoid it. But there is something with using `===` and getting numbers from input fields that we need to discuss.

**Open the example below in CodePen using the `Edit on CodePen` button in the top right corner.**

Let's consider the following example:

<p data-height="265" data-theme-id="0" data-slug-hash="oJYYYN" data-default-tab="css,result" data-user="mikedao" data-pen-title="Game 1 (Non-Working)" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/oJYYYN/">Game 1 (Non-Working)</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

Hmm—that's curious. It doesn't seem to work. You may have encountered this in a previous project. No matter what, input fields always hold **strings** of text. So, we're actually getting the string `"2"` from the input element and not the integer `2`. It makes sense that those things are not strictly equal. What we need to do is turn that string into a number before we compare it.

This is pretty common, so JavaScript gives us a function for doing it called `parseInt()`.

```js
parseInt("2") === 2; // true!
```

Now, we can update our conditional as follows:

```js
if (parseInt(number) === 2) {
  $('.message').text('You are right!');
} else {
  $('.message').text('Sorry, that is not the number 2.');
}
```

It works now!

<p data-height="265" data-theme-id="0" data-slug-hash="REoopR" data-default-tab="css,result" data-user="mikedao" data-pen-title="Game 1 (working)" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/REoopR/">Game 1 (working)</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

## Event Object

Consider a situation where we have three boxes. When that particular box is clicked, we want to toggle a class on that box only. How do we know which box was clicked?

It turns out that when we add an event listener using jQuery, we get access to the `event` object. The event object is a JavaScript object that represents the event (think click, mouseover, etc.) that triggered the listener. We typically name this variable `event` or `e`. We are provided with many properties and methods on the object. Most commonly used is the `target` property. The CodePen and Try It sections below will illustrate what it information it provides us with.

**Open the example below in CodePen using the `Edit on CodePen` button in the top right corner.**

Let's take a look at the example below:

<p class="codepen" data-height="265" data-theme-id="0" data-default-tab="css,result" data-user="ameseee" data-slug-hash="NVwdOB" style="height: 265px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;" data-pen-title="event object">
  <span>See the Pen <a href="https://codepen.io/ameseee/pen/NVwdOB/">
  event object</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>)
  on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

<div class="try-it-section">
  <h2>Try It: Event Object</h2>
  <p>Fork the CodePen above, then implement the following functionality:</p>
  <ul>
    <li>When the user hovers over a given box, that box appears to grow in size.</li>
    <li>When the mouse leaves that hover state, that box returns to its original size.</li>
  </ul>
</div>

## Traversing the DOM

The `event` object comes with a lot of properties and methods that we can use to our advantage. In the example above, we wanted to target the element that was clicked on, so used `e.target`. jQuery also allows us to find an element _in relation_ to the element we clicked. When the browser parses our HTML, it creates a big tree-like structure. jQuery lets us hop from branch to branch.

Where will we need this? In a classic To-Do List, we want to be able to click a delete button associated with a to-do, then have that entire to-do deleted.

Let's work through a box example again. We want each box to have a button inside of it. When the user clicks the button, it should rotate the entire box. (We're rotating the box with a CSS class called `clicked`.)  

<p data-height="265" data-theme-id="0" data-slug-hash="ebBBRb" data-default-tab="css,result" data-user="mikedao" data-pen-title="Rotating Buttons" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/ebBBRb/">Rotating Buttons</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

This code _does not_ work the way we'd like - right now when we click on the button, the button itself is rotating instead of the entire box. What we need to do is when the user clicks on a button, go up and find the box that it lives in (the parent element) and add the class to _that_ element.

<div class="try-it-section">
  <h2>Try It: DOM Traversal</h2>
  <p>Do some research and work to make the entire box rotate, rather than just the button.</p>
  <p>You can see all of ways we can move around the DOM tree in <a target="blank" href="https://api.jquery.com/category/traversing/tree-traversal/.">jQuery documentation.</a></p>
</div>

## Implementation

Now that you've had some time to familiarize yourself with jQuery, let's implement it into a real application.

<div class="try-it-section">
  <h2>Practice</h2>
  <p>Fork <a target="blank" href="https://codepen.io/ameseee/pen/zQppKx">this CodePen</a> and write jQuery to make this a working ToDo List.</p>
</div>

## Interview Questions

* What is jQuery?
* Why is jQuery needed?
* What are the advantages of jQuery?


<!-- # A Deeper Dive

Let's take a closer look at how we can use the jQuery library!

## Part One: Selectors

### Basic Selectors

Out of the box, jQuery supports the selector syntax from CSS to find elements on the page just like `document.querySelector` and `document.querySelectorAll` from vanilla JS. So, you've already come pre-equipped with a bunch of knowledge for finding elements.

That said, let's review some of the different ways we can find an element on page:

* `$('p')`, selects all of a given element.
* `$('#heading')`, selects the element with a given id.
* `$('.important')`, selects all of the elements with a given class.

You can also use multiple selectors in the same statement:

* `$('p, #heading, .important')`, selects everything listed above.

### Chaining Selectors

There are a few different ways to chain selectors to use them together. You can separate these selectors with a comma, a space, or nothing at all.

* Comma: `$('p, #heading, .important')` just combines all of the selectors together.
* Space: `$('p #heading .important')` treats each selector as a child of the previous. This will give you items of the class `important` that are children of the id `heading` which are inside a `<p>` tag.
* Nothing: * `$('p#heading.important')` matches elements that have all three selectors. This selector would select a paragraph which was defined like this: `<p id="heading" class="important">`

## Exercise, Part One: The Presidents

For this exercise, we're going to clone down a repo with [a table of the Presidents of the United States of America][presidents].

[presidents]: https://turingschool-examples.github.io/jquery-playgrounds/presidents.html

Let's try out a few things, just to get our hands dirty. We'll use the console in the Chrome developer tools to validate our work.

* Select each `tr` element.
* Select the first `tr` element only.
* Select the third `tr` element only.
* Select all of the elements with the class of `name`.
* Select all of the elements with either the class of `name` or `term`.
* Select all of the checked—umm—checkboxes. (You'll probably want to check some checkboxes first.)
* Select all of the `td` elements with the class of `number` that appear in a row of a `tr` with the class of `whig`.

## Part Two: Manipulating CSS

Once we have an element in our sites, we probably want to do something with it, right?

In this case, let's add some CSS styling. We can add and remove classes pretty easily in jQuery.

```js
$('.federalist').addClass('red');
$('.federalist').removeClass('red');
```

Keeping track of state is hard. jQuery is here to help. What if we were in a position where we want to add a class if an element had it, but remove it if it didn't? jQuery's `hasClass` method is certainly helpful in this case.

```js
$('.federalist').hasClass('federalist'); // Returns true, obviously.
```

But, it seems like this is a common pattern and there should be a better way to do this, right?

The other option is to use `toggleClass`, which will either add or remove the class depending on whether or not the class currently exists.

```js
$('.federalist').toggleClass('red');
```

(Do this like 17 times for good measure.)

## Exercise, Part Two: Style the Presidents

* Add the class of `red` to all of the Republicans.
* Add the class of `blue` to all of the Democrats.
* Add the class of `yellow` to the term column of the table.
* Take all the whig presidents and give them a purple background and white text.

## Part Three: Filtering and Traversal

Let's talk about a few [DOM traversal methods](http://api.jquery.com/category/traversing/tree-traversal/).

Here are some of the all-stars of the DOM traversing world:

### `parent()`

The `parent()` method will take the currently selected element and go one level up the DOM tree.

<p data-height="265" data-theme-id="0" data-slug-hash="aPBBVe" data-default-tab="html,result" data-user="mikedao" data-pen-title="jQuery Parent" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/aPBBVe/">jQuery Parent</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### `parents()`

This one will include all of the parents—all the way up to the `<body>` of the page. Additionally, you can pass it a selector. `$('.some-selector').parents('.active')` will traverse up the DOM, but only return the elements with the class of `.active`.

<p data-height="265" data-theme-id="0" data-slug-hash="Vqmmya" data-default-tab="html,result" data-user="mikedao" data-pen-title="jQuery Parents" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/Vqmmya/">jQuery Parents</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### `children()`

This method returns all of the direct childen of the given selection. It will _not_ search their children. Like `parents()`, `children()` will also take a selector. `$('.some-selector').children('.active')` will go through the children of the current query and only return the elements with the class of `.active`.

<p data-height="265" data-theme-id="0" data-slug-hash="PXbbEj" data-default-tab="html,result" data-user="mikedao" data-pen-title="jQuery Children" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/PXbbEj/">jQuery Children</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### `siblings()`

`siblings()` will select all of the sibling elements based on the current query. Like its friends, it will also take a selector if you're polite.

<p data-height="265" data-theme-id="0" data-slug-hash="WLoodz" data-default-tab="html,result" data-user="mikedao" data-pen-title="jQuery Siblings" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/WLoodz/">jQuery Siblings</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### `find()`

One you have queried for some elements using jQuery, you can use `find()` to drill down a little deeper.

It's useful to think of `find()` as a more powerful alternative for `children()`. The `children()` method will look only one level down the tree. `find()` will search the children, the grandchildren, the great-grandchildren, and so on. The method will look at anything you currently have selected and then search within those results.

<p data-height="265" data-theme-id="0" data-slug-hash="roWWpR" data-default-tab="html,result" data-user="mikedao" data-pen-title="jQuery Find" class="codepen">See the Pen <a href="https://codepen.io/mikedao/pen/roWWpR/">jQuery Find</a> by Michael Dao (<a href="https://codepen.io/mikedao">@mikedao</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

Which one do you use? It depends, do you want to traverse all the way down the tree or just down one level.


## Exercise, Part Three: One-Term Presidents

* Add the `green` class to anyone who served right after a president who died.
* Find all of the presidents who only served one term and add the class `red`.
* Add the class of `blue` to the parent of a checked checkbox.
* Add the class of `yellow` to the siblings of the parent (`td`, in this case) of an unchecked checkbox.

## Part Four: Adding to the DOM

Let's take a look at some approaches of changing content in the DOM.

### `text()`

`text()` is like using `innerText` or `textContent`. There is an important difference. The vanilla DOM manipulation tools allow you to assign the new value to `innerText`. The jQuery methods on the other hand work on everything as if it were a method.

Let's compare and contrast.

```js
var vanilla = document.querySelector('.some-element');
var jq = $('.some-element');

vanilla.textContent = 'New text.';
jq.text('New text.');
```

### `html()`

`html()` is to `text()` as `innerHTML` is to `innerText`. Basically, change the HTML contents of a bigger element, not just the text of it. As a fun experiment, select an element and try to replace the contents to `<script>alert('HACKED!');</script>` using both `text()` and `html()`. Let me know how it goes for you.

### `append()`

`html()` replaces the entire contents of an element. `append()` adds new content onto the end of it.

### `prepend()`

`html()` replaces the entire contents of an element. `prepend()` adds new content onto the beginning of it.

In order to take both `append()` and `prepend()` for a spin, let's try the following code in the exercise below.

<p data-height="265" data-theme-id="0" data-slug-hash="PQJrQo" data-default-tab="js,result" data-user="ameseee" data-embed-version="2" data-pen-title="Append/Prepend" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/PQJrQo/">Append/Prepend</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

## Exercise, Part Four: Dead Presidents

* Find all of the presidents who died in office (hint: they have a `died` class on their `tr`).
* Append `<span class="died">(Died)<span>` to the the `term` column.
* **Bonus**: Add a radio button before the number in each row.

## DOM Competition

With your partner, you have 10 minutes to create the most impressive CodePen. Create a new pen, and use jQuery to manipulate the DOM in at least FOUR different ways. Extra points for 🦄Sparkle Magic🦄. -->
