---
layout: page
title: Module 3 Assessment Information
length: 90
tags: json, javascript, rails, ruby, api
---

You need to demonstrate a good understanding of the code you are working with and be able to implement features at the speed of a junior developer.

In this assessment you will:

* Work with a third party API
* Build well tested features
* Demonstrate mastery of all parts of the Rails stack
* Demonstrate mastery of Ruby
* Commit every 15 minutes to track your progress (details below)

## Areas of Knowledge

The intent of this assessment is to demonstrate a solid working understanding of the following:

* Consuming an API
* Writing tests that adequately test business value
* Sending data from a form for data not stored in a database
* Core concepts covered in the previous two Modules

In addition, we expect you to:

* Be able to explain all lines of code in your project
* Be able to interpret and implement user stories in a Rails project
* Be able to read, understand and refactor existing code
* Be able to use external resources in the problem solving process (ie: Google, Docs etc)

## Expectations

* As you work, you *should*:
  * Commit and push your code every 15 minutes.
  * Reference external public resources (ie: Google, Ruby API, etc)
  * Use the tooling most comfortable to you (Editor/IDE, testing framework, tools like Faraday and Figaro, etc)
* As you work, you *should not*:
  * Copy code snippets
  * Review old projects for code implementations
  * Seek live support from individuals other than facilitators


#### Note about the commit expectation:

To better follow your progress over the 2 hours we expect that you commit every 15 minutes regardless of where you're at. Try to be as descriptive as possible in your commit messages and sum up briefly how you spent the time. Be sure to commit anything you may want to talk about later. For example: You get the first implementation working but want to refactor. If you don't commit the first implementation and don't finish the refactor there is no record of your initial solution.

## Recommended Resources

These are recommended resources to look through before the assessment, and/or use during the assessment.

* Request libraries such as [Faraday](https://github.com/lostisland/faraday) or [Net::HTTP](http://ruby-doc.org/stdlib-2.3.0/libdoc/net/http/rdoc/Net/HTTP.html)
* [VCR](https://github.com/vcr/vcr)
* [Ruby Docs](http://ruby-doc.org/)
* [Rails Forms](http://guides.rubyonrails.org/form_helpers.html)
* [Rails Docs](http://api.rubyonrails.org/)


## Evaluation Criteria

Passing assessments will meet the following criteria:

### Feature Completion

- [ ] All features are functional

### Process

- [ ] Git history shows student uses TDD and follows red/green/refactor
- [ ] App is well tested

### Ruby/Rails Style

- [ ] Objects used in views
- [ ] No hashes used in the view
- [ ] Hand built API supports non-GET requests using an external tool like Postman or cURL.
- [ ] API keys are not hardcoded
- [ ] Controller is not responsible for making API calls.
- [ ] A service object is used for making the API call.
- [ ] The model-like object is responsible for instantiating itself and not the service object.
- [ ] A model-like object is referenced in the controller when consuming an external API (e.g. Thing.filter(parameter: value)). This does not mean it should be an ActiveRecord backed model. A PORO is often the better choice.

### Refactoring

Passing assessments will implement all but two of the following

- [ ] The model-like object is responsible for asking the service for data.
- [ ] Each class is broken down into small (including width) reusable methods (SRP).
- [ ] Service object is built in a way that allows portions of it to be reusable. An un-refactored example would be using string interpolation to build the API request.
- [ ] Student uses a search object in addition to a model-like PORO.
