# Module 3 Assessment

This assessment is individual and you will be working on it for 3 hours. It's advisable to familiarize yourself with the recommended resources (details below) before the assessment.

You need to demonstrate a good understanding of the code you are working with and to be able to implement features at the speed of a junior developer.

In this assessment you will:

* Use test-driven development
* Work with a third party API
* Demonstrate mastery of all parts of the Rails stack
* Demonstrate mastery of Ruby throughout the process
* Commit every 15 minutes to track your progress (details below)

## Areas of Knowledge

The intent of this assessment is to demonstrate a solid working understanding of the following:

* Producing an API
* Consuming an API
* Testing an API
* Sending data from a form for data not stored in a database.
* Storing data in a Rails Session
* Using ActiveRecord to filter data
* Core concepts covered in the previous two Modules

In addition, we expect you to:

* explain all lines of code in your project
* interpret and implement user stories in a Rails project
* read, understand, and refactor existing code
* use external resources in the problem solving process (ie: Google, Docs etc)

**NOTE:** only some of these topics will be included in the assessment.

## Expectations

* As you work, you *should*:
  * Use TDD and an incremental problem solving process.
  * Commit and push your code every 15 minutes.
  * Reference external public resources (ie: Google, Ruby API, etc)
  * Use the tooling most comfortable to you (Editor/IDE, testing framework, support tools like Guard, etc)
* As you work, you *should not*:
  * Copy code snippets
  * Seek live support from individuals other than your instructors
  * Review implementations on old projects

#### Note about the commit expectation:

To better follow your progress over the three hours we expect that you commit every 15 minutes regardless of where you're at. Try to be as descriptive as possible in your commit messages and sum up briefly how you spent the time.

## Setup

Set up a [new project](https://github.com/new) titled `module_3_assessment` associated with your Github account.

You will build on a Rails 5 version of [Storedom](https://github.com/turingschool-examples/storedom-5). Make sure you setup the project before the assessment.

**NOTE:** Delete `Gemfile.lock` before you bundle to avoid version conflicts.

```sh
$ git clone -b mod_3_assessment_base git@github.com:turingschool-examples/storedom-5.git
$ cd storedom-5
$ rm Gemfile.lock
$ bundle
$ bundle exec rake db:{drop,create,setup}
$ git remote add upstream git@github.com:YOUR-GITHUB-USERNAME/module_3_assessment.git
```

RSpec/Capybara is already set up in the project. Run `rspec` to see one integration test passing. If you prefer to use a different test suite, please setup prior to the assessment.

**Instructors will provide you with your API key the day of the assessment.**

Once you have your project ready to go, commit and push to your remote repo to confirm everything is set up correctly using something similar to the following:

```sh
$ git add .
$ git commit -m "Complete setup for M3 assessment."
$ git push -u upstream master
```

## Recommended Resources

These are recommended resources to look through before the assessment, and/or use during the assessment.

* Request libraries such as [Faraday](https://github.com/lostisland/faraday) or [Net::HTTP](http://ruby-doc.org/stdlib-2.3.0/libdoc/net/http/rdoc/Net/HTTP.html)
* [ActionController::API](http://api.rubyonrails.org/classes/ActionController/API.html)
* [VCR](https://github.com/vcr/vcr)
* [Ruby Docs](http://ruby-doc.org/)
* [Rails Docs](http://api.rubyonrails.org/)
