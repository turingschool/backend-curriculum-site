# Station 1

### Getting Started

Today we are going to be diving into some Git commands that you may or may not be familiar with using. While some of the text editors have nice visuals and may assist you with your current Git workflow, our goal for today is to gain familiarity with commands that are ran from the terminal that can help improve your Git workflow. At each station you have the opportunity to experiment with these commands.

1. Go to [https://github.com/turingschool-examples/be-m4-git-lesson](https://github.com/turingschool-examples/be-m4-git-lesson)
2. __Fork__ the repo and then clone
3. Make sure you change directories to be within be-m4-git-lesson

_Note that spacing is important, so if you don't see what you expect the first time you run a command make sure there isn't a typo and that your spacing is correct._


## Exercise

At this station you are going to look at different commands and options for viewing commit history. Type each command into your terminal and answer the related question.

##### Exercise 1
 `git log`
 1. __What information does this return to you?__

##### Exercise 2
`git log --oneline --decorate --graph --all -30`
2. __How many commits are there excluding those on master?__

Each `--` is a separate option and it is not necessary to run all the commands together. Take a moment and try them individually.
- `--oneline` shows an abbreviated commit hash & commit message
- `--decorate` displays local & remote branches along with commit hash
- `--graph` draws commits with ASCII art lines to help identify branching
- `--all` shows history of all branches, not just the current one
- `-30` this could be any number and will display that number of commits

##### Exercise 3
`git log --pretty=format:'%h - %an [%aD] %s'`

3. __What is the date of the most recent commit?__

##### Exercise 4
`git log --oneline -- Gemfile`

4. __What is the most recent commit message for Gemfile?__
5. __What is the first commit for the item.rb file?__

*Gemfile* could be replaced with any file name to look at the commit history for that file. If the file is not located at the root level it will be necessary to include the path to that file.

##### Exercise 5
First run `git log --grep  'add'` then run `git log --grep 'add' -i`

6. __What is do you notice about the differences between these results?__

This command is allowing us to search through our commits by looking at the commit message. This is another great reason for why it is important to write good commit messages.

##### Exercise 6
`git blame Gemfile`

7. __How many different authors have updated this file?__

Again *Gemfile* could be replaced with any filename.
This command provides a line by line breakdown for who made the most recent commit that modified that line.

##### Exercise 7
`git show 4589ad7` (`4589ad7` is an abbreviated commit hash)

8. __Who is the author of this commit & summarize the changes that were made in this commit?__

##### Bonus time:

1. Checkout this website for additional `git log --pretty=format` options and try them out: [https://devhints.io/git-log-format](https://devhints.io/git-log-format)
2. Do some research into `git reflog`
