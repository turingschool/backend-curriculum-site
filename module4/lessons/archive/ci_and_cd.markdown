---
layout: page
title: Continuous Integration and Continuous Deployment
---

## Learning Goals

* Students understand the purpose of CI
* Students understand the mechanics of how CI works
* Students understand how CI factors into their workflow
* Students understand the purpose of CD
* Students are familiar with the idea of infrastructure management

## Talking Points

### Continuous Integration

* What do we mean by "integration"
* How non-continuous integration goes wrong
* Why have a testing environment -- it works on my machine
* In-house CI
* External CI providers and a bit about how they work
* Triggering the CI job
* Viewing the results
* What's possible when test time is free?

### Continuous Deployment

* Deploying occasionally vs frequently
* [Netflix](http://techblog.netflix.com/2015/11/global-continuous-delivery-with.html)
* CI tools doing deployment
* In more complex / non-Heroku hosting situations
* Elevating "infrastructure" to a first-class concern

## Tooling & Resources to Explore

* CI Tools: [TravisCI](https://travis-ci.org/) & [CodeShip](https://codeship.com)
* [CD with Travis & Heroku](https://docs.travis-ci.com/user/deployment/heroku/)
* [Testing pull requests with Travis](https://docs.travis-ci.com/user/pull-requests)
* [A tutorial video on integrating GitHub, Travis, and Heroku](https://www.youtube.com/watch?v=5AhMk26eLz0)
* [A recap of why a team would choose this setup](https://medium.com/@anicolaspp/github-travis-ci-and-heroku-platform-fe21a72dfb5#.s7o89bwf0)
* [Similar argument from a NodeJS perspective](https://shapeshed.com/continuously-deploy-node-apps-with-github-travis-and-heroku/)

## Follow-On Expectations

* Each capstone project is setup with CI
* Each capstone project is setup with CD to staging
