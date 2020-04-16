---
layout: page
title: CI and Staging Environments
length: 105
tags: workflow, professional skills
---

## Learning & Completion Goals

*   Students build applications that execute in development, staging, CI and production environments *(functional)*

### Learning Goals Breakdown

*   Student can configure each of their environments
*   Student can identify the difference between configuration and logic in their code
*   Student can explain the nature and purpose of a staging environment
*   Student can explain the main components of a staging/production environment

## A Brief History of Environments

### Stage 0: One Environment

Way back when, development would happen directly on production. Imagine your app's been hosted on Heroku, you've got users on it daily, yet you push straight to Heroku every time you add a new feature / fix a bug.

Some problems:

*   Getting the code from your machine onto the production server every time you want feedback from your code
*   You're breaking things a lot while you're working, chancing your users' work being interrupted on the fly

### Stage 1: Two Environments

To solve the last problem, we created development environments. Development environments are meant to:

*   shorten the feedback loop
*   give us a low risk place to write and push code

A development environment is something you can access easily from wherever you do your work. So it may live on your laptop, but there are remote development environments out there.

Some problems with our two environment solution:

*   Just because it worked on my machine, doesn't mean it will work on others'
*   You have to ensure that your software versions are the same between environments
*   Development environments are often not even running the same OS
*   Although rare, hardware can sometimes change how software behaves

### Stage 2: Three Environments

So, we created another environment that we call **staging**. This environment is meant to execute our code in an environment as close as possible to production, without actually disrupting production.

Your staging environment is essentially a copy of production. Whatever setup you do in production, you'll do the same in staging, with a few exceptions we'll get into.

Staging provides a safe environment to check your work, or share your work with others. If you create bad data, or delete data, or introduce bugs, your production users are not affected.

If you want to learn more about staging with Heroku - [check out this article.](https://devcenter.heroku.com/articles/multiple-environments)

### Stage 3: Three Environments + Continuous Integration

There is yet another environment that is common on modern development teams: *Continuous Integration* (CI). It exists to run our tests, report back with success or failure, and in some cases, take additional action.

We all know to run our tests before we push, or after we merge, or before we deploy, but a continuously integrated environment ensures that tests are run. It doesn't allow you to forget. You can even add CI tools to your production deployment process, such that any commit that doesn't pass its tests will be rejected.

## Modern Environments

Let's synthesize what this looks like for a modern dev environment.

### Development

A development environment...

*   should be software-similar to staging and production
*   is likely not hardware-similar
*   needs to be reproducible across dev team machines
*   is typically just setup once per project, but by many people

### Staging

A staging environment...

*   should be software-identical to production
*   uses production-like data (may be a direct copy of the current production DB)
*   has to consider privacy
    * sometimes staging sites, since live, are password-protected
*   ideally setup/teardown is very easy
*   is usually accessible by most or all developers
*   is usually accessible by non-technical members of your team

### Production

A production environment...

*   defines the standard/expected hardware and software
*   has private data
*   is commonly scaled to `n` instances
*   ideally setup/teardown is automated, or at least very well-documented
*   typically has access restricted to only senior members

### Continuous Integration

Continuous integration is an environment integration / practice to consider. CI can span environments in some situations (always run your tests before you push, run your tests in staging, in a separate tool, etc)

A continuously integrated environment...

*   needs the same software as your production environment
*   usually connected to your version control
*   often connected to production for deployment
*   should be accessible by the whole development team
*   uses whatever data is used by the test suite

### Check for understanding

*   What is a staging environment?
*   What advantages does a staging environment give us?
*   What is continuous integration?
*   How does continuous integration make our lives easier?
*   Bonus: You've lived this long without either staging or CI. How could you think to get the same advantages from just your development and production environments?

## Configuration

### What's the Same Across Environments?

We want to ensure that across environments we have:

*   Consistent versions of Ruby/Node
*   The same packages/gems installed

### What's Different Across Environments?

There are also things that we intentionally want different between our environments. The most common example is external data sources and services:

*   Databases
*   APIs
*   Email servers
*   Message queues

To address these differences, we usually use **Environment Variables**. These are *variable values* that differ between *environments*. They're used across languages and platforms to set configuration. They allow the same logic and code to interact with different sources.

### Synthesis / CFUs

*   Why might we need differing configurations?
*   Where do we configure environment settings in Rails?
*   Where do we configure environment settings in Express?

## Implementing CI

On your own, try setting up [Travis CI](https://travis-ci.org/) for one of your existing projects.

Be sure to read their [docs here](https://docs.travis-ci.com/user/getting-started/).
