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

### Mixins

There is advanced capabilities but we are going to talk about a simple way to create what I would call, a function or method in SASS. It can encompass multiple attributes that might be common together.

Do some research on mixins for 5 minutes and see if there is some refactoring that we can do in the `scss` file.

```css
$underlined: underline;
$brown-border: 3px solid brown;

@mixin text_components {
  text : {
    align: center;
    decoration: $underlined;
  }
  border: $brown-border;
}

.square {
  height: 500px;
  width: 500px;
  background-color: #672e6d;
  .blob_1 {
    font : {
      size: 40px;
      family: cursive;
    }
    @include text_components;
  }
  .blob_2 {
    font-size: 90px;
    @include text_components;
  }
}
```

A mixin can also take an argument:

```css
$underlined: underline;
$brown-border: 3px solid brown;

@mixin text_components($underlined) {
  text : {
    align: center;
    decoration: $underlined;
  }
  border: $brown-border;
}

.square {
  height: 500px;
  width: 500px;
  background-color: #672e6d;
  .blob_1 {
    font : {
      size: 40px;
      family: cursive;
    }
    @include text_components($underlined);
  }
  .blob_2 {
    font-size: 90px;
    @include text_components($underlined: line-through);
  }
}
```

What happens when we compile and open `index.html`? Why?

In the example above, `Blob 2`, `$underlined` is set to `line-through`. We can pass in default arguments to our mixins and change those values!

Multiple arguments can be passed into a mixin.

What will the following code compile to do in Blob 2?

```css
@include text_components($underlined, $brown-border: 5px dashed green);
```

What problems did you run into?

Define a new mixin of your choice to implement.  

### Mixins with Dynamic Values

Another way that we could use a mixin is in a more dynamic way. In the above example, we used variables that we had already had created. How do we create a more dynamic mixin?

Take 3 minutes to see if you can build a dynamic `border-styling` mixin that will take 3 arguments: radius, style and color. Give Blob 1 a border radius of 9px, style of dotted and a color of blue. Try this without changing the `text-components` mixin and then after that, try with changing it.

Run into any problems?

```css
@mixin border-styling($radius, $style, $color) {
  border: $radius $style $color
}
```

If we want to use that within the `text-components` mixin, it would look something like this:

```css
@mixin text_components($underlined) {
  text : {
    align: center;
    decoration: $underlined;
  }
  @include border-styling($radius: 3px, $style: solid, $color: brown);
}
```

Notice that we removed `$brown-border` from the mixin and instead defined defaults for my `text_components` mixin border.

We have also adjusted the following information to capture the custom borders of both blobs:

```css
.square {
  height: 500px;
  width: 500px;
  background-color: #672e6d;
  .blob_1 {
    font : {
      size: 40px;
      family: cursive;
    }
    @include text_components($underlined);
    @include border-styling($radius: 9px, $style: dotted, $color: blue);
  }
  .blob_2 {
    font-size: 90px;
    @include text_components($underlined: line-through);
    @include border-styling($radius: 5px, $style: dashed, $color: green);

  }
}
```

### Recap:

Couldn't get it to work? See the solutions branch [here](https://github.com/turingschool-examples/sass_playground/tree/solutions-check-point-1).

When could this have been useful in the past?

-   Compiling
-   Variables
-   Nesting
-   Mixins
-   [SASS Resource](http://sass-lang.com/)
