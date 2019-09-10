---
title: API Design
layout: page
---

[Slides: API Design - Best Practices](https://docs.google.com/presentation/d/1zCMu9ihKhESM2VEsPZBaoBohzUHv03ARY-9pEWOr6lI/edit?usp=sharing)

## Design before coding
When we begin a new project, many of us often attempt to work directly on the problem by coding first. This approach may not be the best, especially for large projects. Instead, programmers should be focusing on design upfront, rather than later. If the programmer does well with planning out a rudimentary design of what you’ll be building and answering many questions at the beginning of the project, then many future issues may be avoided later down the line.

## Ask yourself first: What am I trying to design?
Above is the first question you should ask yourself before starting a project.  You should be seeking to understand what the shape of our data looks like first! It could save us a lot of headaches in the future too. Not doing this before hand can potentially create issues in the future. If you have a simple idea of what the data will look like, then it’ll be easier to build a roadmap in how you’ll build everything.

### Questions to ask before writing a single line of code

* What are the primary resources that we’d be interacting with? Can you list them all out?
* After creating a list of attributes, what would the attributes be? Can you list them?
* If any, what is the relationship between all of the resources?
* Could I design a simple schema with all of this knowledge on paper or using a schema designer?
* What are the most basic endpoints that I could create from this knowledge above?

#### Discussion: What would be the primary resources when attempting to build out an eCommerce application from scratch?  (5 minutes)

## Simple rules for writing API endpoints
1. Treat each URL as a sentence, where the the resource is a noun and the HTTP is the verb.
2. A resource name within a URL should always be in the plural tense.
3. Use :id when trying to reference and access a particular resource
4. URLs shouldn’t be nested more than two resources deep.

#### Discussion: Can you describe and list out the most used HTTP status codes?

## Looking for inspiration
It’s always great to look at other APIs for inspiration. Stripe, Square, and MapBox come to mind. If you ever want to know what great API design looks like, take a look at their documentation and follow some of their strategies.

## Document, document, document
Documentation is key in your API design. Have you ever had a time where you wanted to use an API that solved a particular problem you were having only to find out that it was impossible to use? It’s good to reflect on how that made you feel as a developer. If you create an API, document it as well as you can. If you want some examples of great services that help you with documentation, look up Stoplight and Apiary.

## Let’s practice!
You’ve been tasked to build out a Food Truck API for a network of businesses in your city. Each food truck company can have many food trucks.

These businesses will use the API to handle their /current supplies, payment processing, and the history of completed orders/ of their weekly operations.

Start designing this API using practices we talked about today
