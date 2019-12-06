# Station 3

### Getting Started

Today we are going to be diving into some Git commands that you may or may not be familiar with using. While some of the text editors have nice visuals and may assist you with your current Git workflow, our goal for today is to gain familiarity with commands that are ran from the terminal that can help improve your Git workflow. At each station you have the opportunity to experiment with these commands.

1. Go to [https://github.com/turingschool-examples/be-m4-git-lesson](https://github.com/turingschool-examples/be-m4-git-lesson)
2. __Fork__ the repo and then clone
3. Make sure you change directories to be within be-m4-git-lesson

_Note that spacing is important, so if you don't see what you expect the first time you run a command make sure there isn't a typo and that your spacing is correct._


## Exercise

##### Exercise 1
Take about __8 minutes__ on your own and do some research about git rebase.

##### Exercise 2
Checkout a new branch and make some edits by adding or removing methods from files or creating new files with some content. Create 3 new commits on this branch. Then checkout your master branch. `git rebase your_branch_name` By running this command it is taking the commits from this branch and re-applying them to the master branch. Run 'git log' to see the commits that were applied.

1. __In your own words, how would you describe git rebase?__
2. __Draw a diagram representing a git merge flow vs git rebase flow.__

##### Exercise 3
Let's talk about an interactive rebase. Interactive rebase allows us to manipulate our commit history by editing our commits. To enter an interactive rebase you must first determine at which commit you want to begin viewing the commit history. You can either use the commit hash that is before the commit at which you want to begin editing or you can use _HEAD~3_ where the _~3_ is the number or generations you want to go back.

When you begin the interactive rebase it will list out the commits you will be working with and notice the __most recent commit__ will actually be listed __last__. You should also see a section of comments. These comments are there to help you remember the options you have when doing an interactive rebase.

Today we are going to practice using this command to squash commits. When looking at the `git log --oneline` I notice there are 3 commit messages with the description of _'handwrite routez'_. Let's clean this up a little and squash this into one commit.

Start off by running the command `git rebase -i cfe5f03`
_Note:  `cfe5f03` is the hash for the commit just __before__ the first handwrite routez commit._

In the terminal you should see something like this:

```
pick 79d6204 handwrite routez
pick 5186690 handwrite routez
pick b35223d handwrite routez
pick 4c94701 Update gem versions in Gemfile.lock
pick d4c3473 Add new method to cart
pick 3e89d29 Add another new method to cart
pick a0c7de8 Remove new method from cart

# Rebase cfe5f03..a0c7de8 onto cfe5f03 (7 commands)
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
# d, drop = remove commit
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

Now replace the word `pick` with `squash` in front of `5186690` & `b35223d`.

_Note: If you are in the terminal, in order to edit anything first type i for insert. Once you are done editing, hit esc. Then type :wq (this will save our changes)._

In the terminal you should now see a message like this:
```
# This is a combination of 3 commits.
# This is the 1st commit message:

handwrite routez


# This is the commit message #2:

handwrite routez

# This is the commit message #3:

handwrite routez
"~/Turing/4_mod/little-shop/.git/COMMIT_EDITMSG" 31L, 849C
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    Hugh Morrison <hmorri32@gmail.com>
# Date:      Mon Nov 20 08:56:18 2017 -0500
#
# interactive rebase in progress; onto cfe5f03
# Last commands done (3 commands done):
#    squash 5186690 handwrite routez
#    squash b35223d handwrite routez
# Next commands to do (4 remaining commands):
#    pick 4c94701 Update gem versions in Gemfile.lock
#    pick d4c3473 Add new method to cart
# You are currently rebasing branch 'master' on 'cfe5f03'.
#
# Changes to be committed:
#       modified:   config/routes.rb
```

Here is the opportunity to edit/write the commit message we want to use. If we did not edit any of the messages it will keep them all. So, let's edit our message in the terminal and now it should look like this:

```
# This is a combination of 3 commits.
# This is the 1st commit message:
rewrite the routes

# This is the commit message #2:
# This is the commit message #3:
"~/Turing/4_mod/little-shop/.git/COMMIT_EDITMSG" 31L, 849C
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    Hugh Morrison <hmorri32@gmail.com>
# Date:      Mon Nov 20 08:56:18 2017 -0500
#
# interactive rebase in progress; onto cfe5f03
# Last commands done (3 commands done):
#    squash 5186690 handwrite routez
#    squash b35223d handwrite routez
# Next commands to do (4 remaining commands):
#    pick 4c94701 Update gem versions in Gemfile.lock
#    pick d4c3473 Add new method to cart
# You are currently rebasing branch 'master' on 'cfe5f03'.
#
# Changes to be committed:
#       modified:   config/routes.rb
```

Save the changes once you are done editing, just like how you did before.

In the terminal you should now see:
`Successfully rebased and updated refs/heads/master.`

Now when you run `git log --oneline` there should no longer be 3 commits with _'handwrite routez'_, but instead one commit with the message 'rewrite the routes'.


3. __Why would you want to be able to squash or edit past commits?__

*Bonus Time:*

1. Read this article: [Beginner’s Guide to Interactive Rebasing](https://hackernoon.com/beginners-guide-to-interactive-rebasing-346a3f9c3a6d)
