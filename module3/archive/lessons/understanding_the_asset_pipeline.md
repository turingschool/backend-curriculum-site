---
layout: page
title: Understanding the Asset Pipeline
length: 180
tags: ruby, rails, asset_pipeline
---

## Learning & Completion Goals

* Students can start their Rails application in production mode locally *(functional)*
* Students can troubleshoot common Asset Pipeline errors locally instead of production servers (Heroku) *(functional)*

## Learning Goals

* Start your Rails app in production mode
* How Rails organizes client-side assets in your application
* How and why to use ActionView::Helpers and sass-rails helpers
* Understand how the Asset Pipeline behaves differently in production than in development
* Add assets to manifests to create asset bundles

## Resources

* [Starting a Rails app in production](https://gist.github.com/jmejia/8f6507d3faa92ff21f0b)
* [Sprockets](https://github.com/rails/sprockets-rails)
* [Solutions](https://vimeo.com/256876292) to the paired challenges below

## Prior to Class

* Clone down this [Rails app](https://github.com/turingschool-examples/hinny).
* Start the application in production mode using [this video](https://vimeo.com/255927334).

## Instructor Notes

* Lesson plan is intended to use pairs.
* To start the lesson, have students checkout the `debugging_the_asset_pipeline` branch.

## Warm Up

With your partner:

* Why do we need to run `rake assets:precompile` prior to running our application in production mode?
* Why don't we need to do this in development mode?

## Group Discussion

Silently read the following excerpt from Rails Guides about The Asset Pipeline:

>The first feature of the pipeline is to concatenate assets, which can reduce the number of requests that a browser makes to render a web page. Web browsers are limited in the number of requests that they can make in parallel, so fewer requests can mean faster loading for your application.

>Sprockets concatenates all JavaScript files into one master .js file and all CSS files into one master .css file. As you'll learn later in this guide, you can customize this strategy to group files any way you like. In production, Rails inserts an SHA256 fingerprint into each filename so that the file is cached by the web browser. You can invalidate the cache by altering this fingerprint, which happens automatically whenever you change the file contents.

>The second feature of the asset pipeline is asset minification or compression. For CSS files, this is done by removing whitespace and comments. For JavaScript, more complex processes can be applied. You can choose from a set of built in options or specify your own.

>The third feature of the asset pipeline is it allows coding assets via a higher-level language, with precompilation down to the actual assets. Supported languages include Sass for CSS, CoffeeScript for JavaScript, and ERB for both by default.

What is the job of the Asset Pipeline? What does it do for us?

## Lecture

Source files go in one end; if necessary, they get processed and compiled (think SASS or CoffeeScript); they get concatenated and compressed and spit out the other end as bundles.

The asset pipeline relies on a few technologies:

* **Sprockets** is a Rack-based asset packaging for compiling and serving web assets. It handles dependency management and preprocesses CoffeeScript, SASS, et cetera on your behalf.
* **Tilt** is a wrapper around a number of Ruby template engines, giving them a common interface. You can take a look at all of the formats Tilt can handle by [checking out the documentation][tilt].

[tilt]: https://github.com/rtomayko/tilt/blob/master/README.md

So, why should you use the asset pipeline? Inline JavaScript (mixed in your HTML/ERB code) blocks loading and rendering the page—which is not something we usually want to block. Plus it is messy to mix JavaScript, Ruby, and HTML in a view template. Let's keep JavaScript in its own files in the Rails assets directories.

Rails will pick up new files in your `app/assets` directory, but you have to reset the server if you add a new *directory* to the `app/assets`.

Rails pulls in assets from the following locations:

* `app/assets`
* `lib/assets`
* `vendor/assets`
* Gems with a `vendor/assets` directory.

`app/assets` are your application-specific assets. `lib/assets` is typically used for assets that are created by your team but used by multiple applications. `vendor/assets` is a good place for third-party JavaScript libraries that aren't yours (e.g. Underscore.js, D3).

By default, Rails places three sub-directories in your `app/assets` directory. These are completely arbitrary. You can name these directories whatever you want or add other directories to your heart's content.

Anything in the pipeline will be available at the `/assets` URL. So, the `app/assets/javascripts/application.js` in your asset pipeline will be available in development at `http://localhost:3000/assets/application.js`. `app/assets/stylesheets/application.css` will also be available at the root of your asset directory. The asset pipeline will completely flatten your directory structure when you spin up your development server or precompile your assets.

**In Pairs (3 mins)**

* Create a directory in `app/assets` called `this_name_does_not_matter`.
* Add a text file—let's call it `hello.txt`—to `app/assets/this_name_does_not_matter` and give it some contents.
* Fire up the server and visit `http://localhost:3000/assets/hello.txt`.
* Move it to `app/assets/javascripts` and refresh the page.
* Discuss with your partner: What's the purpose of separate directories?

**As a class**

At it's core, the asset pipeline is a list of load paths. You can see these load paths by firing up the Rails console.

```ruby
y Rails.application.config.assets.paths
```

(The `y` command just formats the hash as YAML.)

You'll typically see something like this:

```yaml
---
- "/Users/michaelbolton/Projects/initech/app/assets/images"
- "/Users/michaelbolton/Projects/initech/app/assets/javascripts"
- "/Users/michaelbolton/Projects/initech/app/assets/stylesheets"
- "/Users/michaelbolton/Projects/initech/vendor/assets/javascripts"
- "/Users/michaelbolton/Projects/initech/vendor/assets/stylesheets"
- "/Users/michaelbolton/.rvm/gems/ruby-2.5.0/gems/less-rails-bootstrap-3.2.0/app/assets/fonts"
- "/Users/michaelbolton/.rvm/gems/ruby-2.5.0/gems/less-rails-bootstrap-3.2.0/app/assets/javascripts"
- "/Users/michaelbolton/.rvm/gems/ruby-2.5.0/gems/less-rails-bootstrap-3.2.0/app/assets/stylesheets"
- "/Users/michaelbolton/.rvm/gems/ruby-2.5.0/gems/turbolinks-2.2.2/lib/assets/javascripts"
- "/Users/michaelbolton/.rvm/gems/ruby-2.5.0/gems/jquery-rails-3.1.1/vendor/assets/javascripts"
- "/Users/michaelbolton/.rvm/gems/ruby-2.5.0/gems/coffee-rails-4.0.1/lib/assets/javascripts"
```

The asset pipeline works its way through your load path starting at the top. The first asset with a given name wins. If you had an asset named `app/assets/stylesheet.css.scss` and another called `vendor/assets/stylesheet.css.scss`, the asset in your `app/assets` directory would win because it occurs first in the load path.

## Loading Assets - Our Journey Begins

We'll be following our assets' journey through the Asset Pipeline. This journey can sometimes feel like a Rube Goldberg machine but there is a purpose behind each stage. Understanding the purpose is essential to controlling and troubleshooting this complex system. The call to load assets starts in the view so let's start exploring there and discuss what is happening along the way.

### ActionView Helpers

ActionView gives you a set of helper methods that you can use in your views to include assets.

With your partner, locate the two lines in your application that look something like this:

```erb
<%= stylesheet_link_tag "application", :media => "all" %>
```

```erb
<%= javascript_include_tag "application" %>
```

These two lines are responsible for loading all CSS and JS that are a part of the Asset Pipeline. We'll come back and look at more ActionView Helpers later. For now, let's breakdown what these lines are doing.

Each of these lines points to a different manifest, one for our stylesheets and one for our JavaScript.

### Manifests

When developing our application's frontend, we like to separate our code into multiple files according to its function or responsibility. This helps keep things manageable and organized as our application grows, especially in Apps that involve a lot of JS or CSS.

However, when serving assets to an end user, this becomes problematic. In development, it is tedious to have to individually require a lot of small asset files in our templates. In production, having lots of asset files is even worse, since it bogs down the page with lots of HTTP requests.

Fortunately Rails gives us asset manifests to help with these issues. Manifests are a way to pull in groups of related files. So, if I request `application.js` and it requires `another.js` in it's manifest, I will get both of them. It's common to see a single large manifest (e.g. `application.js`) that pulls in everything, but we can also segment our assets into smaller manifests that are only used on specific portions of the site (e.g. `admin.js`).

When writing an asset manifest, we can use special "directives" to tell Sprockets what to pull in to the bundle. Directives are written as comments in the appropriate manifest file. Here are a few examples (see below for a complete list):

* `// require_tree .` requires all of the files in that directory and all subdirectories.
* `// require_directory .` loads all of the files in the directory but *not* the subdirectories.
* Alternatively, you can just take matters into you own hands and manually define the files you want to include.

In this example, we're looking at `application.js`; so, we're using JavaScript comments. If you're in `application.css` then it would be in CSS comments.

By default, the asset pipeline concatenates all of assets into one file (using `require_tree .`). Browsers can only make a limited number of requests in parallel. This technique allows you to get all of your assets with one request.

Here's an example of an `application.js` manifest:

```js
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
```

__Discussion/Question:__ Why are `jquery` and our other external JS libraries not picked up by `require_tree .`

#### Manifest Directives

* `require` grabs an asset and puts it in our bundle once.
* `include` works a lot like `require`, but it will allow you to include a file more than once. (I have yet to find a practical use for this directive.)
* `require_self` tells Sprockets to load the body of the current file before loading any of the dependencies. You would use this if you wrote any styles or JavaScript in `application.css` or `application.js` respectively and you wanted Sprockets to load that code before loading any of the required assets.
* `require_directory` requires all of the source files of the same format in a given directory. It only goes one level deep.
* `require_tree` works like `require_directory`, but it also traverses subdirectories.
* `depend_on` announces that you depend on a file, but does not include it in the asset bundle.
* `stub` blacklists a dependency from the bundle.

**In Pairs (10 minutes)**

*Instructor:* The order in your manifest matters. If you load the root page for the application in development mode you'll notice two hero images. This should be a carousel with the two images rotating but there's a problem loading the JavaScript. If you load the console in your browser you should see an error.

* Which file is causing the error?
* Using this [setup documentation](http://kenwheeler.github.io/slick/#getting-started): What is Slick dependent on?
* Try to update the manifest to get the carousel to work.
* If you figure it out, start the app in production and confirm it works there as well.

### ActionView Helpers in Production (as a class)

Start your application in production mode and inspect element in the browser. Locate the line that loads your application JavaScript. You should something that looks like this:

`<script src="/assets/application-c0168a95589ad557034a1e201a2b2dffef63124394d26187259600f77802d45a.js"></script>`

When you fixed the previous problem you edited a file named `application.js` and what we are seeing here is different. That strange looking string is referred to as a fingerprint.

#### MD5 Fingerprints / Asset Caching

It's beyond the scope of this discussion, but caching assets is a large topic in the field of web infrastructure. Retrieving assets over and over adds a lot of network overhead to web applications, so browsers (as well as network intermediaries like CDN's) do everything they can to cache assets.

But if assets are being cached on the browser side, we need a way to update them when necessary. Otherwise our application might get loaded with out-of-date assets (for example, old javascript with a new set of incompatible markup).

If you look at the assets generated by a Rails application, you'll notice that each includes a string of letters and numbers as part of the filename. This string of numbers is a "digest" of all of the asset contents, which allows us to ensure that any change to the underlying asset will generate a completely new filename and URL, thus breaking any asset caches that might have been in place.

By default, this fingerprinting is only necessary in production mode.

### Differences in Development and Production

As we mentioned in the beginning, the whole idea of the asset pipeline is to concatenate everything into one file, because performance. But, we'll notice that when we spin up our application in development, we'll see many files listed in the resources tab of the Chrome Developer Tools.

This is because this functionality is disabled in `config/environments/development.rb`:

```rb
# Debug mode disables concatenation and preprocessing of assets.
# This option may cause significant delays in view rendering with a large
# number of complex assets.
config.assets.debug = true
```

This is useful for debugging JavaScript and CSS issues. It's turned off in production.

#### Precompiling Assets

If you request an asset in development, Rails will check `public/assets` first. If your asset is not there, it will hit up the asset pipeline and compile it on the fly. This is useful in development because you're likely to be making frequent changes and edits to those files. But, it would also be a performance bottleneck in production if Rails had to compile those files on every request.

If you want to use an asset in your application, it has to either be required by a file in your asset pipeline or precompiled.

Let's say you had a stylesheet called `site.css.scss`. You could simply require it in `application.css`.

```css
// = require_self
// = require 'site'
```

Alternatively, you can add it to the precompile list similar to the way we added a load path earlier.

```rb
config.assets.precompile += %w( site.css )
```

When you run `rake assets:precompile`, Rails goes through your assets and copies everything over to `public/assets`. It then creates fingerprinted versions of `application.js` and `application.css` by reading the manifests. It does not look at any other file unless you explicitly tell it to.

### Why Assets Break in Production

**In Pairs (25 minutes)**

For the next exercises we want to start our Rails app in both development and production at the same time 🙀.

**development:** Start your first server like normal using `rails s`.
**production:** Start your second server using the following `RAILS_ENV=production rails s -p 4000 -P ./tmp/pids/alternate_server.pid`

As you know, `RAILS_ENV=production` tells it to start in production mode. `-p` allows us to specify which port to run on. `-P` Tells it to look for a different PID (process identifier). If it doesn't exist it should create one.

* Navigate to each environment in the browser.
* Pull up the docs for `ActionView::Helpers::AssetTagHelper`.
* The CSS isn't loading properly in production mode. What is this filename missing that our application.js file has? (Hint: use Inspect Element or View Source in the browser)
* Find a helper to fix it. (REMINDER: Restart the production server anytime you make a change)
* Using a similar approach, can you find a helper to fix the broken logo?

**As a Class**

* What ended up being the problem?
* What other helpers are there out there?
* Currently the background images of the donkey cards are broken. What do you think the problem is?

#### Some Notes about SASS/SCSS

Background images are loaded using stylesheets and require different helpers than our views. Check out the docs for sass-rails to see what helpers are available. They are the same in principle to `ActionView::Helpers`.

**In Pairs**

* Find the sass-rails helper to load the background images in production.

**As a Class**

You could require and concatenate multiple `.scss` files using manifest directives (eg `require`), but you probably shouldn't. The asset pipeline is fairly agnostic to the special features of the assets you're working with. SASS has an `@import` directive that works better for our purposes. In this case, it's better to just include `@import` directives in your `application.sass` than it is to use manifest directives. This will end up being less buggy.

You can also do something similar with JavaScript, but it's a little more intensive, so for now, we'll use manifests to concatenate our scripts.

### Conclusion
