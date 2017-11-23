---
layout: page
title: Introduction to CSS
---

## Learning Goals

  - Understand difference between element, class, and id selectors
  - Organize a CSS file for ease of use
  - Understand how to import an external CSS file into HTML

## Vocabulary 
* Cascading Style Sheets (CSS) 
* Elements
* Selectors
  * Type Selectors 
  * Class Selectors
  * ID Selectors 

## Warm Up 
* What do you know about CSS so far? Try to organize this information in a chart of some kind. 

### Refresher - What is CSS?

  - Stands for "Cascading Style Sheets".
  - When we apply a `class` or an `id` to an HTML element, we are telling it that it has a "rule". We will write our rules for that element in our CSS file.
  - Each rule in CSS (i.e a `class` or `id` rule) has a specific value assigned. `id`s have more specific values than `class`es.
  - Common misconception that "cascading" means that our browser will flow down the CSS file and the last rule will be applied.
  - "Cascading" means that because more than one rule could apply to a particular piece of HTML (it might have an id and a class), there has to be a known way of determining which rule applies to which piece of HTML.
  - The rule used is chosen by cascading down from the more general rules to the more specific rule required. The most specific rule is chosen.
  - An `id` is the most specific rule
  - There is a way to [calculate CSS Specificity](https://specificity.keegan.st/) (nice to know, not a need to know)

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
 **Note:** Classes and IDs are written in kabob-case

### Organization of CSS files

  - Group from least specific to most specific.
  - The element selectors, class, then id.
  - This helps with not only visual organization but specificity organization.


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
    1. Check out a branch `your_name_css_playground`
    2. To open the static html file from your command line `open example.html`.
    3. Link the stylesheet to the HTML page.
    4. Change/Add information in the HTML file to be your own information.
    5. Create a visually appealing navigation bar with links to the sections (`about-me`, `school`, `work`, you can also make your own)
    6. Create a footer that stays at the bottom of the page with your email address.
    7. HAVE FUN!

## WrapUp 
 * What are the differences between tags, elements, classes, and ids?
 * What all should be considered when organizing a CSS file? 
 * How do we link a stylesheet to an html document?  
