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

<!-- ## Lecture -->

<!-- [Slides](http://m2b-slides.herokuapp.com/m2b/feature_testing_with_capybara_in_sinatra.html#/) -->



## Warmup

* What are we testing so far in our Horses app?
* What aren't we testing?
* Assuming that our tests will have some setup, execution, assertions, and teardown, what might be included in each phase?

## What are Feature Tests?

* Mimic the behavior of the user
* Shouldn't have to know about underlying code
* Based on user stories

## What are User Stories?

Remember those things we want you to make Waffle cards out of?

Depending on how encompassing a user story is, you may want to make multiple Waffle cards from a single story.

```txt
As a user
When I visit the home page
And I fill in title
And I fill in description
And I click submit
Then my task is saved
```

How would this translate to a test? (Reference back to [Four Phase Testing](https://robots.thoughtbot.com/four-phase-test) if need be.)

```
As a [user/user-type]
When I [action]
And I [action]
And I [action]
And I [action]
Then [expected result]
```

### Exercise: Create User Stories

* Adding a Horse to HorsesApp
* Signing up for a new account
* Logging into an account
* Viewing only the Horses associated with a specific Jockey

## Capybara

Capybara is a test framework that allows you to feature test any RACK-based app.

It provides a DSL to help you query and interact with the DOM.

### Helpful Capybara Methods

```ruby
visit(path)
expect(page).to have_content("content")
expect(page).to have_css('.css')
within('.class') {
  # Assertions here
}
save_and_open_page
```

#### Form- and Button-Specific Methods

```ruby
fill_in(identifier, with: content)
click_link(identifier)
click_button(identifier)
click_link_or_button(identifier)
click_on(identifier)
expect(current_path).to eq('/')
```

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

```bash
$ mkdir spec/features/
$ touch spec/features/user_sees_welcome_spec.rb
```

In that new file add the following:

```ruby
require_relative '../spec_helper'

RSpec.describe "When a user visits '/'" do
  it "they see a welcome message" do
    # Your code here.
  end
end
```

### Exercise: Implement Feature Test

Now, our user story is something along the lines of the following:

* As a user
* When I visit the root page
* I should see a welcome message

Try to turn that user story into a test using the Capybara methods from above and see if you can then make it pass.

### Workshop

With the above exercise complete, work to write user stories and feature tests for the following:

* The process of creating a Horse
* That all horses are displayed on the Horse index
* That a Jockey's total winnings are displayed on their page

## Resources

* [Capybara cheat sheet](https://gist.github.com/zhengjia/428105)
* [Another cheat sheet](http://cheatrags.com/capybara)
* [My favorite cheat sheet](https://thoughtbot.com/upcase/test-driven-rails-resources/capybara.pdf)
* [Simple Tricks for Capybara](http://www.elabs.se/blog/51-simple-tricks-to-clean-up-your-capybara-tests)
