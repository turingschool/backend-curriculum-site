---
title: Intro to the Asset Pipeline
---

# Warmup

* What do you already know about the asset pipeline?
* What have you heard?
* What computer languages does your browser understand?

---

# Learning Goals

* Explain the purpose of the asset pipeline
* Explore Heroku
* Run your app in the production environment locally

---

# What Are Assets

* Javascripts
* CSS files
* Images

---

# Where Do Assets Live?

* `app/assets`: assets owned by the application; includes custom CSS, JS files, and images
* `lib/assets`: assets you created, but aren't necessarily specific to your application
* `vendor/assets`: assets created by third-parties.

note: the files in app/assets are never served directly in production.
note: assets in lib/assets and vendor/assets will not automatically be included in the precompile process

---

# The Asset Pipeline

* Asset loading is expensive
* Faster asset loading = faster performance
* Sprockets gem, enabled by default
* Framework to concatenate, minify, and preprocess JS, and CSS files
* Depends on other gems: sass-rails, uglifier, coffee-rails

---

# Asset Pipeline Scavenger Hunt

---

# What Does Minified CSS Look Like?

![inline](css-minified.jpg)

---

# What Does Minified JS Look Like?

![inline](js-minified.png)

---

# Duties of the Asset Pipeline

  * Precompiling higher-level languages - Sass for CSS, CoffeeScript for JavaScript
  * Concatenating assets - one master .js file and one master .css file which reduces the number of requests a browser makes in order to render our web page
  * Minifying files - removes whitespace, comments, and shortens variable names
  * Providing a `fingerprint` to compiled assets to support caching

---

# Manifest Files

  * `app/assets/javascripts/application.js`
  * `app/assets/stylesheets/application.css`

---

# Directives in Manifest Files

  * Processed top-to-bottom
  * `require_tree .` recursively requires all files within app/assets
  * Files required in the manifest can live in app/assets, lib/assets, or vendor/assets

---

# Directives in Manifest Files

![inline](manifest.png)

---

# How Does Your App Know About the Master JS and CSS File?

In app/views/layouts/application.html.erb:

```erb
<%= stylesheet_link_tag "application", media: "all" %>
<%= javascript_include_tag "application" %>
```

---

# Heroku

* When should you push to heroku?
* Who should push to heroku?
* Adding a collaborator: don't clone the app from Heroku!
* Add the Heroku remote instead (`heroku git:remote -a app_name`)

---

# Do you need to keep the strange name that is automatically created for you?

`https://enigmatic-lowlands-98091.herokuapp.com/`

---

# Master

* Heroku likes your master branch
* If you don't want to push master, you need to do `git push heroku your-branch-name:master`

---

# Databases

* Will need to migrate/seed on heroku
* Unable to create/drop on heroku
* Instead, you can `heroku pg:reset DATABASE` if you need
* Don't get too comfortable dropping your production database!

---

# What about your assets?!?

* Heroku precompiles your assets automatically
* Precompiled assets receive a 'fingerprint' to override caching strategies when they change
* In order to access your some assets you'll need to use helpers to access the fingerprinted version of the asset that's being served

---

# Debugging

* `heroku logs`
* `heroku logs --tail`
* `rails_12factor` - in production for earlier versions of rails

---

# Running Your App in Production Locally

---

# Start Your Server

```
rails s -e production
```

---

# Install Figaro

```
# Gemfile
gem 'figaro'

# Command line
> bundel exec figaro install
```

---

# Set `SECRET_KEY_BASE`

```
# Command line
rake secret

# In config/application.yml

production:
  SECRET_KEY_BASE: long_string_from_rake_secret
```

---

# Load DB

* `RAILS_ENV=production rake db:create db:migrate db:seed`

---

# Serve Static Assets

```
# /config/application.yml

procution:
  SECRET_KEY_BASE: long_string_from_rake_secret
  RAILS_SERVE_STATIC_FILES: true
```

---

# Precompile Assets

* `rake assets:precompile`

---

# Run Server

* `rails s -e production`

---

# Clobber

* `rake assets:clobber`

---

# Links to Assets

* Rails gives us helpers that we can use to access these assets
* Without these helpers, our HTML/CSS will not have the fingerprints necessary to access the assets

```
<%= stylesheet_link_tag "application" %>
<%= javascript_include_tag "application" %>
<%= image_tag "rails.png" %>
```

---

# Review

* What does the asset pipeline do?
* How does it benefit our applications?
* What does Heroku do for you with regards to the asset pipeline?
* What is one step you might take if your application seems to be working locally, but broken in production?
