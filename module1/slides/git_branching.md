# Git Branching, PRs, and Merges

---

# Warmup

* What have you heard so far about branching in Git?
* Git is  a Decentralized Version Control System (DCVS). What does decentralized mean in this context?
* What questions do you still have about Git/GitHub

---

# Overview

* Creating a branch
* Checking out a branch
* Pushing a branch
* Submitting a pull request
* Checking out master
* Getting the latest version of master
* Adding code from master to a branch

---

![](https://www.youtube.com/watch?v=_ALeswWzpBo)

---

# Branches

* Check out a branch when you want to work on a new feature
* Keep your branch names snake case
* Branch names should describe the *feature* you plan on implementing
* Branch names can start with a number, but have a good reason

---

# New Git Commands

```
$ git branch new_branch_name
$ git checkout new_branch_name (<= branch name should match)
$ git push origin branch_name
$ git merge master (<= merges master into current branch)
```

---

# Checking out a New Branch

```
$ git branch new_feature
$ git checkout new_feature
```

Do work.
Make commits.

---

# Pull Requests

* Check to see that your code can be merged
* Ask a teammate to review code
* Ask a teammate to merge your changes to the `master` branch

---

# Submitting a Pull Request

```
$ git push origin branch_name
$ hub browse
```

---

# Submitting a Pull Request (continued)

On GitHub:

* `Compare & pull request`
* Review files
* Title
* Message
* `Create pull request`

*Might result in merge conflict.*

---

# If There is a Merge Conflict

```
$ git checkout master
$ git pull origin master
$ git checkout branch_name
$ git merge master
```

Resolve merge conflict.

```
$ git push origin branch_name
```

Pull request will be updated with your fix.

---

# Reviewing a Pull Request

* Review files
* Make comments
* Request changes

Note: You can pull down a branch to review by following [these](https://help.github.com/articles/checking-out-pull-requests-locally/) directions

---

# Merging a Pull Request

* Review files (again!)
* Click `Merge pull request`
* Write message
* Click `Confirm merge`
* Click `Delete branch`

---

# Pulling from Master

* Want to make sure you have most up to date master?

`$ git checkout master`
`$ git pull origin master`

---

# Merging from Master (Locally)

* If you are working on a branch and you want code in your branch that your teammate has pushed:

`$ git status` - Make sure you have everything committed
`$ git checkout master`
`$ git pull origin master`
`$ git checkout branch_with_my_feature`
`$ git merge master`

*Might result in merge conflicts*

---

# Resolving Merge Conflicts

* `$ git status` will list the files that have conflicts
* Open each one
* Decide what to keep
* Remove tags indicating merge conflict

---

# Summary

* How do you create a new branch in Git?
* How do you check out a new branch?
* How do you push that branch to GitHub?
* At a high level, how do you submit a pull request?
* How do you check out master?
* How do you get the latest version of master?
* What do you do if you want to add code from master to your branch?
