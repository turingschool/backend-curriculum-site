---
layout: page
title: HTML and CSS Best Practices
---

## SASS Selector Refresh

  1. What are three advantages of SASS?
  2. How is a variable declared in SASS?
  3. How can we nest css properties in SASS?
  4. What does SASS stand for?

### More SASS

#### Using `@extend`

- Let's say, in `movie_mania`, we want to update our `movies#index` css file. It seems like our title and description share the same color but the title is bold. What if we want both to be bold and purple? We can extend the style of one class to the other to cut down on duplication.

```css
ul {
  border: $custom-border;
  .title {
    color: $custom-color;
    font-weight: bold;
  }

  .description {
    @extend .title;
  }
}
```

- A selector can use more than one extend!

#### Mixins  

- Mixins allow you to define styles that can be re-used throughout the stylesheet. A good place to include these might be the `base.scss` file (see below)

```css
@mixin header-styles {
  color: $custom-color;
  font-weight: bold;
}

.description {
  @include header-styles;
}

.title {
  @include header-styles;
}
```

- Mixins can also take arguments! 

```css
@mixin header-styles($color, $weight) {
  color: $color;
  font-weight: $weight;
}

.description {
  @include header-styles(red, bold);
}

.title {
  @include header-styles($custom-color, italic);
}
```

### Key to success: Modularity

HTML and CSS deserve to be as DRY as your Ruby is. This is difficult to achieve in raw HTML and CSS.

### SCSS Setup in Rails

[`sass-rails`](https://github.com/rails/sass-rails) ships with Rails 5 projects. If you need to add it manually:

```ruby
# Gemfile
gem 'sass-rails'
```
This should provide for you an `application.scss` within `app/assets/stylesheets`

### Identifying and Extracting Modularity

#### Step 1: Base Styles

Right off the bat, create a `base.scss` partial that can hold all base styles for your site. If you get more into SCSS functionalities, you can use this partial to store mixins and extensions as well.

I'd highly recommend saving theme colors to variables and importing fonts and saving them to variables within this partial to start.

```scss
/* assets/stylesheets/base.scss */

@import url('https://fonts.googleapis.com/css?family=Open+Sans');

$font-sans-serif: 'Open Sans', sans-serif;

$light: #fff;
$dark: #000;
$accent: #64609a;
```

#### Step 2: Skeletal styles

If all of our sections of the site we're building are sharing consistency among element names, consistency is assumed among styling for these elements.

Perhaps each `h2` have the same `font-family`, `font-size`, and `color`.

Perhaps each `section` has 30px of top and bottom `padding`.

Perhaps every-other `section` has an accent `background-color`.

We can gather all of this into an SCSS partial.

```css
/* assets/stylesheets/skeleton.scss */

h1, h2, h3, h4, h5, h6 {
  font-family: Helvetica;
}
p {
  font-family: Arial;
  font-size: 14px;
}
section {
  padding: 30px auto;
}
```

#### Step 3: Sections

This would allow me to, at any moment, easily find and update the styles associated with a specific section.

```scss
/* assets/stylesheets/sections/_header.scss */

header {
  h1 {
  }
}
```

```scss
/* assets/stylesheets/sections/_about.scss */

.about {
  h2 {
  }
  p {
  }
}
```

```scss
/* assets/stylesheets/sections/_customers.scss */

.customers {
  h2 {
  }
  ul {
    li {
    }
  }
}
```

#### Step 4: Global Components

We've got our base skeleton's styles extracted. We've got an organized space for each section of our site's extracted styles. What about the styles that are still being shared among our site?

Remember, we want our SCSS to be as DRY as possible.

Consider the following possibly global components you'd have sprinkled across your site:

- Contact buttons
- Favorite buttons
- Open/close buttons
- Buttons in general
- Navbars
- Hamburger menus
- Video player
- User handles

Creating a separate SCSS partial for each of these makes our code immensely more modular. So modular, in fact, that you could reuse these partials among other sites you build with a simple drag/drop and aligning of element/class names.

```scss
/* assets/stylesheets/components/_buttons.scss */

.button {
  &.link-to {
  }
  &.favorite {
  }
  &.contact {
  }
}
```

#### See What Feels Right for Your Site

This cascade of partials may not be immediately implementable for your site. You may even think of another way of organizing your styles. However, with the above, you'll have:

- Skeletal styles extracted into one place
- Section partials with styles specific to that section
- Global components defined in one place

### Including Partials in your SCSS Manifesto

All of the above is good and great, so long as you've got them loaded into your SCSS manifesto properly (`application.scss`).

A general rule of thumb is **import in order of least specific to most specific**. This way, if base styles need to be overridden, they can be within their individual section.

With our above examples, our `application.scss` would look something like:

```scss
/* assets/stylesheets/application.scss */

@import 'base';
@import 'skeleton';
@import 'colors';
@import 'typography';

@import 'components/buttons';

@import 'sections/header';
@import 'sections/about';
@import 'sections/movies';
@import 'sections/directors';
@import 'sections/users';
@import 'sections/footer';
```

### Other Suggestions

* Create separate stylesheets for **typography** (all things related to fonts on your page), **colors**, etc.
* Save common settings like `border`, `margin`, and `line-height` to variables in base.scss
* Read the [Sass docs](http://sass-lang.com/guide) :D
