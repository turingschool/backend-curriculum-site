---
layout: page
title: Introduction to SASS
---

## CSS Selector Refresh

```css
#id-name {
  /*targets elements with id="id-name"*/
}

.class-name {
  /*targets elements with class="class-name"*/
}

.class-name.second-class {
  /*targets elements with class="class-name second-class"*/
}

.class-name p {
  /*targets all paragraph child elements of class="class-name"*/
}

.class-name > p {
  /*targets only paragraph elements that are direct children of class="class-name"*/
}
```

## What is SASS?

Syntactically Awesome StyleSheets! An extension of CSS that allows us to use raw CSS syntax while also mixing in variables, functions, and modularity where we please.

## SCSS Setup in Rails

[`sass-rails`](https://github.com/rails/sass-rails) ships with Rails 5 projects. If you need to add it manually:

```ruby
# Gemfile
gem 'sass-rails'
```

This should provide for you an `application.scss` within `app/assets/stylesheets` or you will want to change the name of the `application.css` file to `application.scss`

### Resources

* Read the [Sass docs](http://sass-lang.com/guide) :D
