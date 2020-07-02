---
layout: page
title: Git and Github
length: 60
tags: git, github
---

## Learning Goals

After this lesson, students should be able to:

* Explain the difference between remote and local repositories
* Create a Git repository locally
* Create a repository on GitHub
* Link a local repository to a remote repository
* Use a branching workflow with Git and GitHub

## Slides

Available [here](../slides/git_and_github)

## Warmup

* What do you already know about Git/GitHub?
* Why do we use Git/GitHub

## Overview

* Git is a version control system that we use in programming.
* GitHub is a website that allows us to share Git repositories.
* In order to keep our code safe we use a branching workflow that allows us to make changes to multiple files before fully commiting to those changes.

## Git

### What is Git?

Git is a **Version Control System** (VCS). It allows you to save work on your project, and reference previous states of a project if needed. Normally when we save something on our computer, the newer version *overwrites* the older version. This is problematic if we need to look back at an earlier version. Git solves this problem by providing you multiple save points. You can get the current version, and ANY previous version. Git's philosophy: never lose anything.

### Commits

Saving your work in git is known as **committing**. Even though you may change a file and hit save, you don't actually save it to your git repository until you use the `commit` command. Changes can be in 3 different states:

  1. __Unstaged__: we have made changes but not told git that we would like to commit them
  1. __Staged__: we have made changes and told git that we are getting ready to commit them
  1. __Committed__: we have committed our changes to the repository's log of commits. Our work is saved.

### Important Git Commands

* `init` - create a git repository in the current directory.
* `status` - show what changes have been made. This will show changes that are staged and unstaged.
* `add <file name>` - stage a change for commit.
    * ex: `git add credit_check.rb`
* `commit -m "<commit message>"` - commit a change. Each commit requires a commit message (must be in quotes).
    * ex: `git commit -m "adds search feature"`

### Git Workflow

#### Creating a Git Repository

1. Use `mkdir` to create a new directory if you have not already.
1. `cd` into that directory.
1. Run `git init` to make that directory a Git repository.
1. The default branch created with git is named `master`. Rename this to `main` by running:
`git symbolic-ref HEAD refs/heads/main`

#### Committing Changes

These are the steps you should take to make changes and save them to your repository.

1. `git status` - make sure our working directory is clean, which means there are no changes. If there are changes, we need to figure out what to do with them, either commit them or stash them.
1. Make changes - e.g. create or update files
1. `git status` - we should see the files we changed as unstaged.
1. `git add <name of file we changed>` - stage those changes for commit. We need to do this for each file we changed.
1. `git status` -  we should see the files we changed as staged for commit.
1. `git commit -m "short message about the changes we made"` - commit the changes.

### Practice!

Using the commands above:

* Create a new directory called `git_practice`.
* Make your `git_practice` directory a Git repository.
* Create a file inside of that directory called `README.md` and add some text to that file.
* Commit your changes
* Make some additional changes
* Commit those changes

## Github

GitHub is a website for hosting git repositories.

The git repository on your computer is called the **local repository**. It is only accessible through your computer. If you are working with a partner, they cannot access it on their computer. That's where Github comes in. When you push your repository to Github, you are creating a **remote repository**. It is in the cloud and collaborators can access it through the web.

Before GitHub, developers or companies configured and ran their own independent git servers, and things were much more fragmented. Now GitHub has become the de facto community standard for hosting and sharing repositories.

You certainly don't need GitHub to use git, but its popularity and dominance, especially within the open source community, have intertwined the 2 for many users.

As you progress through becoming a more practiced git user, don't forget that these are 2 distinct things -- `git` provides the core technology for tracking and managing source control changes, while `GitHub` provides a shared location for hosting git projects.

### Creating a New Repository on GitHub

In order to create a new repository on GitHub we need to visit the site and click on the green `New` button next to the Repositories heading on our dashboard.

Name the new repository the same as what you have named the directory that you're working in. The other default values should be fine for our purposes.

### Commands for interacting with GitHub

Once you've created a new repository on GitHub, you need to link that repository to your local repository. We need to add a remote.

* `remote -v` - this will show you what your remote repository is configured as. This is helpful for debugging.
* `remote add <remote name> <remote url>` - This adds a new remote. If you type `remote -v` and nothing shows up, it means you have no remotes and you will need to use this command to add one. Usually, you only need to do this once when you are setting up a project.
* `push <remote name> <branch name>` - Update your remote repository to match your local repository. The remote name is almost always `origin`. The branch name is whatever branch you want to push to (more on branching further down). For instance, if you are working on the `main` branch, which is the default branch, the command would be:
    * `git push origin main`
