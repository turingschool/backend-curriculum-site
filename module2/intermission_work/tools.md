---
title: Get Module 2 Tools
layout: page
---

## Install Rails

First, check if you have Rails. From the command line:

```bash
$ rails -v
```

If you get a message saying rails is not installed, run

```bash
gem install rails --version 5.1.7
```

Be careful not to install Rails 5.2 by only doing `gem install rails` -- our curriculum is not up to date with 5.2 changes, and you will need to uninstall 5.2.

If you instead get a version of Rails besides `5.1.x`, follow [these instructions](https://github.com/turingschool-examples/task_manager_rails/blob/master/rails_uninstall.md).

## Download PostgreSQL

Download PostgreSQL from Homebrew.

From your terminal, run:

```
brew update
brew install postgresql
brew services start postgresql
```

After this step, try running `gem install pg -v 1.1.4`

#### Gem errors?
If you get errors installing the "pg" gem, try installing PostgreSQL from https://postgresapp.com/

Follow the instructions on their site to install the application and run the database, then try `gem install pg -v 1.1.4` again.

## Install Postico

https://eggerapps.at/postico/

This is a tool that will make it much easier to navigate your local databases and build/run SQL commands.

## Install Chrome

If you are currently using another browser, download and install Chrome [here](https://www.google.com/chrome/). This will make it so that we can share shortcuts and have a consistent experience when debugging together as a class.
