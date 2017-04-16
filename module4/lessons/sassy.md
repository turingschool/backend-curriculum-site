---
layout: page
title: Let's get SASSy
length: 90
tags: html, css, sass
---

Let's Get SASSy
=================

What is SASS?
----------

SASS stands for "Syntactically Awesome StyleSheets". It is an effective way to manage a stylesheet and is perfect for css that is repetitive. Today, we will go through a simple html example of compiling SASS (also referred to as scss) into css.

### Goals of This Lesson:

1.  Understand what SASS is.
2.  Be able to setup the SASS gem and compile scss to css.
3.  Use variables in scss files.
4.  Understand and use nesting in SASS.

### Setup

Clone down the `sass_playground` repo [here](https://github.com/turingschool-examples/sass_playground).

First things first, let's get SASS setup for use with our command line.

1.  `gem install sass`
2.  Verify that sass is setup by checking the version (`sass -v`).

Check out the repo:

What is different between the `stylesheet` folder in this folder and a typical `stylesheet` folder?

Take a look at the `index.html` file. Is there anything different in that file?

Common Theme: Nesting

-   Nested within the `stylesheet/css` folder, there is a `scss` folder. This is where our SASS file lives and it is designated by `.scss`.


Let's jump in:

### Compiling


This is how our `index.html` file looks:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>SASS Playground</title>
    <link rel="stylesheet" href="stylesheet/css/custom.css">
  </head>
  <body>
    <div class="square">
      <div class="blob_1">
        Blob 1
      </div>
      <div class="blob_2">
        Blob 2
      </div>
    </div>
  </body>
</html>
```

If we open the file in our browser (`open index.html` from terminal). What do we see?

The code inside our `custom.scss` has the indication that our square should be 500 x 500 pixels and have a background color of purple. What's happening?

We have not yet compiled our scss to css. And since we installed the gem, this should be easy!

In our terminal, we do the following:

```shell
sass stylesheet/css/scss/custom.scss stylesheet/css/custom.css
```

Let's do the above command now and refresh `index.html` and we should now see a purple square.

#### Why?

-   Our system does not know how to interpret scss like it knows to do with css so by installing the gem, we have created a way to command our computer to compile the scss into plain css.
    1.  `sass` invokes the gem.
    2.  `stylesheet/css/scss/custom.scss` chooses the scss or sass file to compile.
    3.   `stylesheet/css/custom.scss` chooses where to put the compiled css file.

### Variables

SASS allows for the use of variables, just like other languages we are used to, which can be very helpful. A  value can now be changed in one place.

A variable is declared with the `$` sign.

For example:

```css
/**/declaring variable
$standard-margin: 40px;

/**/using variable
.parent {
  margin: $standard-margin;
}
```

The color of purple that I chose is unique so on your own, go ahead and declare a variable with the value of the unique color of purple and assign it to the background color of the square.

### Nesting

In SASS, selectors are nested in other selectors. This allows us to maintain a parent while easily modifying the children.

Consider the following piece of html and css:

```html
<div class="parent">
  <div class="child-1">
    I am the 1st child.
  </div>
  <div class="child-2">
    I am the 2nd child.
  </div>
</div>
```

```css
.parent {
  color: blue;
}

.parent .child-1 {
  font-size: 20px;
}
```

```css
.parent {
  color: blue;
  .child-1 {
    font-size: 20px;
  }
}
```

In the `sass_playground`, set the `font-size` of `blob_1` to `40px` and `blob_2` to `90px`


Another type of nesting that SASS allows for is the nesting of CSS properties

```css
.parent {
  font : {
    size: 80px;
    family: Arial;
  }
}
```

The above will compile css as follows:

```css
.parent {
  font-size: 80px;
  font-family: Arial;
}
```

Lets's add a `font-family` of cursive and a `text-decoration` of underline to `Blob 1`

Let's add a `text-decoration` of underline with `text-align` center for `Blob 2`.


Any refactoring that can happen?

A variable can be created for the `text-decoration`.

What about multiple arguments for something like a border? Take 5 minutes to do some self discovery and see if you can put a solid brown 3px border around each blob.

### Recap:

-   Compiling
-   Variables
-   Nesting
-   [SASS Resource](http://sass-lang.com/)
