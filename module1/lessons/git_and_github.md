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
* Write meaningful commit messages
* Use a branching workflow with Git and GitHub

## Warmup

* What do you already know about Git/GitHub?
* Why do we use Git/GitHub?


## Overview

* Git is a version control system that we use in programming.
* GitHub is a website that allows us to share Git repositories. 
        * Repositories are a container for our folders and files that make up a project. 
* In order to keep our code safe, we use a branching workflow that allows us to make changes to multiple files before fully commiting to those changes.
* Commit messages help us create a readable history of changes.

## Git

### What is Git?

Git is a **Version Control System** (VCS). It allows you to save work on your project, and reference previous states of a project if needed. Normally when we save something on our computer, the newer version *overwrites* the older version. This is problematic if we need to look back at an earlier version. Git solves this problem by providing you multiple save points. You can get the current version, and ANY previous version. Git's philosophy: never lose anything.

### Commits

Saving your work in git is known as **committing**. Even though you may change a file and hit save, you don't actually save it to your git repository until you use the `commit` command. 

<section class="note">

Changes can be in 3 different states:
    <ol>
       <li><b>Unstaged</b>: we have made changes but not told git that we would like to commit them </li>
        <li><b>Staged</b>: we have made changes and told git that we are getting ready to commit them</li>
        <li> <b>Committed</b>: we have committed our changes to the repository's log of commits. Our work is saved.</li>
    </ol>
</section>

### Important Git Commands

* `init` - create a git repository in the current directory.
* `status` - show what changes have been made. This will show changes that are staged and unstaged.
* `add <file name>` - stage a change for commit.
    * ex: `git add credit_check.rb`
* `commit -m "<commit message>"` - commit a change. Each commit requires a commit message (must be in quotes).
    * ex: `git commit -m "feat: add search"`

### Writing Good Commit Messages

Commit messages should be a short description of what is being added, changed, or removed in our code. Writing clear and consistant messages allows us to create a more readable history for ourselves and others. Commits should be specific and small pieces of functionality so that our messages can clearly reflect those changes in a brief message (approximately 50 characters).

<section class="call-to-action">

How to Write a Good Commit Message

<p>Begin the commit message with the <b>type</b> of the commit followed by a <code>:</code> and brief description. </p>

Types of commits include:
    <ul>
        <li> <b>fix</b> - use if committed code is fixing a bug(broken code).</li>
        <li> <b>feat</b> - stands for feature. <i>This will likely be your most common type that you use.</i> It should be used for any new functionality that is committed.</li>
        <li> <b>test</b> - use if committed code is adding test functionality.</li>
        <li> <b>refactor</b> - use if updating and/or removing existing code.</li>
        <li> <b>docs</b> - use if updating your readme.</li>
    </ul>

Examples of good commit messages:
    <ul>
        <li> <code>fix: broken calculation for percent high ranking cards</code></li>
        <li> <code>feat: add shuffle to deck</code></li>
        <li> <code>test: add test for shuffle</code></li>
    </ul>
</section>

### Git Workflow

#### Creating a Git Repository

1. Use `mkdir` to create a new directory.
1. `cd` into that directory.
1. Run `git init` to make that directory a Git repository.


#### Committing Changes

These are the steps you should take to make changes and save them to your repository.

<section class="note">
    <ol>
        <li> <code>git status</code> - make sure our working directory is clean, which means there are no changes. If there are changes, we need to figure out what to do with them, either commit them or stash them.</li>
        <li> Make changes - e.g. create or update files</li>
        <li> <code>git status</code> - we should see the files we changed as unstaged.</li>
        <li> <code>git add <i>name of file we changed</i></code> - stage those changes for commit. We need to do this for each file we changed.</li>
        <li> <code>git status</code> -  we should see the files we changed as staged for commit.</li>
        <li> <code>git commit -m "feat: add new method"</code> - commit the changes.</li>
    </ol>
</section>


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

