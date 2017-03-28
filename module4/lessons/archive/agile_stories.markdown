---
layout: page
title: Agile & Stories
length: 90
tags: workflow, professional skills
---

How you schedule, manage, and communicate about your work is more important than the code you write. Let's set some clear expectations for ourselves during the module.

Learning & Completion Goals

*   Student understands the expected workflow for turning ideas/requirements into work-ready stories.
*   Student is familiar with a template for good stories.
*   Student is able to write a story following the template.
*   Student is able to use a point system for estimating stories.
*   Student is able to decompose a complex story into a simpler one.

Session Plan

### Schedule

*   30 Minutes: Project Roles & Responsibilities
*   20 Minutes: Writing Stories
*   30 Minutes: Pivotal Tracker

### Roles & Responsibilities

In a typical project there are several roles including those below. One person might have multiple roles.

#### Product Owner

The *Product Owner* is responsible for:

*   Defining the business needs of the project (ie: what should it do, what should it not do)
*   Approving the completion of work (ie: deciding whether it does or does not fulfill the expectations based on acceptance criteria)
*   Providing the ideas/information needed to write stories
*   Setting story priority

#### Users

The *Users* are responsible for:

*   Using the software to achieve their business needs
*   Submitting bug reports and feedback

#### Technical Lead

The *Technical Lead* is responsible for:

*   Advising the overall technical approach
*   Ensuring that code is well built
*   Ensuring that strong technical workflow practices are being followed (project tracker, pull requests, documentation, etc)
*   Connecting the team with technical resources (mentors, books/articles, etc)

#### Technical Mentor

The *Technical Mentor* is responsible for:

*   Reviewing code quality and providing feedback
*   Helping think through complex technical challenges
*   Providing perspective from other experience/projects

#### Developers

The *Developers* are responsible for:

*   Turning business requirements from the Product Owner into stories
*   Estimating the stories
*   Scheduling the stories based on the PO's priorities
*   Writing acceptance tests that demonstrate the business value described by the story
*   Implementing features in fulfillment of the acceptance tests
*   Using a strong collaborative method for merging features
*   Deploying features into staging for approval from the PO
*   Deploying approved features into production
*   Gathering feedback from the users
*   Turning user feedback into new acceptance criteria, bug stories, etc with guidance from the PO
*   Coordinating with the Technical Lead for feedback and planning
*   Coordinating with the Technical Mentors for pairing, code review, etc
*   Notifying users of new features, changes, etc

### How Stories Are Born

In a perfect world, here's how an idea turns into production code:

*   Product Owner (PO) discusses the business needs with Dev Team (DT), in person or on Slack
*   DT drafts and estimates a story or multiple stories, sends to Product Owner for feedback/approval
*   PO approves and schedules the story]

At that point, the story is ready to be worked on. In a follow up lesson we'll review the workflow after this point.

### Writing Stories (20 Minutes)

*   Stories communicate intent and achievement
*   Good stories are easy to understand
*   Like any goals, they should be [SMART](http://en.wikipedia.org/wiki/SMART_criteria)
*   Serve as the contract between developer and product owner
*   But the Product Owner is always right

#### A Template for Stories

```plain
As a(n) [user type]
In order to [extract business value]
When I [take some action]
  (and [take some other action])
Then I [observe an outcome]
  (and I [observe another outcome])
```

#### Quick Story Writing

Let's start with some ideas that translate well to single stories.

*Imagine* we've prototyped a small to-do list app. It just allows the user to create to-dos. And it only supports a single user.

Start on your own and draft one story for *each* of the following:

*   Users can complete a task and it moves somewhere else.
*   User knows how many items are on the to-do list.
*   Search my to-do's.
*   Clicking trash on a to-do pops up a confirm/cancel dialog
*   What else does the team need to know to make a successful MVP?

Then we'll turn to a pair and compare our results.

As a group, let's brainstorm questions to increase clarity for user stories.

### Estimating Stories

When we write a story we have to estimate it for the purposes of scheduling. Points-based estimating can be difficult to wrap your head around. Here's how we'll use the points:

*   3 Points - A vague idea or technology we don't understand
*   2 Points - A concept that we understand, but it's too big to start work on (needs to be subdivided)
*   1 Point - A story that is understood and ready for work

#### Decomposing Stories

Start with this 2-point story:

```
As an unauthenticated user
When I click "Login with Census"
And I login successfully
Then I see only my own todos
```

This is way too big to start work on! It'll be in-progress for days.

With your pair, work on drafting at least four 1-point stories that add up to this 2-point story.

#### Big-Picture Thinking

Imagine that you get into a meeting with the PO and they tell you *"Oh, by the way, the app should have an API"*. You jot down a quick 3-point story so it doesn't get forgotten -- but there's no way to start work on an idea that's so vague.

On your own take five minutes to draft at least three 2-point stories about building the todo list's API.

Trade a two-point story with your pair and spend five minutes drafting at least three 1-point stories from theirs.

Big Finish
------------

*   Recap our learning goals & check outcomes
*   Questions
*   Follow up: check out [books/resources like this one](https://www.amazon.com/Fifty-Quick-Ideas-Improve-Stories/dp/0993088104/ref=sr_1_4?ie=UTF8&qid=1485141290&sr=8-4&keywords=agile+stories)
