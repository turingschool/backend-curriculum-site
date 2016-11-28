---
layout: page
title: Workflow & Communication
length: 90
tags: workflow, professional skills
---

How you schedule, manage, and communicate about your work is more important than the code you write. Let's set some clear expectations for ourselves during the module.

Put together a set of expectations of how the project teams will communicate: standups, stories, project management, etc

## Learning & Completion Goals

* Student is setup with a Pivotal Tracker account
* Student is familiar with the basic workflow of using Tracker
* Student is familiar with a template for good stories
* Student is able to use a point system for estimating stories

## Session Plan

### Schedule

* 15 Minutes: Micro-DTR
* 25 Minutes: How Capstones Work
* 20 Minutes: Writing Stories
* 30 Minutes: Pivotal Tracker

### Micro-DTR (15 Minutes)

Let's start in your new project groups discussing the following questions:

* As an individual, how do you define "success" for this module?
* What strengths do you bring to the group?
* What weaknesses are you looking to improve?
* What topics / areas of focus are you most exited about?
* What, from a technical or logistical perspective, are you most concerned about this module?

### How Capstones Work (25 Minutes)

Ready for a six-week project? Let's discuss how things will actually work.

#### Sprints

* Three two-week sprints
* Team-scheduled standup each weekday
* Internal demos every Thursday
* Scope setting each Thursday
* Outcomes report submitted Thursday PM
* Instructor feedback each Friday

#### Roles

The *Product Owner* is responsible for:

* Defining the business needs of the project (ie: what should it do, what should it not do)
* Approving the completion of work (ie: deciding whether it does or does not fulfill the expectaions based on acceptance criteria)
* Providing the ideas/information needed to write stories
* Setting story priority

The *Technical Lead* is responsible for:

* Advising the overall technical approach
* Ensuring that code is well built
* Ensuring that strong technical workflow practices are being followed (project tracker, pull requests, documentation, etc)
* Connecting the team with technical resources (mentors, books/articles, etc)

The *Technical Mentor* is responsible for:

* Reviewing code quality and providing feedback
* Helping think through complex technical challenges
* Providing perspective from other experience/projects

The *Users* are responsible for:

* Using the software to achieve their business needs
* Submitting bug reports and feedback

The *Dev Team* is responsible for:

* Turning business requirements from the Product Owner into stories
* Estimating the stories
* Scheduling the stories based on the PO's priorities
* Writing acceptance tests that demonstrate the business value described by the story
* Implementing features in fulfillment of the acceptance tests
* Using a strong collaborative method for merging features
* Deploying features into staging for approval from the PO
* Deploying approved features into production
* Gathering feedback from the users
* Turning user feedback into new acceptance criteria, bug stories, etc with guidance from the PO
* Coordinating with the Technical Lead for feedback and planning
* Coordinating with the Technical Mentors for pairing, code review, etc
* Notifying users of new features, changes, etc

#### Workflow

Software never goes to plan. But in the perfect world, here's how an idea turns into production code:

* Product Owner (PO) discusses the business needs with Dev Team (DT) [In person / Slack]
* DT drafts a story, sends to PO for feedback/approval (likely multiple stories at once) [Tracker]
* PO approves the story and communicates the priority [Tracker]
* DT estimates the story and schedules it for completion [Tracker]
* A member or pair of the Dev Team (Worker) begins work on the story [Tracker]
* Worker writes acceptance criteria/tests
* Worker implements the feature
* Worker submits a pull request (PR) [GitHub]
* DT and/or Mentor reviews the pull request for technical expectations [GitHub]
* Worker merges the PR [GitHub]
* Worker deploys the feature to staging
* Worker tests the feature in staging
* Worker notifies the PO that the feature is ready to test [Tracker]
* PO tests and approves the feature [Tracker]
* Worker deploys the feature to production
* Worker notifies users of the new feature [Slack / Email]
* Worker solicits user feedback on the new feature
* Worker watches for user feedback or bug reports and, if needed, uses them to create new stories [Tracker]

#### Communication

Let's try and be organized about how we use our tools:

*Tracker* is the core of our communication, home for:

* Durable communication between the PO and the dev team
* Definitions of what is to be done
* Scheduling of when it will be done
* Tracking of what feature is at what stage of completion
* Particpants: PO, TL, DT

*GitHub* is for:

