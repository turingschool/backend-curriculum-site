---
layout: page
title: Consuming an API Part Two - Testing and Refactoring
length: 90
tags: apis, rails, faraday, refactoring, VCR
---

### Resources

* [Video](https://youtu.be/Okck4Fc557o) showing how to setup Webmock and VCR

### Learning Goals

After this class, a student should be able to:

* Refactor code that reaches an API from the controller into its own service.
* Understand the four main advantages of using a network mocking gem to test
external APIs.
* Understand that stubbing can also help testing APIs.
* Configure and set up tests using VCR.


Finally, all of our tests are making real API calls which is not good. There are
multiple ways to get around this. Use this video on [Stubbing External API calls with Webmock and VCR](https://youtu.be/Okck4Fc557o).
