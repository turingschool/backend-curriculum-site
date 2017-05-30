---
title: Intro to the Asset Pipeline
tags: assets, pipeline, rails, heroku
---

# Intro to the Asset Pipeline

## Goals

By the end of this lesson, you will know/be able to:

* Explain the purpose of the asset pipeline
* Run your app in a production environment locally

<!-- * Find the slides [here](https://www.dropbox.com/s/910ifbqmy22l7ua/intro-asset-pipeline.pdf?dl=0)! -->

## Asset Pipeline Overview

* What are assets?
* Where do assets live? (`app/`, `lib/`, `vendor/`)
* Why do we have the asset pipeline?
* What is Sprockets?

### Asset Pipeline Scavenger Hunt

Work with a neighbor to research and answer these questions. Create a new gist to store your answers in.

* What does it mean to **precompile** files? What does this have to do with Coffeescript and Sass files? Does it only have to do with Coffeescript and Sass files?
* What does it mean to **minify** files? Why would we want to minify files?

Clone down, set up and start up the server for [Catch 'em All](https://github.com/turingschool-examples/rails_asset_pipeline_scavenger_hunt) (`rails s`) and navigate to [http://localhost:3000/assets/application.js](http://localhost:3000/assets/application.js). Then open up the code for `application.js` in your text editor.

* Why are these *not* the same?
* What is a **manifest** (in terms of the asset pipeline)? Where can you find *two* manifests in Catch 'em All?
* In regular HTML files, we import CSS files with `<link rel="stylesheet" href="application.css">`. How is this done in a Rails project? Where do you see this line in Catch 'em All?
* How is a **digest** or **fingerprint** used on assets for caching purposes?

Done? Take a look at [RailsGuides: The Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html).

## Running Production Locally

* Why would we want to see if something will work in production mode without pushing to Heroku?
* What are the `development.rb`, `test.rb`, and `production.rb` files?

Catch 'em All looks fine when running in development mode (`rails s`).

Our challenge now is to get it running locally using the production environment AND for our assets to look the same.

Let's start off by spinning up our server in a production environment.

```bash
RAILS_ENV=production rails s
```

What problem do we see first? How can we see our production errors?

_Our logs!_

Now check out `config/production.rb`. What is:

```ruby
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
```

Things won't work in "production" unless `RAILS_SERVE_STATIC_FILES` is returning `true`.

With the `figaro` gem, we can run

```bash
bundle exec figaro install
```

which will give us `config/application.yml`. There, let's set that variable to `true`.

We then want to precompile our assets (yes, by hand). Why do you *not* need to do this on Heroku?

```bash
rake assets:precompile
```

Check out your Rails' `public` folder. Anything different now?

As an aside, it's worth researching `rake assets:clobber`

## Coding Links to Assets

Check out the section on **Coding Links to Assets** [here](http://guides.rubyonrails.org/asset_pipeline.html). Why do we want to be sure we're properly using the following tags?

```
<%= stylesheet_link_tag "application" %>
<%= javascript_include_tag "application" %>
<%= image_tag "rails.png" %>
```

## Resources

* [RailsGuides: The Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)
* [Rails 4 Asset Pipeline on Heroku](https://devcenter.heroku.com/articles/rails-4-asset-pipeline)
* [Rails Asset Pipeline on Heroku Cedar](https://devcenter.heroku.com/articles/rails-asset-pipeline)