* Technical communication among the dev team, mentors, and technical lead
* Organization of code
* Technical documentation
* Particpants: TL, DT, Mentors

*Slack* is for:

* Non-durable communication
* Scheduling people, meetings
* Sharing of files, documents, etc
* Particpants: PO, TL, DT, Mentors

### Writing Stories (20 Minutes)

* Stories communicate intent and achievement
* Good stories are easy to understand
* Like any goals, they should be [SMART](http://en.wikipedia.org/wiki/SMART_criteria)

#### A Template for Stories

```plain
As a(n) [user type]
In order to [extract business value]
When I [take some action]
  (and [take some other action])
Then I [observe an outcome]
  (and I [observe another outcome])
```

#### Story Practice

* TODO

#### Estimating a Story

When we write a story we have to estimate it for the purposes of scheduling. Points-based estimating can be difficult to wrap your head around. Here's how we'll use the points:

* 3 Points - A vague idea we don't understand
* 2 Points - A concept that we understand, but it's too big to start work on
* 1 Point - A story that is understood and ready for work

### Getting Started with Tracker (30 Minutes)

Pivotal Tracker is a heavy tool that will take some practice.

Get started by working your way through this [Quick Start](https://www.pivotaltracker.com/help/articles/quick_start/)

#### In Progress

The order that cards appear in a Tracker project indicates their priority as determined by the product manager and/or project manager. No cards should be in progress unless all cards of higher priority are completed or also in progress.

Any Tracker story card being worked on should be marked as in-progress by one of the members of the pair (or the solo dev) working on it. This lets other developers know not to duplicate the work going in to that card's feature. When the feature for a card is complete, that card should be marked as finished before moving on to the next card.

Although multiple related cards may be marked as owned by a particular developer at the same time, having more than one card in progress at the same time should not be common and should likely indicate that one of the stories has been blocked by dependence on another feature.

#### Story States

Story cards in Tracker go through several stages: "Not Yet Started", "Started", "Finished", "Delivered", "Accepted", and/or "Rejected".

Here are the transitions that each story card should progress through for your project.

##### Not Yet Started

The beginning state, these requirements have been gathered but no work has been done.

##### Started

The state of the card once someone begins working on it. From here, there are two paths:

* Decide not to work on the card. Put the card back into "Not Yet Started", and possibly remove your ownership.
* Complete work on the card and mark it as "Finished"

##### Finished

The card is believed to be complete and correct. The next action taken on it will be delivery. However, it may depend on other cards, and not be delivered until those are ready, too. When they are, "Deliver" all those cards.

##### Delivered

Put cards into this state when a pull request has been made that contains the commits implementing its story. Now it's time for the team to review the work, and make one of two choices.

* Accept the card's work as correct and merge it into the `master` branch.
* Reject the card's work as insufficient, incorrect, or simply not able to be merged cleanly. Include the reason in the rejection.

##### Accepted

The work has been completed and merged into master. Once accepted, the card is frozen and the status should never be changed. If you later realize a problem with that card's work, open a new bug card.

##### Rejected

There was some problem with the card preventing it from being merged to master. The card should be restarted, putting it back into the "Started" state. Correct the problem and proceed through the stages again.

### Addendum: GitHub Workflow

You're probably already familiar with how to use a feature-branch/PR workflow on GitHub, but here's a refresher:

#### Establish a `master`

We start with a `master` branch, in this case, the branch we inherit from the previous project, that remains stable and **deployable at all times**.

#### Create Feature Branches

To add a new feature, say, adding a background job for sending email, we would create a new feature branch called `email_background_jobs` and begin doing our work there.

#### Completing a Feature

When we think we have completed the feature, we pull in any new updates from the stable master branch into our feature branch and then push that feature branch up to GitHub. Once there, we open a GitHub pull request to pull our new feature into `master`

#### Evaluating a Feature

At this point, the other persons on the team will look at the pull request to review the code and decide if it is ready to be merged into `master`.

If so, someone designated by the team can perform the merge, updating `master`. Now everyone that has work on a new feature, not yet in master, will update their in-progress feature branch to pull in the lastest code from `master`. In this way, we maintain a stable, deployable, up-to-date branch, `master`, while making progress on new features in branches that stay reasonably up to date. This reduces merge conflicts.

#### References

For a similar but more advanced version of this workflow, see: http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html