<section class="note">
    <ul>
        <li> <code>remote -v</code> - this will show you what your remote repository is configured as. This is helpful for debugging.</li>
        <li> <code>remote add <i>remote_name</i> <i>remote url</i></code> - This adds a new remote. If you type <code>remote -v</code> and nothing shows up, it means you have no remotes and you will need to use this command to add one. Usually, you only need to do this once when you are setting up a project.</li>
        <li> <code>push <i>remote_name</i> <i>branch_name</i></code> - Update your remote repository to match your local repository. The remote name is almost always <code>origin</code>. The branch name is whatever branch you want to push to (more on branching further down). For instance, if you are working on the <code>main</code> branch, which is the default branch, the command would be:</li>
        <ul>
            <li> <code>git push origin main</code></li>
        </ul>
        <li> <code>pull <i>remote_name</i> <i>branch_name</i></code> - update your local repository with the changes made to the remote. This will be important when you are working with someone else, and you want to get the changes they made. Similar to pushing, remote name will almost always be <code>origin</code>. Branch name is whatever branch you want to pull from. So if you wanted to get the recent changes to <code>main</code>, the command would be:</li>
        <ul>
            <li> <code>git pull origin main</code> <b>note</b>: This will pull the changes in to whatever branch you are currently working in </li>
        </ul>
    </ul>
</section>

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

<section class="call-to-action">
    
Branching commands
    <ul>
        <li><code>branch</code> - view a list of branches</li>
        <li><code>branch branch_name</code> - create a new branch</li>
        <ul>
            <li>ex: <code>git branch new_feature</code></li>
        </ul>
        <li><code>checkout branch_name</code> - switch to a branch</li>
        <ul>
            <li>ex: <code>git checkout main</code></li>
        </ul>
        <li><code>checkout -b branch_name></code> - create and switch to a branch in one command</li>
        <ul>
            <li>ex: <code>git checkout -b new_feature</code></li>
        </ul>
        <li><code>push remote_name branch_name</code> - push to a branch. If the branch doesn't exist in your remote, Github will create a new one for you.</li>
        <ul>
            <li>ex: <code>git push origin new_feature</code></li>
        </ul>
        <li><code>pull remote_name branch_name</code> - pull from a branch. Generally you want to be pushing to feature branches (branches where you're working on code) and pulling from main.</li>
    </ul>
</section>

### Pull Requests

If what you did in a branch works and you want to add it to the main branch, you will `merge` that branch into the main branch.

Pull Requests are a Github feature that allows us to merge code from one branch into another. The name "Pull Request" can be confusing because you are actually trying to merge code rather than pull it. Some other online systems such as Gitlab call them "Merge Requests" for this reason.

Not only do Pull Requests allow you to merge branches, they allow other collaborators to look at the code you added, make comments, and review your changes BEFORE the code gets merged. They are a very powerful collaboration tool, and used extensively in the industry.

### Git Workflow with Branching and Pull Requests

This is the final version of our workflow, and is what you should be doing on every project, partner or solo.

<section class="call-to-action">
    <ol>
        <li><code>git status</code> - make sure our working directory is clean. If there are changes, we need to figure out what to do with them, either commit them or stash them.</li>
        <li><code>git pull origin main</code> - Make sure you are up to date with the latest version of main.</li>
        <li><code>git branch feature_name</code> - make a new branch based on a feature you want to add. Alternatively, you can use <code>git checkout -b feature_name</code> to create and checkout the branch in one command.</li>
        <li><code>git checkout feature_name</code> - Checkout the branch</li>
        <li>Make changes</li>
        <li><code>git status</code> - we should see the files we changed as unstaged.</li>
        <li><code>git add name_of_file_we_changed></code> - stage those changes for commit. We need to do this for each file we changed.</li>
        <li><code>git status</code> -  we should see the files we changed as staged for commit.</li>
        <li><code>git commit -m "short message about the changes we made"</code> - commit the changes.</li>
        <li><code>git push origin feature_name</code> - Push your branch to Github.</li>
        <li>Repeat steps 4 - 10 until the feature is complete</li>
        <li>Put in a Pull Request (PR) to merge your branch into main.</li>
        <li>Visit GitHub and merge your pull request into main.</li>
        <li><code>git checkout main</code> - Switch back to the main branch.</li>
        <li><code>git pull origin main</code> - Make sure that you have the most recent changes that you made on your local main branch.</li>
    </ol>
</section>

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

### Wrap-Up
1. How do you create a git repository locally?
1. What should be included in a git commit message?
