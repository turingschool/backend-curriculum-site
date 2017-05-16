---
layout: page
title: Cloney Island
length: 2 weeks
tags:
type: project
---

## Contents

* [Project Description](#description)
    * [Overview](#overview)
    * [Roles & Responsibilities](#roles)
* [Project Requirements](#requirements)
    * [General Technical Requirements](#general)
    * [Specific Technical Requirements](#specific)
* [Evaluation Rubric](#rubric)

## <a name="description"></a> Project Description

### <a name="overview"></a> Overview

In this project, you'll be building a new platform from scratch to handle multiple types of users (guests, registered users & admins). You'll build a new project assigned by the instructors. This is sometimes called "greenfield" development, because you are starting from scratch.

During this project, you will:

* Create a secure web application that supports multitenancy
* Create seed files

Depending on the project you choose and the requirements that develop, you may also:

* Allow users to upload files to your application
* Consume an external API
* Build an internal API
* Use JavaScript to access an API and/or update your page dynamically

**Note:** This project is not intended for you to clone an entire site in two weeks. You will only be taking some functionality of the sites you choose, and cloning ONLY those parts. In some cases, you might even be adding functionality that the real site doesn't have. We use the example sites to provide ideas for features.

### <a name="roles"></a> Roles & Responsibilities

The project will be completed by teams of four to five developers over the span of two weeks.

You will name a team leader that will:

* Work with the client to establish team priorities.
* Make sure business requirements are transformed into [user stories](supporting_docs/user_stories).
* Seek clarification from the client when a user story is not clear.
* Make sure that all the team members are on track and collaborating following an agreed upon [Git workflow](supporting_docs/git).
* Create a new Rails project on GitHub and invite team members and instructors as collaborators.

Like all projects, individual team members are expected to:

* Seek out features and responsibilities that are uncomfortable.
* Support your teammates so that everyone can collaborate and contribute.
* Follow a professional workflow when developing a feature.

## <a name="requirements"></a> Project Requirements

Project requirements will be developed by your instructors acting as clients over the course of three check-ins (described in greater detail [here](supporting_docs/check-ins)). During these check-ins, you will work with your client to identify their business needs, and afterwards you will transform these requirements into user stories. To the degree that there is any ambiguity or misunderstanding of client requests, you will be responsible for using these check-ins to course correct. We also recommend that you work to use these check-ins manage client expectations. For the purpose of this project, assume that your client does not have any programming experience.

High level cards associated with client requested features should be labeled as such so that they are easily identifiable on your project management tool. When you believe you have completed a feature, move it into the correct state. Depending on your client, they may require that they accept that card and verify that it is working on the production site before they accept it (work this out with your product owner). The stories as written and prioritized in your project management tool will be the authoritative project requirements. They may go against and likely go beyond the general requirements outlined below.

As the stories clearly define the client's expectations, your application needs to **exactly** follow the stories as they've been developed with your customer. A 95% implementation is wrong. If you want to deviate from the story as it's written, you need to discuss that with your client and get approval to change the story _before implementing on the production site_.

If in the course of implementing a feature you create smaller cards, assume that you can move those cards to "Done" on your own.

### <a name="general"></a> General Technical Requirements

#### Overview

One of the main learning goals of this project is to give you the opportunity to develop a web application that supports multitenancy. To that end, each user of your application should have their own unique URL pattern: http://example.com/username.

Before your final evaluation, your store should have the following data pre-loaded:

* 1000 total registered users
* 5 - 10 postings per user
* 1 platform administrator with the following user info:
    * Username: admin@admin.com
    * Password: password

It creates a much stronger impression of your site if the data is plausible. You could use the [Faker](https://github.com/stympy/faker) gem to randomly create categorized data.

#### User types

Your app should allow the following user interactions:

#### Guest User

As a guest, I should be able to:

* Browse public content / profiles.
* Log in or create an account.

#### Registered User

As a registered user, I should be able to:

* Post listings or content either publicly or privately.
* Manage my account information.
* Manage my profile / content.
* "Comment" in some capacity (may be in the form of a "review" depending on your app's domain).
* Utilize two-factor authentication using SMS confirmation via [Twilio's REST API](https://www.twilio.com/docs/api/rest) for a user to reset their password. In order to implement this feature, a phone number should be a required field for a user when they sign up.
    * Mild: Use the Twilio gem.
    * Spicy: Don't use the gem and hand roll your own HTTP wrapper around Twilio's REST API without the use of external tools except a Ruby HTTP library.

#### Platform Admin

As a platform admin, I should be able to:

* Take a user offline / online, including all content associated with them but without removing the user or any of their data from the database.
* delete postings/content.

### <a name="specific"></a> Specific Technical Requirements

Your group will be assigned one of the following applications to clone. Each link has additional information on the requirements for that application. Consistent with the overall description of project requirements above, the specific requirements developed in consultation with your client take precedence over those described in the links below.

* [Airbnb](prompts/airbnb)
* [Dropbox](prompts/dropbox)
* [Flickr](prompts/flickr)
* [Kickstarter](prompts/kickstarter)
* [Pinterest](prompts/pinterest)
* [StackOverflow](prompts/so)
* [Thumbtack](prompts/thumbtack)

## Sprint 1 - Individual Evaluation

Each member of your team will commit to a story that demonstrates understanding of core concepts covered at Turing so far while also taking on a technical challenge that is outside of your comfort zone. The story will be determined with your instructor. At the end of the first sprint, each group will meet with their product owner and each member will demo their story.

**Client Expectations**

* Student delivered user story agreed upon with client.
  * 4: Better than expected
  * 3: As expected
  * 2: Below expectations
  * 1: Well below expectations

**Test Quality**

* Story is well-tested (Above 90% and the most valuable pieces of the app are covered). If you were paying for someone to build this for you, would you be satisfied with the tests that are written?
    * 4: Better than expected
    * 3: As expected
    * 2: Below expectations
    * 1: Well below expectations

**Code Quality**

* Project demonstrates well-factored code and a solid grasp of MVC principles.
    * 4: Better than expected
    * 3: As expected
    * 2: Below expectations
    * 1: Well below expectations

**Student Evaluation**

Each group member will evaluate each member of the group anonymously based on the criteria below. Students will receive the average score combined from all group members.

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

## <a name="rubric"></a> Sprint 2 - Final Evaluation Rubric

Each group is required to do a self assessment using the rubric below and bring it to your evaluation.

You'll be graded on each of the criteria below with a score of (1) well below
expectations, (2) below expectations, (3) as expected, (4) better than expected.

### Completion

**Client Expectations**

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

* Project is well-tested (Above 90% and the most valuable pieces of the app are covered). If you were paying for someone to build this for you, would you be satisfied with the tests that are written?
    * 4: Better than expected
    * 3: As expected
    * 2: Below expectations
    * 1: Well below expectations

**Code Quality**

* Project demonstrates well-factored code and a solid grasp of MVC principles.
    * 4: Better than expected
    * 3: As expected
    * 2: Below expectations
    * 1: Well below expectations

**Bonus**

We want to recognize and reward risk-taking and exploration. Sometimes other areas might suffer if the risk doesn't pan out. Earn a bonus point to offset a score above.

* Did the team push themselves by taking risks?
    * 1: Yes
    * 0: No
