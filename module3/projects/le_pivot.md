---
title: Le Pivot
length: 2 weeks
tags:
type: project
---

## Project Description

Your Little Shop project was a huge success. As it turns out there is an opportunity to make more money. Instead of supporting just one store, we are going to *pivot* and add support for multiple stores -- (think Amazon).

In this project, you'll build upon an existing implementation of Little Shop. You will transform your e-commerce site into a platform that handles multiple, simultaneous businesses. Each business will have their own name, unique URL pattern, items, orders, and administrators.

The project goals and expectations are listed below:

* [Learning Goals](#learning-goals)
* [Teams](#teams)
* [Setup](#setup)
* [Workflow](#workflow)
* [Technical Expectations](#technical-expectations)
* [Requirements](#requirements)
* [Base Data](#base-data)
* [Milestones](#check-ins-and-milestones)
* [Evaluation](#evaluation)

## <a name="learning-goals"></a> Learning Goals

During this project, you'll learn about:

* Work with Multitenancy
* Implement JavaScript
* Secure a Rails App
* Learn to work with brownfield code
* Deliver user stories outside of your comfort zone

## <a name="teams"></a> Teams

The project will be completed by teams over the span of two weeks.

Your team will be responsible for:

* transforming business requirements into user stories.
* working with the customer to establish team priorities.
* seeking clarification from the customer when a user story is not clear.
* making sure all team members are on track and collaborating following a professional workflow.

As individuals you are responsible for:

* seeking out features and responsibilities that are uncomfortable.
* supporting your teammates so that everyone can collaborate and contribute.
* following a professional workflow when developing a feature.

## <a name="setup"></a> Setup

### Project Starting Point

You'll build upon an existing code base assigned by the instructors. You need to work on adapting and improving this codebase, not building your own thing from scratch. This is sometimes called "brownfield" development, and you'll soon know why.

### Exploring the Little Shop App

As a group, dig into the code base and pay particular attention to:

* Test coverage and quality
* Architectural concerns
* Components that are particularly strong or weak
* General strengths and weaknesses

### Beginning The Pivot

Once you've explored the base project:

* Create a new, blank repository on GitHub named `le_pivot` (or some other meaningful name if you prefer)
* Clone [the base project](https://github.com/turingschool-examples/the_pivot_base) that you'll be working with to your local machine
* Go into that project directory and `git remote rm origin`
* Add the new repository as a remote `git remote add origin git://new_repo_url`
* Push the code `git push origin master`
* Add team members and your product owner as collaborators in Github

Once the team lead has done this, the other team members can fork the new repo.

### Restrictions & Outside Code

Your project should evolve, refactor, and clean up the code you inherit. This includes deleting redundant, broken, or obsolete code. However, you should **not** throw out the previous work wholesale.

Furthermore, there should be *no reduction in functionality* except when explicitly called for by new requirements.

### Project Management Tool

There are many popular project management tools out there. For this project we'll use Pivotal Tracker. Instructors will set up a Tracker project for you and send out invites to all team members.

## <a name="workflow"></a> Workflow

### Client Interaction

You will meet with the client frequently to obtain business needs and correct course. You will transform these requirements into user stories.

A feature will not be considered complete until it is working in production. In many jobs your clients won't have programming knowledge. Learning how to manage expectations is a big part of being a professional developer.

The stories as written and prioritized in your project management tool will be the authoritative project requirements. They may go against and likely go beyond the general requirements in this project description.

As the stories clearly define the customer's expectations, your application needs to **exactly** follow the stories as they've been developed with your customer. A 95% implementation is wrong.

If you want to deviate from the story as it's written, you need to discuss that with your client and get approval to change the story *first*.

### User Stories

User stories follow this pattern:

*As a [user], when I [do something], I [expect something].*

Examples:

```
As an admin
When I click on "Dashboard"
I should be on "/dashboard"
And I see a list of all users.
```

```
As a store admin on my store dashboard page
When I visit click on "Orders"
I can see the orders listed by status.
```

### Working with Git

Once you have written the user stories, each team member should:

1. Select a story from the project management tool.
2. If the story is not clear, add comments or request clarification.
3. Create a feature branch in your *local* repo.
4. Write a feature test.
5. Implement the requested feature.
6. Merge the latest master into the requested feature to make sure that all the tests are passing.
7. Commit referencing the issue that you are working on in the commit message. Check this [guide](https://help.github.com/articles/closing-issues-via-commit-messages/) for more information.
8. Push the *feature* branch to the *remote* repo.
9. Submit a pull request asking to merge the branch into *master*.
10. A teammate reviews the code for quality and functionality.
11. The teammate merges the pull request and deletes the remote branch.

## <a name="technical-expectations"></a> Technical Expectations

You will receive stories, chores, and tasks that need to be taken care of. Most of the project requirements will be communicated through your project management tool. The following is a high level overview of our goals.

You are to extend Little Shop so that it can handle multiple, simultaneous businesses.

The Pivot should be able to handle the following users:

* Guest Customer
  * Visit different businesses.
  * Add items from multiple businesses into a single cart.
  * Log in or create an account before completing checkout.
* Registered Customer
  * Make purchases on any business
  * Manage my account information
  * View my purchase history
* Store Manager
  * Manage items on my business
  * Manage orders on my business
* Store Admin
  * Manage items on my business
  * Manage orders on my business
  * Update my business information
  * Manage other business managers and business admins for your store
* Platform Admin
  * Approve or decline the creation of new businesses
  * Take a business offline / online
  * Perform any functionality restricted to business admins

## Requirements

Group size and communication will impact how much work can be completed. Work with your product owners to set expectations. You will be graded on what you commit to.

### Initial State and migrations

Each project must be deployed and seeded in the original state of the app. When running the migrations to support multitenancy the existing data and uptime should not be disrupted. *DO NOT ALTER ANY OF THE PRE-EXISTING DATA IN PRODUCTION*. Your product owners will be checking to confirm data isn't being lost or changed. If you want to test your features out in production create new data. Deploy early and often. Every time code makes it to your main branch it should be deployed.

## Base Data

In addition to the pre-populated data, you should add

* 5 businesses
* 10 additional categories
* 5 items per new category
* 5 additional registered customers, one with the following data:
  * Username: josh@turing.io
  * Password: password
* 1-5 orders per new registered customer
* 1 new business manager per business with the following data:
  * Username: josh@turing.io
  * Password: password
* 1 new business admin per business, one with the following data:
  * Username: ian@turing.io
  * Password: password
* 1 new platform administrators
  * Username: cory@turing.io
  * Password: password

It creates a much stronger impression of your site if the data is plausible. We recommend creating a few "template" businesses that have real listings, then replicating those as needed. You could also use the [Faker](https://github.com/stympy/faker) gem.

## Check-ins and Milestones

Each team will have daily stand-ups with their product owner. On the job most technical discussion will take place on Github. You should practice asking technical questions of your instructors on Github in addition to Slack and face-to-face conversations. Be sure to add your product owner to your Github repo.

### Day 1

#### What should be done

The scope of the pivot is more fluid than prior projects. Your client will want to go over your plan for the project. Don't underestimate the value of a good plan. Groups that communicate and plan will outperform those that just start coding.

* DTR
* Each group member should assign themselves a user story that is challenging for them to complete by the end of the project. You don't need to work on this yet but there are likely other pieces that need to be in place to complete that story (aka blockers).
* Wireframes
* Design
* Original state of the application should be deployed

### Day 2

#### What should be done

* Review test suite and get a sense of what isn't tested
* Schema should be sketched out.
* Stories should be prioritized based on selected stories and blockers.
* Writing of additional user stories should be completed
* Start building the most important pieces.

### Day 3

#### What should be done

At this point you should be moving along with coding and fixing tests.

## Deployment and Workflow

Each team must...

* deploy early and often.
* disable the ability to push to master.
* setup continuous integration to validate there are no failing tests prior to deployment.
* use the pull request template.
* review pull requests prior to merging.
* deploy to production after merging to master.

Some groups may have a workflow that doesn't merge to master from a PR. You should avoid waiting days to deploy. The most successful groups will likely deploy every time something makes it to master (or whatever main branch you are working off of).

## Evaluation

You'll be graded on each of the criteria below with a score of (1) well below
expectations, (2) below expectations, (3) as expected, (4) better than expected.

### Peer Evaluation

Each group member will evaluate each member of the group anonymously based on the criteria below. Students will receive the average score combined from all group members. 3 and above is considered passing.

* Communication
  * 4: Group member did all the things mentioned in the bullet point below, but also was a catalyst for communication with the whole group.
  * 3: Group member communicated clearly when they would and wouldn't be available well ahead of time. It was clear what they were working on and what the status was.
  * 2: Group member would communicate when they would or wouldn't be available, but not until the last minute, or they would miss deadlines and not notify the group until the last minute.
  * 1: It was unclear what the group member was working on, or they would fail to notify the team when they weren't going to meet a commitment.

* Group member contributed code (quantity and quality)...
  * 4: above expectations.
  * 3: as expected.
  * 2: below expectations.
  * 1: well below expectations.

* I would like to work with this group member professionally.
  * 4: Absolutely. I will likely seek them out in the future with the hopes of working with them again.
  * 3: Yes, I think I would enjoy working with them.
  * 2: I would prefer not to.
  * 1: I would actively avoid working with them again.

### Client Evaluation

**Completion**

* Team completed all the user stories and requirements set by the client.
  * 4: Better than expected
  * 3: As expected
  * 2: Below expectations
  * 1: Well below expectations

**User Experience**

* Project exhibits a production-ready user experience.
  * 4: Better than expected
  * 3: As expected
  * 2: Below expectations
  * 1: Well below expectations

**Organization**

* Team used a project management tool to keep their project organized.
  * 4: Better than expected
  * 3: As expected
  * 2: Below expectations
  * 1: Well below expectations

### Technical Evaluation

**Git Workflow**

* Team always used pull requests and commented on pull requests prior to introducing code into the master branch.
  * 4: Better than expected
  * 3: As expected
  * 2: Below expectations
  * 1: Well below expectations

**Test Quality**

* If you were paying for someone to build this for you, would you be satisfied with the tests that are written?
  * 4: Better than expected
  * 3: As expected
  * 2: Below expectations
  * 1: Well below expectations

**Code Quality**

* Project demonstrates well factored code and a solid grasp of MVC principles.
  * 4: Better than expected
  * 3: As expected
  * 2: Below expectations
  * 1: Well below expectations

**Bonus**

We want to recognize and reward risk taking and exploring. Sometimes other areas might suffer if the risk doesn't pan out. Earn a bonus point to offset a score above.

* Did the team push themselves by taking risks?
  * 1: Yes
  * 0: No
