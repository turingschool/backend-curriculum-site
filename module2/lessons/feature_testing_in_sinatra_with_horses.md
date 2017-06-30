---
title: Feature Testing in Sinatra with Capybara
length: 120
tags: capybara, user stories, feature tests, testing, sinatra
---

## Goals

By the end of this session, you will be able to:

* differentiate between feature tests and model tests
* write user stories
* translate user stories into feature tests using Capybara

<!-- ## Lecture -->

<!-- [Slides](http://m2b-slides.herokuapp.com/m2b/feature_testing_with_capybara_in_sinatra.html#/) -->

## Repository

If you already have a copy of the `intro-to-ar` repo, cd into it and type:

`git checkout model_complete`

If you do not have a copy of the `intro-to-ar` repo: 

`git clone -b model_complete git@github.com:turingschool/intro-to-ar.git feature_testing`

## Warmup

* What are we testing so far in our Horses app?
* What aren't we testing?
* Assuming that these unwritten tests will have some setup, execution, assertions, and teardown, what might be included in each phase?

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

## [Capybara](https://github.com/teamcapybara/capybara)

What is a Capybara? 

It is an aquatic herbivore that lives in South America. It is either the largest or second largest rodent in the world. They also have really cute babies. 

![Capybara](https://c1.staticflickr.com/7/6020/5918545695_ef0e98c8ef_b.jpg)

Capybara is also a Ruby test framework that allows you to feature test any RACK-based app.

It provides a DSL (domain specific language) to help you query and interact with the DOM.

### Important Setup Things

Add the following lines to your `Gemfile` in the `:development, :test` group:

```ruby
gem 'capybara'
gem 'launchy'
```

Run `bundle`

Update your `spec/spec_helper.rb` file to include the following:

```ruby
# other required items here
require 'capybara/dsl'

Capybara.app = HorseApp

# within the RSpec configuration (this is the same place you have your database cleaner options set): 

  c.include Capybara::DSL
```

### How to Format Feature Specs

There are three general schools of thought:

1) Scenario string contains context information that forms complete sentence with feature string

(below example from [thoughtbot](https://robots.thoughtbot.com/rspec-integration-tests-with-capybara))
```ruby
RSpec.feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    ...
  end

  scenario 'with invalid email' do
    ...
  end

  scenario 'with blank password' do
    ...
  end
end
```

2) Scenario contains desired outcome (along with any context)

(below example also from [thoughtbot](https://thoughtbot.com/upcase/test-driven-rails-resources/rspec_acceptance.pdf))
```ruby
RSpec.feature 'Signing in' do
  scenario 'signs the user in successfully with a valid email and password' do
    ...
  end
  scenario 'notifies the user if their email is invalid' do
    ...
  end
end
```

3) Scenario contains brief description of user action

(below example from [Relishapp - RSpec documentation](https://relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec))
```ruby
RSpec.feature "Widget management", :type => :feature do
  scenario "User creates a new widget" do
    ...
  end
end
```

There are also some other strange and unconventional ways to write features in the depths of the internet. I caution you to use your best judgement when looking at people's blog posts and figure out what the style is and why they're using that before blindly adopting it as your own. 

I personally prefer approach #1 since it creates beautiful, gramatically correct sentences :) Aim to use that structure to get the most out of RSpec's documentation-style output. However, there are some situations where that approach doesn't really lend itself to the test. 

### Making the Test

Since we're going to be creating a new type of test, let's add a new folder to separate them from our model tests. The test that we're about to create is probably *not* a test you'd actually write in your project, but it's a simple example to show how Capybara works. 

```bash
$ mkdir spec/features/
$ touch spec/features/user_sees_welcome_spec.rb
```

In that new file add the following:

```ruby
RSpec.feature "User visits '/'" do
  scenario "and sees a welcome message" do
    # Your code here.
  end
end
```

Now, our user story is something along the lines of the following:

* As an unauthenticated user
* When I visit the root page
* I should see a welcome message

Let's turn that user story into a test using the Capybara methods from above and make it pass.

### Helpful Capybara Methods

```ruby
visit(path)
expect(page).to have_content("content")
expect(page).to have_css("css_selector")
within("css_selector") {
  # Assertions here
}
save_and_open_page #must have `gem launchy` in Gemfile
```

### A More Realistic Test

Let's write a feature spec for creating a horse:

```bash
$ touch spec/features/user_creates_horse_spec.rb
```

Inside that file:

```ruby
RSpec.feature "User creates horse" do
  scenario "with valid attributes" do
    # Your code here.
  end
end
```

#### Form- and Button-Specific Methods

```ruby
fill_in("name_of_field", with: content)
click_link("css_selector")
click_button("css_selector")
click_link_or_button("css_selector")
expect(current_path).to eq('/')
```

### Workshop

Work to write user stories and feature tests for the following:

* That all horses are displayed on the Horse index
* That a Jockey's total winnings are displayed on their individual page
* The process of creating a Horse
* The process of editing a Horse's winnings

## Resources

* [Capybara cheat sheet](https://gist.github.com/zhengjia/428105)
* [Another cheat sheet](http://cheatrags.com/capybara)
* [Yet another cheat sheet](https://thoughtbot.com/upcase/test-driven-rails-resources/capybara.pdf)
* [Simple Tricks for Capybara](http://www.elabs.se/blog/51-simple-tricks-to-clean-up-your-capybara-tests)
