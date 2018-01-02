---
layout: page
title: Little Shop of Orders
---

In this project you'll use Ruby on Rails to build an online commerce platform to facilitate online ordering.

## Introduction

### Learning Goals

* Use TDD to drive all layers of Rails development including unit and integration tests
* Design a system of models which use one-to-one, one-to-many, and many-to-many relationships
* Practice mixing HTML, CSS, and templates to create an inviting and usable User Interface
* Differentiate responsibilities between components of the Rails stack
* Write an articulate README documenting features and functionalities of application
* Deploy an application to Heroku
* Build a logical user-flow that moves across multiple controllers and models
* Practice an agile workflow and improve communication skills working within a team

### Restrictions

Project implementation may **not** use:

* Any external library for authentication except `bcrypt`

### Getting Started

1. Fork and fill out [expectations gist](https://gist.github.com/Carmer/85b9e0569af607d14f6e14b696b5e131) with your team.
2. One team member creates a repository with the name of your online ordering platform
3. Add the other team members and your instructor(s) as collaborators
4. Add your project to [waffle.io](http://waffle.io) to write and track user stories
5. Create a Pull Request template
6. Add the [user stories](little_user_stories) to waffle.

## Base Expectations

You will build an online ordering platform. Customers should be able to place orders and view placed order details. The site owner should be able to manage products and categories in addition to processing and completing orders.

## Process

Each team will have an assigned project manager that will be the primary point of contact between the product owner (instructor) and the rest of the team.

All base stories will be provided by the product owner. You will be asked to write your own stories for extensions and they should follow the same format as the ones that are provided to you.

You should not write code or migrations until a story calls for it.

Teams can self-pace but will have a number of stories required to be completed at each check-in. Teams will meet with the product owner regularly and demo completed stories. Project scope and requirements can change at the discretion of the product owner so following an agile approach is really important.

It is expected that teams will have meaningful discussions and code reviews using comments on Github. Your instructors will be looking for this. Commits should also have meaningful messages. Be careful about what type of commits are being made, i.e. "Cleanup Hound violations". If you want to learn more about squashing and rebasing commits, see [here](http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html).

It is also expected that teams will use a Pull Request Template, as described [here](https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/).

The master branch of your project should always remain in a state where it can be demoed and deployed... yes, even days that you don't have any _planned_ meetings.

Everyone will provide feedback for group members at the end of the project.

## Extensions

The extensions listed below are a non-exhaustive list of extension ideas.

* product reviews
* product recommendations based on past orders
* product and category search
* credit card processing with Stripe or Paypal
* phone or text message order confirmation
* Implementing Authorization with an outside provider (OAuth)
* admin dashboard with analytics about item performance

## Evaluation Process

For the evaluation we'll work through the expectations above and look at the
following criteria:

### 1. Feature Completeness

* Exceeds Expectations: All features are correctly implemented along with two extensions and project is depoyed
* Meets Expectations: All features defined in the assignment are correctly implemented and project is deployed
* Below Expectations: There are one or two features missing or incorrectly implemented and/or project is not fully deployed

### 2. Views

* Exceeds Expectations: Views show logical refactoring into layout(s), partials and helpers, with no logic present
* Meets Expectations: Views make use of layout(s), partials and helpers, but some logic leaks through
* Below Expectations: Views don't make use of partials or show weak understanding of `render`

### 3. Controllers

* Exceeds Expectations: Controllers show significant effort to push logic down the stack
* Meets Expectations: Controllers are generally well organized with three or fewer particularly ugly parts
* Below Expectations: There are four to seven ugly controller methods that should have been refactored

### 4. Models

* Exceeds Expectations: Models show excellent organization, refactoring, and appropriate use of Rails features
* Meets Expectations: Models show an effort to push logic down the stack, but need more internal refactoring
* Below Expectations: Models are somewhat messy and/or make poor use of Rails features

### 5. Testing

* Exceeds Expectations: Project has a running test suite that exercises the application at multiple levels
* Meets Expectations: Project has a running test suite that tests at multiple levels but fails to cover some features
* Below Expectations: Project has sporadic use of tests at multiple levels

### 6. Usability

* Exceeds Expectations: Project is highly usable and ready to deploy to customers
* Meets Expectations: Project is highly usable, but needs more polish before it'd be customer-ready
* Below Expectations: Project needs more attention to the User Experience, but works

### 7. Workflow

* Exceeds Expectations: Excellent use of branches, pull requests, and a project management tool.
* Meets Expectations: Good use of branches, pull requests, and a project-management tool.
* Below Expectations: Sporadic use of branches, pull requests, and/or project-management tool.
