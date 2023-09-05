---
layout: page
title: Intro to Service-Oriented Architecture
length: 120min
tags: rails, apis, services, architecture, monolith, microservice
---

## Learning Goals
* Understand what a service oriented architecture is
* Describe why we might use SOA over a monolith

## Vocabulary
* Service
* Monolith
* Microservice

----

## Warm Up
On your own or in a small group, answer the following questions: 

1. On a scale of 1-5, how familiar are you with the vocabulary terms listed above? 
2. What do you already know about SOA?
3. Have you heard the term "monolith" used in reference to an application? 


### Solo reading
Read the first few paragraphs of [this article](https://aws.amazon.com/what-is/service-oriented-architecture/), and find 2-3 interesting points to share with the group. 

## Architecting an Application
As you've learned so far in your development career, there are pros and cons to nearly every decision you will make while creating or updating an application. Similarly, there are some good and some not-so-good effects of implementing a service-oriented architecture (SOA). There are also lots of different kinds of SOA, engineered differently to fit each use case. But the common factor between these types is the idea that a number of separate, specific _services_ will communicate to each other to achieve a common goal. We'll explore one way that this type of design can be achieved through what's called **microservices**. 

A _microservice_ is the implementation of one or more "loosely-coupled" hyperspecific services that can communicate to applications or other services. If you recall from your projects so far, you can think of a microservice as a larger-scale example of the single-responsibility principle (SRP) - one method in a class (or one service) should do only one thing, and it should do it well. 
A microservice, though, is just an application - just like the applications you've built so far - and as such it will have its own codebase, maybe a database, it may make other API calls, and it will have its own tests. 


## Diagramming some SOA Examples
If we look at the [Slack Status page](https://status.slack.com/), or the [Heroku Status page](https://status.heroku.com/), we can see that both of these companies likely use some form of SOA patterns as part of their architecture. 

Thinking back to your own projects this inning, how would you delineate the services those application(s) offer? What would your "status" page look like? Take 15-20 minutes to diagram your own project. 

## Big-Picture Thinking
We're going to do use our 🌈 imaginations during this next part. 

First, let's imagine ourselves working at a 5-person software company. There's a CEO, a salesperson, two developers, and an account manager. They sell a SaaS (software-as-a-service) product that helps businesses manage their clients. You and the other developer decide to implement a microservice architecture to help with your product. 

Next, let's imagine a similar scenario at a 1,000-person company. There are teams upon teams of developers all working on different products and projects, each with their own manager or team lead. You're on a team that is designing and developing a new microservice that will track sales forecast data for all international sales teams. 

For each of these scenarios, answer the following questions: 

<section class="answer">
<h3>1. What specific job(s) would your services have?</h3>
<div>
It's the classic answer, <em>"it depends!"</em> This is because each application's needs are different, depending on the features it provides. For example, the first scenario could make a service just for logging into the application, another service to calculate all data across a specific demographic, etc. As long as each service does one thing and does it well. 
</div>
</section>
<section class="answer">
<h3>2. How will you connect your application to those service(s)?</h3>
<div>
There are multiple ways to do this, but for us, assuming the main application is able to make HTTP requests, we would implement a series of RESTful endpoints in our service as an API in order to allow and consume specific requests and responses from our service. 
</div>
</section>
<section class="answer">
<h3>3. What would happen to our service(s) if there's an error in the main application? </h3>
<div>
Assuming the main application has an error that it doesn't send to the microservice.... nothing! Nothing would happen to the microservice at all, since it is its own self-contained application. Similarly, if an error occurred in the microservice, the main application would have to handle it in some way (show the user an error message, or retry, or both, etc), but it shouldn't cause a catastrophic event on either end of the request.
</div>
</section>
<section class="answer">
<h3>4. Who is responsible for making updates/changes/general maintenance on the microservice(s)?</h3>
<div>
If you answered "developers", you'd be correct - but think harder. What happens when you, or another developer on your team, leaves the company? What happens when a new developer gets hired & onboarded onto your team? How easy will it be to transfer the knowledge or train a new developer to use that service? Again, it does all depend on the application's level of complexity, but that complexity can make decision-making both at the higher- and lower-levels much more important than it seems. In other words, decisions regarding software architecture _matter_, regardless of the size of the company. 
</div>
</section>

### Synthesis - Pros & Cons
As you discuss those questions, write down some Pros and Cons of using a microservice architecture pattern. 


## Further Reading
* [Microservice Architecture](https://microservices.io/index.html)
* [Wikipedia - Microservices](https://en.wikipedia.org/wiki/Microservices)

## Checks for Understanding
* Define the term "microservice" in your own words, and use an example of how you may implement it. 
* What are some benefits of using microservices? What about some drawbacks?