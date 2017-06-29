---
title: Model Testing in Sinatra with RSpec
length: 120
tags: sinatra, models, tdd, validations, scopes
---

## Goals

* set up RSpec within a Sinatra web app
* test model methods and validations using best practices in RSpec

## Warmup

1) Read [this](https://robots.thoughtbot.com/four-phase-test) Thoughtbot article about the four-phase test design.

2) We'll be using RSpec for this lesson. Read [this documentation](https://relishapp.com/rspec/rspec-core/docs/example-groups/basic-structure-describe-it) as an introduction to the RSpec syntax. 

With a pair:  

* Find a test you wrote in Mod 1. Can you map the four phases of testing to that test?
* What similarities and differences do you see between the syntax of Minitest and RSpec? 

## Repository

If you already have a copy of the `intro-to-ar` repo, cd into it and type:

`git checkout crud_complete`

If you do not have a copy of the `intro-to-ar` repo: 

`git clone -b crud_complete git@github.com:turingschool/intro-to-ar.git`

## Intro to RSpec

* Slightly different than Minitest, but not by much.
    * `describe` blocks as an outside wrapper to group related tests: use for *things*
    * `context` blocks to add... context (but technically the same method as `describe`): use for *states*
    * `it` blocks to indicate an outcome (something to test)
    * `expect` instead of assert

## Code-Along

### Setting up Model Tests

**STEP 1**: Install rspec

Add the following line to your `Gemfile`

```ruby
gem 'rspec'
```

Run `bundle`.

**STEP 2**: Create File structure

Make sure you are in the root of your app. 

* `touch .rspec`
* `mkdir spec`
* `touch spec/spec_helper.rb`

The shortcut to this step is to type `rspec --init`. However, this creates a bloated `spec_helper.rb` file that is, to be honest, more scary than helpful when you're first starting out. 

Within the `spec` folder, we'll create another folder called models. This way we can separate our model tests from our feature tests (more on this tomorrow).

```
$ mkdir spec/models
```

**STEP 3**: Configurations in .rspec file

Your `.rspec` file can contain certain flags that are helpful when you run your tests. 

    --require spec_helper
    --color
    --format documentation
    --order random
    


**STEP 4**: Set up the `spec_helper.rb` file:

Add the following to your `spec_helper.rb` file:

```ruby
require 'bundler'
Bundler.require(:default, :test)
require File.expand_path('../../config/environment.rb', __FILE__)
```

Let's take a second to talk about what those three lines are doing. 

### Setup of a Model Spec File

Now, let's create a file for testing our first model, Horse:

```
$ touch spec/models/horse_spec.rb
```

There are numerous ways to organize a model spec. However, let's work with [this approach](https://jarredtrost.com/how-to-organize-model-specs-82c10a59c24f). Take a few minutes to read the article. 

With a pair: What's the general approach recommended by this article for organizing a model spec? What are the benefits? 

### Testing the `.total_winnings` Class Method

Before we start testing anything, let's delete any model code that already exists so that we can truly mimic a TDD process. Head into `horse.rb` and `jockey.rb` to remove existing methods. (Don't be sad. It's good practice for you. Code isn't valuable anyway.)

Let's write our first model test. In `spec/models/horse_spec.rb`:

```ruby
RSpec.describe Horse do
  describe "Class Methods" do
    describe ".total_winnings" do
      it "returns total winnings for all horses" do
        Horse.create(name: "Phil", age: 22, total_winnings: 3)
        Horse.create(name: "Penelope", age: 24, total_winnings: 4)

        expect(Horse.total_winnings).to eq(7)
      end
    end
  end
end
```

Let's discuss: 

