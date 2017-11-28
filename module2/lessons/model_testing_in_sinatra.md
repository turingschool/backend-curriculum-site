---
title: Model Testing in Sinatra with RSpec
length: 120
tags: sinatra, models, tdd, validations, scopes, testing
---

## Learning Goals

* set up RSpec within a Sinatra web app
* test model methods and validations using best practices in RSpec

## Vocab
* RSpec
* Model Testing

## Repository

We will continue to use the Film File repository that we used in the Intro to ActiveRecord lesson.

## Warmup

1) Read [this](https://robots.thoughtbot.com/four-phase-test) Thoughtbot article about the four-phase test design.
2) Thinking about what you just read, what did this look like in Minitest?

## Lecture

### Intro to RSpec

* Slightly different than Minitest, but not by much.
    * `describe` blocks as an outside wrapper to group related tests: use for *things*
    * `context` blocks to add... context (but technically the same method as `describe`): use for *states*
    * `it` blocks to indicate an outcome (something to test)
    * `expect` instead of assert

## Code-Along

### Setting up Model Tests

**STEP 1**: Install rspec

Add the following line to the block labeled `group :development, :test` in your `Gemfile`

```ruby
gem 'rspec'
```

Run `bundle`.

**STEP 2**: Create File structure

Make sure you are in the root of your app.

* `touch .rspec`
* `mkdir spec`
* `touch spec/spec_helper.rb`
* `mkdir spec/models`
* `touch spec/models/film_spec.rb`

**STEP 3**: Configurations in .rspec file

Your `.rspec` file can contain certain flags that are helpful when you run your tests.

    --require spec_helper
    --color
    --format=documentation
    --order=random

**STEP 4**: Set up the `spec_helper.rb` file:

Add the following to your `spec_helper.rb` file:

```ruby
require 'bundler'
Bundler.require(:default, :test)
require File.expand_path('../../config/environment.rb', __FILE__)
```

First this will require the `bundler` gem, then use that gem to require the other gems we have loaded in the `default` and `test` groups in our Gemfile.

Finally, we require the `environment.rb` file, which loads up the rest of our application so that we can use it in our tests.

### Create a Model Spec

In `spec/models/film_spec.rb`:

There are many ways we could choose to use RSpec `describe` and `context` blocks to organize our tests, but for our purposes today, we're going to use the following:

```ruby
RSpec.describe Film do
  describe "Class Methods" do
    describe ".total_box_office_sales" do
      it "returns total box office sales for all films" do
        Film.create(title: "Fargo", year: 2017, box_office_sales: 3)
        Film.create(title: "Die Hard", year: 2016, box_office_sales: 4)

        expect(Film.total_box_office_sales).to eq(7)
      end
    end
  end
end
```

Let's discuss:

