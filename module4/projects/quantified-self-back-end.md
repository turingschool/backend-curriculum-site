---
layout: page
title: Quantified Self
subheading: A calorie tracker project for the fourth module
---

## Intro

Local storage is used in the real world, mostly for offline functionality, and sometimes when you have a local dataset that's just too big for cookies. However, it's rarely used as the only source of truth. Let's build an API to manage our data.

## Learning Goals

- Student will experience API implementation in something other than Ruby/Rails
- Student will write JavaScript on the back end in Node
- Student will design, build and test a service using a Express, a simple framework for Node
- Student will use SQL for all database communication

## Challenges

- Breaking down large requirements into stories
- Replacing Local Storage with an API
- Using SQL for all database communication
- Dealing with development and production environments between two codebases

## Requirements

Build a service in Node that will store all of the Quantified Self data. The service will serve and consume JSON. Remove all instances of local storage from your application. Replace them with AJAX calls to your new service. Besides some slight delay, user experience should not change.

## Rubric

You will be subjectively graded by an instructor on the following criteria:

### Planning and Design

- 4: Team created visual schema, API documentation and user stories, before writing tests. API adheres to REST standard.
- 3: Team created either a schema or API docs to facilitate implementation of a service.
- 2: Team has some notes on how to implement their service, but someone else couldn't implement it.
- 1: Team did not design their service.

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
