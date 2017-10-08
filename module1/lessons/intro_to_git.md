---
layout: page
title: Intro to Git
length: 60
tags: git, github
---

## Learning Goals

After this lesson, students should be able to:  
-  Explain that git is local and github is remote  
-  Configure their local git to access their remote GitHub account via the command line  
-  Configure global .gitignore files  
-  Personalize Slack profiles with GitHub information  

## Vocabulary

- Git
- Github
- Version Control System
- Distributed Version Control System


## Warm Up  
* Has anyone heard of git before?  Thumbs Up/Down have you used it all during pre-work?  
* What do you know about GitHub? How have you used it so far?  

## Introduction to Git

### What is Git?

* Version control system
* Provides "multiple save points"
* Solving the problem of `some_docV1.doc`, `some_docV2.doc`, `some_docFinal.doc`, `some_docREALLYFINAL.doc`, etc.
* Specifically: **Distributed** Version Control System; contrasts with traditional centralized VCS (journalism, architecture, engineering)
* Git's philosophy: never lose anything

### Preliminary `gitconfig` Setup

First, let's install `git` via `brew`:

```shell
$ brew install git
==> Downloading http://git-core.googlecode.com/files/git-1.8.3.4.tar.gz
########################################################### 100.0%
```

Git stores a special configuration file at `~/.gitconfig`

-   Let's colorize git in the command line

```bash
$ git config --global color.ui true
```

-  And set up our GitHub credentials:

```bash
$ git config --global user.email "you@example.com"
$ git config --global user.name "YourUsername"
```

You can also double check what values are currently set by running `git config -l` at the command line

## Github

GitHub is a platform for hosting git repositories online. Before GitHub, developers or companies configured and ran their own independent git servers, and things were much more fragmented. Now GitHub has become the de facto community standard for hosting and sharing repositories.

You certainly don't need GitHub to use git, but its popularity and dominance, especially within the open source community, have intertwined the 2 for many users.

As you progress through becoming a more practiced git user, don't forget that these 2 are really distinct things -- `git` provides the core technology for tracking and managing source control changes, while `GitHub` provides a shared location for hosting git projects.

Currently, our local git configurations knows of our GitHub credentials - GitHub needs to know where we'll be pushing our code from. To do this, we'll generate an SSH key that they'll each know of.

-   Generate a new key by running

```bash
$ ssh-keygen -t rsa -C "you@example.com"
```

When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.
You may enter a secure passphrase if you'd like, but it's not necessary. To move ahead, continue pressing "Enter".

-   Add this new key to your system by running:

```bash
$ ssh-add ~/.ssh/id_rsa
```

-   Copy the new key to your clipboard (shortcut for OSX below):

```bash
$ pbcopy < ~/.ssh/id_rsa.pub
```

-   Let's tell GitHub about this key.

Go to [https://github.com/settings/ssh](https://github.com/settings/ssh),
and paste in the whole SSH key.

-   To test that our key is configured, type the following into the command line:

```bash
$ ssh -T git@github.com
```

-   If you get this prompt:

```bash
=> The authenticity of host 'github.com (xxx.xxx.xxx.xxx)'... can\'t be established.
RSA key fingerprint is XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX.
Are you sure you want to continue connecting (yes/no)?
```

-   Type 'yes'
-   If everything's working, you'll see the the following:

```bash
=> Hi YourUsername! You\'ve successfully authenticated, but GitHub does not provide shell access.
```

## Global `.gitignore`  
GitIgnore is a dot file used for making sure that certain types of files and directories do not get pushed up to GitHub. This may include any code with sensitive information that you do not wish to be public, or files and directories that do not need to be included with your shared public repository. There are a number of things below that just become noise as they contain many files but do not add anything for collaboration sake.  

From Terminal run:

```
$ touch ~/.gitignore
$ git config --global core.excludesfile ~/.gitignore
```

Then open `~/.gitignore` with your text editor(i.e. atom ~/.gitignore), paste, and save the following:

```ruby
# Git #
########
*.orig

# macOS #
#########
*.DS_Store
.DS_Store?
.AppleDouble
.LSOverride
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Ignore Spring Files #
#######################
/spring/*.pid

# Ignore RubyMine Files #
#######################
.idea/

# Rails #
#########
*.rbc
capybara-*.html
.rspec
/public/system
*/coverage/
/spec/tmp
**.orig
rerun.txt
pickle-email-*.html
.env

# Logs and Databases #
######################
*.log
*.sql
*.sqlite
/log
/tmp
/db/*.sqlite3
/db/*.sqlite3-journal

# Environment normalization #
#############################
/.bundle
/vendor/bundle
.powenv

# if using bower-rails ignore default bower_components path bower.json files
/vendor/assets/bower_components
*.bowerrc
bower.json

# Ruby #
########
*.gem
/.config
/InstalledFiles
/pkg/
/spec/reports/
/spec/examples.txt
/test/tmp/
/test/version_tmp/
/tmp/
.rvmrc

# Ignore Byebug command history file.
.byebug_history

# Documentation cache and generated files #
###########################################
/.yardoc/
/_yardoc/
/doc/
/rdoc/

# Environment normalization #
#############################
/.bundle/
/lib/bundler/man/

# Compiled source #
###################
*.com
*.class
*.dll
*.exe
*.o
*.so

# Packages #
############
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip
```

## Slack and Further Customizations

If you've verified the above is complete, please work through the following:

-   Customize your Slack profile (name and/or profile picture help your team identify you)
-   Add your GitHub username/profile link to your Slack profile
-   Customize your terminal - colors/themes, default directory, aliases, etc.  

## Wrap Up  

* What is git? Why do we use it?  
* What is GitHub? Why is it helpful?  
* What types of things go in a .gitignore?  
