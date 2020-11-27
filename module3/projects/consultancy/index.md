---
layout: page
title: Consultancy Competition
length: 2 weeks
tags:
type: project
---

## Project Description

The goal of this project is to create a successful web application from a student-led project idea. Your team will create an app that will solve a real world problem, and allow users to authenticate with a third-party service, and consume at least two other apis.

This project will focus heavily on Service-Oriented Architecture (SOA), and will include the following components and restrictions:

Our "Front End" application will be built in Rails, but could be substituted later for a JavaScript-based application in React, Angular, etc.
- Rails "front end"
  - this is a typical "rails new" project
  - it will have simple testing, and will mostly focus on View templates, HTML and CSS, maybe some JavaScript, highly recommend Bootstrap
  - this application is responsible for authentication via OAuth
    - try to find a way to utilize your user's OAuth token within the application in some way
      - eg, if you OAuth with Google, what can we use their OAuth token to do on their behalf at Google?
  - this application is only allowed to store user data in a local database
    - this app's data will only have a "users" table
    - all other database storage must go through a "DatabaseService" that you implement to do any CRUD behavior
      - this will follow the typical Facade and Service design patterns
      - you will need HEAVY use of webmock to test expected results until the backend endpoints are finished
      - once the backend endpoints are finished, consider changing to VCR
  - Requirement: using Rails caching to cache data retrieved from backend

Our "Back End" application will be an API built in Rails. It will act as the interface layer to our database
- Rails "back end"
  - this is a "rails new --api" project
    - it will have more thorough testing, follow our Facade and Service design patterns, and use Serializers
    - there is no ERB, HTML or CSS, JavaScript, or assets, anywhere in this project
  - all input is received as JSON data; it only responds with JSON data
  - this layer will serve as our database interface for other applications
    - we recommend eager loading where possible, and use of the "bullet" gem to detect N+1 queries
  - we recommend considering the use of GraphQL to reduce the amount of RESTful CRUD endpoints you'll need to build
  - Requirement: using Rails caching to cache data retrieved from microservices

Our project will include at least one "micro-services" - a Service API which abstracts away a single responsibility.
- Sinatra "microservice"
  - no HTML, CSS or ERB, JS, assets, etc of any kind
  - no database storage of any kind
  - receives JSON requests from the Rails back end only, responds only in JSON
  - responsible to talk to an external API to fetch data or do something on the user's behalf using their OAuth token
  - knows nothing about any other component/service in the system
  - extension: one micro-service is hosted on an alternate service provider (AWS, Digital Ocean, etc)

---

## Professional Development Benefits

You will be better prepared to hit the ground running in the workplace having worked on a larger team, in a much larger application base, with lots of moving pieces. Understanding the deeper impact of how a small change can have a cascading effect on other pieces of a system will be crucial.

We'll also examine our end users on a deeper level to install a strong sense of developer empathy. We will do this by focusing time on "user personas" to answer questions like "who is our user", "what age range are we targeting", "how tech-savvy must the user be to use our app" and so on.

Please see the technical and professional learning goals [here](./project_goals).

---

## Phases

* [Ideation](./ideation)
* [Inception](./inception)
* [Development](./development)
* [Retro](../retro_guide)
* [Evaluation](./evaluation)
