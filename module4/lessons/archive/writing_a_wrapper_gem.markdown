---
layout: page
title: Writing a Wrapper Gem
length: 90
tags: ruby, api, gem, testing
---

## Learning Goals

* Practice wrapping HTTP API calls in a Ruby class
* Understand how Faraday is used to make web requests
* Understand how VCR/mocks are used for testing

## Structure

* 25 - Independent Work
* Break
* 25 - Lecture/Demo
* Break
* 25 - Paired Work

## Independent Work

Work for the first 15 minutes on your own to:

* Clone the [Tweeter project](https://github.com/turingschool-examples/tweeter)
* Bundle, migrate, and run `rake db:data:load`
* Get the server running locally on port 3000
* Visit the "endpoints" to display an individual tweet and an individual poster in your broswer
* Read the README for the Faraday gem
* Load your console, require Faraday, and use it to make the same two requests to your local server

If you complete those tasks:

* Can you use Faraday to create a Poster? Create a tweet?
* Can you use the PATCH verb to modify an existing tweet?
* Think about / experiment with: how could you create a per-user token that acted like their password to "sign" API requests?

## Lecture

Let's come back together to discuss the theory and practice of wrapper gems.

* Big Picture
  * Why create a wrapper gem?
  * What does the wrapper essentially do?
  * Making requests with HTTParty or Faraday
* Wrapper Approaches
  * The Convenience Wrapper
  * The Pattern-Shifting Wrapper
* Challenges of external dependencies
  * What if the API changes?
  * Gem to match different versions of the API
  * Your own services are dependencies
* The testing story
  * Interdependent testing sucks
  * HTTP requests suck
  * VCR is a pretty-good solution
  * Mocking is sometimes a better solution
* Wrapper Gem Expectations
  * Minimize the dependencies it drags into a project
  * Minimize knowledge of the including system
  * Tight semantic versioning with link to the API version
  * Bonus: offer a way to verify the actual API
  * Bonus: offer built-in mocking functionality

## Experimenting with Tweeter-Client

Let's return to the Tweeter project to dive into what a wrapper might look like in practice. Get together with your pair and:

* Clone the [Tweeter-Client project](https://github.com/turingschool-examples/tweeter-client)
* Spend about three minutes exploring the code and tests that are already there
* Write tests for the same methods you worked with in the independent work
* *Write an implementation to pass the tests*

### Extensions

You'll talk more about testing in a future lesson. But you can experiment now:

* Add VCR to the project
* Use VCR to record a successful test run
* Make your test suite pass *without* the API app running

## Returning to Monsterporium

Yesterday you built up your `Rating` model as a wrapper of the service functionality.

* Generate a new gem, `ratemachine`
* Move the `Rating` model, now just a PORO, to the gem
* Bundle it as a gem
* Open an IRB session, load the gem, and make it works to fetch ratings
* Require the local gem from your Monsterporium `Gemfile`
* Load the app and prove that it works
