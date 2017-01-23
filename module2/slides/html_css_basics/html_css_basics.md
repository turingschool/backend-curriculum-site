# HTML & CSS Basics

---

# Warmup

* What is the purpose of HTML?
* What is the purpose of CSS?
* What are some HTML tags you learned over break? Anything interesting?
* What is the purpose of a `class` in CSS? an `id`?
* Any other interesting ways to select things using CSS?

---

# HTML

---

# HTML Skeleton

```html
<!DOCTYPE html>
<html>
  <head>
  </head>

  <body>
  </body>
</html>
```

---

# <head></head>

```html
<title>Some Title</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
```

---

# <body></body>

```html
<h1></h1>
<p></p>
<img src="img/image1.png">
<a href="http://www.google.com">Google</a>
<ul>
  <li>Item 1</li>
  <li>Item 2</li>
</ul>
```

---

# Semantic Tags

```html
<header>
<nav>
<main>
<footer>
<article>
<aside>
<section>
```
Plus some others...

---

# Non-Semantic Tags

```html
<div>
<span>
```

---

# CSS

---

# Selectors

```css
p {
  background-color: #00F;
  color: #FFF;
}
```

---

# Class Selectors

```css
.some-class {
  background-color: orange;
}
```

---

# ID Selectors

```css
#some-id {
  background-color: purple;
}
```

---

# Box Model

![inline](box-model.png)

---

# Display Property

* *Block* will take up as much horizontal space as possible.
* *Inline* will allow text to wrap around an element.
    * Accepts margin and padding.
    * Will ignore width and height.
* *Inline-Block* like _inline_, but will respect width and height.
* *None* will hide an element.

---

# Floats

```css
h1 {
  display: inline-block;
  padding: 20px;
  float: left;
}

.buttons {
  float: right;
}
```

---

# Clearfix

```css
.clearfix:after {
  content: ' ';
  display: table;
  clear: both;
}
```

---

# Detour: Lorem Ipsum

* Hipster
* Bacon
* Beer
* Seinfeld
* Ulysses

---

# Wireframing

With a partner

* Think of a type of site (store, personal, news, review, blog).
* Brainstorm content that would be displayed on the front page.
* Create a wireframe for that site.

---

# Code Along

Implement a simple wireframe.

---

# Implement Your Wireframe

With a partner

* See if you can create the basic layout for the site you wireframed.

---

# Other CSS Wizardry

---

# Pseudo-Classes

* `:hover`
* `:nth-child(2)`
* `:nth-of-type(2)`

---

# Spaces, Commas, and Dots

* *Period With No Space*: Apply to elements that have both selectors.
* *Comma*: Apply elements that have either selector.
* *Space*: Child elements.
* *>*: Direct children.

---

# Additional Wireframes

With the time remaining:

* See if you can implement two more high level wireframes.
* If you have time remaining, play with pseudo-classes and relative selectors.
