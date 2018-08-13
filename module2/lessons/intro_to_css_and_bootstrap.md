---
title: Introduction to CSS & Bootstrap
tags: css, introduction, bootstrap
---

### Learning Goals

* Understand between element, class, and id selectors
* Organize CSS file
* Understand how to import an external CSS file
* Difference between Grid and Flexbox
* Intro to BootStrap

## Warm Up

* What do you know about CSS so far?

## CSS

- Stands for "Cascading Style Sheets".
- When we apply a `class` or an `id` to an HTML element, we are telling it that it has a "rule". We will write our rules for that element in our CSS file.
- Each rule in CSS (i.e a `class` or `id` rule) has a specific value assigned. `id`s have more specific values than `class`es.
- Common misconception that "cascading" means that our browser will flow down the CSS file and the last rule will be applied.
- "Cascading" means that because more than one rule could apply to a particular piece of HTML (it might have an id and a class), there has to be a known way of determining which rule applies to which piece of HTML.
- The rule used is chosen by cascading down from the more general rules to the more specific rule required. The most specific rule is chosen.
- An `id` is the most specific rule
- There is a way to [calculate CSS Specificity](https://specificity.keegan.st/) The highest number wins for most specific and will correspondingly take precedence in application of style. (nice to know, not a need to know)

#### Selectors

  ```css
  /* element */
  p {
    background-color: blue;
    color: #FFFFFF;
  }
  ```

#### Class Selectors

  ```css
  /* class */
  .some-class {
    background-color: orange;
  }
  ```

#### ID Selectors

  ```css
  /* id */
  #some-id {
    background-color: purple;
  }
  ```
 **Note:** Classes and IDs are written in kabob-case.

### Organization of CSS files

  - Group from least specific to most specific.
  - The element selectors, class, then id.
  - This helps with not only visual organization but specificity organization.

### The Box Model
#### All the Elements are Boxes
Each element is a rectangular box. CSS leverages "the box model" to control layout and design. An HTML element is comprised of its content and the margins, borders, padding surrounding it. Boxes are "stacked" in the order they appear in your HTML. You can stack them horizontally, vertically, and in the z-plane.

![Box Model](https://raw.githubusercontent.com/turingschool/front-end-curriculum/gh-pages/assets/images/box-model.jpg)

In HTML, you can visualize each element as its own rectangular box. There are a number of CSS properties that can affect the final width and height of each of these boxes. The CSS Box Model describes how the final height and width of an element is determined.

We have a `div` element that we gave a `width` of `400` and a `height` of `200`. However, we've also applied several additional properties that are affecting its size and positioning. The `padding` and `border` properties are both adding `20px` to the element's height and width. Now the actual *visible* dimensions of our element are `480x280`.


### DevTools
Visit any web page, right click on any part of the page. A dropdown box will appear, with `inspect` towards the bottom. Click this will open your `Developer Tools`

![Editing CSS](https://raw.githubusercontent.com/turingschool/front-end-curriculum/gh-pages/assets/images/lessons/debugging-with-devtools/editing-css.png)

On the left you will see what is currently being rendered (original html + anything else impacting the layout such as CSS and JavaScript).

To the right of the HTML pane, there's a small sidebar that gives us styling information for the currently selected element. If you scroll down on the righ, you will see a handy graphic of how our element is being rendered.

#### Editing CSS
Similar to the HTML pane, we can add or remove styles and adjust CSS property values from this pane. You can click on any style property associated with the selected element and change its value. You can also use the blue checkbox to toggle the style on or off.

### Linking CSS to HTML

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

### Flexbox and Grid
#### Flexbox
Flexbox is used to have a more flexible layout that helps to align and distribute space of items in a container. The container is able to alter the width/height of the items within to fill the available space. This allows the content to control the way it is displayed.

Flexbox uses a horizontal axis and vertical axis to align items and create space around those items. It is better to use for small-scale layouts and one dimensional layouts.

#### Flexbox Resources
[Flexbox Guide](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)

[Flexbox Visualization](https://medium.freecodecamp.org/an-animated-guide-to-flexbox-d280cf6afc35)

[Flexbox Tutorial](https://mastery.games/p/flexbox-zombies)

[Another Flexbox Tutorial](https://flexboxfroggy.com/)

#### Grid
Grid is used for a two-dimensional layout where both columns and rows are used. This allows us to break up the container into cells to align objects, but unlike a table, grid allows us to layer items if necessary.

#### Grid Resources
[Grid Guide](https://css-tricks.com/snippets/css/complete-guide-grid/)

[Grid Tutorial](https://cssgridgarden.com/)

### BootStrap
Free front-end framework that includes HTML and CSS based design templates that have a mobile first approach. Bootstrap layouts are based on a grid design. It can be quickly and easily added to projects and does use jQuery to function.

To get started using the available templates, you must first include the necessary links and script tags in our html document. Then we simply look through documentation to find what we want to include in our own html add the necessary class or classes to our html elements and bootstrap will handle the rest.

#### Bootstrap Resources
[Bootstrap Docs](https://getbootstrap.com/)

[How to Start with Bootstrap](https://www.taniarascia.com/what-is-bootstrap-and-how-do-i-use-it/)

## WrapUp
* What are the differences elements, classes, and ids?
* What all should be considered when organizing a CSS file?
* How do we link a stylesheet to an html document?  
* When do we use Flexbox?
* When do we use Grid?

#### Other Resources
[CSS Basics](https://thecssworkshop.com/css-basics)

[CSS Zen Garden](http://www.csszengarden.com/)

[CSS Psuedo-Classes & Psuedo-Elements](http://www.growingwiththeweb.com/2012/08/pseudo-classes-vs-pseudo-elements.html)

[Sass](https://sass-lang.com/guide)
