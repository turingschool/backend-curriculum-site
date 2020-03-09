---
layout: page
title: APIcurious
length: 1 week
tags:
type: project
---

## Project Description

In this project, we'll be focusing on consuming and working with data from public APIs.

As a vehicle for learning these concepts, we'll be selecting an API from a popular website and working to re-construct a simplified version of the website's existing UI using their own API. For example, you might decide to use the Twitter API to build a basic version of the Twitter feed where users can view and post tweets.

As we build these features, we'll also be working with the OAuth protocol to authenticate our users with the third-party provider, and using various testing techniques to allow us to test against the third-party data.

The project requirements are listed below:

* [Learning Goals](#learning-goals)
* [Technical Expectations](#technical-expectations)
* [Available APIs](#available-apis)
* [Milestones](#milestones)
* [What to Expect](#what-to-expect)
* [Evaluation](#evaluation)

## <a name="learning-goals"></a> Learning Goals

* Learn to consume data from third-party APIs
* Continue to emphasize performance, UI, and overall user experience
* Continue using TDD to drive all layers of development
* Coordinate with project stakeholders to produce quality code and product
* This project will be completed individually over a period of 4 days.

## <a name="technical-expectations"></a> Technical Expectations

You'll work with an instructor to define more explicitly the requirements for your specific application, but the basic requirements for this project include:

* Use an Omniauth authentication library for authenticating users with the 3rd-party service.
* Mimic the interface functionality of one online service from the list below.
* Consume an external API to get real data and interact with a third-party service.
* Do *NOT* use a gem to communicate with the external API (Omniauth is OK)

## <a name="available-apis"></a> Available APIs

To start, you need to select an API to work with. We've selected the following list of applications for their well-documented public APIs, and relatively straightforward UI's.

For each project, we have included a rough summary list of features to include. As with any development project, you should focus on moving iteratively through the most basic features before starting on more complex ones. During the project, the instructors will meet with you to assess progress and determine what features to focus on next.

### Github

Build a basic version of the Github profile / feed UI. As a user, I should be able to:

* Authenticate with my github account
* View basic information about my account (profile pic, number of starred repos, followers, following)
* View a summary feed of my recent activity (recent commits)
* View a summary feed of recent activity from users whom I follow
* View a list of organizations I'm a member of
* View a list of my repositories

**Extensions:**

* View a list of open pull requests that I have opened
* View a list of "@mentions" that I was included in
* Create a new repository

### Reddit

*Reddit can be a scary place. Tread lightly.*

Build a basic subreddit browser. As a user, I should be able to:

* Authenticate with my Reddit account
* View my basic info (username, karma)
* View a list of my subreddit subscriptions
* View a subreddit, with it's rules and sidebar content
* View the last 15 posts in a subreddit. Each post should be a link
* View the score for each post
* View the comments for each post. Comment replies should be visually nested.

**Extensions:**

* Add pagination for a subreddit
* Add upvote and downvote links for each post
* Add upvote and downvote links for each comment
* Be able to view and send private messages
* Create a new subreddit

## <a name="milestones"></a> Milestones

By **Tuesday afternoon** you should have oAuth implemented. Using the token you receive from authentication, you should be able to make requests to the API at least using Postman or curl. Ideally you will be able to make a request from your application and display *some information* on a page by Tuesday evening/Wednesday morning even if the code has not yet been refactored into a service. This will leave you with Wednesday and Thursday to refactor and implement the required functionality.

## <a name="what-to-expect"></a> What to expect from instructors

Instructors will work to review pull requests for code quality and limited debugging. As we start to move forward in Mod 3, we continue to encourage you to rely upon available documentation to implement functionality, even if you are uncomfortable with how the code is working. If you do run into a problem where you are unable to implement some functionality after exhausting your resources, please submit a [WIP] pull request *with an explicit question* so that instructors can view the code in context.

## <a name="evaluation"></a> Evaluation

This project is not graded but the following rubric can help determine if you are moving at the correct pace:

(1) well below expectations
(2) below expectations
(3) as expected
(4) better than expected

### Feature Delivery

**1. Completion**

* 4: Developer delivered all planned features plus 2 extensions.
* 3: Developer delivered all planned features.
* 2: Developer reduced functionality to meet the deadline.
* 1: Developer missed major features and/or the application is not deployed to production.

**2. Organization**

* 4: Developer used a project management tool and updated their progress in real-time.
* 3: Developer used a project management tool to keep their project organized.
* 2: Developer used a project management tool but didn't update the progress frequently.
* 1: Developer failed to use a project management tool to track its progress.

### Technical Quality

**1. Test-Driven Development**

* 4: Project demonstrates high test coverage (>90%), tests at the feature and unit levels, and does not rely on external * services.
* 3: Project demonstrates high test coverage (>80%), tests at feature and unit levels, but relies on external services
* 2: Project demonstrates high test coverage (>70%), but does not adequately balance feature and unit tests
* 1: Project does not have 70% test coverage

**2. Code Quality**

* 4: Project demonstrates exceptionally well factored code.
* 3: Project demonstrates solid code quality and MVC principles.
* 2: Project demonstrates some gaps in code quality and/or application of MVC principles.
* 1: Project demonstrates poor factoring and/or understanding of MVC.

### Product Experience

**1. User Experience**

* 4: The application is a logical and easy to use implementation of the target application
* 3: The application covers many interactions of the target application, but has a few holes in lesser-used functionality
* 2: The application shows effort in the interface, but the result is not effective
* 1: The application is confusing or difficult to use
