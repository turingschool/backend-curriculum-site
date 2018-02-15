---
title: jQuery Intro - DOM Traversal, Manipulation, and Events
length: 180
tags: jquery, javascript
---

### Learning Goals

* Student can navigate and select/alter content on an HTML page using jQuery
* Begin recognizing patterns involved with using jQuery
* Explain what jQuery is, and it's benefits

jQuery is a library that allows us to use CSS selectors to find elements on the page and then interact with them. Under the hood, **it's JavaScript**. It's used on about 78% of the top million web pages, so it's worth while getting comfortable with it.

#### Loading the jQuery library

To use the jQuery library, you'll need to include the following lines right above the closing body tag in your HTML:

```html
  <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'>
  </script>
  <script src="<YOUR INDEX.JS FILE HERE>"></script>
```

## First Lines of jQuery

Let's say that we have a page with the following markup:

```html
<h1 class="important-header">Dinosaurs are awesome.</h1>
```

Just like with plain ol' JavaScript, jQuery lets us change the text programatically. The neat thing about jQuery, though, is that it significantly reduces the amount of code we have to write.

```js
$('h1').text('I AM A DINOSAUR.');
```

Play around with the following example using jQuery.

- Change the replacement text to something else.
- Change the `h1` selector to `.important-header`
- Add the following line of code: `$('h1').css('color', '#FC17A5');`

<p data-height="265" data-theme-id="0" data-slug-hash="XZepGP" data-default-tab="html,result" data-user="ameseee" data-embed-version="2" data-pen-title="Dino 1" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/XZepGP/">Dino 1</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

## Responding to User Events

jQuery and, of course, JavaScript are used to change and manipulate web pages. Just like JavaScript, jQuery has the ability to add event listeners based on user interaction.

This is the crux of front-end engineering. We present a user interface and then as the user interacts with the UI, we change and update what the user sees.

Let's take a look at the jQuery syntax and then we'll talk about what's happening.

<p data-height="265" data-theme-id="0" data-slug-hash="aqLJRO" data-default-tab="html,result" data-user="ameseee" data-embed-version="2" data-pen-title="Dino 2" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/aqLJRO/">Dino 2</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

The following things are happening in the example above:

- We're querying for any elements with the class of `change-me`.
- We're adding an "event listener" to those elements. (There is just one in this case.)
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

## Try It: Adding a CSS Class

Open the example below in CodePen using the "Edit on CodePen."

<p data-height="265" data-theme-id="0" data-slug-hash="rJGJjO" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="Dino 3" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/rJGJjO/">Dino 3</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

We're using a jQuery method called `toggleClass()`. When the user clicks on the button, it either adds or remove the class `upside-down` depending on whether or not it was already there.

- Can you create some additional CSS classes and toggle them?
- Can you also change the text?
- Try out the following methods:
  - `toggle()`
  - `slideToggle()`
  - `fadeToggle()`

## Getting Values from the User

We're getting somewhere! We can respond to actions and change elements. It would be cool if we could also get some information from the user. If you recall, HTML provides `<input>` elements for just this kind of situation. jQuery helps out by providing the `.val()` method for getting the value out of a selected `<input>` element.

Let's explore the following example.

<p data-height="265" data-theme-id="0" data-slug-hash="qxPxPj" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="Dino 4" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/qxPxPj/">Dino 4</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

In this example, we're doing the following:

- We're adding an event listener to the "Change Me" button.
- When it's clicked, we're grabbed the value of the input field and storing it into a variable.
- We're then updating the contents of the `<h1>` to the value we stored from the input field.

### A Note on Working with Numbers

JavaScript has two ways of seeing if two values are equal: `==` and `===`. `==` is notoriously weird, so we tend to avoid it. But there is something with using `===` and getting numbers from input fields that we need to discuss.

Let's consider the following example:

<p data-height="265" data-theme-id="0" data-slug-hash="rJGJYe" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="Game 1 (Non-Working)" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/rJGJYe/">Game 1 (Non-Working)</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

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

<p data-height="265" data-theme-id="0" data-slug-hash="OQxQzr" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="Game 1 (working)" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/OQxQzr/">Game 1 (working)</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

### Try It: Secret Passcode Time

Can you change the code above so that it's looking for a secret passcode before it prints a hidden message to the screen? It's totally your call on what the password is and what the message should be. I don't want to steal your creative thunder.

## Knowing Which Element We Clicked - THIS!

Consider a situation where we have three boxes. When that particular box is clicked, we want to toggle a class on that box only. How do we know which box was clicked?

It turns out that when we add an event listener using jQuery, we get a special variable called `this`. Although the concept of the JavaScript `this` can get quite complicated, for our purposes the variable `this` is assigned to the context within which it is called.

