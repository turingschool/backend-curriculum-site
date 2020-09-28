---
layout: page
title: Consultancy Competition
length: 2 weeks
tags:
type: project
---

## Learning Goals

* Learning how to build a full application stack from idea to delivery
* Revisiting previous concepts such as APIs and OAuth
* Finding the strengths and gaps in your knowledge of Ruby, Rails, and organizing a project.
* Use an Agile process as you develop features
* Configure a continuous integration server with deployment to production


## Project Description

The goal of this project is to create a successful web application from a student-led project idea. Your team will create an app that will solve a real world problem, and allow users to authenticate with a third-party service, and consume at least two other apis.

This project will focus heavily on Service-Oriented Architecture (SOA), and will include the following components and restrictions:

Our "Front End" application will be built in Rails, but could be substituted later for a JavaScript-based application in React, Angular, etc.
- Rails "front end"
  - this is a typical "rails new" project
  - it will have simple testing, and will mostly focus on View templates, HTML and CSS, maybe some JavaScript
  - this layer is responsible for authentication via OAuth
  - this application is not allowed to directly interact with a database
    - instead, it will implement a "DatabaseService" to do any CRUD behavior
  
Our "Back End" application will be an API built in Rails. It will act as the interface layer to our database
- Rails "back end"
  - this is a "rails new --api" project
  - it will have more thorough testing, follow our Facade and Service design patterns, and using Serializers
  - there is no ERB, HTML or CSS anywhere in this project
  - all input is received as JSON data; it only responds with JSON data
  - this layer will serve as our database interface for other applications

Our project will include at least two "microservices" -- a Service API which abstracts away a single responsibility.
- Sinatra "microservice"
  - no HTML, CSS or ERB of any kind
  - receives JSON requests from the Rails back end only, responds only in JSON
  - responsible to talk to an external API to fetch data or do something on the user's behalf using their OAuth token
  - knows nothing about any other component/service in the system

---

## Technical Expectations

* Use an external OAuth provider to authenticate users
* Consume two or more external APIs
* Utilize a Service-Oriented Architecture with a front-end, a back-end, and at least two microservices
* Implement a production-quality user interface using Bootstrap or other common CSS styling framework
* Optimize your application using at least one of the following: database indexing, eager loading, caching, background workers, or AJAX requests

## Phases

* [Ideation](./ideation)
* [Inception](./inception)
* [Development](./development)
* [Retro](../retro_guide)
* [Evaluation](./evaluation)
