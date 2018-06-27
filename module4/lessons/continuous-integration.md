---
title: Continuous Integration
layout: page
---

## Learning Goals

- Students can explain the benefits of using continuous integration
- Students understand the steps used in the practice of CI
- Students can utilize a CI service on a Github repo to automate testing code changes

## Intro (10 min)

Read [What is Continuous Integration?](https://aws.amazon.com/devops/continuous-integration/)

Discuss with the person next to you:
- What is CI?
- Why would we want to use it?

## Continuous Integration

### What is CI?

Continuous Integration is a development practice of routinely merging in code changes into a central repository and testing these changes as early and often as possible. The CI process entails both a automation aspect such as a CI platform or build service and a cultural aspects of integrating more frequently.

### What are the benefits?

- Identify conflicts early
- Find and address bugs quicker
- Avoid Integration Hell
- Improve Software Quality

### What are the steps?

1. Write tests for all critical parts of the code base
2. Use a CI service to run those tests automatically with all repo changes
3. Make sure team integrates as early as possible
4. Fix broken build ASAP
5. Write tests for all new features

## Utilizing Travis CI

### Step 1. Create Rails Repo

1. Create new Application
```
rails new tweet-saver
```

2. Scaffold the app
```
rails generate scaffold Tweet message:string published:boolean
```

3. Run app to make sure everything is working
```
rails server
```

4. Run tests to make sure everything is working
```
rake
```

### Step 2. Push App to Github

1. Initialize a new git repo
2. Add your new changes and link up a remote from your new Github repo
3. Push up changes like you always do

### Step 3. Sign up for Travis CI

1. Go to [Travis CI Github App](https://github.com/marketplace/travis-ci)
2. Add the `tweet-saver` repo
3. Confirm you can see you repo on [Travis CI](https://travis-ci.com)
4. Change settings to NOT 'Build Pushed Branches'

### Step 4. Add Travis config to trigger initial build
1. Create `.travis.yml` file in your `tweet-saver` project
```
language: ruby
rvm:
 - 2.4.1
```
> Hint: Be sure to use your ruby version

2. Add `.travis.yml` file to git, commit, & push
3. Go to your dashboard in travis - confirm that the build PASSED
4. Go to your repo in github and notice the dot next to the commit

### Step 5. Let's break the build
1. Create a new branch `break-the-build`
2. BREAK IT - sabotage test
3. Commit changes and push to Github
4. Create a PR and watch the magic happen

What do you see on Github?
What do you see on Travis CI?

#### Don't Break the Build - Example Issues
- Forgetting a new asset or file
- Not running tests locally
- Inconsistent dependency versions

## Continuous Integration vs Continuous Delivery

Continuous delivery is an extension of CI that deploys code changes automatically to a specific environment (i.e testing, staging, production) after the build stage.

It is also known as the process of releasing code frequently to the end user (daily, weekly, etc) based typically on business requirements.

Where have you already seen this? *cough, cough* Github pages?

Many CI platforms have these features built in and can automatically deploy your application after your code is merged.
[Auto Deploy With Travis CI and Heroku](https://docs.travis-ci.com/user/deployment/heroku/)
