---
title: Git for Pairs
length: 60
tags: ruby, git, workflow
---

## Learning Goals

* Describe flow integrating git and github
* Describe how two people might work off the same repository
* Describe steps to resolving a merge conflict

## Structure

* 5   - Warmup
* 20  - Pairing Demonstration
* 5   - Break
* 25  - Resolve Merge Conflict Demonstration
* 5   - Closing/Synthesis

## Vocabulary

* Merge Conflict
* Pull Request (PR)
* Clone
* Fork

## WarmUp

* Diagram git workflow. Include any relevant git commands.

## Review: Git Commands

**Create a local repository>**
* git init

**Save updates**
* git status
* git add file_name
* git commit -m "Add message"

**Create and switch to new branch**
* git checkout -b branch_name
OR
* git branch branch_name
* git checkout branch_name

**Interact with remote**
* git pull origin branch_name
* git push origin branch_name
* git remote -v
* git remote add <ssh key>

## Clone vs. Fork and Clone

Cloning is when you copy a remote Github repository to your local computer. You clone a repository with:

```
git clone <ssh key for repository>
```

Whenever you clone a repository, you interact with that repository by pushing and pulling branches. Therefore, when you are working with teammates, i.e. in a group project, you all need to clone the same repository so that you are all working in the same code base.

Sometimes, you want to work on a code base that you do not own or don't have permission to change. For example, Turing often provides starter repositories for your projects. You do not have permission to change these repositories, so in order to work with them in Github, you need to create a **Fork**. Forking is creating your own copy of a Github repo. This new repo will be associated with your username, so you have permission to change it. After you create a fork, you clone that forked repository the same way you clone a repository that you created from scratch.

## Merge Conflicts

When you submit a Pull Request, git merges code from one branch into another. Usually, git is merging a feature branch into the master branch. Git has rules that it uses to determine what the code should look like after the merge. However, there are some instances where git can't automatically figure this out using its rules, so it needs you to manually tell it what the code should look like after the merge. This is called a **Merge Conflict**. The easiest way to resolve one is using Github's Merge Conflict Tool. Git represents a merge conflict by inserting some text into the file where the conflict happened. It will look something like this:

```
<<<<<<<< branch_name
 # Code from the branch_name Branch
========
# Code from the master Branch
>>>>>>>> master
```

In order to fix it, you need to change the text of the file to include only the desired code.

## Git Flow for Pairs

#### Person A

* Make a directory and CD into it
* Check that repo is not already inited
  (`git status`)
* Initialize repo locally
  (`git init`)
* Create a repo on GitHub
  (repositories/new)
* Add remote to local
  (`git remote add origin <ssh key to remote>`)
* Check successful addition
  (`git remote -v`)
* Check git status
  (`git status`)
* Make a file
  (`touch filename.rb`)
* Add some code to the file
* Commit and push
  - `git status`
  - `git add filename.rb`
  - `git status`
  - `git commit -m "initial commit"`
  - `git push origin master`
* Add collaborator on github

#### Person B
* accepts invitation
* clones repo (`git cone <ssh key to repo>`)
* cds into cloned repo
* checks out a new branch (`git checkout -b add_content`)
* changes first line of file
* commits and pushes to branch
  - `git status`
  - `git add filename.rb`
  - `git status`
  - `git commit -m "changes first line"`
  - `git push origin add_content`
* Creates a Pull Request on Github

#### Person A
* checks out a new branch (`git checkout -b new_feature`)
* changes first line of file
* commits and pushes to branch
  - `git status`
  - `git add filename.rb`
  - `git status`
  - `git commit -m "different change to fist line"`
  - `git push origin new_feature`
* Creates a Pull Request on Github

#### Person B
* Review and comment on Person A's Pull Request
* Merge Person A's Pull Request

#### Person A
* Review and comment on Person B's Pull Request
* Fix Merge Conflict with Github Tool
* Merge Person B's Pull Request

#### Both
* Checkout and pull from master
  * `git checkout master`
  * `git pull origin master`


![Merging a Branch to Master](https://docs.google.com/drawings/d/e/2PACX-1vR6KtiUHn_LsBfxJRYUYwgT7KJClTVLajC3OzwME6RLF1HroCbOQGuRXUcgjI-I1xfZ-LuF4R5BGbi7/pub?w=960&h=720)

## Closing

Talk with partner
* What are the commands to do the following:
   - Create a repo
   - Connect a git repo to a GitHub repo
   - Update your local git with new content
   - Update GitHub with new content
* What steps would you take if working with a partner on a separate computer? What are the pros/cons of this work flow?
* What is a merge conflict? How might you resolve a merge conflict?

### Additional Resources

[Git - the Simple Guide](http://rogerdudler.github.io/git-guide/)
[Pro Git](https://git-scm.com/book/en/v2)
