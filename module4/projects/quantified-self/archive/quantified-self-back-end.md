---
layout: page
title: Quantified Self Back End
subheading: Quantified Self Grows Up
---

## Intro

Local storage is used in the real world, mostly for offline functionality, and sometimes when you have a local dataset that's just too big for cookies. However, it's rarely used as the only source of truth. Let's build an API to manage our data.

## Learning Goals

- Student will experience service implementation in something other than Ruby/Rails
- Student will write JavaScript on the back end in Node
- Student will design, build and test a service using a Express, a simple framework for Node
- Student will use SQL for all database communication

## Challenges

- Breaking down large requirements into stories
- Replacing one source of truth with another (Local Storage with an API), without changing functionality
- Using SQL for all database communication
- Dealing with development and production environments between two codebases

## Requirements

1. Build a service in Node that will store all of the Quantified Self data.The service will serve and consume JSON.
2. Remove all instances of local storage from your application. Replace them with AJAX calls to your new service.
3. Document a plan in the form of a schema, API docs and user stories.

Besides some slight HTTP request/response delay, functionality and user experience should not change.

## Expectations

- These requirements are sparse. That's partially because it's a pretty straight forward request, and partially because I want you to practice breaking down a big problem into smaller tasks.
- Use whatever you've used in the past for schema, documentation and user stories. Or something new you've been wanting to try out. These things are graded on completion. Probably want to agree on format in your DTR.
- Now that you're using a back-end, the data should persist no matter which client I'm using.

## Rubric

You will be subjectively graded by an instructor on the following criteria:

### Planning and Design

- 4: Team created visual schema, API documentation and user stories, before writing tests. API adheres to REST standard.
- 3: Team created either a schema or API docs to facilitate implementation of a service.
- 2: Team has some notes on how to implement their service, but someone else couldn't implement it.
- 1: Team did not design their service.

### Functionality

- 3: Team was able to maintain all previous functionality using the new back-end
- 2: Team was able to complete the back-end, but unable to integrate it into the
- 1: Team was unable to build a functioning API

### Testing

- 4: All functionality is covered by tests. Appropriate mix of unit and integration tests. Sad path testing in both unit and integration tests.
- 3: All functionality is covered by tests. Appropriate mix of unit and integration tests.
- 2: More functionality implemented than tested or only uses one test type
- 1: Team fails to effectively test the application.

### JS syntax and Style

- 4: Javascript demonstrates great OOP concepts, and uses named and anonymous functions when appropriate
- 3: Uses classes as modules. DRY code where appropriate. Attention payed to indentation and naming.
- 2: Javascript is noticeably lacking in the above concepts.
- 1: Team has not applied any style concepts from class or from Ruby background

### Git Workflow

- 4: Team uses master for production, and creates a feature branch for each card worked on. Team is using pull requests with good context and conversation
- 3: Team is using the feature branches for small groups of cards, and has a pull request for each feature. Developers that aren't on the team have commented on PRs.
- 2: Team fails to use feature branches, or isn't using pull requests
- 1: All code is committed to master

### Project Management

- 4: Team is using a project management tool and updating their progress daily. User stories are clearly written.
- 3: Team is using a project management tool to keep their project organized. Nearly every card has been turned into user stories.
- 2: Team is using a project management tool but didn't update the progress frequently. Many cards have no changes made to them
- 1: Team failed to use a project management tool to track its progress.

### Risk Taking

If you adhere to one of the following challenges, you can add one point to a score above:

#### Sources of Truth

Local Storage is often used for "offline" functionality. When the user is having trouble connecting to the internet, the application will continue to function. When a connection is re-established, the local changes are uploaded to the server. Likewise, if changes are made on one client, they should be downloaded to another client

Use Local Storage and AJAX to meet the following requirements:

1. If I'm disconnected from the internet, I can continue to use the application.
1. When I make a change while disconnected from the internet, that change will be uploaded to the server when I reconnect
2. If I make a change one computer, those changes should propagate to any other clients through the server

You will probably need to use a concept called `service workers`

#### Mircroservices

Instead of building a single service, build a series of microservices. Each microservice is a separate codebase and application that represents a single table in your schema. These applications communicate with each other via HTTP. Since they all live in the same datacenter, this is not much of a performance problem.

The architecture would look something like this:

![microservices-challenge](./microservices-challenge.png)

If you attempt this challenge, your planning and design should include your microservices architecture.

As to why you might want to do this, watch [Chad Fowler's Rocky Mountain Ruby 2015 talk](https://www.youtube.com/watch?v=-UKEPd2ipEk)
