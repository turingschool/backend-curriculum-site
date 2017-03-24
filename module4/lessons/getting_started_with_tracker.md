---
layout: page
title: Getting Started with Tracker
length: 30
tags: workflow, professional skills
---

Why
-------

Professional software teams use tools to organize their development. While simple tools Trello or Waffle can work in small teams with simple structures, larger teams use larger tools. These larger tools are particularly appropriate when we have multiple parties involved including developers, project managers, product owners, Q/A, etc.

While tools like Pivotal Tracker and Jira can be used in different ways in different organizations, let's explore a mainstream way to use Pivotal Tracker.

### Learning Goals

*   Learners are familiar with the visual layout of Pivotal Tracker.
*   Learners can explain the four types of tracker cards: feature, bug, chore, and release.
*   Learners understand how to assign points and estimate a feature.
*   Learners are familiar with a recommended progression of features.

Exploring Tracker
------------

### Warmup (2 minutes)

*   Open your Quantified Self Pivotal Tracker.
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
*   *Members* - Up the the top tab bar, note that Members is where we control who has access to this project.

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

### Bug

A bug card is used to track bugs that are found in features already deployed.

*   One bug card per problem.
*   Bugs do not carry estimates.
*   Bugs do not affect velocity.

If a bug is going to take more than two hours to solve it may deserve to be upgraded to a feature.

*Practice*: Create a bug card with the title "Debug why new account emails are sent properly in staging but not production"

### Chore

Chores are tasks that needs to be completed but do not directly deliver business value. For instance, a team/project might need to "Setup PostgreSQL accounts on the production server". That's a chore. They are not estimated and don't contribute to velocity.

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

Estimation Refresher
----------

Each feature story should have an estimate. As a quick refresher, here's how we understand the point scale:

*   3 Points - A vague idea or technology we don't understand
*   2 Points - A concept that we understand, but it's too big to start work on (needs to be subdivided)
*   1 Point - A story that is understood and ready for work

A good 1-point story represents less than a half day of work.
