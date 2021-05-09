---
layout: page
title: Model Testing
tags: rails, models, testing
---

## Learning Goals

* Understand why Model Testing is important
* Setup an RSpec test suite in Rails
* Write model tests for instance methods

## Setup

This lesson builds off of the [Task Manager Tutorial](https://github.com/turingschool-examples/task_manager_rails). You can find the completed code from this tutorial [here](https://github.com/turingschool-examples/task_manager_rails_complete).

## Why Model Test?

As Backend developers, our job is to handle data. We need to add data, retrieve data, manipulate data, validate data, analyze data, etc. and we cannot afford to have any errors when handling data. Since our Models are the thing in our Rails apps that interact with the data, we write tests specifically for the models to ensure that we are handling data properly. These tests should fully cover all of the data logic in our application.

Now that we know why it is important to model test, let's add some model testing to Task Manager.

## Setup RSpec and SimpleCov

### Gems

We are going to use RSpec as our testing framework, so first thing is to install and set up RSpec.

In your `Gemfile` Inside the existing `group :development, :test` block, add

  * `gem 'rspec-rails'`
  * `gem 'pry'`
  * `gem 'simplecov'`

Your Gemfile should now have:

```ruby
group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'simplecov'
end
```

Always run `bundle install` whenever you update your Gemfile.

Now from the command line run:

```bash
$ rails g rspec:install
```

What new files did this generate?

- `./.rspec` file
- a whole `./spec/` directory
- `./spec/rails_helper.rb` is the new `spec_helper`, holds Rails-specific configurations
- `./spec/spec_helper.rb` - where we keep all specs that don't depend on rails

At the top of your `rails_helper.rb`, add these lines to configure SimpleCov:

```ruby
require 'simplecov'
SimpleCov.start
```

We'll also add a line for `coverage` to the `.gitignore` file so that our SimpleCov reports aren't pushed to github.

## Testing the Task Model

Let's start by creating a test file for the Task class. From the command line run:

`mkdir spec/models`  
`touch spec/models/task_spec.rb`

It is important that these folders are named `spec` and `models`, respectively.

In our new test file, add the following:

```ruby
require 'rails_helper'

RSpec.describe Task, type: :model do

end
```

This is the basic set up for any model test. `RSpec.describe Task` tells our test that we are testing the Task class. `type: :model` tells our test that it is a model test. You can optionally leave this out since our test will recognize that it is a model test because it is defined inside `spec/models`. Yes, the name of the folders and files will affect how your tests run.

Inside our model test, let's add a section for instance method tests:

```ruby
require 'rails_helper'

describe Task, type: :model do
  describe 'instance methods' do

  end
end
```

And inside that section, let's add another section for a test for a specific method:

```ruby
require 'rails_helper'

describe Task, type: :model do
  describe 'instance methods' do
    describe '#laundry?' do

    end
  end
end
```

The idea of this `laundry?` method is that it will return a boolean if the Task's title or description contains the word "laundry". Notice that we are using the `#` symbol to indicate that this is an instance method test in addition to our `describe 'instance methods'` block.

We're now ready to write our first test! Let's start with a simple test case:

```ruby
require 'rails_helper'

describe Task, type: :model do
  describe 'instance methods' do
    describe '#laundry?' do
      it 'returns true when the title is laundry' do
        task = Task.create!(title: 'laundry', description: 'clean clothes')

        expect(task.laundry?).to be(true)
      end
    end
  end
end
```

A couple of things to note here:

1. `describe` blocks are used to organize tests. `it` blocks are the actual tests.
1. We are using the `create!` method as opposed to the `create` method. The bang `!` is very useful for testing because it will throw an error if the instance of the model was not created successfully. In our tests, we would want to see this error to indicate that something went wrong so we can make debugging easier.

Now let's run this test and TDD our way to a passing test. From the command line run `bundle exec rspec` and you should see an error:

```
NoMethodError:
       undefined method 'laundry?' for #<Task id: 1, title: "laundry", description: "clean clothes">
```

Let's go make the method in our Task model:

```ruby
class Task < ApplicationRecord
  def laundry?
  end
end
```

Running the test again gives us `expected true, got nil`, which makes sense since an empty method returns `nil`. Let's fill in the method body:

```ruby
class Task < ApplicationRecord
  def laundry?
    if title == 'laundry'
      return true
    else
      return false
    end
  end
end
```

Now we should have a passing test!

Let's add some more test cases:

```ruby
describe '#laundry?' do
  it 'returns true when the title is laundry' do
    task = Task.create!(title: 'laundry', description: 'clean clothes')

    expect(task.laundry?).to be(true)
  end

  it 'returns true when the description is laundry' do
    task = Task.create!(title: 'Clean my clothes', description: 'laundry')

    expect(task.laundry?).to be(true)
  end
end
```

Run this test and you should get a failure `expected true, got false`. Let's update our method:

```ruby
class Task < ApplicationRecord
  def laundry?
    if title == 'laundry'
      return true
    elsif description == 'laundry'
      return true
    else
      return false
    end
  end
end
```

And now we should have two passing tests.

## Test Coverage

Let's check in on our test coverage. Open the SimpleCov report with `open coverage/index.html` from the command line. This should open a new page in your default web browser with the report and you should see coverage less than 100%. If you click on the `app/models/task.rb` file in the report you should see the line of code that is not covered: `return false`.

We tested when the method returns true, but not the other path when it returns false. Remember earlier when we said that our model tests should **fully** cover our models? This is an example of when the model is not fully covered. Additionally, SimpleCov is a great tool to get quick feedback on our test coverage, but SimpleCov is exactly that... simple! This means that even if SimpleCov says that your file is fully covered, there could still be some edge cases that we need to consider.

Finally, because we are particularly concerned with model test coverage, we should run `bundle exec rspec spec/models` to point rspec to the model tests folder. We are going to add another type of test called `features` later, and we won't want our Feature Testing to affect our Model Test coverage.

## Practice

Let's create some pending tests for practice:

```ruby
describe '#laundry?' do
  it 'returns true when the title is laundry' do
    task = Task.create!(title: 'laundry', description: 'clean clothes')

    expect(task.laundry?).to be(true)
  end

  it 'returns true when the description is laundry' do
    task = Task.create!(title: 'Clean my clothes', description: 'laundry')

    expect(task.laundry?).to be(true)
  end

  it 'returns false when neither the description nor title is laundry'

  it 'returns true when the title contains the word laundry'

  it 'is case insensitive when checking if the title contains the word laundry'

  it 'returns true when the description contains the word laundry'

  it 'is case insensitive when checking if the description contains the word laundry'
end
```

See if you can fill in the test bodies and update our `laundry?` method to handle each additional case.

If you finish, try to come up with another test case on your own.

You can find a completed version of this practice exercise on the `model_testing` branch of [Task Manager](https://github.com/turingschool-examples/task_manager_rails_complete/tree/model_testing)


## Checks for Understanding

* What are model tests?
* Why is model testing important?
* What does a `describe` block do in an RSpec test?
* What does an `it` block do in an RSpec test?
