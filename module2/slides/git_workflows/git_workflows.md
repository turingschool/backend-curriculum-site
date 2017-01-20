autoscale: true

# Git Workflow
## Review & Exploration

---

# Warmup

* What are your top 5 Git commands?
* Do you have a preferred Git/GitHub workflow?
* Do you have a sequence of commands you run when committing/pushing?
* Does anything make you nervous about Git? If so, what?

---

# Overview

* Git Workflow in Teams
* Better Commits
* GitHub & Code Reviews
* Some Fun Commands
* Pair Work

---

# Git Workflow

1. Anything in the master branch is deployable.
2. To work on something new, create a descriptively named branch off of the master branch.
3. Commit to that branch locally frequently.
4. Regularly push your work to the same named branch on the remote server.
5. Open a [WIP] pull request so your code can be reviewed along the way.
6. Tag reviewers in a comment with their github `@username` for need feedback or help.
7. After a reviewer has reviewed and signed off on the feature, they can merge to master.
8. Once it is merged and pushed to ‘master’, you can and should deploy immediately.
9. Anything on master should be deployable.

---

# Better Commit Messages

1. Separate subject from body with a blank line
2. Limit the subject line to 50 characters
3. Capitalize the subject line
4. Do not end the subject line with a period
5. Use the imperative mood in the subject line
6. Wrap the body at 72 characters
7. Use the body to explain what and why vs. how

---

# Tools for Code Reviews

* `[WIP]` Pull Requests
* Conversations/Line Comments
* Waffle.io/GitHub Issues

---

# Fun Commands

* `git remote -v`
* `git branch -a`
* `git blame some_file_name`
* `git diff`
* `git diff --staged`
* `git remote prune origin --dry-run`
* `git branch -d branchname`
* `git commit --amend`

---

# Pairs

* Pick 2 exercises and 2 addiitonal resources.
* Complete the exercises with your partner.
* Review the resources, summarize, and discuss with your partner.