* the dot in `.total_box_office_sales`: check out [this best practice](http://www.betterspecs.org/#describe)
* the space between the created films and the expectation

At this point you should be able to run your tests from the command line using the command `rspec`.

*Note*: `rspec` will also take some flags to change the output. For a full list run `rspec --help | less`. For example, run `rspec -c -f d` to see how the output differs. If you find yourself consistently using flags you can save them to a `.rspec` file in your home directory. See [this](http://stackoverflow.com/questions/1819614/how-do-i-globally-configure-rspec-to-keep-the-color-and-format-specdoc-o) Stack Overflow answer for additional details.

### Make it Pass

What do we get? Errors! Great. We can follow errors. These errors are a bit different from Minitest Errors. Let's take a look:
```ruby
Randomized with seed 28022

Film
  Class Methods
    .total_box_office_sales
      returns total box office sales for all films (FAILED - 1)

Failures:

  1) Film Class Methods .total_box_office_sales returns total box office sales for all films
     Failure/Error: expect(Film.total_box_office_sales).to eq(7)

     NoMethodError:
       undefined method `total_box_office_sales' for #<Class:0x007fea2ab582d8>
     # /Users/aleneschlereth/.rvm/gems/ruby-2.4.0/gems/activerecord-5.1.4/lib/active_record/dynamic_matchers.rb:22:in `method_missing'
     # ./spec/models/film_spec.rb:9:in `block (4 levels) in <top (required)>'

Finished in 0.02851 seconds (files took 0.80607 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/models/film_spec.rb:5 # Film Class Methods .total_box_office_sales returns total box office sales for all films

Randomized with seed 28022
```
First we see the Randomized seed, which is a record of the random order the tests were run this time around.
Next we see the descriptors from our describe, context, and it blocks. Now we see a failure which should be a bit more familiar to you.

```ruby
NoMethodError:
       undefined method `total_box_office_sales' for #<Class:0x007fea2ab582d8>
```
Let's add that method now.

```ruby
# film.rb
def self.total_box_office_sales

end
```
Run our spec again and it tells us:

```ruby
Randomized with seed 33027

Film
  Class Methods
    .total_box_office_sales
      returns total box office sales for all films (FAILED - 1)

Failures:

  1) Film Class Methods .total_box_office_sales returns total box office sales for all films
     Failure/Error: expect(Film.total_box_office_sales).to eq(7)

       expected: 7
            got: nil

       (compared using ==)
     # ./spec/models/film_spec.rb:9:in `block (4 levels) in <top (required)>'

Finished in 0.08559 seconds (files took 0.80613 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/models/film_spec.rb:5 # Film Class Methods .total_box_office_sales returns total box office sales for all films

Randomized with seed 33027
```

These error messsages are a lot longer, but in the middle we see

```ruby
expected: 7
     got: nil
```

Which should be pretty familiar. What is causing our method to return nil instead of 7?
We need to populate it with something, the sum of the box_office_sales for each Film in the database.

ActiveRecord has just what we need:

```ruby
#film.rb
def self.total_box_office_sales
  sum(:box_office_sales)
end
```

What's happening here? Well, `sum` is an ActiveRecord method that will sum a particular column of values in our database. How does it know which column? We pass it the column name as a symbol as an argument.

How does it know that we're trying to call this method on our `films` table? The implicit receiver of the `sum` method is `self`, which in this case is the class Film.

Great! Run our tests again, and we still get an error.

What's going on here? It looks like the total that's being reported by our test is the full total of our all the films currently in our database.

Run it one more time to check. Notice that the actual value that we're getting increased? So, not only are we not testing with only the data we're providing in the test, but on top of that, every time we run the test we're adding new films to our development database.

This is not the behavior we want. We're polluting the database that we're using when we browse the site locally. Wouldn't it be better if we could run our test suite without making these changes?

Every time we run our tests, we want to start with a fresh slate with no existing data in our test database. Because of this, we need to have two different databases: one for testing purposes and one for development purposes. This way, we will still have access to all of our existing data when we run shotgun and look at our app in the browser, but we won't have to worry about those pieces interfering with our tests because they'll be in a separate database.

How will our app know which environment -- test or dev -- we want to use at any moment? By default (like when we start the server with shotgun), we will be in development. If we want to run something in the test environment, we need an indicator. We'll use an environment variable: ENV["RACK_ENV"].

We're going to set an environment variable in our spec helper file and then use that variable to determine which database to use. In `spec_helper.rb` add the following **above** all the `require` lines:

```ruby
ENV["RACK_ENV"] = "test"
```

It's very important that this line comes before you require the environment. If you want to trace why, take a look first at line 14 in your `config/environment.rb` file, which should lead you to the `config/database.rb` file. In that file, you'll see that the database name gets set based on the current environment.

One more step and then we should be in good shape. From the command line:

```
$ rake db:test:prepare
```

This should both create and run the migrations for a test database (you should be able to see the new file in your `db` directory).

Now run your test again from the command line using `rspec`. Passing test? Great!

Run the test again. Failing test! Damn.

What's happening here? Before we were saving new films to our development database every time we ran our test suite. Now we're doing the same thing to our test database. What we'd like to do is to clear out our database after each test. We could create these methods in each one of our tests, but there's a tool that will help us here: [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner).

In the test/development section of your Gemfile add the following line:

```ruby
  gem 'database_cleaner'
```

Then in your `spec_helper.rb`, add the following after your current `require` lines:

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

This will clean the database before all tests and after each test. This ensures that if we stop our test suite at any point before it finishes, we will still have a clean database.

Save and run your tests again from the command line. Passing test? Great! Run it one more time to double check? Great again!

### Testing Validations

One thing we haven't really worried about up to this point was whether or not a new Film had all of its pieces in place when we were saving it to the database. We want to make sure that when someone tries to save a film that they're providing us with all the information we need. We don't want to have someone save a film with, for example, no title.

Add the following test to your `film_spec` within the main `describe Film` block, but outside of your existing `describe 'Class Methods'` block.

```ruby
describe "Validations" do
  it "is invalid without a title" do
    film = Film.new(year: 2017, box_office_sales: 2)

    expect(film).to_not be_valid
  end
end
```

Run your test suite from the command line with `rspec` and look for the new failure.

```ruby
Randomized with seed 20037

Film
  Validations
    is invalid without a title (FAILED - 1)
  Class Methods
    .total_box_office_sales
      returns total box office sales for all films

Failures:

  1) Film Validations is invalid without a title
     Failure/Error: expect(film).to_not be_valid
       expected `#<Film id: nil, title: nil, year: 2017, box_office_sales: 2, created_at: nil, updated_at: nil>.valid?` to return false, got true
     # ./spec/models/film_spec.rb:7:in `block (3 levels) in <top (required)>'

Finished in 0.07235 seconds (files took 0.81411 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/models/film_spec.rb:4 # Film Validations is invalid without a title

Randomized with seed 20037
```
Under Film, Class Methods, .total_box_office_sales you should see a green `returns total box office sales for all films`. That is our old test still passing.   
Under Film, Validations, you should see a red `is invalid without a title (FILED -1)`  
Then when we look under the `Failures:` section it tells us

```ruby
Failure/Error: expect(film).to_not be_valid
       expected `#<Film id: nil, title: nil, year: 2017, box_office_sales: 2, created_at: nil, updated_at: nil>.valid?` to return false, got true
```

The heart of this error is telling us that it expected `.valid?` to return false when called on our new film, and instead got true.

Great! It seems like this is testing what we want, but how can we actually make this pass?

### Writing Validations

ActiveRecord actually helps us out here by providing a `validates` method which we'll pass the column name in the form of a symbol, and an options hash `{presence: true}`. We *could* format it like this, `validates(:title, {presence: true})`. However, convention is to use the following format:

Go into the `app/models/film.rb` model and add the following line:

```ruby
  validates :title, presence: true
```

Alternatively, you can write this as: `validates_presence_of :title`. This is nice if you want to validate the presence of multiple columns.

Run your tests again, and... passing. Great news.

## Worktime

* In pairs, add the following tests and make each one pass:
    * a test for an `.average_box_office_sales` class method
    * tests that a film cannot be created without a `year` or `box_office_sales`

Remember to use your four phases of testing!

## Finished?

* Take a look at the [BetterSpecs](http://www.betterspecs.org/) community guidelines.
* Check out the [RSpec Documentation](http://rspec.info/documentation/): For now you'll likely be most interested in the `rspec-core`, and `rspec-expectations` links.

## Recap
* What goes into your spec_helper in a Sintra app? What does each piece do?
* Create a Venn Diagram comparing MiniTest & RSpec. Think about set up of methods and how you check expected outcomes.
