# HTML & CSS Basics

---

## Warmup

* What is the purpose of HTML?
* What is the purpose of CSS?
* What are some HTML tags you learned over break? Anything interesting?
* What is the purpose of a `class` in HTML/CSS? an `id`?
* Any other interesting ways to select things using CSS?

---

## Learning Goals

* Understand the standard structure of an HTML page.
* Understand the information that belongs in each part of the HTML page.
* Define a semantic tag.
* Select HTML by a specific tag, class or id and apply CSS to those elements.
* Describe the difference between a block and inline tag.
* Understand how to chain HTML selectors in HTML and CSS code.

# HTML

---

## HTML Skeleton

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

## <head></head>

```html
<head>
  <title>Some Title</title>
  <link rel="stylesheet" type="text/css" href="css/main.css">
</head>
```

---

## <body></body>

```html
<body>
  <h1></h1>
  <p></p>
  <img src="img/image1.png">
  <a href="http://www.google.com">Google</a>
  <ul>
    <li>Item 1</li>
    <li>Item 2</li>
  </ul>
</body>
```

---

## Semantic Tags



```html
<header>
<nav>
<main>
<footer>
<article>
<aside>
<section>
```
---

## [Less]-Semantic Tags

```html
<div>
<span>
```
---

# CSS

---

## Selectors

```css
p {
  background-color: blue;
  color: #FFFFFF;
}
```

---

## Class Selectors

```css
.some-class {
  background-color: orange;
}
```

---

## ID Selectors

```css
#some-id {
  background-color: purple;
}
```

---

## Box Model

![inline](box-model.png)

---

## Display Property

* *Block* will take up as much horizontal space as possible.
* *Inline* will allow text to wrap around an element.
    * Accepts margin and padding.
    * Will ignore width and height.
* *Inline-Block* like _inline_, but will respect width and height.
* *None* will remove an element from the DOM (Document Object Model).

---

## Floats

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

## Wireframing

Wireframes, from a developer's vantage point, should be minimal. Looking at a wireframe, one should be able to gather the basic structure of the site. Specific fonts, images, or copy (text), shouldn't be a concern.

## Exercise: Wireframe: With a Partner

### Part 1:

* Think of a type of site (store, personal, news, review, blog).
* Brainstorm content that would be displayed on the front page.
* Create a wireframe for that site.

### Part 2:

* See if you can create the basic layout for the site you wireframed with HTML/CSS

## Other CSS Wizardry

---

## Pseudo-Classes

* `:hover`
* `:nth-child(2)`

```css
h1:hover {
  opacity: .5;
}
```

---

## Advanced CSS Selectors

```html
<body>
  <p class="red dog"></p>
  <p class="red cat"></p>
  <div class="red">
    <p class="inner">
      <a href="#" class="more inner"></a>
    </p>
  </div>
</body>
```

* *Chained classes*: Apply to elements that have all classes.

```css
.red.dog {
  /*would only apply to <p> with both red and dog classes*/
}
```

* *Comma*: Apply to elements that have either selector.

```css
.cat, .dog {
  /* would apply to anything with class of cat or dog */
}
```

* *Space*: Child elements (direct or indirect).

```css
.red .inner {
  /* would apply to <p>, <a> children of <div class="red"> */
}
```

* *>*: Direct children.

```css
.red > .inner {
  /* would only apply to <p class="inner"> child of <div> */
}
```

---

## Additional Wireframes

With the time remaining:

* See if you can implement two more high level wireframes.
* If you have time remaining, play with pseudo-classes and relative selectors.
