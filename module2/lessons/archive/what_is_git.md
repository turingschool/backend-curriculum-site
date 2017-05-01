---
title: What is Git?
subheading: re-introduction to git
tags: git, github, workflow, collaboration
---

### Visualize Your Git Workflow

Let's spend some time diagramming and visualizing our git workflows. Break into groups of about 4. Everyone should have paper and markers. Together let's diagram a strait forward git workflow.

1. You create a project `git init`
1. You do work and stage & commit along the way `git add path_to/file_name` & `git commit -m "add x feature"`
1. That work is then eventually merged in the master branch
1. You checkout a new feature branch `git branch -b new_feature_A`
1. You do work, stage & commit along the way `git add path_to/file_name` & `git commit -m "add x feature"`
1. Team member checkouts a new feature branch `git branch -b new_feature_Z`
1. Team member does work, stage & commit along the way `git add path_to/file_name` & `git commit -m "add x feature"`
1. Team member finishes feature, work is approved and merged to master
1. Once master is updated, update your local version of master `git checkout master` & `git pull remote_name master`
1. Update your feature branch to stay current with master `git checkout feature_branch_A` & `git merge master`.
1. Repeat

### Some helpful git tools:

* `git branch -a` - show all branches on the git repository
* `git fetch` - gets the code from your remote repositories and pulls it into the remote branch tracking on your machine. This command does not add the changes pulled from the remote into your local version.
* `git merge` - merges one branch/history into another. `git merge branch_name` will merge the branch named `branch_name` onto the local branch you are on.
* `git checkout -b feature_branch_name` - checks out a new branch under the name `feature_branch_name`
* `git checkout branch_name` - checks out an existing branch under the name `branch_name`
* `git log`
  - `git log --oneline`
  - `git log --author=Name`
  - `git log --graph`
  - many more options for git log
*
