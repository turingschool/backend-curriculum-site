---
layout: page
title: Professional Code Environments
length: 90
tags: workflow, professional skills
---

## Learning & Completion Goals

### Local Development Environments

*   Student can explain the roles of the tools in a MacOS development environment including Homebrew, XCode, GCC, RVM, Ruby, V8, and NPM
*   Student is aware of tools like Docker and Vagrant for isolating application development

### Staging & Production

*   Student can explain the nature and purpose of a staging environment
*   Student can explain the main components of a staging/production environment
*   Student has setup a local virtualized development environment

## Session Plan

### Part 1: Understanding Environments (30 Minutes)

Let's start by defining three key environments: Development, Staging, and Production.

#### Development

You've been using a dev environment for some time. Let's review the key components and their purpose:

*   XCode
*   Homebrew
*   GCC
*   RVM
*   Ruby
*   V8
*   NPM

A dev environment:

*   Should be software similar to staging and production
*   Is likely *not* hardware similar
*   Needs to be reproducible across dev team machines
*   May need to juggle multiple projects
*   Typically just setup once per project

#### Staging

A staging environment:

*   Should be hardware and software identical to production
*   Uses production-like data
*   Has to consider privacy
*   Is typically dedicated to one project
*   Ideally setup/teardown is very easy

#### Production

*   Defines the standard/expected hardware and software
*   Has private data
*   Is typically dedicated to one project
*   Commonly scaled to `n` instances
*   Ideally setup/teardown is automated

### Part 2: Experimenting with Virtualization

Now that we have level-set on environments, how does this affect our workflow?

For now, your *production* environment will probably still be Heroku. As you start using a *staging* environment, you'll want to setup a *separate* Heroku instance. If/When you start working with VPS systems, you'll want to have a VPS for production and a separate one for staging.

But, for now, we can do some experiments in that direction via Virtualization. Let's [dive into virtualization with Vagrant](introduction_to_vagrant).
