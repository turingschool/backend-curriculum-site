---
layout: page
title: Introduction to HTML
---

## Learning Goals

  - Understand structure of an HTML page
  - Understand difference between semantic/non-semantic tags
  - Understand difference between block and inline elements
  - Identify different parts of an HTML tag

### Review from Task Manager

  - What file extension did we use for HTML files?
  - What does that file extension stand for?
  - How did we create structure in our HTML?

### Structure of an HTML Document

  - General Structure:

  ```html
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>

  </body>
  </html>
  ```
  - Let's talk about the specific parts:

#### Type Declaration

  - `<!DOCTYPE html>` tells our browsers that our application is using HTML5. `html` signals the beginning of our HTML.

  ```html
  <!DOCTYPE html>
  <html>
  </html>
  ```

#### Head

  - Contains all the meta data about the document.
  - The ones we care about right now are:
    - `<title>` - The title that will show in the tab of your browser.
    - `<link>` - How we link to external stylesheets, i.e. our CSS. We want this in the head so it loads first.
    - `<script>` - How we link to our client-side statements (JavaScript).

#### Body

  - Contains ALL the elements of the HTML document that we would like to display.

### Semantic vs Non-Semantic Tags

  - How did you create HTML structure in your Task Manager app?

#### Non-Semantic

  - `div`s - incredibly common but with the introduction of HTML5, there was a move towards semantic tags.
  - `div`s tell us NOTHING about the content of the element.  

  ```html
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8">
      <title>Personal Site</title>
    </head>
    <body>
      <div class="nav">
        <h1>Welcome to Ilana's Site</h1>
      </div>
      <div class="about-me">
        <div class="bio">
          <h2>Denver</h2>
          <p>Denver is where I live.</p>
        </div>
        <div class="education">
          <h2>Schooling</h2>
          <ul>
            <li>University of Colorado</li>
            <li>Turing School of Software and Design</li>
          </ul>
        </div>
      </div>
      <div class="portfolio">
        <div class="apps">
          <a href="http://arcade.turing.io">Turing Arcade</a>
        </div>
        <div class="lesson-plans">
          <p>ALL OF THEM</p>
        </div>
      </div>
      <div class="contact-me">
        <p>email me at <a href="mailto:ilana@turing.io"></a></p>
      </div>
    </body>
  </html>
  ```

#### Semantic Tags

  - Can act the same as a `div` but have implied meaning.

  ```html
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8">
      <title>Personal Site</title>
    </head>
    <body>
      <nav>
        <h1>Welcome to Ilana's Site</h1>
      </nav>
      <section class="about-me">
        <header>
          <p>I would like to tell you about myself</p>
        </header>
        <article class="bio">
          <h2>Denver</h2>
          <p>Denver is where I live.</p>
        </article>
        <article class="education">
          <h2>Schooling</h2>
          <ul>
            <li>University of Colorado</li>
            <li>Turing School of Software and Design</li>
          </ul>
        </article>
      </section>
      <section class="portfolio">
        <header>
          <p>Here is my work:</p>
        </header>
        <article class="apps">
          <a href="http://arcade.turing.io">Turing Arcade</a>
        </article>
        <article class="lesson-plans">
          <p>ALL OF THEM</p>
        </article>
      </section>
      <footer class="contact-me">
        <p>email me at <a href="mailto:ilana@turing.io"></a></p>
      </footer>
    </body>
  </html>
  ```
  - A lot of the tags we use are already semantic such as form, link, etc.

### Block vs. Inline

  - All HTML tags have a default display value. Either block or inline.
  - The display value can be changed with CSS.

#### Block-level Elements

  - A block-level element will take up the entire width of the page, no matter how small the content is within the tag.
  - It will always start on a new line.
  - `p`, `form`, `h1 - h6`, and `div`s are all block level elements

#### Inline-level Elements

  - `link`, `a`, `span` are all inline by default.
  - They will only take up as much space as it needs.
  - It will not start on a new line.

### HTML Tag Attributes - The Break Down

#### Example 1

  - `<section class="tasks" id="all-tasks">`
    - `class` - used for several elements.
    - `id` - used for one element. Takes higher priority in CSS (more on this later).

#### Example 2

  - `<input name="task[title]" value="Enter Task Here">`
    - Seen in our forms.
    - Seen mostly in `input` or `button`.
    - `name` - the key the data submitted will have.
    - `task[title]` - will be the parameter value that maps to the key `name`
    - `value` - the value we want the `input` or `button` to have originally.

### Recap

  - What type of information belongs in the head of an HTML document?
  - Why would we use semantic vs. non-semantic tags?
  - What is the difference between a block and inline element?
  - When should we use an id over a class?
