---
layout: page
title: Intro to Postman and Faraday
length: 180
tags: apis, rails, faraday
---

### Learning Goals

- Understand how to consume API endpoints
- Gain familiarity with the Faraday and Postman HTTP clients

### Vocabulary Bank

* __API__: Application Programming Interface
* __API Endpoint__: An address to which a client can request information
* __JSON__: JavaScript Object Notation
* __Client__: A program that relies on requesting information from a server
* __HTTP__: Hypertext Transfer Protocol
* __HTTP Verb__: methods that define the intended action to be performed on a resource
* __HTTP request__: A standard way to communicate information between a client _ex. Browser_ and a server
* __HTTP response__: A standard way to return information from a server to a client based on the client's request
* __Postman__: A tool that allows developers to visualize the parts of HTTP requests and responses
* __Faraday Gem__: An HTTP client library that allows developers to more easily write requests and handle responses in Ruby
* __Response Status__: A numerical code provided by a server to indicate the result of a request

### Warmup

- What is the purpose of an API?
- Why do we expose data through APIs?
- What format is the data in when it is exposed through an API endpoint?


### Overview

In this lesson, we will review the anatomy of a HTTP request and response. In the intermission work, you were asked to write this out, so feel free to reference your diagram or create a new one from today's review. We will be looking at the types of requests & responses you made in Mod 2 for HTML and how they compare to the requests and responses from APIs.

Throughout the lesson you will have the opportunity to explore how to make a `GET` request to an API using different clients: the browser, Postman, and a Ruby file using the Faraday gem. For each of these, we will look at how to make the request and how to understand the response that is returned. We will also discuss some of the benefits to using these tools and explore documentation.

#### HTTP Request and Response Review

List out the parts of a generic HTTP GET request and response

#### HTTP Client 1: The Browser

Using the browser, make a GET request to hit the [GitHub users](https://developer.github.com/v3/users/#get-a-single-user) API endpoint.

`https://api.github.com/users/<username>`


* How did you make this request?
* What does the response look like?
* What information is included in the response?


#### HTTP Client 2: Postman

Download [Postman app](https://www.postman.com/downloads/) Take a minute to explore the different tabs and options in Postman.

After you've explored Postman, try to make a GET request to hit the Github users API endpoint.

* How did you make this request in Postman?
* What is the status of the response?
* What is included in the response's Headers?


#### HTTP Client 3: Faraday

Explore the [Faraday Gem Docs](https://lostisland.github.io/faraday/). Then create a Ruby file and require the Faraday library and Pry at the top of it. In this newly created Ruby file, use the Faraday docs to make the same HTTP request to the GitHub users endpoint.

* How did you make this request using Faraday?
* What is the return of the of the request?
* How can you access just the body of the response?


### Practice with Postman and Faraday

We've practiced making a `GET` request, so now let's try making requests using other HTTP verbs.
Complete the exercises included in this [README](https://github.com/turingschool-examples/pets_api)


---

Looking for more practice. Try [here](./exercises/additional_api_consumption_practice)
