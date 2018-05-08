---
title: Git for Pairs
length: 120
tags: git, workflow, pull request, merge, commit, github
---

## Learning Goals

* Write clear commit messages following conventions
* Push local branches to GitHub, open PRs with comments
* Merge & comment on PRs

## Agenda

- Visualizing Git & GitHub
- Model Workflow
- Practice Workflow
- Solidify

## Vocabulary
* Repo
* Commit
* Branch
* Pull Request (PR)
* Clone vs. Fork & Clone

## Slides

Available [here](../slides/git_for_pairs)

## WarmUp

* What is git?
* How does GitHub relate to git?
* What are the steps to creating and interacting with a repo on GitHub? How is git involved?

## Model

### Creating a repo

Sometimes you will want to start with a boilerplate that you are provided with at Turing:
  - Click 'fork' - this copies the repo to a new repo in your name. It still shows the history of the entire project
  - Now that you are in YOUR project on GitHub: `$ git clone <SSH key> project_name`
  - `$ cd project_name`
  - `$ git status`
    - _On branch master / Your branch is up-to-date with 'origin/master'. / nothing to commit, working tree clean_


Sometimes you will want to start from scratch:
  - `$ mkdir project_name && cd project_name`
  - `$ touch first_file.rb`
  - `$ git init`
    - _Initialized empty Git repository in /Users/user/turing_m1/project_name/.git/_
  - `$ git add first_file.rb`
  - `$ git commit -m "Initial commit"`
    - _On branch master / Initial commit / nothing to commit_
  - Go to your GitHub account -> Create A New Repository -> provide a name, -> click Create
  - Follow `…or push an existing repository from the command line` directions:
    - `$ git remote add origin git@github.com:ameseee/git_intro.git`
    - `$ git push -u origin master`
  - Refresh your GitHub repo - the changes should be reflected there now


### Saving your changes as you go

Just like one would frequently click 'save' in a word document when you finish a really great paragraph that will contribute to an essay, we want to save small pieces of code that contribute to completing a project. Not only does this allow us to save changes so we don't lose anything we worked hard on, git keeps track of the history, so we can always look back and see who worked on the project, how often, how long it took to build, etc. These little saves are called `commits`.

Commit messages should follow [these rules](https://chris.beams.io/posts/git-commit/#seven-rules).

Workflow:
- `$ git status`
- `$ git add <file_name>`
- `$ git commit -m "Add ________ functionality"`
- `$ git push origin master`

Want to check which remote repository you're connected to?
- `$ git remote -v`

### Keeping your workflow even more organized (and safe)

Commits should represent small pieces of code that fix a bug, complete functionality, write some tests, etc. Branches allows us to group a few-many commits that are related to each other. This is usually used for a bigger feature. When work is done on a branch, the master (as well as any other) branch remains unchanged. This guarantees that even if you go down a very dark a scary road, your code from earlier that day or week is still there.

Workflow:
- `$ git status`
- `$ git checkout -b feature_name`  - this creates a branch and 'checks out' to that branch
- write some code
- `$ git add <file_name>`
- `$ git commit -m "Add ________ functionality"`
- write some code
- `$ git add <file_name>`
- `$ git commit -m "Add another piece of functionality"`
- `$ git push origin feature_name`
- At this point, GitHub knows that you've sent this branch, with all this new code to it. It doesn't **not** yet know if you truly want this on your master branch, though. You need to create a pull request - which requires quite a few steps, because GitHub is your friend and wants to make 100% sure that you are 100% sure you want to do this.

Create a PR (pull request):
- Navigate to the GitHub account of the project owner (you or your partner)
- You should see a light yellow banner on the top right corner with <branch_name> (time since it was pushed)
- Click on the green icon (or click branches tab, and find the corresponding 'New Pull Request' button)
- Notice the commit message has populated the first input field. You may add any additional notes about this branch/PR in the larger text area below.
- Click green 'Create Pull Request' button
- STOP
- If you are working with a partner - your partner would need to do the rest. If you are working solo, click the green 'Merge Pull Request', then 'Confirm Merge' buttons
- You should see a 'Pull request successfully merged and closed' message. This means your GitHub has been updated to the work from the branch you set up.

WHAT IF I GET SCARED?
- `$ git status` - will tell you if you have any changed files - if they have been staged (added) or not, and more.
- `$ git diff` - will show the changes you have made since last commit
- `$ git log` - will show you the commits and some info about them

### Collaborating and more on keeping workflow organized

- PR comments
- comments as reviewer to merge


### Making sure you are up-to-date
After merging something on GitHub, you always want to make sure you have that latest up-to-date version of the project on your machine. Checkout to your master branch and pull from GitHub.
- `$ git checkout master`
- `$ git pull origin master`


## Practice
- Create a new directory, make it a git repository, create a GitHub repository
- Checkout to a feature branch
- Make three changes; for each change, make a commit
  - You are 'faking' the code, but still practice strong commit messages
- Push feature branch to GitHub
- Create a PR, write a comment, merge PR


### Extension: Merge Conflict Work Flow

* Original makes a change to the line in the file
* Original commits changes
* Original pulls from branch w/ Collaborator's changes
  (`git pull origin add_content`)
* Original resolves merge conflict
  (choose which version of the code you'd like to keep
   delete the code you do not want)
* Original commits changes
  (`git status`
   `git add -p`
   ` git status`
   `git commit -m "Add a message"`)
* Original switches to master (`git checkout master`)
* Original pull from master (`git pull origin master`)
* Original switches back to branch (`git checkout add_content`)
* Original merges master into branch (`git merge master`)
* Original pushes updated branch to GitHub
  (`git push origin add_content`)
* Original puts in PR
* Collaborator comments and merges PR

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
