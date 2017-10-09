---
title: The Pivot
length: 2 weeks
tags:
type: project
---

## Project Description

Your Little Shop project was a huge success. As it turns out there is an opportunity to make more money. Instead of supporting just one store, we are going to *pivot* and add support for multiple stores -- (think Amazon).

In this project, you'll build upon an existing implementation of Little Shop. You will transform your e-commerce site into a platform that handles multiple, simultaneous businesses. Each business will have their own name, unique URL pattern, items, orders, and administrators.

The project requirements are listed below:

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

* Working with Multitenancy
* Implementing JavaScript
* Securing a Rails App
* Sending Email
* Creating Seed files

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

* Create a new, blank repository on GitHub named `the_pivot` (or some other meaningful name if you prefer)
* Clone the Little Shop project that you'll be working with to your local machine
* Go into that project directory and `git remote rm origin`
* Add the new repository as a remote `git remote add origin git://new_repo_url`
* Push the code `git push origin master`
* Add team members and your product owner as collaborators in Github

Once the team leader has done this, the other team members can fork the new repo.

### Tagging the Start Point

We want to be able to easily compare the change between the start of the project and the end. For that purpose, create a tag in the repo and push it to GitHub:

* $ git tag -a little_shop_v1
* $ git push --tags

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

You are to extend Little Shop so that it can handle multiple, simultaneous businesses. Each business should have:

* A unique name
* A unique URL pattern (http://example.com/name-of-business)
* Unique items
* Unique orders
* Unique administrators

The Pivot should be able to handle the following users:

### Guest Customer

As a guest customer, I should be able to:

* Visit different businesses.
* Add items from multiple businesses into a single cart.
* Log in or create an account before completing checkout.

### Registered Customer

As an registered customer, I should be able to:

* Make purchases on any business
* Manage my account information
* View my purchase history

### Business Manager

As a business manager I should be able to:

* Manage items on my business
* Manage orders on my business

### Business Admin

As a business admin, I should be able to:

* Manage items on my business
* Manage orders on my business
* Update my business information
* Manage other business admins for your store

### Platform Admin

As a platform admin, I should be able to:

* Approve or decline the creation of new businesses
* Take a business offline / online
* Perform any functionality restricted to business admins

## Requirements

The following is a list of possible features to include. Work with your product owner to determine how many are required. Group size and initial state of the application will impact how much work can be completed. The ones marked "required" must be implemented.

### Initial State and migration (required)

Each project must be deployed and seeded in the original state of the app. When running the migrations to support multitenancy the existing data and uptime should not be disrupted. When you are ready to deploy let your product owner know so they can monitor the process and deployment to confirm the data was successfully updated and that service didn't go down.

### Multitenancy (required)

See the specifics of the roles above.

### OAuth login (required)

We want to support OAuth login with Twitter or Facebook in addition to the existing login functionality with an email address.

### Build an Authenticated API for the Admin Dashboard (required)

In RailsEngine you built an API that anyone could access at anytime. That's kinda gross and not gonna fly most of the time. Let's build out an API with the intent that it will be consumed only on the Admin dashboard. You will have to lock down your API and authenticate your requests.

Mild: Check for an API key.
Spicy: Use a JWT (JSON Web Token). This is becoming the norm for front end applications interacting with back end apps.

### Implement an Admin Dashboard (required)

Practice your ActiveRecord and SQL chops. You can decide what types of info might be useful. Ideas: Top selling merchant, top selling items, inactive merchants, etc.

Use AJAX to consume your own API.

### Two-Factor Password Reset (required)

Using Twilio, build the following story. You must generate and track the reset code in your database and not use a third party for this.

```md
As a guest user
When I visit "/login"
And I click "Forgot my Password"
Then I should be on '/password-reset'

When I fill in `Email` with "josh@example.com"
And I click `Submit`
Then I should be redirected to "/password-confirmation"
And I should see instructions to enter my confirmation code
And I should have received a text message with a confirmation code

When I enter the confirmation code
And I fill in `Password` with `password`
And I fill in `Password Confirmation` with `password`
And I click "Submit"
Then I should be redirected to "/dashboard"
And I should be logged in
And my old password should no longer work for logging in
And my new password should work after logging out and logging back in
```

### Merchant Dashboard

Try to think of some things that might help store owners maximize their sales. What's a merchant's best selling product? Worst selling? How many views does each item have this month? What percentage of viewers add the item to their cart? How many of those purchase? etc.

### Live Chat Support

Using Web-Sockets (probably ActionCable) create a live chat to help customers that need help or have questions about a product.

### Home Page Suggestions

Use the home page to display previously viewed items or items related to the things they have previously purchased.

### Shipping

Use the UPS, FedEx, or USPS API to integrate different shipping features. Address validation and shipping estimates.

## Base Data

You should have the following data pre-loaded in your marketplace:

* 20 total businesses
* 10 categories
* 50 items per category
* 1000 registered customers, one with the following data:
  * Username: josh@turing.io
  * Password: password
* 10-20 orders per registered customer
* 1 business manager per business with the following data:
  * Username: josh@turing.io
  * Password: password
* 1 business admin per business, one with the following data:
  * Username: ian@turing.io
  * Password: password
* 1 platform administrators
  * Username: cory@turing.io
  * Password: password

It creates a much stronger impression of your site if the data is plausible. We recommend creating a few "template" businesses that have real listings, then replicating those as needed. You could also use the [Faker](https://github.com/stympy/faker) gem.

## Check-ins and Milestones

Each team will have daily stand-ups with their product owner. On the job most technical discussion will take place on Github. You should practice asking technical questions of your instructors on Github in addition to Slack and face-to-face conversations.

### The Client

Each team will be assigned a client who will serve a non-technical role and guide the development of the product. Your client will evaluate your project from the perspective of a product owner and whether their needs were satisfied.

### Day 1

#### What should be done

The scope of the pivot is more fluid than prior projects. You client will want to go over your plan for the project. Wireframes and detailed user stories should be completed today. Don't underestimate the value of a good plan. Groups that communicate and plan will outperform those that just start coding.

Use your client to review your plan.

### Day 2

#### What should be done

* Original state of the application should be deployed.
* Design and styles should be starting to get flushed out.
* Schema should be sketched out.
* Stories should be prioritized.
* Start building the most important pieces.

#### What to expect from instructors

Your client will review the work you've done so far at a high level. Then it's really up to you what to look at, whether it's with your client or technical lead.

You'll also decide what should be done by the next check-in.

### Day 3

#### What should be done

At this point you should be moving along with coding and fixing tests.

## Deployment and Workflow

Each team must...

* deploy early and often.
* disable the ability to push to master.
* setup continuous integration to validate there are no failing tests prior to deployment.
* review pull requests prior to merging.
* deploy to production after merging to master.

Some groups may have a workflow that doesn't merge to master from a PR. You should avoid waiting days to deploy. The most successful groups will likely merge to master and deploy multiple times a day.

## Evaluation

You'll be graded on each of the criteria below with a score of (1) well below
expectations, (2) below expectations, (3) as expected, (4) better than expected.

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

* Project is well tested (Above 90% and the most valuable pieces of the app are covered). If you were paying for someone to build this for you, would you be satisfied with the tests that are written?
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
