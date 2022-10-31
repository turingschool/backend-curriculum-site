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

Our "Front End" application will be built in Rails.
- Rails "front end"
  - This is a typical `rails new` project
  - It will have simple feature testing, and will mostly focus on View templates, HTML and CSS. We highly recommend Bootstrap
  - This application is responsible for authentication via OAuth
    - Try to find a way to utilize your user's OAuth token within the application in some way
      - eg, if you OAuth with Google, what can we use their OAuth token to do on their behalf at Google?
  - This application is only allowed to store user data in a local database (although you can choose to store user data on the backend instead)
    - This app's database can only have a "users" table
    - All other database storage must go through a "DatabaseService" that you implement to do any CRUD behavior on your Backend
      - This will follow the typical Facade and Service design patterns
      - You will need HEAVY use of webmock to test expected results until the backend endpoints are finished. Planning the structure of your JSON ahead of time will go a long way in allowing both applications to proceed in a decoupled manner asynchronously
      - Once the backend endpoints are finished, consider changing to VCR
  - Extension: using caching to cache responses retrieved from the backend application

Our "Back End" application will be an API built in Rails. It will act as the interface layer to our database, and it will handle our API consumption.
- Rails Backend
  - this is a `rails new --api` project
    - it will have more thorough testing, follow our Facade and Service design patterns, and make use of Serializers
    - There is no ERB, HTML or CSS, JavaScript, anywhere in this project
  - All input is received as JSON data; it only responds with JSON data
    - we recommend [**eager loading**](https://dev.to/johncip/understanding-rails-eager-loading-3n6j) where possible, and use of the "bullet" gem to detect N+1 queries
  - Extensions: 
     1. using Rails caching and/or memoization to cache/memoize data retrieved from external APIs
     2. hosted on an alternate service provider (AWS, Digital Ocean, etc)
     3. use background worker

---

## Professional Development Benefits

You will be better prepared to hit the ground running in the workplace having worked on a larger team, in a much larger application base, with lots of moving pieces. Understanding the deeper impact of how a small change can have a cascading effect on other pieces of a system will be crucial.

#### Feedback from Previous students:

  * "The complexity added value to the interviewing conversations. I got to speak to pros/cons, and I understood the concepts a lot better."
  * "Exploring different design patterns was great and being able to speak on different ways to build things PLUS being able to compare was helpful."
  * "Incredibly helpful in interviewing. It was the biggest project on my resume, and was key to my early interviews. It was more important in my interview for my new role than my Mod 4 capstone because of the multi-app architecture. I could speak to decision-making more because I got to work on each piece. My new company said I reset their expectations for what a bootcamp grad could accomplish."
  * "It came up in just about every interview I had."
  * "People seemed most excited/interested about working on a larger team project. They asked lots of followup questions about how we handled project management, made decisions, etc. It was really helpful to know how SOA/multi-app systems worked."
  * "They were surprised that we got exposure to SOA and speaking about microservices.
  It helped to understand and speak to Abstraction and Encapsulation a lot more. Working o
  n a larger team definitely helped me get started at my job which was a way bigger team t
  han the 10-person project."
  * "People seemed most excited/interested about working on a larger team project (10 p
  eople). They asked lots of followup questions about how we handled project management, m
  ade decisions, etc. It was really helpful to know how SOA/multi-app systems worked."
  * "It definitely came up in interviews, especially about microservices, and the trade
  offs versus monolith apps."

#### User Empathy, Personas

We'll also examine our end users on a deeper level to instill a strong sense of developer empathy. We will do this by focusing time on "user personas" to answer questions like "who is our user", "what age range are we targeting", "how tech-savvy must the user be to use our app" and so on.

Please see the technical and professional learning goals [here](./project_goals).

---

## Phases

* [Ideation](./ideation)
* [Inception](./inception)
* [Development](./development)
* [Retro](../retro_guide)
* [Evaluation](./evaluation)
