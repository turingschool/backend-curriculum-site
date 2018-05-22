---
title: Project Etiquette Part 2
layout: page
length: 60min
tags: ruby
---

## Ruby Project Etiquette: Gemfiles, Bundler, & LOAD_PATH

In this session we're going to go over some common best practices for organizing and managing code in our Ruby projects. By the end of the lesson, you should be comfortable with the following tasks.

* How to build a gemfile and why you'd want to
* What `$LOAD_PATH` is and how it helps you


## Vocabulary
* Gem
* Gemfile
* $LOAD_PATH

## Warmup

* How do you manage dependencies in your project?

## Gems & Gemfiles

- A "Gem" is a packaged up piece of ruby code designed to be shared with others (i.e. a library). [RubyGems](https://rubygems.org/) is the community-run repository and website where gems can be published so other users can download and use them easily.
- [Bundler](http://bundler.io/) is the popular dependency manager rubyists use to download and manage gems. Bundler versions are unique to Ruby versions, if you change Ruby versions you must have that Ruby's Bundler version installed also.
- Similar to a `Rakefile`, a `Gemfile` lives at the **root of your project** and contains a list of the gems that project *depends on*.

**Sample Gemfile:**

```ruby
source "https://rubygems.org"

gem "minitest"
```

To install the dependencies listed in your Gemfileyou would run `bundle` (**Can you guess from where?**). Running bundle will also create a special file called `Gemfile.lock` in your project root. This file records which version of each gem your project relies upon. You should commit both of these files to source control so that other users of your application use the same gem versions and things don't break.

### Exercise - Making A Gemfile

1. Use the directory you created in the Rake section of [Ruby Project Ettiquette Part 1](../ruby_project_ettiquette)
2. Add a method `jam` to your `Event` class.
3. In the file, enter the following code to make a request using the Faraday gem:

```ruby
require "faraday"

def jam
  puts Faraday.get('https://corgiorgy.com/').body
end
```

4. Create an empty `Gemfile` in the directory
5. Use GOOGLE to determine what to add to the gemfile to install the `faraday` gem
6. Then use `bundle` to install this gem
7. Run your file to see that your code works and how Faraday helps you read webpages


## Load Path Crash Course

How does Ruby know where we look when we `require` something? Why is it we say `require "minitest"` but `require "./lib/enigma"` when obviously the `minitest` file is not sitting in the root of our project.

### What is the `$LOAD_PATH`

$LOAD_PATH is an internal structure (actually an `Array`) that Ruby uses to keep track of where it can look to find files it needs (or we ask it to look for).

Open a `pry` or `irb` session and type in `$LOAD_PATH`. You should get a response of something like this:

```ruby
["/Users/your_username/.rvm/gems/ruby-2.3.0@global/gems/did_you_mean-1.0.0/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0@global/gems/executable-hooks-1.3.2/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0@global/extensions/x86_64-darwin-15/2.3.0/executable-hooks-1.3.2",
 "/Users/your_username/.rvm/gems/ruby-2.3.0@global/gems/bundler-unload-1.0.2/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0@global/gems/rubygems-bundler-1.4.4/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0@global/gems/bundler-1.12.5/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/gems/slop-3.6.0/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/gems/method_source-0.8.2/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/gems/pry-0.10.4/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/gems/coderay-1.1.1/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/gems/byebug-9.0.5/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/extensions/x86_64-darwin-15/2.3.0/byebug-9.0.5",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/gems/pry-byebug-3.4.0/lib",
 "/Users/your_username/.rvm/gems/ruby-2.3.0/gems/pry-rails-0.3.4/lib",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/site_ruby/2.3.0",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/site_ruby/2.3.0/x86_64-darwin15",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/site_ruby",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/vendor_ruby/2.3.0",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/vendor_ruby/2.3.0/x86_64-darwin15",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/vendor_ruby",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/2.3.0",
 "/Users/your_username/.rvm/rubies/ruby-2.3.0/lib/ruby/2.3.0/x86_64-darwin15"]
```

The default `$LOAD_PATH` will contain Ruby itself, files in the standard library (hence we can `require "pry"` without a path), **as well as our current directory**. This is why `require`, by default, works relative to the place from which you code is *being run*, and thus why we should try to stick with the habit of running code from project root.

Your OS has a similar construct called `PATH` which it uses to find executable commands. Check it out by running `echo $PATH` at your terminal. This is how it knows what to execute when we type a simple command like `git`

### Exercise: Messing with Load Path

1. Create a ruby file called `print_stuff.rb` in the directory `/tmp` on your machine. `/tmp` is two levels up from your base user directory (`cd ~../..`)
2. In that file define a simple method that prints a line of text. Call it `print_stuff`
3. Go to your **Home Directory** (`cd ~`) and open a pry or IRB session
4. Try to require `print_stuff` in irb/pry with `$ require 'print_stuff'`. You will get an error.
5. Use ruby to ADD the path `../../tmp` to your load path (remember, `$LOAD_PATH` is just an array so you can use normal Ruby array methods on it)
6. Try to require `print_stuff` again using the command in 4 (above). It will return true.

### Check for Understanding

Describe to a neighbor why the exercise above worked.

### Extension

If you finish early, scan this article from Joshua Paling on [Load Path](http://joshuapaling.com/blog/2015/03/22/ruby-load-path.html).

## Wrap Up
* What is a gem? Why would you use one?
* What is a Gemfile and a Gemfile.lock? Why would you use one?
* What is a load path? How can you alter your load path?
