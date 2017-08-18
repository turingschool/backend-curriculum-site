---
layout: page
title: Branching in Git
length: 60
tags: git, github
---

## Prework (the Night Before)

Set up your ssh keys on github according to [these instructions](https://help.github.com/articles/generating-ssh-keys/)

## Standards

### Learning Goals

In this lesson, you will learn how to:

* Start a project with Git
* Make local version contributions to a project using Git
* Make changes to branches and merge them into master

### Vocabulary

- Branch (Noun)
- Branch (Verb)
- Merge
- Repository
- Remote/Local

### Navigating Branches and Commits

* `Branches`: Git actually allows us to have multiple histories, each on its own *branch*;
by default git creates a standard branch called *master*
* `Head`: Reference for "Where am I now?"
  * By default this is the "tip" of the current branch you're on, the latest commit on a given branch
  * If you manually jump to another commit, `head` will represent the state of your code when that commit was the most recent change.
  * When new commit is made on a branch, `head` moves to that new commit
* `Working Directory` represents the current view of files, what we see as opposed to the various changes and alternative views git stores in its history

### Check for Understanding
Write on the following questions to synthesize what's been covered.
* How do commits and branches serve as the bricks and mortar of a git repository?
* What _is_ a commit and how does git use it to reconstruct the history of your code?

When you're finished, post your answers in Slack.

## A Basic Git Workflow

Git contains many features. Fortunately, in 99% of cases we don't have to
know or use most of them. Instead, we can rely on a very simple and straightforward workflow:

1. Create a new git repository within your project directory (`git init`)
2. Do work / Change files
3. "Stage" changes using `git add`
4. "Commit" your changes using `git commit`
5. Repeat steps 2-5 until done

### Basic Workflow in Practice

Let's go through a more concrete example all together.

First, create and navigate into an empty directory to simulate a new project
we might be working on:

```
mkdir intro_git && cd intro_git
```

Next, let's create an empty file to simulate some code changes we
might have made:

```
touch Readme.md
```

Now we need to tell git to create a new, empty "repository" within the directory:

```
git init
```

We sometimes use the terms `repository` and `directory` interchangeably in the context of git, but technically they are separate things. The directory contains all our working files, as well as the hidden files used by git to track all of our work. The repository is composed of files and directories within the hidden `.git` directory where git does its magic.

Let's check the status of our repository.

```
git status
```

The `status` command shows us git's perspective on the current state of our repository. It tells us the current branch we're working from, but it also tells us the current state of any uncommitted files. We'll see changes in 3 possible states here:

1. __Unstaged__ (we have made changes but not told git that we would like to commit them)
2. __Staged__ (we have made changes and told git that we are getting ready to commit them)
3. __Committed__ (we have committed our changes to the repository's log of commits)

Our `Readme.md` file will be showing as Unstaged at this point, so let's add it:

```
git add Readme.md
```

We can verify the `add` worked by using the status command again:

```
git status
```

We'll now see that `Readme.md` (and the changes we made to it) have moved to the "staging" area -- they are ready to be committed.

#### `git commit`

Finally, let's make a commit!

We use the `git commit` command for this. One key component of every commit is a "message" describing what the commit does. We can provide this message from the command line using the `-m` flag, like so:

```
git commit -m "initial commit -- added Readme"
```

Run `git status` one more time. Since we committed all of our changes,
our working directory is now "clean".

Check `git log` once more. It will show detailed information about each commit. Right now, we only have one.

This cycle -- make changes, stage changes (`git add`), and commit changes --
is the backbone of a standard git workflow.

You should use these steps frequently as you're working on a project.

### Check for Understanding

Write on the following questions to synthesize what's been covered.
* What's the difference between unstaged, staged, and committed changes?
* How do these states (unstaged, staged, committed) help git keep track of the history of your code?
* How are `git status` and `git log` used to review the status of our code? How are they different?

When you're finished, post your answers in Slack.

## Github

Github is a platform for hosting git repositories online. Before github, developers or companies configured and ran their own independent git servers, and things were much more fragmented. Now Github has become the de facto community standard for hosting and sharing repositories.

You certainly don't need Github to use git, but its popularity and dominance, especially within the open source community, have made the 2 somewhat synonymous for many users.

As you progress through becoming a more practiced git user, don't forget that these 2 are really distinct things -- `git` provides the core technology for tracking and managing source control changes, while GitHub provides a shared location for hosting git projects.

### Basic Workflow for Using GitHub

There are a few things we'll need to do to use GitHub to host our newly-created repository:

1. Create a new repo on GitHub
2. Add the online repo as a "remote" for our local repository
3. `push` changes from our local repository to the remote copy that Github is tracking for us

### Creating a Repository with [Hub](https://github.com/github/hub)

We can create a repository via the GitHub web interface, but fortunately there's also a very handy command line utility called `Hub` that makes this even easier.

Let's install it using homebrew:

```
brew install hub
```

Hub provides a command-line interface to streamline many of the common interactions we have with GitHub. It uses GitHub's API to do things like creating repositories, opening issues, etc.

You can read more about the commands available in Hub's [documentation](https://github.com/github/hub#commands), but for now we're going to be using the `create` command.

Hub will help us create a relationship to our remote repository. Before we do that, though, let's check whether we currently have any remote relationships defined.

```
git remote -v
```

We should see no results when we run this command. Now let's add the relationship.

Make sure you're in the `intro_git` directory we created earlier, and create a new (GitHub) repository to host this content online. Use Hub's `create` command:

```
hub create
```

If this is your first time using Hub, you'll be prompted for your github username and password. After that, hub will do 2 things:

1. Create the repository on GitHub
2. Add that repository as a "remote" within our local repository (on our machine)

Check `git remote -v` and we'll see that origin has been set to our remote repo address: `origin git@github.com:username/repo_name.git`

### Pushing changes to our new remote

__Discussion:__ Remote vs. Local Copies of Repo

Thanks to hub, we have a remote available to push to. We'll do this with the `git push` command, which takes __2 arguments__:

1. A "remote" to push to (most often this will be `origin`)
2. The "branch" we'd like to push to (for now this will usually be `master`)

So we can push our code so far like so:

```
git push origin master
```

Now let's use Hub to go to our repo page on github and view our changes:

```
hub browse
```

### Check for Understanding

Write on the following questions to synthesize what's been covered.

* How is Github different from Git?
* What does Hub help us with?
* What relationship does a `remote` repository have with our `local` repository?
* What does pushing to a remote branch do for us?

When you're finished, post your answers in Slack.


### Working on Branches

Branches are helpful when working on teams, but also just for developing new functionality. [This link](http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging) shows some helpful visuals related to git branches.

#### The master branch

When we type `git status`, part of the message we get back is "On branch master". Let's discuss the what git means by a "branch", and what is "master"?

In Git, there is this concept of branches. They represent a line of development. The master branch is typically the branch where the code works without known bugs.  

Ideally, we want to keep the master branch "clean" of bugs. So if we want to write new code, then we can branch off of master.

When you branch off of the master branch, that new branch can serve as a `sandbox` for development where you can make changes or experiment with a `research spike` without affecting the master branch.

[More info on branching.](https://www.atlassian.com/git/tutorials/using-branches/git-branch)

The general workflow is:

  * Make a new branch based on a feature you want to add
  * Checkout the branch
  * Make changes, add and commit the changes
  * Checkout master
  * Merge your branch into master

Let's practice this.

#### Creating A Branch

(`git branch` and `git checkout`)  

Before we make a new branch, let's check what branch we are currently on.

Command to identify current branch: `git branch`  
This command lists all of the branches you have made and also tells us what branch we are on.

```shell
* master
```

We only have the default branch master right now, so it lists only `master`. The `*` denotes what branch we are currently on. In this case: `master`.

Let's make a new branch! The command to make a new branch is `git branch [branch name]`. Branch names typically follow the "Kebab Case" convention. This just means that you separate words with dashes (-) as though they're all skewered on a kebab.

Type `git branch node-class` in the terminal. Now run `git branch` again. What do we see? We see our new branch name! However, the `*` is still next to the master branch.

```shell
node-class
* master
```

To change to our new branch, we need to "checkout" the branch.  

Let's checkout the new branch using the command `git checkout node-class`. To checkout any branch, the command is `git checkout branch-name`. Now if we enter `git branch`, the asterisk shows we are on the new branch we just created.

```shell
* node-class
  master
```

Note: You're doing it so often, there's a shortcut for creating and checking out a new branch. It is `git checkout -b branch-name`.

#### Make changes on the new branch

Now that we've checked out the new feature branch, we can start making changes on the branch. Since we're using TDD for our project, let's create a test folder, and fill it with a test for our new Node class.

```
mkdir test
cd test
touch node_test.rb
```

Add the file to staging, and commit the changes: `git add test/node_test.rb` and then `git commit -m "Add empty node_test file"`.

Run `git status` and `git log` to get an idea of whats going on.

Now it's your turn. Create and add a placeholder for our `Node` class also. Create, add and commit `lib/node.rb`. Your `lib` folder should live in `git_intro`, at the "root" of the project, not inside the `test` folder (our current folder).

#### Merge feature work to master branch (`git merge`)

Let's pretend that we've filled out files, and all of our tests pass for our `Node` class. We're ready to merge our branch back into the `master` branch.

Let's start by switching back to our `master` branch with `git checkout`, and confirm that we're on the right branch with `git branch`

```
git checkout master
git branch
```

Now, let me show you something scary. Run `ls` to see the contents of your folder.

**What happened to my work?!**

![Table Flip](https://media.giphy.com/media/zUGqX3EtG6l1u/giphy.gif)

Don't worry. Git still has it. Git never forgets. It's just not part of the master branch. We've been working inside of our `node-class` branch specifically so that our changes didn't affect our master branch. But now we want to bring that work into our master branch.

To merge changes locally between branches, you should first move to the branch you want to update. Then run the command `git merge [branch you want to merge changes from]`.

```
git merge node-class
ls
```

Our changes are now in master! We have now successfully made changes on a feature branch, kept master clean of unwanted code, and merge our finalized changes into master.

Our changes are not yet public on Github. Our work only exists locally. If you run `hub browse` now, you'll see that the _remote_ repository does not have our most up to date commit.

Let's wrap up by publishing (pushing) our changes to github.

```
git push origin master
```

Now refresh your repository on github, and you should see your most recent work. You can also see all your commits by clicking on "code".

### Typical Git Workflow

From the example we worked through above, we can come up with a common workflow when we are only using Git locally (without worrying about GitHub yet).

1. Make a new project directory
2. Initialize the directory (`git init`)
3. Make and checkout a feature branch (`git branch` and `git checkout`)
4. Make changes to the code, add to staging area, and then commit the changes (`git add`, `git commit`)
5. Checkout the master branch and merge changes into master from the feature branch (`git merge`)
6. Repeat with more feature branches!

## Independent Practice

If you're brand new to git, start with [Try Github](https://try.github.io/levels/1/challenges/1).

If you've used git before (or if you complete try.github), work through [Git Immersion](http://gitimmersion.com/). Atlassian also has a helpful [Git Tutorial](https://www.atlassian.com/git/tutorials/setting-up-a-repository).

And, if you just can't get enough Git, check out the [Pro Git book](http://git-scm.com/book).

## Wrapup

Return to standards and check progress.
* What was easy?
* What was challenging?
* What made sense?
* What didn't make sense?