* `pull <remote name> <branch name>` - update your local repository with the changes made to the remote. This will be important when you are working with someone else, and you want to get the changes they made. Similar to pushing, remote name will almost always be `origin`. Branch name is whatever branch you want to pull from. So if you wanted to get the recent changes to `main`, the command would be:
    * `git pull origin main`
    * **note**: This will pull the changes in to whatever branch you are currently working in

### Git workflow with Github

#### To set up the link to our repository

1. `pwd` - make sure we're in the right directory
1. `git status` - double check that we have already initialized our local Git repository
1. Create the repo on GitHub
1. Copy the SSH address from GitHub
1. `git remote -v`: this will tell us if we already have a remote repository for this local repository.
1. `git remote add origin <YOUR_SSH_ADDRESS HERE>`
1. `git log` make sure we have at least one commit
1. `git push origin main`

#### To push to your remote repository

1. Make changes
1. `git status` - we should see the files we changed as unstaged.
1. `git add <name of file we changed>` - stage those changes for commit. We need to do this for each file we changed.
1. `git status` -  we should see the files we changed as staged for commit.
1. `git commit -m "short message about the changes we made"` - commit the changes.
1. `git push origin main`

It is important to note that you do not have to push every time you commit. You can make several commits, and `push` will send all the new commits you made at once.

### Practice

* Create a new repository called `git_practice`
* Add the remote to your local `git_practice` repository
* Push your existing commits to the GitHub repository
* Make additional changes to your README
* Commit them
* Push your changes to GitHub

## Branching

If you do `git status` you'll see part of the status is "On branch main". Branches represent a line of development. The main branch is the default branch, and is typically where the code works without known bugs.

Switching to a branch is called a **checkout**. When you checkout a new branch, it can serve as a sandbox for development where you can make changes or experiment with a research spike without affecting the main branch. If whatever you are trying doesn't work, no big deal; your main branch remains intact.

[This link](http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging) shows some helpful visuals related to git branches.

[More info on branching.](https://www.atlassian.com/git/tutorials/using-branches/git-branch)

### Branching commands

* `branch` - view a list of branches
* `branch <branch name>` - create a new branch
    * ex: `git branch new_feature`
* `checkout <branch name>` - switch to a branch
    * ex: `git checkout main`
* `checkout -b <branch name>` - create and switch to a branch in one command
    * ex: `git checkout -b new_feature`
* `push <remote name> <branch name>` - push to a branch. If the branch doesn't exist in your remote, Github will create a new one for you.
    * ex: `git push origin new_feature`
* `pull <remote name> <branch name>` - pull from a branch. Generally you want to be pushing to feature branches (branches where you're working on code) and pulling from main.

### Pull Requests

If what you did in a branch works and you want to add it to the main branch, you will `merge` that branch into the main branch.

Pull Requests are a Github feature that allows us to merge code from one branch into another. The name "Pull Request" can be confusing because you are actually trying to merge code rather than pull it. Some other online systems such as Gitlab call them "Merge Requests" for this reason.

Not only do Pull Requests allow you to merge branches, they allow other collaborators to look at the code you added, make comments, and review your changes BEFORE the code gets merged. They are a very powerful collaboration tool, and used extensively in the industry.

### Git Workflow with Branching and Pull Requests

This is the final version of our workflow, and is what you should be doing on every project, partner or solo.

1. `git status` - make sure our working directory is clean. If there are changes, we need to figure out what to do with them, either commit them or stash them.
1. `git pull origin main` - Make sure you are up to date with the latest version of main.
1. `git branch <feature name>` - make a new branch based on a feature you want to add. Alternatively, you can use `git checkout -b <feature name>` to create and checkout the branch in one command.
1. `git checkout <feature name>` - Checkout the branch
1. Make changes
1. `git status` - we should see the files we changed as unstaged.
1. `git add <name of file we changed>` - stage those changes for commit. We need to do this for each file we changed.
1. `git status` -  we should see the files we changed as staged for commit.
1. `git commit -m "short message about the changes we made"` - commit the changes.
1. `git push origin <feature name>` - Push your branch to Github.
1. Repeat steps 4 - 10 until the feature is complete
1. Put in a Pull Request (PR) to merge your branch into main.
1. Visit GitHub and merge your pull request into main.
1. `git checkout main` - Switch back to the main branch.
1. `git pull origin main` - Make sure that you have the most recent changes that you made on your local main branch.

### Practice

* Check out a new branch
* Make some additional changes to your README
* Commit those changes
* Push your change to the branch on GitHub
* Visit GitHub
* Create a pull request
* Merge your pull request
* Check out your main branch locally
* Pull your changes into your main branch

### Change Default Branch Name of Existing Repository

* Locally:
  * git branch -m master main
  * git push -u origin main

* Github
  * Head to the repository on github.com
  * Click on the `Settings` Tab
  * Click on `Branches` on the left panel
  * Change the default branch to `main` and click `update`

You can now safely delete both the local master and remote master branches.