Let's take a look at the example below:

<p data-height="265" data-theme-id="0" data-slug-hash="KQXjwV" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="$(this)" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/KQXjwV/">$(this)</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

#### Try It

Can you create a class that adds a border and then toggle that class on the specific box that is hovered over? (For your own sanity, you probably want to remove the alert!)  

## Traversing the DOM

A little while ago, we wanted to figure out how to tell which element we clicked. But, what if we wanted to find an element in relation to the element we clicked? jQuery lets us navigate from one element to another. When the browser parses our HTML, it creates a big tree-like structure. jQuery lets us hop from branch to branch.

Let's work through a box example again.  

We want each box to have a button inside of it. When the user clicks the button, it should rotate the entire box. (We're rotating the box with a CSS class called `clicked`.)  

<p data-height="265" data-theme-id="0" data-slug-hash="YeroWR" data-default-tab="css,result" data-user="ameseee" data-embed-version="2" data-pen-title="Rotating Buttons" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/YeroWR/">Rotating Buttons</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

This code _does not_ work the way we'd like - right now when we click on the button, the button itself is rotating instead of the entire box. What we need to do is when the user clicks on a button, go up and find the box that it lives in (the parent element) and add the class to _that_ element.

Work with your partner to make the entire box rotate, rather than just the button.

You can see all of ways we can move around the DOM tree in [jQuery documentation](https://api.jquery.com/category/traversing/tree-traversal/).

# A Deeper Dive

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

<p data-height="265" data-theme-id="0" data-slug-hash="NyaZbq" data-default-tab="html,result" data-user="ameseee" data-embed-version="2" data-pen-title="jQuery Parent" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/NyaZbq/">jQuery Parent</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

### `parents()`

This one will include all of the parents—all the way up to the `<body>` of the page. Additionally, you can pass it a selector. `$('.some-selector').parents('.active')` will traverse up the DOM, but only return the elements with the class of `.active`.

<p data-height="265" data-theme-id="0" data-slug-hash="vdeqxb" data-default-tab="html,result" data-user="ameseee" data-embed-version="2" data-pen-title="jQuery Parents" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/vdeqxb/">jQuery Parents</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

### `children()`

This method returns all of the direct childen of the given selection. It will _not_ search their children. Like `parents()`, `children()` will also take a selector. `$('.some-selector').children('.active')` will go through the children of the current query and only return the elements with the class of `.active`.

<p data-height="265" data-theme-id="0" data-slug-hash="VQMJWq" data-default-tab="html,result" data-user="ameseee" data-embed-version="2" data-pen-title="jQuery Children" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/VQMJWq/">jQuery Children</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

### `siblings()`

`siblings()` will select all of the sibling elements based on the current query. Like its friends, it will also take a selector if you're polite.

<p data-height="265" data-theme-id="0" data-slug-hash="wyrLra" data-default-tab="html,result" data-user="ameseee" data-embed-version="2" data-pen-title="jQuery Siblings" class="codepen">See the Pen <a href="https://codepen.io/ameseee/pen/wyrLra/">jQuery Siblings</a> by Amy Holt (<a href="https://codepen.io/ameseee">@ameseee</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

### `find()`

One you have queried for some elements using jQuery, you can use `find()` to drill down a little deeper.

It's useful to think of `find()` as a more powerful alternative for `children()`. The `children()` method will look only one level down the tree. `find()` will search the children, the grandchildren, the great-grandchildren, and so on. The method will look at anything you currently have selected and then search within those results.

<p data-height="300" data-theme-id="23788" data-slug-hash="dXVEpN" data-default-tab="js,result" data-user="turing" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/team/turing/pen/dXVEpN/">jQuery Find</a> by Turing School of Software and Design (<a href="http://codepen.io/turing">@turing</a>) on <a href="http://codepen.io">CodePen</a>.</p>

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

<p data-height="300" data-theme-id="23788" data-slug-hash="pbWXgg" data-default-tab="js,result" data-user="turing" data-embed-version="2" data-editable="true" class="codepen">See the Pen <a href="http://codepen.io/team/turing/pen/pbWXgg/">Append/Prepend</a> by Turing School of Software and Design (<a href="http://codepen.io/turing">@turing</a>) on <a href="http://codepen.io">CodePen</a>.</p>

## Exercise, Part Four: Dead Presidents

* Find all of the presidents who died in office (hint: they have a `died` class on their `tr`).
* Append `<span class="died">(Died)<span>` to the the `term` column.
* **Bonus**: Add a radio button before the number in each row.

## Final CFU

* What is jQuery? What is it so popular?
* What's an example of a way jQuery can be used?
* Why is it important to use precise selectors?
