---
title: Intro to the Asset Pipeline
tags: assets, pipeline, rails, heroku
---

# Intro to the Asset Pipeline

## Goals

By the end of this lesson, you will know/be able to:

* Explain the purpose of the asset pipeline
* Explain how Heroku works with the asset pipeline
* Run your app in a production environment locally
* Be comfortable using `figaro` to set environment variables

## Slides

* Available [here](../slides/asset_pipeline_plus_heroku/asset_pipeline)

<!-- * Find the slides [here](https://www.dropbox.com/s/910ifbqmy22l7ua/intro-asset-pipeline.pdf?dl=0)! -->

## Asset Pipeline Overview

* What are assets?
* Where do assets live? (`app/`, `lib/`, `vendor/`)
* Why do we have the asset pipeline?
* What is Sprockets?

### Asset Pipeline Scavenger Hunt

Work with a neighbor to research and answer these questions.

* What does it mean to **precompile** files? What does this have to do with Coffeescript and Sass files? Does it only have to do with Coffeescript and Sass files?
* What does it mean to **minify** files? Why would we want to minify files?
* What does [Sprockets](https://github.com/rails/sprockets) do and how does it fit into the precompile / minify puzzle?

Clone down, set up and start up the server for [Catch 'em All](https://github.com/turingschool-examples/rails_asset_pipeline_scavenger_hunt) (`rails s`) and navigate to [http://localhost:3000/assets/application.js](http://localhost:3000/assets/application.js). Then open up the code for `application.js` in your text editor.

* Why are these *not* the same?
* What is a **manifest** (in terms of the asset pipeline)? Where can you find *two* manifests in Catch 'em All?
* In regular HTML files, we import CSS files with `<link rel="stylesheet" href="application.css">`. How is this done in a Rails project? Where do you see this line in Catch 'em All?
* How is a **digest** or **fingerprint** used on assets for caching purposes?

Done? Take a look at [RailsGuides: The Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html).

## Heroku & the Asset Pipeline

Heroku does some extra work for you with regards to the asset pipeline. In other environments, you may need to compile your assets yourself or use other tools to automate that process.

## Running Production Locally

* Why would we want to see if something will work in production mode without pushing to Heroku?
* What are the `development.rb`, `test.rb`, and `production.rb` files?

Catch 'em All looks fine when running in development mode (`rails s`).

Our challenge now is to get it running locally using the production environment AND for our assets to look the same.

Let's start off by spinning up our server in a production environment.

```bash
rails s -e production
```

What problem do we see first? How can we see our production errors?

_Our logs!_

We need to set our secret key.

We're going to use the Figaro gem to set our environment variables. Add `gem 'figaro'` to your Gemfile.

With the `figaro` gem, we can run

```bash
bundle exec figaro install
```

which will give us `config/application.yml`. This file will allow us to set variables environment-wide. This file is also `.gitignore`d, so it's safe to keep sensitive information there, including API keys.

Enter the following into your newly created `config/application.yml` file.

```
# /config/application.yml

procution:
  SECRET_KEY_BASE: long_string_from_rake_secret
```

Check your server, and it looks like we're in better shape, but maybe not all the way there. If we inspect the page we see that some of our assets are still not loading.

Check out `config/environments/production.rb`. What is:

```ruby
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
```

Things won't work in "production" unless `RAILS_SERVE_STATIC_FILES` is returning `true`.

Let's set an environment variable for `RAILS_SERVE_STATIC_FILES` to `true`. Update your `config/application.yml` file to the following.

```
# /config/application.yml

procution:
  SECRET_KEY_BASE: long_string_from_rake_secret
  RAILS_SERVE_STATIC_FILES: true
```

We then want to manually precompile. Why do you *not* need to do this on Heroku?

```bash
rake assets:precompile
```

Check out your Rails' `public` folder. Anything different now?

> Know that `rake assets:precompile` generates an `assets` directory that does not update when changes are made to your codebase. Know that `rake assets:clobber` will remove that directory of precompiled assets so that you can regenerate.

## Coding Links to Assets

Check out the section on **Coding Links to Assets** [here](http://guides.rubyonrails.org/asset_pipeline.html#coding-links-to-assets).

In your gist from earlier, research and answer why we'd want to be sure we're properly using the following tags:

```
<%= stylesheet_link_tag "application" %>
<%= javascript_include_tag "application" %>
<%= image_tag "rails.png" %>
```

## Resources

* [RailsGuides: The Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)
* [Rails 4 Asset Pipeline on Heroku](https://devcenter.heroku.com/articles/rails-4-asset-pipeline)
* [Rails Asset Pipeline on Heroku Cedar](https://devcenter.heroku.com/articles/rails-asset-pipeline)
