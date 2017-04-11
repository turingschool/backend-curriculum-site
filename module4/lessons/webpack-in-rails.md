---
title: Webpack in Rails
subheading: Everything in it's right place
---


Learning Goals
-------------

-   Student can use webpacker for managing their JavaScript in Rails
-   Student can make tradeoff decisions on whether webpacker is right for their project

The Hook
-----------

>  Because the hook brings you back  
>  I ain't tellin' you no lie  
>  The hook brings you back  
>  On that you can rely  
>  -- <cite>Blues Traveler</cite>

Rails is perfectly capable of managing the back-end and the front-end, but it falters a little with the front-end, especially as our applications become more and more complicated. For a couple reasons:

-   **We're using Ruby to import javascript**

    Any javascript library you want to bring in (jQuery, bootstrap, react, underscore, etc..) has to be added by downloading the JS file itself (increasingly difficult) or wait for someone to pack it up as a gem. So now you're adding a JS package by adding a Ruby gem. Kinda funky.

-   **Everything is global**

    As our applications get more and more complicated, we should be scoping our code into modules, so we aren't creating globals all over the place, but sprockets can't handle that.

-   **Babel is so nice**

    All transpiling has to be forced in as a sprockets gem, instead of using the gold standard babel package

-   **Front End developers want to use their tools**

    How do you ramp up a front end developer to put their code into rails. Tell them they don't have any of their favorite tools or packages.

Webpack and NPM solve all these problems. Why can't we use them? No, really. Why can't we?

Enter Webpacker gem
-------------------

DHH and the Rails team have been working on a gem that will let you organize your javascript, css and images the same way you would in Webpack. And you can install all the modules available through NPM.

This is pretty new stuff, and will continue to evolve before it's wide release in Rails 5.1, but I was so excited that I wrote this lesson plan that will probably never be useful again.

### Quick note about yarn

Yarn is Facebook's replacement for npm. It's like faster and hotter and stuff. Moving on....

Code Along
------------

Let's start a new rails project, and add some modular javascript to it.

### Setup

Add the `webpacker` gem to your Gemfile. They recommend pulling directly from github since this gem is being worked on heavily right now:

```ruby
gem 'webpacker', github: 'rails/webpacker'
```

Then install it from your terminal:

```
bundle
rails webpacker:install
```

This is going to install a `config/webpack` folder (which we'll get so some of) and a new `app/javascript` folder. For now, let's just disable the dev server. We don't need two servers running.

The last step is to load the "pack file" in the head of your layout

```erb
<%= javascript_pack_tag 'application' %>
```

If you're not planning on using the asset pipeline, you can also remove the `javascript_include_tag`. Technically you can use them side by side, but I can see that being confusing.

### Development

A couple things to keep in mind while developing your application:

-   Use `bin/yarn add` to add packages instead of `npm install`
-   Whenever you're actively developing javascript, and want to have your changes automatically loaded, you'll need to run `bin/webpack-watcher` in a separate terminal window.
-   You can also use `bin/webpack-dev-server`, but I thought it was silly to run a whole other server.
-   You don't have to use the sprockets specific `// require` syntax anymore. In your `app/javascripts/packs/application.js` file, you can use your standard require/import syntax to load modules.
    ```javascript
    import module from 'module';
    // OR //
    const module = require('module');
    ```


### Deployment

Really, you shouldn't have to do anything different. The build phase of webpack is now included whenever `rails precompile:assets` is run. So if you're using Heroku, it will be taken care of, and if you needed to precompile assets in any other deployment process, just keep doing that.

### Testing

You should be able to use all the same integration test features you're used to, like selenium or poltergeist. I haven't tested this extensively, and there may be edge cases, but selenium is mostly edge cases already.

You can also unit test your JavaScript from the `app/javascript` folder. They won't automatically run when you run rspec, but if you write a clever rake file, you should be able to get them to run together.

### Documentation

You've added additional steps that most Rails developers don't know about. Don't forget to add them so collaborators can setup and maintain your application, including running `yarn` along with `bundler` when you first clone down.

Next steps
-------------

Check out the [webpacker readme](https://github.com/rails/webpacker) for more tricks.

-   You can preinstall react, angular or vue.js
-   You can use Foreman to run both `rails s` and `webpack-watcher` with one command
-   You can use ERB in your modules for linking to asset pipeline images, or using environment variables
-   
