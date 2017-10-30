---
title: Introduction to the Asset Pipeline
length: 120
---

## Research

1. Where do assets live in a rails project?
2. What is precompiling mean?
3. What is the purpose of the public folder in rails?

### Asset Pipeline in Rails

- Prepares JS, CSS and images for the browser to read.

#### Where Do Assets Live?

* `app/assets`: assets owned by the application; includes custom CSS, JS files, and images
* `lib/assets`: assets you created, but aren't necessarily specific to your application
* `vendor/assets`: assets created by third-parties.

note: the files in app/assets are never served directly in production.
note: assets in lib/assets and vendor/assets will not automatically be included in the precompile process

#### Concatenate Assets

- Reduces the number of requests (time) it takes to render the page.
- Rails inserts a SHA256 fingerprint for caching in production. Changing the file, will automatically change the SHA

#### Minification and Compression

- Removes whitespace and comments and creates a file with less lines of code.

#### Pre-processing

- Pre-processes other languages such as SASS, CoffeeScript, etc. into JS or CSS.

### How to Use the Asset Pipeline

- In development, rails automatically prepares and pre-processes our assets but in production, we may need to manually do this: `ENV=production rake assets:precompile`
- This creates an `assets` directory in the public folder with the files compressed and compiled.
- Our browser will automatically serve assets from the public folder but if files are put directly in that folder, they will bypass the asset pipeline.

#### Manifest Files

  * `app/assets/javascripts/application.js`
  * `app/assets/stylesheets/application.css`

#### Directives in Manifest Files

  * Processed top-to-bottom
  * `require_tree .` recursively requires all files within app/assets
  * Files required in the manifest can live in app/assets, lib/assets, or vendor/assets

#### Directives in Manifest Files

![inline](manifest.png)

#### How Does Your App Know About the Master JS and CSS File?

In app/views/layouts/application.html.erb:

```erb
<%= stylesheet_link_tag "application", media: "all" %>
<%= javascript_include_tag "application" %>
```

As the file SHA changes in production, Rails has created this one file `application.js` and `application.css` to which we reference.
