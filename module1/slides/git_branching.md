# Git Branching, PRs, and Merges

---

# Warmup

* On your last partner project, how did you handle working together on a single project?
* What have you heard so far about branching in Git?
* Git is  a Decentralized Version Control System (DCVS). What does decentralized mean in this context?
* What do you remember about submitting a pull request for your `Scrabble` challenge last week?

---

# Overview

* Checking out a branch (`git checkout -b branch_name`)
* Submitting a pull request
* Reviewing a pull request
* Merging a pull request
* Pulling from master/merging from master
* Resolving merge conflicts

---

# Branches

* Check out a branch when you want to work on a new feature
* Keep your branch names snake case
* Branch names should describe the *feature* you plan on implementing
* Branch names can start with a number, but have a good reason

---

# Checking out a New Branch

`$ git checkout -b branch_name`

---

# Pull Requests

* Ask a teammate to review code
* Ask a teammate to merge your changes to the `master` branch

---

# Submitting a pull request

`$ git push origin branch_name`

On GitHub:

* `Compare & pull request`
* Review files
* Title
* Message
* `Create pull request`

---

# Reviewing a Pull Request

* Review files
* Make comments
* Request changes

Notes:
1) Teammate can make changes and push to the same branch
2) You can pull down a branch to review by following [these](https://help.github.com/articles/checking-out-pull-requests-locally/) directions

---

# Merging a Pull Request

* Review files (again!)
* Click `Merge pull request`
* Write message
* Click `Confirm merge`
* Click `Delete branch`

---

# Pulling from Master

* Want to make sure you have most up to date master

`$ git checkout master`
`$ git pull origin master`

---

# Merging from Master (Locally)

* If you are working on a branch
* And master is now ahead of your branch

`$ git status` - Make sure you have everything committed
`$ git checkout master`
`$ git pull origin master`
`$ git checkout branch_with_my_feature`
`$ git merge master`

**Might result in merge conflicts**

---

# Resolving Merge Conflicts

* `$ git status` will list the files that have conflicts
* Open each one
* Decide what to keep
    * Generally want to keep the code that was on master
    * Not always
* Remove tags indicating merge conflict

---

# Summary

```
$ git checkout -b branch_name
$ git push origin branch_name
```

* Create a PR on GitHub
* Teammate Reviews PR on GitHub

```
$ git checkout master
$ git pull origin master
$ git checkout other_branch
$ git merge master
```

