
# Station 2

### Getting Started

Today we are going to be diving into some Git commands that you may or may not be familiar with using. While some of the text editors have nice visuals and may assist you with your current Git workflow, our goal for today is to gain familiarity with commands that are ran from the terminal that can help improve your Git workflow. At each station you have the opportunity to experiment with these commands.

1. Go to [https://github.com/turingschool-examples/be-m4-git-lesson](https://github.com/turingschool-examples/be-m4-git-lesson)
2. __Fork__ the repo and then clone
3. Make sure you change directories to be within be-m4-git-lesson

_Note that spacing is important, so if you don't see what you expect the first time you run a command make sure there isn't a typo and that your spacing is correct._

## Exercise

Here at station 2 we are going to look at some helpful commands to use when we've potentially made a mistake somewhere in our workflow and need a quick fix. Work through each scenario and answer the questions.

##### Exercise 1
While on the `master` branch, edit the `order.rb` file by removing one of the methods. Now, `git stash` that change. Checkout a new branch and run `git stash apply`

Let's do something similar to what we did above. Start on the `master` branch, edit `cart.rb` file by adding a new method. `git stash` this change. Now, open the `order.rb` file and make another edit either by removing a method or adding a new method. Again run your command of `git stash`. Switch over to the branch you've already created and run `git stash list`.

1. __It's nice that we can make multiple stashes, but what could be a potential downside to having a stash list?__

To remove a stash you can specify which stash number you would like to remove like so: `git stash drop stash@{0}` Try this for yourself.

##### Exercise 2
Create a new file, such as `new.md` in our project. Run `git stash`.

Did this stash the new file?

By default `git stash` only stashes the changes for files that are currently being tracked. In order to stash untracked files we can add `-u` to `git stash`. Give it a try.

2. __How would you use git stash in your workflow?__

##### Exercise 3
On a new branch, make some changes to a few existing files like we have done previously. Create a new file with some content. Now, let's add everything. `git add .` Then look at the status of our files `git status`. Often we add everything at once because it is easier than adding each file one at a time. However, before you commit you should run `git status` to ensure you actually need all the files for that commit. Maybe we decide the new file that we created shouldn't be a part of this commit, to "un-stage" that file use the command. `git reset new_file.md` (*new_file.md* can be replaced with the file name of the one you are un-staging)

##### Exercise 4
Building off of exercise 3 with the new file still un-staged commit those changes. Let's pretend as if we had added each of those files individually because we are reviewing each file before staging it and realize after our commit we forgot to add our new file. Fortunately, git allows us to *amend* our previous commit. First, `git add new_file.md` and then `git commit --amend --no-edit`.

The `--no-edit` option allows us to keep the commit message we used rather than needing to update it. However, `git commit --amend` will also allow you to edit the last commit message in the event that you need to make it more descriptive or perhaps had a typo.

3. __Why is it good practice to not use `git add .` and instead add each file individually?__

##### Exercise 5
Continue working on the branch you've created. and make __2__ new commits by making some changes to the project. Let's say that last commit that you made actually was incomplete and you still had more work you needed to do. Rather than amending the commit, we can "undo" it by reseting the commit history. *Note: there is no way to truly undo a commit, but this command is mimicking what we would expect if we could.*  Run the command `git reset --soft HEAD^` Notice you still have all the changes from the commit that you reverted.

##### Exercise 6
Switch back to the master branch and make some changes and commit those changes. You've now decided that those changes are incomplete and broke some code so they shouldn't be on master.
Take a moment and think about how you would fix this problem before continuing.

Now that you've thought about it on your own, here is a solution for you to try. Create a branch from master that contains the changes you made. Next, switch back to master and `git reset --hard HEAD^`.

The `HEAD^` option is specifying what commit we want our commit history to point to and in this case it is the previous commit. Rather than using `HEAD^`, you can specify the commit hash you want to set it back to as well. You could then switch to the branch you made and continue working.

4. __What is the difference between `git reset --soft` & `git reset --hard`?__

##### Exercise 7
Start on the `master` branch.  Let's look at another way in which we can move our commits from one branch to another. Run `git log` to see what the last commits were and copy the latest commit hash and the commit hash that was 3 back from the current. Now we are going to move that range of commits. Checkout a new branch. While on that branch, `git cherry-pick 3_back_hash..latest_hash` (Replace with the actual hash values)

The `..` between `3_back_hash..latest_hash` excludes the 3_back commit if we want to include it simply change to `3_back_hash^..latest_hash`. *Note: the master branch will still have these commits. In order to "remove" them from master we would have to hard reset our branch.*

5. __In your opinion, what is the benefit of cherry-picking commits?__

##### Bonus Time

1. Look into the difference between `git apply` and `git pop`. Why might you use one over the other?
2. What command could I used to reset back three commits from current without using the commit hash?
3. What does `git add patch` do?