* the dot in `.total_winnings`: check out [this best practice](http://www.betterspecs.org/#describe)
* the space between the created horses and the expectation

At this point you should be able to run your tests from the command line using the command `rspec`. 

*Note*: `rspec` will also take some flags to change the output. For a full list run `rspec --help | less`. For example, run `rspec -c -f d` to see how the output differs. If you find yourself consistently using flags you can save them to a `.rspec` file in your home directory. See [this](http://stackoverflow.com/questions/1819614/how-do-i-globally-configure-rspec-to-keep-the-color-and-format-specdoc-o) Stack Overflow answer for additional details.

Did we get what we expected? No? What's going on here? It looks like the total that's being reported by our test is the full total of our all the horses currently in our database.

Run it one more time to check. Notice that the actual value that we're getting increased? So, not only are we not testing with only the data we're providing in the test, but on top of that, every time we run the test we're adding new horses to our development database.

This is not the behavior we want. We're polluting the database that we're using when we browse the site locally. Wouldn't it be better if we could run our test suite without making these changes?

Every time we run our tests, we want to start with a fresh slate with no existing data in our test database. Because of this, we need to have two different databases: one for testing purposes and one for development purposes. This way, we will still have access to all of our existing data when we run shotgun and look at our app in the browser, but we won't have to worry about those pieces interfering with our tests because they'll be in a separate database.

How will our app know which environment -- test or dev -- we want to use at any moment? By default (like when we start the server with shotgun), we will be in development. If we want to run something in the test environment, we need an indicator. We'll use an environment variable: ENV["RACK_ENV"]. So, in test/test_helper.rb:

We're going to set an environment variable in our spec helper file and then use that variable to determine which database to use. In `spec_helper.rb` add the following **above** all the `require` lines:

```ruby
ENV["RACK_ENV"] = "test"
```

It's very important that this line comes before you require the environment. If you want to trace why, take a look first at line 14 in your `config/environment.rb` file, which should lead you to the `config/database.rb` file. In that file, you'll see that the database name gets set based on the current environment.

One more step and then we should be in good shape. From the command line:

```
$ rake db:test:prepare
```

This should both create and run the migrations for a test database (you should be able to see the new file in your `db` directory). Now run your test again from the command line using `rspec`. Passing test? Great!

Run the test again. Failing test! Damn.

What's happening here? Before we were saving new horses to our development database every time we ran our test suite. Now we're doing the same thing to our test database. What we'd like to do is to clear out our database after each test. We could create these methods in each one of our tests, but there's a tool that will help us here: [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner).

In the test/development section of your Gemfile add the following line:

```ruby
  gem 'database_cleaner'
```

Then in your spec helper, add the following after your current `require` lines:

```ruby
DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end
```

Save and run your tests again from the command line. Passing test? Great again!

### Testing Validations

One thing we haven't really worried about up to this point was whether or not a new Horse had all of its pieces in place when we were saving it to the database. We want to make sure that when someone tries to save a horse that they're providing us with all the information we need. We don't want to have someone save a horse with, for example, no name.

Add the following test to your `horse_spec` within the main `describe Horse` block, but outside of your existing `describe 'Class Methods'` block.

```ruby
describe "Validations" do
  it "is invalid without a name" do
    horse = Horse.new(age: 22, total_winnings: 14)

    expect(horse).to_not be_valid
  end
end
```

Run your test suite from the command line with `rspec` and look for the new failure. The heart of this error is telling us that it expected `.valid?` to return false when called on our new horse, and instead got true.

Great! It seems like this is testing what we want, but how can we actually make this pass?

### Writing Validations

ActiveRecord actually helps us out here. Go into the `app/models/horse.rb` model and add the following line:

```ruby
  validates :name, presence: true
```

Alternatively, you can write this as: `validates_presence_of :name`

Run your tests again, and... passing. Great news.

## Worktime

* In pairs, add the following tests and make each one pass:
    * a test for an `.average_winnings` class method
    * a test for an `#age_in_months` instance method that returns the horse's age in months
    * tests that a horse cannot be created without an age or `total_winnings`
    * a test for the `.total_winnings` method that ensures that when two jockeys exist, you're able to scope `.total_winnings` down to a single jockey by calling something like `Jockey.first.horses.total_winnings` (hint: you'll need to create your associations in your test, and make sure that `total_winnings` for the second jockey are not included in the `.total_winnings` result)
    * a test to ensure that the name of each of our Jockeys is `unique`. Write a test that would ensure we can't create two Jockeys with the same name, and then use the ActiveRecord documentation available [here](http://guides.rubyonrails.org/active_record_validations.html#uniqueness) to see what you could do to ensure the `uniqueness` of a new jockey.

Remember to use your four phases of testing! 

## Finished? 

* Take a look at the [BetterSpecs](http://www.betterspecs.org/) community guidelines. 
* Check out the [RSpec Documentation](http://rspec.info/documentation/): For now you'll likely be most interested in the `rspec-core`, and `rspec-expectations` links.
