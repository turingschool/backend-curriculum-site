---
layout: page
title: Introduction to CSS
---

## Learning Goals

  - Understand difference between element, class, and id selectors
  - Organize a CSS file for ease of use
  - Understand how to import external CSS file into HTML

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

### Organization of CSS files

  - Group from least specific to most specific.
  - The element selectors, class, then id.
  - Because styles CASCADE down, we want the styles that are most important to us to be at towards the bottom so nothing overrides them.

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

### Let's Play!

  - Clone down [this](https://github.com/turingschool-examples/html_css_playground) repo and:
    1. Link the stylesheet to the HTML page.
    2. Make a GARBAGE UNICORN.
