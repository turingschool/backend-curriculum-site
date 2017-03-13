---
layout: page
title: Tracker & Git Workflow
length: 90
tags: workflow, professional skills
---

Learning & Completion Goals
------------------

*   Student understands the expected workflow for turning stories into deployed features
*   Student is setup with a Pivotal Tracker account
*   Student is familiar with the basic workflow of using Tracker
*   Student is familiar with the meanings of each Tracker state
*   Student understands the roles of development, staging, and production

Session Plan
------------

### Workflow (10 Minutes)

In the previous lesson we explored how business requirements turn into work-ready 1-point stories. Today we'll continue the flow:

*   A member or pair of the Dev Team (Worker) begins work on the story Tracker
*   Worker writes acceptance criteria/tests
*   Worker implements the feature
*   Worker submits a pull request (PR)
*   DT and/or Mentor reviews the pull request for technical expectations [
*   Worker merges the PR
*   Worker deploys the feature to staging
*   Worker tests the feature in staging
*   Worker notifies the PO that the feature is ready to test
*   PO tests and approves the feature
*   Worker deploys the feature to production
*   Worker notifies users of the new feature
*   Worker solicits user feedback on the new feature
*   Worker watches for user feedback or bug reports and, if needed, uses them to create new stories

### Communication (10 Minutes)

*Tracker* is the core of our communication, home for:

*   Durable communication between the PO and the dev team
*   Definitions of what is to be done
*   Scheduling of when it will be done
*   Tracking of what feature is at what stage of completion
*   Particpants: PO, TL, DT

*GitHub* is for:

*   Technical communication among the dev team, mentors, and technical lead
*   Organization of code
*   Technical documentation
*   Particpants: TL, DT, Mentors

*Slack* is for:

*   Non-durable communication
*   Scheduling people, meetings
*   Sharing of files, documents, etc
*   Particpants: PO, TL, DT, Mentors

### Environments (10 Minutes)

We'll execute code in three main environments:

#### Development

Where you do your normal work, probably on your own laptop.

#### Staging

An environment that mimics Production as closely as possible. It has the same software and OS as production running the same versions. It has data that's similar to production (though often "sanitized" for user privacy).

Production-quality code is deployed to Staging for team and PO evaluation.

#### Production

Approved features are deployed to production where they're accessible to live users.

### Getting Started with Tracker (45 Minutes)

Pivotal Tracker is a heavy tool that will take some practice.

Get started by working your way through this [Quick Start](https://www.pivotaltracker.com/help/articles/quick_start/)

#### Card Types

##### Feature

A feature is the primary card type. We use a card to represent a single story. A card of this type can be estimated. Completing the card adds to the team's velocity.

##### Bug

A bug card is used to track bugs that are found in features already deployed. These cards are not estimated and do not count towards velocity.

If a bug is going to take more than an hour or two to solve, it may deserve to be upgraded to a proper story.

##### Chore

Chores are tasks that needs to be completed but do not directly deliver business value. For instance, a team/project might need to "Setup PostgreSQL accounts on the production server". That's a chore. They are not estimated and don't contribute to velocity.

##### Release

These are checkpoints. We'll use at least one release at the end of each sprint. Your PO may choose to add mid-sprint release points to gauge progress.

#### Story States

Story cards in Tracker go through several stages: "Not Yet Started", "Started", "Finished", "Delivered", "Accepted", and/or "Rejected".

Here are the transitions that each story card should progress through for your project.

#### Clicking "Start" => "In Progress"

The order that cards appear in a Tracker project indicates their priority as determined by the product manager and/or project manager. No cards should be in progress unless *all* cards of higher priority are completed or also in progress.

When you're ready to begin a story you click its `START` button which changes it's status to *In Progress*

Any Tracker story card being worked on should be marked as in-progress by one of the members of the pair (or the solo dev) working on it. This lets other developers know not to duplicate the work going in to that card's feature.

#### Clicking "Finish" => Finished

When the card is done, mark it as finished. If there are other tightly-related cards that make sense to deliver all together, begin working on another card. But if this card stands alone or completes the thread, move on to the following steps.

#### Clicking "Deliver" => Delivered

Put cards into this state when a pull request has been made that contains the commits implementing its story. The one PR might encompass multiple cards, so they all get "Delivered" at once.

If the code is satisfactory it is merged.

#### Clicking "Accept" => Accepted or "Reject" => Rejected

The work has been completed and merged. That branch gets deployed to the staging environment. The Project Owner is notified that the story is ready for evaluation.

**Only the Product Owner decides to Accept/Reject a card.**

If the PO finds the feature to meet the expectations of the story, they click "Accept". Once accepted, the card is frozen and the status should *never* be changed. The code is ready to be deployed to production.

If the PO finds a problem, they click "Reject" to turn it to "Rejected" at which point the cycle can be restarted by the developers.

If a problem is found after the card is rejected (at any point in the future), create a Bug Card rather than altering the accepted story.

### GitHub Workflow

You're probably already familiar with how to use a feature-branch/PR workflow on GitHub, but here's a refresher:

#### Establish a `master`

We start with a `master` branch, in this case, the branch we inherit from the previous project, that remains stable and **deployable at all times**.

#### Create Feature Branches

To add a new feature, say, adding a background job for sending email, we would create a new feature branch called `email_background_jobs` and begin doing our work there.

You might use one feature branch for each story, but likely you have a thread of a few stories that are tightly related. It makes sense to build these all on the same feature branch.

#### Completing a Feature

When we think we have completed the feature, we pull in any new updates from the stable master branch into our feature branch and then push that feature branch up to GitHub. Once there, we open a GitHub pull request to pull our new feature into `master`

#### Evaluating a Feature

At this point, the other persons on the team will look at the pull request to review the code and decide if it is ready to be merged into `master`.

#### Deployment to Staging

Once merged, the code should be deployed to your staging environment and the PO asked for review/feedback.

#### Deployment to Production

If the PO approves of the feature then it should be deployed to master and, likely, users notified of the new feature.

#### References

For a similar but more advanced version of this workflow, see [here]( http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html)

### Practice with Tracker (15 Minutes)

Use your current project Tracker to go through this sequence:

*   Create a new Feature card with a made-up story (in the "Description" box) and save it
*   Add an estimate
*   Add a question for the PO in a comment
*   Set yourself as the owner of the story
*   Start the card, imagining that you being development
*   Role-play by adding comments to the story as you move the card through each state (ie: "Completed the feature and pushed to GitHub" then taking the appropriate action)
*   Once it's all done, delete the card

Then, *repeat* the process with a Bug card.

Finally, *repeat* the process with a Chore card.

Wrap
-----------

You're ready to start working with Tracker!
