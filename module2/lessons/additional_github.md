---
title: Additional Github
layout: page
---

# Cool Git Stuff, and a Reminder to be Professional

## Learning Goals

- A few extra git commands and HOW-TO ideas
- shell-based git configuration shortcuts for productivity
- professional use of git

---

## Oh noes! You cloned down the wrong repo, now what?

Hint: You don't need to completely erase your work folder and start all over!

Let's say you've forked a repo from Turing, but you've accidentally cloned the Turing repo instead of your own fork. Now what?

### Enter: "git remotes"

A "remote" in git is another git repo that is related to what you already have cloned on your system. The benefit here is that you can pull and push work to different repos.

Instructors may do this at Turing all the time, it's also very common in the workplace.

- we clone a Turing project to our laptop
- we fork a copy of the repo
- we add a 'remote' to the repo
  - `git remote -v` will show you the remote "name" and the URL path to the repo
  - Ian likes to change "origin" to something more meaningful, like "turing" if it's the Turing URL, and "mine" if it's his own GitHub account
    - `git remote rename origin turing`
- we make changes and push the work to our own fork
  - `git push mine master`
- then we make a pull request from our fork to Turing's repo

---

## Did you know...?

If you fork somebody's repo, and that other person later deletes their repo, you also lose your forked copy of that repo?

Never fear!

If you have cloned their repo or your forked copy to your local system, create a new repo on GitHub with the same name, and then run `git push -u (remote_name) master` and you have your own copy for reference later on!

```bash
$ hub create old-repo-name
created repository: iandouglas/old-repo-name
```

Normally this `hub create` command would set a new "origin" remote. If you *already* have an origin remote, `hub create` WILL NOT CHANGE your old remote name. You may need to add a new remote for your own GitHub account.

```bash
$ git remote rename origin old_origin
$ git remote add origin git@github.com:your_github_username/old-repo-name
```

And now we can save our work by pushing our local code to our repo on GitHub:

```bash
$ git push -u origin master
```

---

## Squashing Commits

Many open-source contributions will want you to "squash" your commits to remove unnecessary "work in progress" markers
or commit messages that aren't helpful for tracking your progress along the way. Some workplaces will encourage
squashing unhelpful commit messages, but will generally discourage squashing ALL commit messages to a single commit.

### Scenario

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

### Disadvantages

- You lose the incremental work history of how you've built your project.
  - You can still find them in your local work history (sometimes) but work you push to GitHub will lose that history.
- Hiring managers and tech leads who evaluate your GitHub history may want to see your actual workflow so it doesn't appear that you created all portions of a feature in one "perfect" commit.

---

## .gitconfig -- Command Line shortcuts for git

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

Other Alias resources:

Be careful not to just "copy and paste" these and use them without understanding them:

- [https://dev.to/megamattmiller/the-git-aliases-that-get-me-to-friday-1cmj](https://dev.to/megamattmiller/the-git-aliases-that-get-me-to-friday-1cmj)
- [https://dev.to/nickytonline/my-git-aliases-5dea](https://dev.to/nickytonline/my-git-aliases-5dea)
- [http://durdn.com/blog/2012/11/22/must-have-git-aliases-advanced-examples/](http://durdn.com/blog/2012/11/22/must-have-git-aliases-advanced-examples/)


---

## Being Professional with Git

We all get frustrated, and sometimes we want to take it out on our poor, little github commit messages.

Be careful though: [https://twitter.com/gitlost](https://twitter.com/gitlost) (warning, contains lots of profanity!)

Employers will likely be looking through your GitHub repos, seeing how you built your projects, as part of evaluating you as a potential candidate for a job. Do you REALLY want them seeing commit messages full of swearing, or loads and loads of "this isn't working" / "this still isn't working" / "why the #$%^ isn't this working?!" commit messages?

No, of course not.

Employers also want to see what goes on in your group projects (like how well the workload was split among everyone) and how well you communicate with one another. Having civil and meaningful conversation with groupmates through GitHub comments (not just on Slack) is a great way to indicate to employers that you are happy to keep open and friendly communication going with your team.
