---
layout: page
title: Intro to Professional Workflow
length: 30
tags: workflow, professional skills
---

### Learning Goals

*   Learners are familiar with the visual layout of Pivotal Tracker.
*   Learners can explain the five types of tracker cards: feature, epic, bug, chore, and release.
*   Learners understand how to assign points and estimate a feature.
*   Learners are familiar with a recommended progression of features.
*   Understand roles and responsibilities.

Structure
-----------

|-|-|
| 5| Overview and Warmup |
|20| Exploring Tracker |
| 5| Pomodoro |
|25| Exploring Continued |
| 5| Pomodoro |
|20| Applied Practice |
| 5| Review |

Why
-------

Professional software teams use tools to organize their development. While simple tools Trello or Waffle can work in small teams with simple structures, larger teams use larger tools. These larger tools are particularly appropriate when we have multiple parties involved including developers, project managers, product owners, Q/A, etc.

While tools like Pivotal Tracker and Jira can be used in different ways in different organizations, let's explore a mainstream way to use Pivotal Tracker.

Exploring Tracker
------------

### Warmup (2 minutes)

*   Open your project in Pivotal Tracker.
*   Find *two* terms, buttons, or features that you don't understand.
*   Try to create a new story card with a two-point estimate.

Pivotal Tracker is a heavy tool that will take some practice.

