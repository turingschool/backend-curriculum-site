---
title: Feature Testing in RSpec for a Sinatra App
length: 120
tags: capybara, user stories, feature tests, testing, sinatra
---

## Learning Goals

* differentiate between feature tests and model tests
* write user stories
* translate user stories into feature tests using Capybara

## Vocabulary
* feature test
* user story
* "top-down" design
* DSL (Domain Specific Language)

## Repository

You should be able to use the `Set List` repository that we have been using this week.
* https://github.com/turingschool-examples/set-list

## Warmup

* What are we testing so far in our SetList app?
* What aren't we testing?
* Assuming that our tests will have some setup, execution, assertions, and teardown, what might be included in each phase?

## Lecture

## What are Feature Tests?

* Feature tests mimic the behavior of the user: In the case of web apps, this behavior will be clicking, filling in forms, visiting new pages, etc.
* Just like a user, the feature test should not need to know about underlying code
* Based on user stories

## What are User Stories?

* A tool used to communicate user needs to software developers.
* They are used in Agile Development, and it was first introduced in 1998 by proponents of Extreme Programming.
* They describe what a user needs to do in order to fulfill a function.
* They are part of our "top-down" design.

```txt
As a user
When I visit the home page
  And I fill in title
  And I fill in description
  And I click submit
Then my task is saved
```

We can generalize this pattern as follows:

```
As a [user/user-type]
When I [action]
And I [action]
And I [action]
...
Then [expected result]
```

Depending on how encompassing a user story is, you may want to break a single user story into multiple, smaller user stories.

### Exercise: Create User Stories

Open a blank file and write user stories for the four situations below with a partner:

* Adding a Horse to HorsesApp
* Signing up for a new account
* Logging into an account
* Viewing only the Horses associated with a specific Jockey

## Creating Our Feature Test

[Capybara](https://github.com/teamcapybara/capybara#using-capybara-with-rspec)

Capybara is a Ruby test framework that allows you to feature test any RACK-based app.

It provides a DSL (domain specific language) to help you query and interact with the DOM.

For example, the following methods are included in the Capybara DSL:

* `visit '/path'`
* `expect(page).to have_content("Content")`
* `within ".css-class"  { Assertions here }`
* `within "#css-id"  { Assertions here }`
* `fill_in "identifier", with: "Content"`
* `expect(page).to have_link("Click here")`
* `click_link "Click Here"`
* `expect(page).to have_button("Submit")`
* `click_button "Submit"`
* `click_on "identifier"`
* `expect(current_path).to eq('/')`

### Important Setup Things

Ensure the following lines are present in your `Gemfile` in the `:development, :test` group:

```ruby
gem 'capybara'
gem 'launchy'
gem 'simplecov'
```

Run `bundle install`

Update your `spec/spec_helper.rb` file to include the following:

```ruby
# other required items here

# SimpleCov will help us see which lines of code we've tested or not
require 'simplecov'
SimpleCov.start

require 'capybara/dsl'
Capybara.app = SetList
Capybara.save_path = 'tmp/capybara'

# within the RSpec configuration (this is the same place you have your database cleaner options set):

  c.include Capybara::DSL
```
NOTE: If you do not have a `spec/spec_helper.rb` follow the set up directions found [here](http://backend.turing.edu/module2/lessons/model_testing_in_rspec_for_sinatra_app)

### Writing the Test

Based on the following user story, let's learn how to write a feature test:

```
As an unauthenticated user
When I visit the home page of the site
Then I see a "welcome" message
```

Since we're going to be creating a new type of test, let's add a new folder to separate them from our model tests. The test that we're about to create is probably *not* a test you'd actually write in your project, but it's a simple example to show how Capybara works.

```bash
$ mkdir spec/features/
$ touch spec/features/user_sees_welcome_message_spec.rb
```

In that new file add the following:

```ruby
RSpec.describe "an unauthenticated user visiting welcome page" do
  it "should see a welcome message" do
    # Your code here.
  end
end
```

Now, our user story is something along the lines of the following:

* As an unauthenticated user
* When I visit the root page
* I should see a welcome message

Let's turn that user story into a test using the Capybara methods from above and make it pass.

```ruby
RSpec.describe "an unauthenticated user visits welcome page" do
  context "they visit /" do
    scenario "they see a welcome message" do
      visit '/'

      within "#greeting" do
        expect(page).to have_content("Welcome!")
      end
    end
  end
end
```

### Debugging tools

* use 'binding.pry' in your controller code, model code, tests
* use `save_and_open_page` to debug a view


### What about all of those html files from save_and_open_page?

If you used `save_and_open_page` in your test as you were trying to determine what should be included in your view, Launchy will have generated a number of files and saved them. They should be living in your `tmp/capybara` directory since you used this line in your spec_helper: `Capybara.save_path = 'tmp/capybara'`

However, they will still be watched by git unless you make a `.gitignore` file at the root of your project:

```bash
$ touch .gitignore
```

Then, inside that file, add:

```
tmp/
```

This will tell git to ignore everything inside of the `tmp` directory.

Do the same for the `coverage/` folder to avoid saving SimpleCov coverage files to Git.


## Notes about feature test file organization

The names of the files you create for feature testing MUST end in `_spec.rb`. Without that 'spec' part of the filename, RSpec will completely ignore the file.

How many tests should go in one file? It's totally up to you, but having multiple tests in a file is marginally faster than putting a single test in a single file. Also, grouping lots of tests into one file allows you to share the setup across your tests.

You can group your test files into subfolders to organize them in a similar format to your `/app/views` folder, and can help with strong organization. Every team you work on, every job you have, could have a completely different organizational method for test files, so keep that 'growth mindset' and be flexible!

```
/spec
/spec/features
/spec/features/songs
/spec/features/songs/index_spec.rb # all tests about the index page
/spec/features/songs/show_spec.rb  # all tests about the show page
etc
```

## Wrap Up

* What is the difference between a model and feature test?
* What are the 4 main methods (blocks) for a test? Why/when would you use each one?
* What is the general structure of a user story?


## Workshop

Since we've built a LOT of code in our previous lessons WITHOUT feature tests, let's back-fill some tests to make sure all of our functionality works for our users. Write tests for the following user stories:

```
As a visitor to the web site
When I visit '/songs/new'
And I fill in the form completely and click the Submit button
Then I return to the index page
And I see my new song on the page
```

```
As a visitor to the web site
When I visit '/songs'
Then I see all songs in the database
Each song shows its title, length, and play count
```


## Resources

* [Capybara cheat sheet](https://gist.github.com/zhengjia/428105)
* [Another cheat sheet](http://cheatrags.com/capybara)
* [Yet another cheat sheet](https://thoughtbot.com/upcase/test-driven-rails-resources/capybara.pdf)
* [Simple Tricks for Capybara](http://www.elabs.se/blog/51-simple-tricks-to-clean-up-your-capybara-tests)
