---
title: Feature Testing in Sinatra with Capybara
length: 120
tags: capybara, user stories, feature tests, testing
---

## Key Topics

During our session, we'll cover the following topics:

* Types of testing
* What are user stories? Why are they beneficial?
* Capybara

## Lecture

[Slides](http://m2b-slides.herokuapp.com/m2b/feature_testing_with_capybara_in_sinatra.html#/)

## Capybara

### Important Setup Things

Add the following lines to your `Gemfile` in the `:development, :test` group:

```ruby
gem 'capybara'
gem 'launchy'
```

Run `bundle`

Update your `spec/spec_helper.rb` file to include the following:

```ruby
# with your other required items
require 'capybara/dsl'

Capybara.app = HorseApp

# within the RSpec configuration:
  c.include Capybara::DSL
```

Since we're going to be creating a new type of test, let's add a new folder to separate them from our model tests.

`mkdir spec/features/`
`touch spec/features/user_sees_welcome_spec.rb`

In that new file add the following:

```ruby
require_relative '../spec_helper'

RSpec.describe "When a user visits '/'" do
  it "they see a welcome message" do
    # Your code here.
  end
end
```

Now, our user story is something along the lines of the following:

* As a user
* When I visit the root page
* I should see a welcome message

Try to turn that user story into a test using the Capybara methods from the slides and see if you can then make it pass. Let instructors know if you get stuck!

## Resources

* [Capybara cheat sheet](https://gist.github.com/zhengjia/428105)
* [Another cheat sheet](http://cheatrags.com/capybara)
* [Simple Tricks for Capybara](http://www.elabs.se/blog/51-simple-tricks-to-clean-up-your-capybara-tests)
