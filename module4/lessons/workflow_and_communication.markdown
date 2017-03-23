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

See [Getting Started with Tracker](/miscellaneous/getting_started_with_tracker) lesson.

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
