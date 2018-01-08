---
layout: page
title: HTML and CSS Best Practices
---

## SASS Selector Refresh

  1. What are three advantages of SASS?
  2. How is a variable declared in SASS?
  3. How can we nest css properties in SASS?
  4. What does SASS stand for?

## More SASS

### Key to success: Modularity

HTML and CSS deserve to be as DRY as your Ruby is. This is difficult to achieve in raw HTML and CSS.

### SCSS Setup in Rails - Manual

[`sass-rails`](https://github.com/rails/sass-rails) ships with Rails 5 and > projects. If you need to add it manually:

```ruby
# Gemfile
gem 'sass-rails'
```
This should provide for you an `application.scss` within `app/assets/stylesheets`

### Including Partials in your SCSS Manifesto

We are going to extract some scss from our `custom.scss` file so we need to load them into our SCSS manifesto properly (`application.scss`).

A general rule of thumb is **import in order of least specific to most specific**. This way, if base styles need to be overridden, they can be within their individual section.

With our above examples, our `application.scss` would look something like:

```scss
/* assets/stylesheets/application.scss */

@import 'base';
@import 'skeleton';

@import 'components/buttons';

@import 'sections/header';
@import 'sections/movies-index';
```

### Identifying and Extracting Modularity

#### Step 1: Base Styles

Right off the bat, create a `base.scss` partial that can hold all base styles for your site. If you get more into SCSS functionalities, you can use this partial to store mixins and extensions as well.

I'd highly recommend saving theme colors to variables and importing fonts and saving them to variables within this partial to start.

Let's put our font colors and type there. We want to use a new "fun" font!

```css
/* assets/stylesheets/base.scss */

@import url('https://fonts.googleapis.com/css?family=Joti+One');

$font-default: 'Joti One', cursive;

$light-purple: #E8E1EF;
$ice-blue: #D9FFF8;
$wow-green: #C7FFDA;
$mellow-green: #C4F4C7;
$forest-green: #9BB291;
```

#### Step 2: Skeletal styles

If all of our sections of the site we're building are sharing consistency among element names, consistency is assumed among styling for these elements.

We can gather all of this into an SCSS partial.

```css
/* assets/stylesheets/skeleton.scss */
h1 {
  font: {
    family: $font-default;
    size: 50px;
  }
  color: $ice-blue;
}

h2 {
  text: {
    align: center;
    decoration: underline;
  }
}


p {
  font: {
    family: papyrus;
    size: 15px;
  }
}

```

#### Step 3: Sections

This would allow me to, at any moment, easily find and update the styles associated with a specific section.

```css
/* assets/stylesheets/sections/_header.scss */

header {
  h1 {
  }
}
```

```css
/* assets/stylesheets/sections/_movie-index.scss */

.movie-index {
  h1 {
    color: $mellow-green;
  }

  h2 {
    color: $forest-green;
    border: $wow-border;
  }
  p {
    border: $wow-border;
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

```HTML
<div class="movie-index">
  <h1>All Movies</h1>

  <% @movies.each do |movie| %>
    <h2><%= movie.title %></h2>
    <p><%= movie.description %></p>
    <%= button_to "Add Movie", carts_path(movie_id: movie.id), class: 'button.cart' %>
  <% end %>
</div>
```

```css
/* assets/stylesheets/components/_buttons.scss */

.button {
  &.cart {
    background-color: $mellow-green;
  }
}
```

#### See What Feels Right for Your Site

This cascade of partials may not be immediately implementable for your site. You may even think of another way of organizing your styles. However, with the above, you'll have:

- Skeletal styles extracted into one place
- Section partials with styles specific to that section
- Global components defined in one place

### More SASS syntax

#### Using `@extend`

- Let's say, in `movie_mania`, we want to style our `movies#new` css file. It seems like our title and description share the same color but the title is bold. What if we want both to be bold and purple? We can extend the style of one class to the other to cut down on duplication.

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

- Mixins allow you to define styles that can be re-used throughout the stylesheet.

### Other Suggestions

* Create separate stylesheets for **typography** (all things related to fonts on your page), **colors**, etc.
* Save common settings like `border`, `margin`, and `line-height` to variables in base.scss
* Read the [Sass docs](http://sass-lang.com/guide) :D
