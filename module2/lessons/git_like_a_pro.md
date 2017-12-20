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
