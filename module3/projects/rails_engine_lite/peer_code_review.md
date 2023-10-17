---
layout: page
title: Peer Code Review
subheading: Rails Engine Lite
length: 60
tags:
type: project, retro, peer review
---
_[Back to Rails Engine Lite Home](./index)_

You will be given a code review partner. Exchange links for the repo and then independently walk through the sections below. You should answer the review questions from each section in a notebook or in a gist. Once both partners have completed the review of **all** sections, meet with your partner to discuss the feedback from notes you've taken. *Remember that feedback should be actionable and kind.*

### Setup

First,

* Clone down your partner's project.
* Set up your partner's project.

Then, answer the following questions:

* Was your partner's project easy to set up? Why or why not?
* Do they have a clear README? What sort of things should be included to make the set up more clear?

### Postman Tests

First,

* Run your partner's server in a Terminal window.
* Run each Postman test one at a time. 

Then, answer the following questions:

* Are all the Postman tests passing? Are any failing? 

### Code Quality

Review the code in your partner's project, focusing on these main areas: 
* Controllers
* Serializers
* Facades, services, and/or poros (if any)
* Error handling
* Tests, including `requests` and any unit tests like `serializers`, `facades`, `poros`, etc. 

Then, answer the following questions:

* Does each controller action conform to SRP? Why or why not? 
* Are they using a gem for their serializers? 
* How well does each controller action handle exceptions? What type of objects are they using for their errors? 
* In their tests, do they cover any edge cases or additional sad paths? 
