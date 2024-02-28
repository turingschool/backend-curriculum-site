---
layout: page
title: Lunch and Learn
subheading: Overview
length: 1 week
tags:
type: project
---

## Project Description

You are a back-end developer working on a team that is building an application to search for cuisines by country, and to provide an opportunity to learn more about that country's culture. This app will allow users to search for recipes by country, mark recipes as "favorite", and learn more about a particular country.

Your team is working in a service-oriented architecture. The front-end will communicate with your back-end via API. Your job is to expose the API that satisfies the front-end team's requirements.

## Learning Goals

* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Implement Basic Authentication
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc). 

## Requirements

The project must expose all of the endpoints [listed here](./requirements).

### Pre-Approved Gems

This project will have you to consume multiple APIs - you should do so *manually*, without the use of SDKs/gems that may make it faster/easier. This is an assessment in part of your ability to read documentation, implement tooling required to test & consume one or more APIs manually, traverse complex external datasets, and refactor your application to do these things as efficiently as possible. 

Here is a list of pre-approved gems you can use on this project: 
```
pry, debug, byebug
simplecov # required
rspec-rails
capybara
launchy
webmock
vcr 
faraday
jsonapi-serializer # optional
factorybot
faker
bcrypt
shoulda-matchers
orderly
```

If you have questions about a gem that is not on this list, please reach out to your instructors *first*.

## Evaluation

Your project will be evaluated based on [this rubric](./rubric).
