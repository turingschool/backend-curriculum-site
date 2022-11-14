---
title: Intro to the Asset Pipeline
---

## Learning Goals

* Give examples of `assets` in the context of a Rails application
* Describe the reason we minify/concatenate assets
* Explain how caching helps web pages load faster
* Explain how Rails uses fingerprinting to expire cached assets
* Use Rails' view helpers to link to assets in production

## Slides

Available [here](../slides/asset_pipeline/asset_pipeline)

## Warmup

* What do you already know about the asset pipeline?
* What have you heard?
* What computer languages does your browser understand?

## Overview

* *Asset Exploration:* Explore how assets are loaded in the browser.
* *Enter the Asset Pipeline:* Provide a high level descripition of the responsibilities of the asset pipeline.
* *Putting it Together:* Descrbie how assets are stored/accessed in a Rails application.

## Background

At a high level, the [Rails Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html) is an attempt by Rails developers to decrease the time it takes for our pages to load. Specifically, the Asset Pipeline aims to speed up the process of serving our static assets. But what are assets?

* JavaScript Files
* CSS Files
* Images

## Asset Exploration

* Visit Turing's [Back-End Curriculum](http://backend.turing.edu/) site.
* With a neighbor, estimate how many requests were made to load that site.
* In Chrome, open the developer tools (cmd-opt-i).
* Click on the Network tab, and hit reload.
* Count the number of assets loaded.

Answer the questions below:

* Were there more or fewer assets loaded than you expected?
* Look at the Size column in the table that displays on the Network tab. How many of the assets that loaded were cached?
* What does it mean that they were cached? Is this a good thing or a bad thing?
* Can you think of any issues that caching might create?
* Hover over some of the bars under the Waterfall section of the table. How does Chrome break out the time spent to load an asset?
* Which asset took the most time to load? Which took the least? Why do you think that might be?

Share out.

## Enter the Asset Pipeline

According to the Rails documentation, the Asset Pipeline is "a framework to concatenate and minify or compress JavaScript and CSS assets." What does that mean? At a high level, the Asset Pipeline:

* *Concatenating/Minifying:* Makes the assets we serve more compact.
* *Precompiling:* Allows us to write in languages related to CSS/JavaScript.
* *Fingerprinting:* Provides a means to invalidate cached assets.

More on each of those in a moment.

### Concatenating/Minifying

The asset pipeline makes our assets smaller through minification and concatenation. What does that look like in practice?

#### Exploration

See if you can find answers to the following questions on the internet:

* What does minified CSS look like?
* What does minified JavaScript look like?
* What does it mean that the asset pipeline concatenates our assets?

#### Concatenation and Our Manifests

* Concatenating assets - one master .js file and one master .css file which reduces the number of requests a browser makes in order to render our web page

### Precompiling

Our browser understands three languages:

* HTML
* CSS
* JavaScript

However, some people don't like writing plain old CSS or JavaScript. They create tools that will allow them to use things like variables in CSS (Sass/Less), or simplified JavaScript (CoffeeScript).

Outside the context of a larger framework, you will neeed to use those same tools (e.g. Sass) to translate the code that you wrote into the vanilla CSS/JavaScript that our browsers understand.

The Asset Pipeline handles that process for us, making it just a little bit easier for us to prepare our applications for production.

### Fingerprinting

We've seen the advantages of caching our assets, but what happens when we make a change to our JS/CSS? We need to have a way to tell our browser that the version they have cached is out of date. We do that using fingerprinting.

#### Fingerprinting

The asset pipeline takes the assets (JS/CSS/images) that we provide and adds a fingerprint (a long generated string) to the end of the file name. If the file itself changes, then Rails will update the fingerprint will also change.

*If the fingerprint changes, our browser will view this as a wholly different file, and will not rely on the cached version.*

## Putting it Together

### Where Do Assets Live?

* `app/assets`: assets owned by the application; includes custom CSS, JS files, and images
* `lib/assets`: assets you created, but aren't necessarily specific to your application
* `vendor/assets`: assets created by third-parties.

note: the files in app/assets are never served directly in production.
note: assets in lib/assets and vendor/assets will not automatically be included in the precompile process

### How does our application know about our assets?

Within each of those directories is a manifest file.

* `app/assets/javascripts/application.js`
* `app/assets/stylesheets/application.css`

These manifest files provide instructions on how to find our assets.

* These instructions are processed top-to-bottom
* `require_tree .` recursively requires all files within app/assets
* Files required in the manifest can live in app/assets, lib/assets, or vendor/assets

### How Do Our Templates Know About the Compiled Assets?

In app/views/layouts/application.html.erb:

```erb
<%= stylesheet_link_tag "application", media: "all" %>
<%= javascript_include_tag "application" %>
```

### How Do We Access Assets with a Fingerprint

* `asset_path()`
* `image_path()`

### How Does Heroku Process Our Assets

* Heroku precompiles your assets automatically
* Precompiled assets receive a 'fingerprint' to override caching strategies when they change
* In order to access your some assets you'll need to use helpers to access the fingerprinted version of the asset that's being served

## Review

* What does the asset pipeline do?
* How does it benefit our applications?
* What does Heroku do for you with regards to the asset pipeline?
* What is one step you might take if your application seems to be working locally, but broken in production?

## Challenge

Clone down [Backpacking](https://github.com/turingschool/backpacking). Run the following commands:

```
$ cd backpacking
$ rake db:create db:migrate db:seed
$ rails s
```

Visit `127.0.0.1:3000` to see what the app should look like.

Now, close your server and run the application in production using the command `rails s -e=production`.

If you visit `127.0.0.1:3000` your application will show an error that will likely be new to you. Work with a partner to address errors generated until the app that you see matches the app that you see when you run `rails s` without the `-e=production` flag.