Additional Resource for getting started is [here](https://www.pivotaltracker.com/help/articles/quick_start/).

### Create a Project

If you have admin access, you can create a project. Without paying for admin access, you will not be able to create a project.

*   Click the top left project menu (might say "Pivotal Tracker" or the name of your project).
*   Click "Dashboard".
*   Click the green "Create Project" button in the top right.

### What is a Workspace?

-   The `Create Workspace` feature will be used mostly by Project Managers, Product Owners and Developers that might work on multiple projects in tandem.
-   Workspaces are private and only accessible to the specific user. (Good for personal organization).
-   Projects are color-coded for organization.

#### Project Naming

*   Organization is critical.
*   Create a naming convention.

#### Public? Private?

For student work it's probably best to make the project's *public*. That'll allow casual participants like mentors and students in other cohorts to view the project details but not contribute.

#### Other Settings

-   When Pivotal Tracker opens, it opens to the dashboard. This can be changed in the users profile under `start page` to open the project that is currently being worked on.

#### What You See

Here are a few things to observe:

*   *Current Iteration / Backlog* - this is where we keep the prioritized cards we're working on now or in the near future.
*   *Icebox* - this is where we keep cards for the future and ideas we don't want to forget about. They are not ready to work on. Once it has a good estimate, it can move into current iteration/backlog .
*   *Velocity* - Right next to the backlog title is a velocity that estimates how many points our team is delivering per week.
*   *Members* - The last link on the top left nav bar, note that Members is where we control who has access to this project.

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
*   PO approves and schedules the story

At that point, the story is ready to be worked on. In a follow up lesson we'll review the workflow after this point.

Creating Cards
--------------

There are four card types:

### Feature

A feature is the most common card type -- it describes a unit of business value to be delivered through software.

*   One feature card for each story.
*   A feature card can be estimated.
*   Completing the feature adds to the team's velocity.

*Practice*: Create a feature card with the story below and give it a one-point estimate

```
As a Tracker user
When I create a new feature card
And I enter the story
And I set an estimate
And I click Save
Then my teammates see the card in their project views
```

### Epic

Epics are made to help organize large themes of functionality. In other words, a bunch of small, related stories make up an epic.

For example, we might group all stories related to user authentication under an epic card titled "User Authentication". Labels tied to epics are colored purple, whereas regular labels are green. Epics allow teammates to assess and understand the state of a project based on broader themes and categories.

*Practice*: Create a User Authentication epic and designate a `LINKED LABEL` for it (e.g., "authentication"). Add two feature cards related to logging in and out and add the "authentication" label to them. Explore the epic once these features are written.

### Bug

A bug card is used to track bugs that are found in features already deployed.

*   One bug card per problem.
*   Bugs do not carry estimates.
*   Bugs do not affect velocity.

*Practice*: Create a bug card with the title "Debug why new account emails are sent properly in staging but not production"

### Chore

Chores are tasks that need to be completed but do not directly deliver business value. For instance, a team/project might need to "Setup PostgreSQL accounts on the production server". That's a chore. They are not estimated and don't contribute to velocity.

*Practice*: Create a chore card with the title "Setup email provider account keys for production server instance"

### Release

These are dated checkpoints. Typically you'll want to create a Release card for each check-in date and the project submission.

*Practice*: Create a release card with the name "End of First Sprint" dated for tomorrow

Card States
--------

Feature cards in Tracker go through several stages: "Not Yet Started", "Started", "Finished", "Delivered", "Accepted", and/or "Rejected".

What's important for each stage:

*   WHO: who clicks the button.
*   WHY: why they click it.
*   NEXT: what happens next

Here are the transitions that each story card should progress through for your project.

### A Note on Priority

The order that cards appear in a Tracker project indicates their priority as determined by the product manager and/or project manager. No cards should be in progress unless *all* cards of higher priority are completed or also in progress.

### START

*   WHO: Developer
*   WHY: They're ready to begin work on a new feature
*   NEXT: After clicking start they begin their development work

Any Tracker story card being worked on should be started when work *begins*. This lets other developers know not to duplicate the work going in to that card's feature.

### FINISH

*   WHO: Developer
*   WHY: They've completed the work and ready to move on
*   NEXT: After clicking finish they're ready to deliver

When the feature is built, submit a PR to the project and click FINISH.

If there are other tightly-related cards, mark the PR as a WIP, then go through the same START/FINISH cycle and add additional features to the same PR.

### DELIVER

*   WHO: Developer, Team Lead
*   WHY: The feature is merged and pushed to staging
*   NEXT: The PO will need to review the work

Once the PR is reviewed and accepted it's time to transition responsibility to the product owner. Push the feature to staging and click DELIVER.

### ACCEPT or REJECT

*   WHO: Product Owner
*   WHY: Determine if the feature is ready for production
*   NEXT: Deploy to prod

**Only the Product Owner decides to Accept/Reject a card.**

The PO visits the staging environment and exercises the feature according to the story.

If the PO finds the feature to meet the expectations of the story, they click "Accept". Once accepted, the card is frozen and the status should *never* be changed. The code is ready to be deployed to production.

If the PO finds a problem, they click "REJECT" and add a comment explaining the problem. At that point the entire cycle can be restarted by the developer.

If the PO finds additional functionality that should be implemented, they create a new feature card (rather than modifying this one).

If a problem is found after the story is accepted the PO should create a BUG card, not modify this feature.

#### Quick Story Writing

Let's start with some ideas that translate well to single stories.

*Imagine* we've prototyped a small to-do list app. It just allows the user to create to-dos. And it only supports a single user.

Start on your own and draft one story for *each* of the following:

*   Users can complete a task and it moves somewhere else.
*   User knows how many items are on the to-do list.
*   Search my to-do's.
*   Clicking trash on a to-do pops up a confirm/cancel dialog

Then we'll turn to a pair and compare our results.

As a group, let's brainstorm questions to increase clarity for user stories.

Estimating
----------

Each feature story should have an estimate. As a quick refresher, here's how we understand the point scale:

Points mean different things at different places. There is no one way to estimate stories. For now, let's use the following:

*   1 Point = ~2 hours of work



#### Decomposing Stories

Start with this 6-point story:

```
As an unauthenticated user
When I click "Login with Census"
And I login successfully
Then I see only my own todos
```

This is way too big to start work on! It'll be in-progress for days.

With your pair, work on drafting at least four 1-point stories that deliver the same functionality as this 6-point story.

#### Big-Picture Thinking

Imagine that you get into a meeting with the PO and they tell you *"Oh, by the way, the app should have an API"*. You jot down a quick 3-point story so it doesn't get forgotten -- but there's no way to start work on an idea that's so vague.

On your own take five minutes to draft at least three 2-point stories about building the todo list's API.

Trade a two-point story with your pair and spend five minutes drafting at least three 1-point stories from theirs.

Review
-------

Explain/describe the following:

* feature
* epic
* bug
* chore
* release
* assigning points
* progression/timeline of a feature
* business roles
