# Git & GitHub

---

# Warmup

* What do you already know about Git/GitHub?
* What questions do you still have?

---

# Overview

* Git is a version control system that we use in programming.
* GitHub is a website that allows us to share Git repositories.
* In order to keep our code safe we use a branching workflow that allows us to make changes to multiple files before fully committing to those changes.

---

# Git

---

# What is Git?

* Version Control System
* Provides multiple save points that we can go back to

---

# Commits

Files that we change can be in one of three states:

1. __Unstaged__: we have made changes but not told git that we would like to commit them
1. __Staged__: we have made changes and told git that we are getting ready to commit them
1. __Committed__: we have committed our changes to the repository's log of commits. Our work is saved.

---

# Important Git Commands

* `init` - create a git repository in the current directory.
* `status` - show what changes have been made. This will show changes that are staged and unstaged.
* `add <file name>` - stage a change for commit.
    * ex: `git add credit_check.rb`
* `commit -m "<commit message>"` - commit a change. Each commit requires a commit message (must be in quotes).
    * ex: `git commit -m "adds search feature"`

---

# Git Workflow

---

# Creating a Git Repository

1. Use `mkdir` to create a new directory if you have not already.
1. `cd` into that directory.
1. Run `git init` to make that directory a Git repository.

---

# Committing Changes

These are the steps you should take to make changes and save them to your repository.

1. `git status`
1. Make changes
1. `git status`
1. `git add <name of file we changed>`
1. `git status`
1. `git commit -m "short message about the changes we made"`

---

# Practice!

Using the commands that we reviewed:

* Create a new directory called `git_practice`.
* Make your `git_practice` directory a Git repository.
* Create a file inside of that directory called `README.md` and add some text to that file.
* Commit your changes
* Make some additional changes
* Commit those changes

---

# Share

---

# Github

* Website for hosting git repositories.
    * Git repository on your computer is called the **local repository**.
    * When you push your repository to Github, you are creating a **remote repository**.

---

# Creating a New Repository on GitHub

* Visit the site.
* Click the green `New` button
* Name the repository

---

# Commands for interacting with GitHub

* `remote -v`
* `remote add <remote name> <remote url>`
* `push <remote name> <branch name>`
    * `git push origin master`
* `pull <remote name> <branch name>`
    * `git pull origin master`

---

# Git workflow with Github

---

# To set up the link to our repository

1. `pwd`
1. `git status`
1. Create the repo on GitHub
1. Copy the SSH address from GitHub
1. `git remote -v`
1. `git remote add origin <YOUR_SSH_ADDRESS HERE>`
1. `git log`
1. `git push origin master`

---

# To push to your remote repository

1. Make changes
1. `git status`
1. `git add <name of file we changed>`
1. `git status`
1. `git commit -m "short message about the changes we made"`
1. `git push origin master`

---

# Practice

* Create a new repository called `git_practice`
* Add the remote to your local `git_practice` repository
* Push your existing commits to the GitHub repository
* Make additional changes to your README
* Commit them
* Push your changes to GitHub

---

# Branching

* Branches represent a line of development.
* The `master` branch is the default branch.
* Switching between branches is also called `checking out` a branch.
* Branches can serve as a sandbox for development.
* If whatever you are trying doesn't work, no big deal; your master branch remains intact.

---

# Branching commands

* `branch`
* `branch <branch name>`
* `checkout <branch name>`
* `checkout -b <branch name>`
* `push <remote name> <branch name>`
* `pull <remote name> <branch name>`

---

# Pull Requests

* GitHub feature
* Allow us to request that the code we changed be merged to master
* Also allow us to review the code we've pushed

---

# Git Workflow with Branching and Pull Requests

This is the final version of our workflow, and is what you should be doing on every project, partner or solo.

1. `git status` - make sure our working directory is clean. If there are changes, we need to figure out what to do with them, either commit them or stash them.
1. `git pull origin master` - Make sure you are up to date with the latest version of master.
1. `git branch <feature name>` - make a new branch based on a feature you want to add. Alternatively, you can use `git checkout -b <feature name>` to create and checkout the branch in one command.
1. `git checkout <feature name>` - Checkout the branch
1. Make changes
1. `git status` - we should see the files we changed as unstaged.
1. `git add <name of file we changed>` - stage those changes for commit. We need to do this for each file we changed.
1. `git status` -  we should see the files we changed as staged for commit.
1. `git commit -m "short message about the changes we made"` - commit the changes.
1. `git push origin <feature name>` - Push your branch to Github.
1. Repeat steps 4 - 10 until the feature is complete
1. Put in a Pull Request (PR) to merge your branch into master.
1. Visit GitHub and merge your pull request into master.
1. `git checkout master` - Switch back to the master branch.
1. `git pull origin master` - Make sure that you have the most recent changes that you made on your local master branch.

---

# Practice

* Check out a new branch
* Make some additional changes to your README
* Commit those changes
* Push your change to the branch on GitHub
* Visit GitHub
* Create a pull request
* Merge your pull request
* Check out your master branch locally
* Pull your changes into your master branch
