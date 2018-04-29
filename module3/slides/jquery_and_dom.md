# JQuery & the DOM

---

# Warmup

Use the web to research JQuery and answer the following questions:

* At a high level, what is jQuery? What does it allow us to do? How is it related to JavaScript?
* In an plain HTML document, how do we load JavaScript on the page?
* In Rails how do our scripts get loaded?
* How do you select all `<p>` tags using vanilla JS?
* How do you select all `<p>` tags using jQuery?

---

# Learning Goals

* Student can navigate and select/alter content on an HTML page using jQuery
* Begin recognizing patterns involved with using jQuery
* Explain what jQuery is, and it's benefits

---

# Loading the jQuery library

In a static HTML page, include the following lines right above the closing body tag in your HTML:

```html
<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'>
</script>
<script src="<YOUR INDEX.JS FILE HERE>"></script>
```

* In Rails, you can also use a gem to add JQuery to the Asset Pipeline.
* Before Rails 5.1, this gem was included by default.

---

# First Lines of jQuery

Given an HTML page with the following:

```html
<h1 class="important-header">Dinosaurs are awesome.</h1>
```

We can change the text of the h1 with the following jQuery:

```js
$('h1').text('I AM A DINOSAUR.');
```

---

# Exploration

In the CodePen in the lesson:

- Change the replacement text to something else.
- Change the `h1` selector to `.important-header`
- Add the following line of code: `$('h1').css('color', '#FC17A5');`

---

# Responding to User Events

```js
$('.change-me').on('click', function () {
  $('h1').css("textDecoration", "line-through");
  $('h2').text('Shih-tzus are better.');
});
```

* Query for elements with `.change-me` class.
* Add `event listerner` to those elements.
* Listen for a mouse click.
* Provide anonymouse function.
* Add line through the `h1` and add text to `h2`.

---

# Other Events: Investigate

- `click`
- `dblclick`
- `hover`
- `mouseenter`
- `mouseleave`
- `mousemove`
- `mouseout`
- `mouseover`

---

# Explore: Adding a CSS Class

- Can you create some additional CSS classes and toggle them?
- Can you also change the text?
- Try out the following methods:
  - `toggle()`
  - `slideToggle()`
  - `fadeToggle()`

---

# Getting Values from the User

```js
$('.change-me').on('click', function (event) {
  event.preventDefault();
  var newText = $('.new-text').val();
  $('h1').text(newText);
});
```

- Add an event listener for `click` to the "Change Me" button.
- Grab the value of the input field and store it in a variable.
- Update the contents of the `<h1>` with the stored value.

---

# A Note on Numbers

```js
$('.user-submit').on('click', function () {
  var number = $('.user-number').val();
  if (number === 2) {
    $('.message').text('You are right 🦄');
  } else {
    $('.message').text('Sorry, that is not the number 2 🙉');
  }
});
```

* Try it in the CodePen in the lesson.
* Thoughts?

---

# `parseInt()`

```js
parseInt("2") === 2; // true!
```

* Update the conditional in the CodePen.

---

# Try It: Secret Passcode Time

* Change the code in the CodePen so that it's looking for a secret passcode.
* Print a hidden message to the screen when the user correctly enters the passcode.

---

# `this`

```js
$('.box').on('mouseenter mouseleave', function() {
  $(this).toggleClass('hover')
})
```

---

# Try It

Can you create a class that adds a border and then toggle that class on the specific box that is hovered over? (For your own sanity, you probably want to remove the alert!)

---

# Traversing the DOM

* Helps find elements in relation to other elements.
* For example, find the parent element of an element that was clicked.

---

# A Deeper Dive

Let's take a closer look at how we can use the jQuery library!

---

# Part One: Selectors

---

# Basic Selectors

* `$('p')`, selects all of a given element.
* `$('#heading')`, selects the element with a given id.
* `$('.important')`, selects all of the elements with a given class.
* `$('p, #heading, .important')`, selects everything listed above.

---

# Chaining Selectors

* Comma: `$('p, #heading, .important')` just combines all of the selectors together.
* Space: `$('p #heading .important')` treats each selector as a child of the previous. This will give you items of the class `important` that are children of the id `heading` which are inside a `<p>` tag.
* Nothing: * `$('p#heading.important')` matches elements that have all three selectors. This selector would select a paragraph which was defined like this: `<p id="heading" class="important">`

---

# Exercise, Part One: The Presidents

Clone down [presidents repo][presidents].

[presidents]: https://turingschool-examples.github.io/jquery-playgrounds/presidents.html

* Select each `tr` element.
* Select the first `tr` element only.
* Select the third `tr` element only.
* Select all of the elements with the class of `name`.
* Select all of the elements with class of `name` or `term`.
* Select all checked checkboxes.
* Select all of the `td` elements with the class of `number` that appear in a row of a `tr` with the class of `whig`.

---

# Part Two: Manipulating CSS

```js
$('.federalist').addClass('red');
$('.federalist').removeClass('red');
$('.federalist').toggleClass('red');
$('.federalist').hasClass('federalist'); // Returns true, obviously.
```

---

# Exercise, Part Two: Style the Presidents

* Add the class of `red` to all of the Republicans.
* Add the class of `blue` to all of the Democrats.
* Add the class of `yellow` to the term column of the table.
* Take all the whig presidents and give them a purple background and white text.

---

# Part Three: Filtering and Traversal

[DOM traversal methods](http://api.jquery.com/category/traversing/tree-traversal/).

* `parent()`
* `parents()`
* `children()`
* `siblings()`
* `find()`

---

# Exercise, Part Three: One-Term Presidents

* Add the `green` class to anyone who served right after a president who died.
* Find all of the presidents who only served one term and add the class `red`.
* Add the class of `blue` to the parent of a checked checkbox.
* Add the class of `yellow` to the siblings of the parent (`td`, in this case) of an unchecked checkbox.

---

# Part Four: Adding to the DOM

---

# Adding to the DOM

* `text()`
* `html()`
* `prepend()`
* `append()`

---

# Exploration

See lesson plan.

---

# Exercise, Part Four: Dead Presidents

* Find all of the presidents who died in office (hint: they have a `died` class on their `tr`).
* Append `<span class="died">(Died)<span>` to the the `term` column.
* **Bonus**: Add a radio button before the number in each row.

---

# DOM Competition

With your partner, you have 10 minutes to create the most impressive CodePen. Create a new pen, and use jQuery to manipulate the DOM in at least FOUR different ways. Extra points for 🦄Sparkle and Delight🦄.

---

# Final CFU

* What is jQuery? What is it so popular?
* What's an example of a way jQuery can be used?
* Why is it important to use precise selectors?
