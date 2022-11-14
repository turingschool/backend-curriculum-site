---
layout: page
title: HTML and CSS
---

## Learning Goals

  - Understand structure of an HTML page
  - Understand how to use `application.html.erb`
  - Understand difference between semantic/non-semantic tags
  - Understand difference between block and inline elements
  - Understand difference between class and id selectors
  - Understand how to add CSS to our apps

## Vocabulary
  - HTML
  - Tag
  - Element
  - Semantic
  - Block
  - Inline

# Hyper Text Markup Language

A Markup Language used for describing the structure/layout of web pages.

Some HTML tags are "containers" for content, and some tags **are** the content.

### Application Layout

In SetList, open up the `app/views/layouts/application.html.erb`

```html
<!DOCTYPE html>
<html>
  <head>
    <title>SetList</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all' %>
    <%= javascript_include_tag 'application' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>

```

* `<!DOCTYPE html>` - The [Type Declaration](https://www.w3schools.com/tags/tag_doctype.asp) tells our browsers that our application is using HTML5 (this is NOT an html tag, but rather just an instruction for the browser about our HTML version).
* `<html>` signals the beginning of our HTML.
* `<head>` contains all the metadata (information *about* the document)
  * `<title>` - The title that will show in the tab of your browser.
  * `<%= stylesheet_link_tag %>` - An `ActionView::Helpers`. How we link to external stylesheets, i.e. our CSS. We want this in the head so it loads first. We could also style right in our html document with a `style` tag but DON'T DO THAT. We always want to use `ActionView::Helpers` when we can.
  * `<%= javascript_include_tag %>` - Another `ActionView::Helpers`. How we link to our client-side statements (JavaScript). We could use the `<script>` html tag, but we prefer the  `ActionView::Helpers`.

#### Body

Contains ALL the elements of the HTML document that we would like to display.

`<%= yield %>` is where all of our view files get rendered. This is used in a 'layout level template' to help us 'DRY' up our HTML. Now instead of needing to repeat the above in every erb/html file we can simply write the html that we want our body to contain.

This means that if there is part of a view we want to render on **every** page (like a navbar or footer), we can put it in `application.html.erb`.

## Semantic vs Non-Semantic Tags

  - How did you create HTML structure in your Task Manager app? Most everyone uses `<div>` tags at first.

### Non-Semantic

  - `div`s - incredibly common but with the introduction of HTML5, there was a move towards semantic tags.
  - `div`s tell us NOTHING about the content of the element.  
  - A good use case for a `div` might be creating an element on a page like a solid box.

```html
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8">
      <title>Our Zoo</title>
    </head>
    <body>
      <div class="nav">
        <h1>Welcome to Our Zoo</h1>
      </div>
      <div class="animals">
        <div class="otters">
          <h2>Cuddly Otters</h2>
          <p>Come visit our friendly otters and watch them slip and slide.</p>
        </div>
        <div class="penguins">
          <h2>Cute Penguins</h2>
          <ul>
            <li>Emperor Penguins</li>
            <li>King Penguins</li>
            <li>African Penguins</li>
          </ul>
        </div>
      </div>
      <div class="exhibits">
        <div class="explore-the-shore">
          <a href="https://www.denverzoo.org/explore-shore">Explore the Shore</a>
        </div>
        <div class="lorikeet-advuenture">
          <p>Come play with out lorikeets.</p>
        </div>
      </div>
      <div class="contact-me">
        <p>email me at <a href="mailto:dione@turing.edu"></a></p>
      </div>
    </body>
  </html>
```

### Semantic Tags

- Can act the same as a `div` but have implied meaning.
- Some examples of semantic tags:
  * `<article>`
  * `<aside>`
  * `<details>`
  * `<figcaption>`
  * `<figure>`
  * `<footer>`
  * `<header>`
  * `<main>`
  * `<mark>`
  * `<nav>`
  * `<section>`
  * `<summary>`
  * `<time>`
  * See more information about the specific tags [here](https://www.w3schools.com/html/html5_semantic_elements.asp)

Example:   

```html
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8">
      <title>Our Zoo</title>
    </head>
    <body>
      <nav>
        <h1>Welcome to Our Zoo</h1>
      </nav>
      <section class="animals">
        <header>
          <p>I would like to tell you about our animals</p>
        </header>
        <article class="otters">
          <h2>Otters</h2>
          <p>Come visit our friendly otters and watch them slip and slide.</p>
        </article>
        <article class="penguins">
          <h2>Cute Penguins</h2>
          <ul>
            <li>Emperor Penguins</li>
            <li>King Penguins</li>
            <li>African Penguins</li>
          </ul>
        </article>
      </section>
      <section class="exhibits">
        <header>
          <p>Check out our exhibits!</p>
        </header>
        <article class="explore-the-shore">
          <a href="https://www.denverzoo.org/explore-shore">Explore the Shore</a>
        </article>
        <article class="lorikeet-adventure">
          <p>Come play with our lorikeets.</p>
        </article>
      </section>
      <footer class="contact-me">
        <p>email me at <a href="mailto:dione@turing.edu"></a></p>
      </footer>
    </body>
  </html>
```
- A lot of the tags we use are already semantic such as form, link, etc.

## Class vs. ID

We can give our HTML elements **attributes**. These attributes appear inside the tag itself (in between the angle brackets `< >`). For example, the following `img` tag:

```html
<img src='https://cutedogs.com/1'>
```

Has an attribute of `src` with a value of `'https://cutedogs.com/1'`.

Two very important attributes we can give our HTML elements are `class` and `id`.

```html
<div class="song" id="song-4">
<div class="song" id="song-3">
<div class="song" id="song-2">
```

* We use the `class` attribute to identify several related elements.
* We use the `id` attribute to identify a single element.
* `id` takes higher priority in CSS (more on this later).
* Only one element should have a certain `id`. If two elements have the same `id`, your page will still display, but it may not work the way you expect.
* We can use erb tags to interpolate an id in our views. The above example HTML could be rendered by the view with the following code:

```html
<% @songs.each do |song| %>
  <div class="song" id="song-<%= song.id %>">
<% end %>
```

# CSS

CSS stands for "Cascading Style Sheets".

When we apply a `class` or an `id` to an HTML element, we can use CSS to **select** it and give it a "rule" of how it should be styled.

When more than one rule applies to an HTML element (it might have an id and a class), CSS "cascades" down from the more general rules to the more specific rules. The most specific rule is chosen. An `id` is the most specific rule.

A common misconception is that "cascading" means that our browser will flow down the CSS file and the last rule will be applied.

There is a way to [calculate CSS Specificity](https://specificity.keegan.st/). Each rule in CSS (i.e a `class` or `id` rule) has a specific value assigned. `id`s have higher  values than `class`es. The highest number wins for most specific and will correspondingly take precedence in application of style. (nice to know, not a need to know)

## How to add CSS to Rails

Normally, you link a CSS stylesheet to an HTML files using a `<link>` inside the `<head>` like so:

```HTML
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="/css/master.css">
  </head>
  <body>

  </body>
</html>
```

Rails gives us those handy `ActionView::Helpers` that we mentioned earlier. Your default `application.html.erb` file should have a link to `application.css`:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>SetList</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all' %>
    <%= javascript_include_tag 'application' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

This means that you can open up `application.css` and add CSS directly to that file, but **don't remove any of the comments in that file**. This will cause issues with the Asset Pipeline.

Alternatively, if you want to create more files to organize your styles, you can create a new file in `app/assets/stylesheets` and give it the extension `.css`. Any css files in this directory will be applied to **all** of your views.

It is also helpful to organize the rules within your stylesheets from least specific to most specific (The element selectors, then class, then id.) This helps with not only visual organization but specificity organization.

Check out the [Intro to the Asset Pipeline](./asset_pipeline) for more detail on how CSS is added to our projects.

## Creating CSS Rules

In order to style elements, you will need to target them with **CSS Selectors**. There are many selectors, but the ones you need to know are:

* The pound `#` symbol targets an element by its `id` attribute
* The dot `.` symbol targets elements by their `class` attribute
* You can target all `<p>` elements with `p`, all `<div>` elements with `div`, etc.
* You can combine selectors, for example the following would target only a `<p>` element with a class of `song` and an `id` of `song-4`: `p.song#song-4`

For a complete reference of CSS Selectors, [see this W3Schools page](https://www.w3schools.com/cssref/css_selectors.asp)

Once you have selected elements, you can specify styles for those elements in curly brackets `{}`. For example, you could place the following css directly into the `application.css` file:

```css
/* element */
p {
  background-color: blue;
  color: #FFFFFF;
}
```

```css
/* class */
.some-class {
  background-color: orange;
}
```

```css
/* id */
#some-id {
  background-color: purple;
}
```

**Note:** It is convention to write classes and ids in `kabob-case`

Capybara "within" statements use this same CSS Selector syntax for selecting elements in feature tests.

## Display Properties: Block vs. Inline
- The default value for all HTML tags is `inline`. Most "User Agent stylesheets" (the default styles the browser applies) reset many elements to `block`
- The display value can be changed with the CSS property `display`.

### Block
- An element with a display of block will take up the entire width of the page, no matter how small the content is within the tag.
- It will always start on a new line.
- `p`, `form`, `h1 - h6`, `ul`, `section` and `div`s are all block elements

### Inline
- `link`, `a`, `span` are all inline by default.
- They will only take up as much space as it needs.
- It will not start on a new line.
- You can set the margin and padding but it will only adjust horizontally. Will ignore any rules for width or height.

### Inline-Block
- Will situate itself inline, but can set a width and height.

## DevTools
Visit any web page, right click on any part of the page. A dropdown box will appear, with `inspect` towards the bottom. Click this will open your `Developer Tools`

![Editing CSS](https://raw.githubusercontent.com/turingschool/front-end-curriculum/gh-pages/assets/images/lessons/debugging-with-devtools/editing-css.png)

On the left you will see what is currently being rendered (original html + anything else impacting the layout such as CSS and JavaScript).

To the right of the HTML pane, there's a small sidebar that gives us styling information for the currently selected element. If you scroll down on the right, you will see a handy graphic of how our element is being rendered.

### Editing CSS

Similar to the HTML pane, we can add or remove styles and adjust CSS property values from this pane. You can click on any style property associated with the selected element and change its value. You can also use the blue checkbox to toggle the style on or off.

## The Box Model

**All the Elements are Boxes**

Each element is a rectangular box. CSS leverages "the box model" to control layout and design. An HTML element is comprised of its content and the margins, borders, padding surrounding it. Boxes are "stacked" in the order they appear in your HTML. You can stack them horizontally, vertically, and in the z-plane.

Open up the DevTools and select any HTML element to see a diagram of its Box Model:

![Box Model](https://raw.githubusercontent.com/turingschool/front-end-curriculum/gh-pages/assets/images/box-model.jpg)

In HTML, you can visualize each element as its own rectangular box. There are a number of CSS properties that can affect the final width and height of each of these boxes. The CSS Box Model describes how the final height and width of an element is determined.

We have a `div` element that we gave a `width` of `400` and a `height` of `200`. However, we've also applied several additional properties that are affecting its size and positioning. The `padding` and `border` properties are both adding `20px` to the element's height and width. Now the actual *visible* dimensions of our element are `480x280`.

# CSS Frameworks

In modern web application development, we tend to rely on frameworks to style pages rather than plain HTML and CSS.

## Bootstrap

Free front-end framework that includes HTML and CSS based design templates that have a mobile first approach. Bootstrap layouts are based on a grid design. It can be quickly and easily added to projects and does use jQuery to function.

To get started using the available templates, you must first include the necessary links and script tags in our html document. Then we simply look through documentation to find what we want to include in our own html add the necessary class or classes to our html elements and bootstrap will handle the rest.

[Bootstrap Docs](https://getbootstrap.com/)

### Flexbox

Flexbox is used to have a more flexible layout that helps to align and distribute space of items in a container. The container is able to alter the width/height of the items within to fill the available space. This allows the content to control the way it is displayed.

Flexbox uses a horizontal axis and vertical axis to align items and create space around those items. It is better to use for small-scale layouts and one dimensional layouts.

[Flexbox Guide](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)

### Grid

Grid is used for a two-dimensional layout where both columns and rows are used. This allows us to break up the container into cells to align objects, but unlike a table, grid allows us to layer items if necessary.

[Grid Guide](https://css-tricks.com/snippets/css/complete-guide-grid/)

## Practice

In SetList:

* Add some HTML to `app/views/layouts/application.html.erb` to create element(s) that will be rendered on every page, for example a search bar, nav bar, an image, etc.
* Style your Song index:
    * Make sure you have a header at the top of the page. Give this header an `id`
    * Wrap each Song in a semantic container element
    * Give each container a class of "song"
    * Give each container an id of `song-<id>` where `<id>` is the id of the song. This id should be dynamically assigned in the view.
    * In your `application.css` file, target all of the classes and ids you made in the song index and add at least one new style for each

**Extension**: Incorporate one of the CSS frameworks into your app

## Checks for Understanding

* What is HTML?
* What is `application.html.erb`?
* What are `ActionView::Helpers`?
* Why would we use semantic vs. non-semantic tags?
* What is the difference between a block and inline element?
* When should we use an `id` over a `class`?
* What is CSS?
* How can you add CSS to a Rails app?
* How do you select elements, classes, and ids in CSS?
