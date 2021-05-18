---
title: Git for Pairs
length: 60
tags: ruby, git, workflow
---

## Learning Goals

* Describe flow integrating git and github
* Describe how two people might work off the same repository
* Describe steps to resolving a merge conflict

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

When you submit a Pull Request, git merges code from one branch into another. Usually, git is merging a feature branch into the main branch. Git has rules that it uses to determine what the code should look like after the merge. However, there are some instances where git can't automatically figure this out using its rules, so it needs you to manually tell it what the code should look like after the merge. This is called a **Merge Conflict**. The easiest way to resolve one is using Github's Merge Conflict Tool. Git represents a merge conflict by inserting some text into the file where the conflict happened. It will look something like this:

```
<<<<<<<< branch_name
 # Code from the branch_name Branch
========
# Code from the main Branch
>>>>>>>> main
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
* Commit 
* IF your initial branch is not named 'main', rename it now
  (`git branch -m main`)
* and push
  - `git status`
  - `git add filename.rb`
  - `git status`
  - `git commit -m "initial commit"`
  - `git push origin main`
* Add collaborator on github

* Checks out new branch (`git checkout -b new_feature`)
* Changes first line of file
* Commits and pushes to branch
  - `git status`
  - `git add filename.rb`
  - `git status`
  - `git commit -m "change to first line"`
  - `git push origin new_feature`

#### Person B
* accepts invitation
* clones repo (`git clone <ssh key to repo>`)
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
* Review and comment on Person B's Pull Request
* Merge Person B's Pull Request

Remote main is now updated

From `new_feature` branch (should already be on this): 
* pulls origin main into `new_feature`
  - `git pull origin main`
* fixes merge conflict
* commits and pushes to remote `new_feature`
* creates pull request on Github

#### Person B
* Review and comment on Person A's Pull Request
* Merge Person A's Pull Request

#### Both
* Checkout local main and pull from main
  * `git checkout main`
  * `git pull origin main`


## Closing

Talk with partner
* What is the git workflow when working with a partner on a separate computer?
* What is a merge conflict? How might you resolve a merge conflict?

### Additional Resources

[Git - the Simple Guide](http://rogerdudler.github.io/git-guide/)
[Pro Git](https://git-scm.com/book/en/v2)
