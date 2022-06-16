---
layout: page
title: Module 3
subheading: Ruby and Rails Versions
---

## Ruby 2.7.4

We will use Ruby 2.7.4 in Module 2 & 3. You can check your Ruby version by running `ruby -v`.

Using [rbenv](https://github.com/rbenv/rbenv), you can install Ruby 2.7.4 (if you don't have it already) with:

```
rbenv install 2.7.4
```

With `rbenv` you can set your Ruby version for a directory and all subdirectories within it. If you have a `3module` directory on your machine, you can set your Ruby version for this directory (and all subdirectories) by first changing into that directory and then running

```
rbenv local 2.7.4
```

Always double check that your Ruby version is correct after changing it with `ruby -v`

## Rails 5.2.8

We will use Rails version 5.2.8 in Module 2 & 3.

Rails is a Gem, and if you are using `rbenv`, gems are specific to your current Ruby version, so you need to make sure you are on Ruby 2.7.4 before proceeding by following the instructions above.

Once you have verified your Ruby version is 2.7.4, check if you have Rails. From the command line:

```bash
$ rails -v
```

If you get a message saying rails is not installed or you do not have version 5.2.8, run

```bash
$ gem install rails --version 5.2.8
```

You may need to quit and restart your terminal session to see these changes show up when you check your rails version with:

```bash
$ rails -v
```

Be careful not to install the latest version of Rails by only doing `gem install rails` -- our curriculum is not up to date with the latest version and you will need to uninstall it.

If you instead get a version of Rails besides `5.2.8`, follow [these instructions](https://github.com/turingschool-examples/task_manager_rails/blob/master/rails_uninstall.md).
