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

If you already have a copy of the `intro-to-ar` repo, cd into it, make sure everything is added and committed, then check out a new branch:

`git checkout -b feature_testing`

If you do not have a copy of the `intro-to-ar` repo: 

`git clone -b model_tests git@github.com:turingschool/intro-to-ar.git feature_testing`

## Warmup

* What are we testing so far in our Horses app?
* What aren't we testing?
* Assuming that these unwritten tests will have some setup, execution, assertions, and teardown, what might be included in each phase?

## What are Feature Tests?

* What are other types of tests? Unit, model (type of unit test), integration, feature (type of integration)...
* Feature tests mimic the behavior of the user: In the case of web apps, this behavior will be clicking, filling in forms, moving to new pages, etc.
* Just like a user, the feature test should not need to know about underlying code
* Based on user stories

## What are User Stories?

* A tool used to communicate user needs to software developers.
* It is used in Agile Development, and it was first introduced in 1998 by proponents of Extreme Programming.
* It describes what a user needs to do in order to fulfill job function.

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
...
Then [expected result]
```

Depending on how encompassing a user story is, you may want to make multiple Waffle cards from a single story.

### Exercise: Create User Stories

Open a blank file and write user stories for the four situations below with a partner: 

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
Capybara.save_and_open_page_path = 'tmp/capybara'

# within the RSpec configuration (this is the same place you have your database cleaner options set): 

  c.include Capybara::DSL
```

### How to Format Feature Specs

We're going to look at the formatting of feature tests in Rails. Because we do not have the `rspec-rails` gem in Sinatra, our feature tests will use different wording than `feature` and `scenario`, but the wording below is what you'll be using after you move to Rails. 

There are three general schools of thought:

1) Scenario string contains context information that forms complete sentence with feature string; does not contain desired outcome

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

3) Scenario contains brief description of user action without desired outcome 

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

Regardless, I encourage you to choose a pattern and stick with it. Try not to mix the approaches together. 

The difference in our Sinatra apps is that we will use `describe` instead of `feature` and `it` instead of `scenario`. 

### Making the Test

Since we're going to be creating a new type of test, let's add a new folder to separate them from our model tests. The test that we're about to create is probably *not* a test you'd actually write in your project, but it's a simple example to show how Capybara works. 

```bash
$ mkdir spec/features/
$ touch spec/features/user_sees_welcome_spec.rb
```

In that new file add the following:

```ruby
RSpec.describe "User visits '/'" do
  it "and sees a welcome message" do
    # Your code here.
  end
end

# In Rails, you would use:

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

Let's write a feature spec for creating a Jockey:

```bash
$ touch spec/features/user_creates_jockey_spec.rb
```

Inside that file:

```ruby
RSpec.describe "User creates jockey" do
  it "with valid attributes" do
    # Your code here.
  end
end

# In Rails, it would look like this: 

RSpec.feature "User creates jockey" do
  scenario "with valid attributes" do
    # Your code here.
  end
end
```

#### Form- and Button-Specific Methods

```ruby
fill_in("name_of_field", with: content) # use the name= attribute from the HTML
select("text", :from => 'name_of_field') # use the name= attribute from the HTML
click_link("text")
click_button("text")
click_link_or_button("text")
expect(current_path).to eq('/')
```

### What about all of those html files from save_and_open_page?

They should be living in your `tmp/capybara` directory since you used this line in your spec_helper: `Capybara.save_and_open_page_path = 'tmp/capybara'`

However, they will still be watched by git unless you make a `.gitignore` file at the root of your project:

```bash
$ touch .gitignore
```

Then, inside that file, add:

```
/tmp
```

This will tell git to ignore everything inside of the `tmp` directory. 

### Workshop

Work to write user stories and feature tests for the following:

* Mild: That all jockeys are displayed on the Jockey index
* Mild: The process of editing a breed
* Medium: That a Jockey's total winnings are displayed on their individual page
* Spicy: The process of creating a Horse (hint: think of what data needs to exist in the database in order to create a horse)

## Resources

* [Capybara cheat sheet](https://gist.github.com/zhengjia/428105)
* [Another cheat sheet](http://cheatrags.com/capybara)
* [Yet another cheat sheet](https://thoughtbot.com/upcase/test-driven-rails-resources/capybara.pdf)
* [Simple Tricks for Capybara](http://www.elabs.se/blog/51-simple-tricks-to-clean-up-your-capybara-tests)
