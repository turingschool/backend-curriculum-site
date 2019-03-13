---
title: Model Testing in RSpec for a Sinatra App
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

We will continue to use the [Set List repository](https://github.com/turingschool-examples/set-list) that we used in the Intro to ActiveRecord lesson.

## Warmup

1) Read [this](https://robots.thoughtbot.com/four-phase-test) Thoughtbot article about the four-phase test design.
2) Thinking about what you just read, what did this look like in Minitest?

## Lecture

### Intro to RSpec

* Slightly different than Minitest, but not by much.
    * `describe` blocks as an outside wrapper to group related tests: use for *things*
    * `context` blocks to add... context (but technically the same method as `describe`): use for *states*
    * `it` blocks to indicate an outcome (something to test)
    * `scenario` blocks to indicate an outcome (something to test)
    * `expect` instead of assert

* Model testing describes our "bottom-up" design, and shows other developers how our model code should work within our application.


## Code-Along

### Setting up Model Tests

**STEP 1**: Install `rspec`

Add the following line to the block labeled `group :development, :test` in your `Gemfile`

```ruby
gem 'rspec'
```

Run `bundle`.

Next, make sure you are in the root folder of your app.

**STEP 2**: Configurations in .rspec file

* `touch .rspec`

Your `.rspec` file can contain certain flags that are helpful when you run your tests.

```
--require spec_helper
--format=documentation
--order=random
```

*Note*: `rspec` can take command-line flags also take some flags to change its output. For a full list run `rspec --help | less`. These flags can be stored within this `.rspec` file to be used each time.

