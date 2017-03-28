---
layout: page
title: Professional Code Environments
length: 105
tags: workflow, professional skills
---

## Learning & Completion Goals

*   Students build applications that execute in development, test, CI and production environments *(functional)*

### Learning Goals Breakdown

*   Student can configure each of their environments
*   Student can identify the difference between configuration and logic in their code
*   Student can explain the nature and purpose of a staging environment
*   Student can explain the main components of a staging/production environment
*   Student is aware of tools like Docker and Vagrant for isolating application development

## A brief history of environments

### Stage 0: One environment

![Fuck it, we'll do it live](https://media.giphy.com/media/A34x7CEKUkCyc/giphy.gif)

In the beginning, we developed in production (no really, I've done this, and it still happens, but mostly on PHP teams)

Some problems:

*   Getting the code from your machine into the production server every time you want feedback from your code
*   You're breaking things a lot while you're working, and so your users' work can be interrupted

### Stage 1: Two environments

So we created development environments. Development environments are meant to:

*   shorten the feedback loop
*   give us a low risk place to write code

A development environment is something you can access easily from wherever you do your work. So it may live on your laptop, but there are remote development environments out there.

Some problems with our two environment solution:

*   Just because it worked on my machine, doesn't mean it will work on others
    *   You have to ensure that your software versions are the same between environments
    *   Development environments are often not even running the same OS
    *   Although rare, hardware can sometimes change how software behaves

### Stage 2: Three environments [WIP]

So, we created another environment that we call *Staging*. This environment is meant to execute our code in an environment as close as possible to production, without actually disrupting production.

Your Staging environment will basically be a copy of production. Whatever setup you do in production, you'll do the same in staging. With a few exceptions we'll get into.

### Stage 3: Four environments [WIP]

There is yet another environment that is common on modern development teams: *Continuous Integration*. It exists to run our tests, report back with success or failure, and in some cases, take additional action.

We all know to run our tests before we push, or after we merge, or before we deploy, but a continuous integration environment ensures that tests are run. We can't forget. You can even add CI tools to your production deployment process, such that any commit that doesn't pass its tests will be rejected.

## Modern Environments

So let's synthesize this into some features of our modern environments

### Development

A dev environment...

*   should be software similar to staging and production
*   is likely *not* hardware similar
*   needs to be reproducible across dev team machines
*   usually is juggling multiple projects
*   is typically just setup once per project, but by many people

### Staging

A staging environment...

*   should be hardware and software identical to production
*   uses production-like data
*   has to consider privacy
*   is typically dedicated to one project
*   ideally setup/teardown is very easy
*   is usually accessible by most or all developers

### Production

A production environment...

*   defines the standard/expected hardware and software
*   has private data
*   is typically dedicated to one project
*   is commonly scaled to `n` instances
*   ideally setup/teardown is automated, or at least very well documented
*   typically has access restricted to only senior members

### Continuous Integration

Continuous integration is another environment to consider. CI can span environments in some situations (always run your tests before you push, run your tests in staging, in a separate tool, etc)

A continuous integration environment...

*   needs the same software as your production environment
*   usually connected to your version control
*   often connected to production for deployment
*   should be accessible by the whole development team
*   needs whatever data is needed by the test suite


### Check for understanding

*   What is a staging server?
*   What advantages does a staging server give us?
*   What is continuous integration?
*   How does continuous integration make our lives easier?
*   Bonus: You've lived this long without either of these environments. How would you get the same advantages with just your development and production environments.

## Configuration

### Stuff that's the same

We want to ensure across our that we have:

*   Consistent versions of ruby/node
*   The same packages/gems installed

### Stuff that's different

There are also things that we intentionally want different between our environments. The most common example is external data sources and services:

*   Databases
*   APIs
*   Email servers
*   Message queues

To address these differences, we usually use **Environment Variables**. These are *variables* that differ between *environments*. They're used across languages and platforms to set configuration. They allow the same logic and code to interact with different sources.

### Synthesis/reflection

*   Why might we need differing configurations?
*   Where do we configure things in Rails?
*   Where have we configured things in Node?

## Some next level things to be aware of

Before we dive into some practice, here's a couple more concepts you're liable to run into on the job or in job descriptions, and how they relate:

***Continuous Deployment***

The idea of deploying to production as often as you push code. Usually in tandem with CI, so you know your tests all pass before you deploy. There are tools out there to help with this.

***Virtual Machines***

A tool for ensuring all of your environments are effectively the same. You actually run a small computer in each of your environments, and share the configuration for that (virtual) computer across environments. Sometimes *containers*. Docker uses Containers. Containers are leaner than VMs, but solve the same problem.

***The 12 factor app***

If you want to dive deep into solutions to environment problems, dig into the manifesto at <https://12factor.net>. The `rails-12factor` gem was started to make Rails more consistent with this document.


## Some practice

### We do

Let's try to implement some of these things in an old project. Cloney island is perfect. It has just about every trick you know so far. Let's try to rework it

*    Identify something that we can make into configuration. Something we want to differ between environments.
*    Set up CI with Travis CI
*    Set up CD from Github to Heroku (if we have time)

### You do

You've got the information and the tools. Try adding new environments to an old project on your own, or implement it on your current project.
