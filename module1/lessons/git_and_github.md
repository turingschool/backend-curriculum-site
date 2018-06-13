---
layout: page
title: Git and Github
length: 60
tags: git, github
---

## Learning Goals

After this lesson, students should be able to:

* explain the difference between remote and local repositories
* push, pull, commit, and branch using the git command line interface
* submit and merge Pull Requests using the Github interface

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
  * ex: `git commit -m "adds search feature"``

### Git Workflow

These are the steps you should take to make changes and save them to your repository.

1. `git status` - make sure our working directory is clean, which means there are no changes. If there are changes, we need to figure out what to do with them, either commit them or stash them.
1. Make changes
1. `git status` - we should see the files we changed as unstaged.
1. `git add <name of file we changed>` - stage those changes for commit. We need to do this for each file we changed.
1. `git status` -  we should see the files we changed as staged for commit.
1. `git commit -m "short message about the changes we made"` - commit the changes.

## Github

GitHub is a website for hosting git repositories.

The git repository on your computer is called the **local repository**. It is only accessible through your computer. If you are working with a partner, they cannot access it on their computer. That's where Github comes in. When you push your repository to Github, you are creating a **remote repository**. It is in the cloud and collaborators can access it through the web.

Before GitHub, developers or companies configured and ran their own independent git servers, and things were much more fragmented. Now GitHub has become the de facto community standard for hosting and sharing repositories.

You certainly don't need GitHub to use git, but its popularity and dominance, especially within the open source community, have intertwined the 2 for many users.

As you progress through becoming a more practiced git user, don't forget that these are 2 distinct things -- `git` provides the core technology for tracking and managing source control changes, while `GitHub` provides a shared location for hosting git projects.

### Commands for interacting with Github

* `push <remote name> <branch name>` - push your commits to Github. The remote name is almost always `origin`. The branch name is whatever branch you want to push to (more on branching further down). For instance, if you are working on the `master` branch, which is the default branch, the command would be:
  * `git push origin master`
* `pull <remote name> <branch name>` - update your local repository with the changes made to the remote. This will be important when you are working with someone else, and you want to get the changes they made. Similar to pushing, remote name will almost always be `origin`. Branch name is whatever branch you want to pull from. So if you wanted to get the recent changes to `master`, the command would be:
  * `git pull origin master`
  * **note**: This will pull the changes in to whatever branch you are currently working in
* `remote -v` - this will show you what your remote repository is configured as. This is helpful for debugging.
* `remote add <remote name> <remote url>` - This adds a new remote. If you type `remote -v` and nothing shows up, it means you have no remotes and you will need to use this command to add one. Usually, you only need to do this once when you are setting up a project.
* `remote remove <remote name>` - This removes a remote. You usually only need to do this if you made a mistake and your remote is not set up properly.

### Git workflow with Github

If you are working in a group project, you want to make sure you are up to date with the changes your partners may have made.

1. `git status` - make sure our working directory is clean, which means there are no changes. If there are changes, we need to figure out what to do with them, either commit them or stash them.
1. `git pull origin master` - make sure we have the most current version
1. Make changes
1. `git status` - we should see the files we changed as unstaged.
1. `git add <name of file we changed>` - stage those changes for commit. We need to do this for each file we changed.
1. `git status` -  we should see the files we changed as staged for commit.
1. `git commit -m "short message about the changes we made"` - commit the changes.
1. `git push origin master`

It is important to note that you do not have to push every time you commit. You can make several commits, and `push` will send all the new commits you made at once.

## Branching

If you do `git status` you'll see part of the status is "On branch master". Branches represent a line of development. The master branch is the default branch, and is typically where the code works without known bugs.

Switching to a branch is called a **checkout**. When you checkout a new branch, it can serve as a sandbox for development where you can make changes or experiment with a research spike without affecting the master branch. If whatever you are trying doesn't work, no big deal; your master branch remains in tact.

[This link](http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging) shows some helpful visuals related to git branches.

[More info on branching.](https://www.atlassian.com/git/tutorials/using-branches/git-branch)

### Branching commands

* `branch` - view a list of branches
* `branch <branch name>` - create a new branch
  * ex: `git branch new_feature`
* `checkout <branch name>` - switch to a branch
  * ex: `git checkout master`
* `checkout -b <branch name>` - create and switch to a branch in one command
  * ex: `git checkout -b new_feature`
* `push <remote name> <branch name>` - push to a branch. If the branch doesn't exist in your remote, Github will create a new one for you.
  * ex: `git push origin new_feature`
* `pull <remote name> <branch name>` - pull from a branch. The vast majority of the time, you want to be pushing and pulling from the same branch you are working on. So if you and your partner are working on the `new_feature` branch, you should first do `git checkout new_feature` to make sure you are on the `new_feature` branch, and then do `git pull origin new_feature` to update your local with any changes to the remote.

### Pull Requests

If what you did in a branch works and you want to add it to the master branch, you will `merge` that branch into the master branch. You can `merge` from the command line, but it is much easier and better practice to do it using a Github **Pull Request**, often referred to as a "PR".

Pull Requests are a Github feature that allows us to merge code from one branch into another. The name "Pull Request" can be confusing because you are actually trying to merge code rather than pull it. Some other online systems such as Gitlab call them "Merge Requests" for this reason.

Not only do Pull Requests allow you to merge branches, they allow other collaborators to look at the code you added, make comments, and review your changes BEFORE the code gets merged. They are a very powerful collaboration tool, and used extensively in the industry.

### Git Workflow with Branching and Pull Requests

This is the final version of our workflow, and is what you should be doing on every project, partner or solo.

  1. `git status` - make sure our working directory is clean. If there are changes, we need to figure out what to do with them, either commit them or stash them.
  1. `git branch <feature name>` - make a new branch based on a feature you want to add. Alternatively, you can use `git checkout -b <feature name>` to create and checkout the branch in one command.
  1. `git checkout <feature name>` - Checkout the branch
  1. `git pull origin <feature name>` - make sure you are up to date with the remote.
  1. Make changes
  1. `git status` - we should see the files we changed as unstaged.
  1. `git add <name of file we changed>` - stage those changes for commit. We need to do this for each file we changed.
  1. `git status` -  we should see the files we changed as staged for commit.
  1. `git commit -m "short message about the changes we made"` - commit the changes.
  1. `git push origin <feature name>` - Push your branch to Github.
  1. Continue committing to the branch until the feature is complete
  1. Put in a Pull Request (PR) to merge your branch into master. If you are working in a group, your teammates should review your PR and merge it if it is acceptable. If you are working alone, it is okay to merge your own PR.