See [this](http://stackoverflow.com/questions/1819614/how-do-i-globally-configure-rspec-to-keep-the-color-and-format-specdoc-o) Stack Overflow answer for additional details.


**STEP 3**: Set up the `spec_helper.rb` file:

* `mkdir spec`
* `touch spec/spec_helper.rb`

Add the following to your `spec_helper.rb` file:

```ruby
require 'bundler'
Bundler.require(:default, :test)
require File.expand_path('../../config/environment.rb', __FILE__)
```

First this will require the `bundler` gem, then use that gem to require the other gems we have loaded in the `default` and `test` groups in our Gemfile.

Finally, we require the `environment.rb` file, which loads up the rest of our application so that we can use it in our tests.

### Create a Model Spec

* `mkdir spec/models`
* `touch spec/models/song_spec.rb`

In `spec/models/song_spec.rb`:

There are many ways we could choose to use RSpec `describe` and `context` blocks to organize our tests, but for our purposes today, we're going to use the following:

```ruby
RSpec.describe Song, type: :model do
  describe "Class Methods" do
    describe ".total_play_count" do
      it "returns total play counts for all songs" do
        Song.create(title: "Song 1", length: 180, play_count: 3)
        Song.create(title: "Song 2", length: 220, play_count: 4)

        expect(Song.total_play_count).to eq(7)
      end
    end
  end
end
```

Let's discuss:

* the dot in `.total_play_count`: check out [this best practice](http://www.betterspecs.org/#describe)
* the space between the created songs and the expectation

At this point you should be able to run your tests from the command line using the command `rspec`.

### Make it Pass

What do we get? Errors! Great. We can follow errors. These errors are a bit different from Minitest Errors. Let's take a look:
```ruby
Randomized with seed 28022

Song
  Class Methods
    .total_play_count
      returns total play counts for all songs (FAILED - 1)

Failures:

  1) Song Class Methods .total_play_count returns total play counts for all songs
     Failure/Error: expect(Song.total_play_count).to eq(7)

     NoMethodError:
       undefined method `total_play_count' for #<Class:0x007fea2ab582d8>
     # /Users/ian/.rvm/gems/ruby-2.4.0/gems/activerecord-5.1.4/lib/active_record/dynamic_matchers.rb:22:in `method_missing'
     # ./spec/models/song_spec.rb:9:in `block (4 levels) in <top (required)>'

Finished in 0.02851 seconds (files took 0.80607 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/models/song_spec.rb:5 # Song Class Methods .total_play_count returns total play counts for all songs

Randomized with seed 28022
```
First we see the Randomized seed, which is a record of the random order the tests were run this time around.

Next we see the descriptors from our describe, context, and it blocks. Now we see a failure which should be a bit more familiar to you:

```ruby
NoMethodError:
       undefined method `total_play_count' for #<Class:0x007fea2ab582d8>
```

Add that method into our Song model.

```ruby
# app/models/song.rb
def self.total_play_count

end
```
Run our spec again and it tells us:

```ruby
  1) Song Class Methods .total_play_count returns total play counts for all songs
     Failure/Error: expect(Song.total_play_count).to eq(7)

       expected: 7
            got: nil

       (compared using ==)
     # ./spec/models/song_spec.rb:9:in `block (4 levels) in <top (required)>'
```

The error we see now should be pretty familiar. What is causing our method to return `nil` instead of 7?
We need to populate it with something -- the sum of the play_count for each Song in the database.

ActiveRecord has just what we need:

```ruby
# app/models/song.rb
def self.total_play_count
  sum(:play_count)
end
```

What's happening here? Well, `sum` is an ActiveRecord method that will sum a particular column of values in a single table within our database (it can't sum things across different tables). How does it know which column? We pass it the column name as an argument using 'symbol notation'.

How does it know that we're trying to call this method on our `songs` table? The implicit receiver of the `sum` method is `self` in the method definition, which in this case is the class Song.

**This is an example of a Class Method -- ActiveRecord calls on the entire class are usually used for performing work on EVERY row in the Class' table**

Great! Run our tests again, and we still get an error.

```ruby
  1) Song Class Methods .total_play_count returns total play counts for all songs
     Failure/Error: expect(Song.total_play_count).to eq(7)

       expected: 7
            got: 1972034
```

What's going on here?

It looks like the total that's being reported by our test is the full total of our all the songs currently in our database.

Run it one more time to check. Notice that the actual value that we're getting increased? So, not only are we not testing with only the data we're providing in the test, but on top of that, every time we run the test we're adding new songs to our development database.

This is not the behavior we want. We're "polluting" the database that we're using when we browse the site locally. Wouldn't it be better if we could run our test suite without making these changes?

Every time we run our tests, we want to start with a fresh slate with no existing data in our test database. Because of this, we need to have two different databases: one for testing purposes and one for development purposes. This way, we will still have access to all of our existing data when we run shotgun and look at our app in the browser, but we won't have to worry about those pieces interfering with our tests because they'll be in a separate database.

How will our app know which environment -- test or dev -- we want to use at any moment? By default (like when we start the server with shotgun), we will be in development. If we want to run something in the test environment, we need an indicator. We'll use an environment variable: `ENV["RACK_ENV"]`.

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

Run the test again a few times. Failing test! Hmm.

What's happening here? Before we were saving new songs to our development database every time we ran our test suite. Now we're doing the same thing to our test database. What we'd like to do is to clear out our database after each test. We could create these methods in each one of our tests, but there's a tool that will help us here: [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner).

In the test/development section of your Gemfile add the following line:

```ruby
  gem 'database_cleaner'
```

Run `bundle install`

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

Save and run your tests again from the command line. Passing test? Great! Run it one more time to double check.

### Testing Validations

One thing we haven't really worried about up to this point was whether or not a new Song had all of its pieces in place when we were saving it to the database. We want to make sure that when someone tries to save a song that they're providing us with ALL the information our app needs. We don't want to have someone save a song with, for example, no title.

Add the following test to your `song_spec` within the main `describe Song` block, but outside of your existing `describe 'Class Methods'` block.

```ruby
describe "Validations" do
  it "is invalid without a title" do
    song = Song.new(length: 207, play_count: 2)

    expect(song).to_not be_valid
  end
end
```

Run your test suite from the command line with `rspec` and look for the new failure.

```ruby
  1) Song Validations is invalid without a title
     Failure/Error: expect(song).to_not be_valid
       expected `#<Song id: nil, title: nil, year: 207, play_count: 2, created_at: nil, updated_at: nil>.valid?` to return false, got true
     # ./spec/models/song_spec.rb:7:in `block (3 levels) in <top (required)>'
```

- Under Song, Class Methods, .total_play_count you should see a green `returns total play counts for all songs`. That is our old test still passing.   
- Under Song, Validations, you should see a red `is invalid without a title (FAILED -1)`  

The output of this error is telling us that it expected `.valid?` to return `false` when called on our new song, and instead got `true`.

Great! It seems like this is testing what we want, but how can we actually make this test pass?

### Writing Validations

ActiveRecord actually helps us out here by providing a `validates` method which we'll pass the column name in the form of a symbol, and an options hash `{presence: true}`. The convention we use is the following format:

Go into the `app/models/song.rb` model and add the following line:

```ruby
  validates :title, presence: true
```

Alternatively, you can write this as: `validates_presence_of :title`. This is nice if you want to validate the presence of multiple columns.

Run your tests again, and... passing. Great news.

## Worktime

* In pairs, add the following tests and make each one pass:
  * a test for an `.average_play_count` class method
  * tests that a song cannot be created without a `title` or `length`

Remember to use your four phases of testing!

## Finished?

* Take a look at the [BetterSpecs](http://www.betterspecs.org/) community guidelines.
* Check out the [RSpec Documentation](http://rspec.info/documentation/): For now you'll likely be most interested in the `rspec-core`, and `rspec-expectations` links.

## Recap

* What goes into your spec_helper in a Sintra app? What does each piece do?
* Create a Venn Diagram comparing MiniTest & RSpec. Think about set up of methods and how you check expected outcomes.
