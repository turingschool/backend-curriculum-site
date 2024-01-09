---
layout: page
title: Module 3
subheading: Ruby and Rails Versions
---

## Ruby 3.2.2

We will use Ruby 3.2.2 in Modules 2 & 3. You can check your Ruby version by running `ruby -v`.

Using [rbenv](https://github.com/rbenv/rbenv), you can install Ruby 3.2.2 (if you don't have it already) with:

```bash
rbenv install 3.2.2
```

NOTE: If rbenv tells you that the version you supplied is missing or not available, run 

```bash
brew update && brew upgrade ruby-build
```
This will take some time to complete. 

With `rbenv`, you can set your Ruby version to a default globally, or for a specific directory and all subdirectories within it. If you have a `2module` or `3module` directory on your machine, you can set your Ruby version for this directory (and all subdirectories) by first changing into that directory and then running

```bash
rbenv local 3.2.2
```

Or, if you wanted to set it globally for your machine, you can run 

```bash
rbenv global 3.2.2
```

Always double check that your Ruby version is correct after changing it with `ruby -v`.

## Rails 7.1.2

We will use Rails version 7.1.2 in Module 2 & 3.

Rails is a Gem, and if you are using `rbenv`, gems are specific to your current Ruby version, so you need to make sure you are on Ruby 3.2.2 before proceeding by following the instructions above.

Once you have verified your Ruby version is 3.2.2, check if you have Rails. From the command line:

```bash
$ rails -v
```

If you get a message saying rails is not installed or you do not have version 7.1.2, run

```bash
$ gem install rails --version 7.1.2
```

You may need to quit and restart your terminal session to see these changes show up when you check your rails version with:

```bash
$ rails -v
```

Be careful not to install the latest version of Rails by only doing `gem install rails` -- there are always newer versions and our curruiculum is based on these specific versions, so you will need to uninstall and reinstall correctly. 

If you instead get a version of Rails besides `7.1.2`, follow [these instructions](https://github.com/turingschool-examples/task_manager_rails/blob/master/rails_uninstall.md).
