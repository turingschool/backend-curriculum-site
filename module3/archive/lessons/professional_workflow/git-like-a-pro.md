---
title: Git Like a Pro
length: 60-ish
tags: git, workflow, rebase
---

Some content shared from [the front-end program](https://github.com/turingschool/front-end-curriculum/blob/6b5b565c409c769e297fac720cc6aca92ee9f2d3/lessons/module-3/merge-vs-rebase.md)


## Goals

* Understand the difference between merge and rebase workflows
  * Know when and when not to rebase
  * Identify pros and cons of each method
* Squashing Commits
* Other helpful Git shortcuts


# The Git Merge Branch Workflow

We're all familiar with the most common git workflow: create a development branch, commit your work, push it to
GitHub, make a pull request, and merge.

## Review

```bash
# find an awesome repo, fork it to your own GitHub user account, clone that repo:
$ git clone git@github.com:your_username/some-awesome-repo

$ git checkout -b new-branch
# do some work
$ git add new_file.rb
$ git commit -m "here is my new awesome work"
$ git push origin new-branch

# visit github.com/your_username/some-awesome-repo
# create a pull request
# merge the code

$ git checkout master
# fetch master and download new changes
$ git pull master

# finally, delete your old branch
$ git branch -D new-branch
```

## Whiteboard diagram

## Git Log

Your git log will look something like this:

- Merge pull request #76 from your_username/new-branch
- here is my new awesome work
- Merge pull request #75 from your_username/some-old-branch
- ...

# Advantages

- This is a great workflow if you want to see a branch history in your git log. You can view the "network" of your
git history on GitHub using a URL like this:
  - https://github.com/your-username/your-repo-name/**network**
- This method of merging works great in solo and pairing projects.

## Disadvantages

- A simple review of `git log` will be difficult to see what happened and when, commits will be all mashed together
across branches.
- You'll need to "pull" or "merge" master into your branch frequently to resolve merge conflicts as they come up.


# Git Workflow: Rebase

Some tech companies want a much cleaner commit log. Using `git rebase` allows us to see a more streamlined
history of the commits without the branching.

## Disclaimer

Not every tech company uses the rebase method. Your mileage may vary. No electrons were harmed in the production
of this tutorial.


## Overview

Rebasing will effectively rebuild your branch's commit history with a new starting point from your master branch. You
should `git rebase` often to minimize merge conflicts along the way.

Doing a `git rebase` will have to step through every single commit you've made on your **feature** branch, one at a
time, and see if it's possible to apply it on top of the **master** branch. Squashing your commits may make this
process easier. (covered later)

## Whiteboard diagram

## Workflow

```bash
# find an awesome repo, fork it to your own GitHub user account, clone that repo:
$ git clone git@github.com:your_username/some-awesome-repo

$ git checkout -b new-branch
# do some work
$ git add new_file.rb
$ git commit -m "here is my new awesome work"
# pull master from the origin fork and rebase our work
# git pull --rebase origin master

# fix any merge conflicts, commit them

$ git checkout master
# merge our branch into master to catch up our master
$ git merge new-branch

# finally, delete your old branch
$ git branch -D new-branch
```

## Advantages

- Avoids auto-generated commits of pulling/merging master into your feature branch or merging your branch into master
- History appears cleaner. All of the new work you've done on your feature branch will be placed **after** the other
  commits on master. It's kind of like telling git, "pretend I didn't take 2 weeks to finish my feature, and make it
  seem like I started the work today and finished it all in a couple of minutes."


## Disadvantage

- Dealing with merge conflicts can be repetitive if your feature branch has lots of commits
- If teammates create a branch off of YOUR branch (and not master), rewriting your git history in this manner will
  cause problems combining their work later.



## To Rebase or Not to Rebase?

As a general rule, it works best to rebase regularly while you are working on a feature branch locally and
individually. If anyone else is looking at or using your branch to base their work off of, rebasing is dangerous
because rebasing will rewrite the commit history. Avoiding complicated rebases means rebasing almost as frequently
as you are committing.


# Squashing Commits

Many open-source contributions will want you to "squash" your commits to remove unnecessary "work in progress" markers
or commit messages that aren't helpful for tracking your progress along the way. Some workplaces will encourage
squashing unhelpful commit messages, but will generally discourage squashing ALL commit messages to a single commit.

## Scenario

```bash
# you've cloned a repo, and you make a feature branch
$ git checkout -b new-branch

# you edit some files and leave for lunch but want to commit your work first
$ git add <list of files>
$ git commit -m"morning work in progress"

# after lunch you do more work and want to commit before you leave work for the day
$ git add <list of files>
$ git commit -m"afternoon work in progress"

# repeat for every day you work
```

Suddenly your log history starts to look like:

```
| * 60ae30c wip
| * d0129b5 wip
| * aed52c2 wip
| * c7a5ac7 wip
| * 124578a wip
| * 3562c99 wip
| * ee1d6a6 wip
| * d256033 wip
```

What if you could finish a portion of your work, undo all of those commit messages, and leave one meaningful commit
instead?

```bash
# rewind 5 commits, but keep all altered files
$ git reset HEAD~5

# now you can add/stage and commit all of that work in one commit
$ git add <list of files>
$ git commit -m"database integration done, more work needed on UI"
```

This is **extremely** helpful when rebasing as well, so you can squash all feature work down into fewer commits.

## Disadvantages

- You effectively lose the incremental work history of how you've built your project. Hiring managers and tech
leads who evaluate your GitHub history may want to see your actual workflow so it doesn't appear that you created
all portions of a feature in one perfect commit.


# .gitconfig

You probably already have a `.gitconfig` file in your `$HOME` folder (ie, `/Users/username/gitconfig`)

## Aliases for shortcuts

Add a section to your `.gitconfig` to create shortcut aliases for things you do frequently

```
[alias]
  co = checkout
  st = status
```

Save and close the file, and now you'll have access to shorter commands such as:

```bash
$ git co your-branch
$ git st
```

Some cool shortcuts:

```
[alias]

  last = !sh -c 'test "$#" = 1 && git log -$1 HEAD || git log -1 HEAD' -
  # What is it:  retrieve only the last 'n' log entries
  # Usage:       git last 5
  # Notes:       If you don't include a numeric value, it will default to 1


  br = branch -v
  # What is it:  show all local branches
  # Usage:       git br


  cleanup = !git branch --merged master | grep -v 'master$' | xargs git branch -d
  # What is it:  delete any local branch which has already been merged to master
  # Usage:       git cleanup


  unstage = reset HEAD --
  # What is it:  reverse any files you've staged for commits, without losing your work
  # Usage:       git unstage


  graph = log --oneline --decorate --all --graph
  # What is it:  see an ASCII-branched history of your repo
  # Usage:       git graph
```


## Resources

* [Git Book: Merge vs Rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
* [Atlassian: Merge vs Rebase](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
