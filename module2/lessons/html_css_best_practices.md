---
layout: page
title: HTML and CSS Best Practices
---

## Key to success: Modularity

HTML and CSS deserve to be as DRY as your Ruby is. This is difficult to achieve in raw HTML and CSS.

### HTML - Templating Libraries

Ideally - especially for large sites - HTML is used with a **templating library** (erb, haml, shandlebars, jade).
This allows you to access to variables, the ability to loop over elements, and eliminate most need for hard-coded/repeated code.

### CSS - Preprocessors / Frameworks

Sass, Less, etc are all at your disposal to up your CSS game. If given the choice between raw CSS and Sass, **never** choose raw CSS.

The implementation of Sass we're most familiar with, thanks to Rails, is SCSS.
SCSS allows us to use raw CSS syntax while also mixing in variables, functions, and modularity where we please. Take advantage of this!

## SCSS Setup in Rails

[`sass-rails`](https://github.com/rails/sass-rails) ships with Rails 5 projects. If you need to add it manually:

```ruby
# Gemfile
gem 'sass-rails'
```

This should provide for you an `application.scss` within `app/assets/stylesheets`

## HTML Organization

### Be [Semantic](https://developer.mozilla.org/en-US/docs/Web/HTML/Element)

HTML offers an absurd amount of element tags available to use. The best best practice in HTML when using these is to **pick a tag whose function is what it's called.**
That is essentially the definition of semantic. If you're building a nav bar, use a `nav` tag. If you're breaking out your body into similarly-formatted sections, wrap each in `section` tags.

These HTML best-practices lead directly to CSS best practices.

### Don't Litter HTML Classes and IDs

Let your HTML elements breath freely. CSS and jQuery selectors offer numerous combinations for selecting specific elements, so that you don't have to throw a class on everything you need to style. Again, this will lead to neater CSS.

However, if you're going to use a class or ID on an element, use a class. IDs are troublesome and don't offer enough benefits to outweigh their hassles. They're frowned upon in the front-end world. Classes can achieve the same goal by only using them once.

I personally try to limit my class usage to container (usually `section`) tags and to global components that will be styled similarly (i.e., all favorite buttons).

Take note of the very intentional repition in the below markup. This type of repition with tag structure is not only okay, it's ideal (non-ideal repition would be pasting the same navbar onto multiple html files).
By remaining intentional and consistent with my tag usage, I'm setting myself up nicely for consistent and non-confusing stylsheets structure with SCSS.

```html
<body>
    <header>
      <h1>Welcome!</h1>
      <a class="contact" href="mailto:example.com">Check Us Out!</a>
    </header>

    <main>
      <section class="about">
        <h2>About Us</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
      </section>

      <section class="history">
        <h2>Our History</h2>
        <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
      </section>

      <section class="services">
        <h2>Our Services</h2>
        <ul>
          <li>Service One</li>
          <li>Service Two</li>
        </ul>
      </section>

      <section class="customers">
        <h2>See Who Loves Our Product</h2>
        <ul>
          <li>Customer One</li>
          <li>Customer Two</li>
        </ul>
      </section>
    </main>

    <footer>
      <a class="contact" href="mailto:example.com">Get in Contact!</a>
    </footer>
</body>
```

## CSS Organization

This takes some time to master, but every effort made towards more modular, organized CSS is an effort worth making.

The following is assuming use of SCSS (SCSS is the CSS syntax of Sass).

### Identifying and Extracting Modularity

#### Step 1: Base Styles

Right off the bat, create a `base.scss` partial that can hold all base styles for your site. If you get more into SCSS functionalities, you can use this partial to store mixins and extensions as well.

I'd highly recommend saving theme colors to variables and importing fonts and saving them to variables within this partial to start.

```scss
/* assets/stylesheets/base.scss */

@import url('https://fonts.googleapis.com/css?family=Lora|Muli');

$font-serif: 'Lora', serif;
$font-sans: 'Muli', sans-serif;

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

Take another look at the HTML markup above. A very simple transalation of that markup into organized SCSS would be to make a separate stylesheet for each section.
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
@import 'sections/history';
@import 'sections/services';
@import 'sections/customers';
@import 'sections/footer';
```

### Other Suggestions

* Create separate stylesheets for **typography** (all things related to fonts on your page), **colors**, etc.
* Save common settings like `border`, `margin`, and `line-height` to variables in base.scss
* Read the [Sass docs](http://sass-lang.com/guide) :D
