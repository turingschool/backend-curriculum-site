---
layout: page
title: Intro to Git
length: 30
tags: git, github
---

## Standards

After this lesson, students should be able to:

-  Configure their local git to access their remote GitHub account via the command line

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
brew install git
==> Downloading http://git-core.googlecode.com/files/git-1.8.3.4.tar.gz
########################################################### 100.0%
```

Git stores a special configuration file at `~/.gitconfig`

-   Let's colorize git in the command line

```bash
git config --global color.ui true
```

-  And set up our GitHub credentials:

```bash
git config --global user.email "you@example.com"
git config --global user.name "YourUsername"
```

You can also double check what values are currently set by running `git config -l` at the command line

## Github

Github is a platform for hosting git repositories online. Before github, developers or companies configured and ran their own independent git servers, and things were much more fragmented. Now Github has become the de facto community standard for hosting and sharing repositories.

You certainly don't need Github to use git, but its popularity and dominance, especially within the open source community, have made the 2 somewhat synonymous for many users.

As you progress through becoming a more practiced git user, don't forget that these 2 are really distinct things -- `git` provides the core technology for tracking and managing source control changes, while `GitHub` provides a shared location for hosting git projects.

Currently, our local git configurations knows of our GitHub credentials - GitHub needs to know where we'll be pushing or code from. To do this, we'll generate an SSH key that they'll each know of.

-   Generate a new key by running

```bash
ssh-keygen -t rsa -C "you@example.com"
```

When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.
You may enter a secure passphrase if you'd like, but it's not necessary. To move ahead, continue pressing "enter".

-   Add this new key to your system by running:

```bash
ssh-add ~/.ssh/id_rsa
```

-   Copy the new key to your clipboard (shortcut for OSX below):

```bash
  pbcopy < ~/.ssh/id_rsa.pub
```

-   Let's tell GitHub about this key.

Go to [https://github.com/settings/ssh](https://github.com/settings/ssh),
and paste in the whole SSH key.

-   To test that our key is configured, type the following into the command line:

```bash
ssh -T git@github.com
```

-   If you get this prompt, type 'yes':

```bash
The authenticity of host 'github.com (xxx.xxx.xxx.xxx)'... can\'t be established.
RSA key fingerprint is XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX.
Are you sure you want to continue connecting (yes/no)?
```

-   If everything's working, you'll see the the following:

```bash
Hi YourUsername! You\'ve succesfully authenticated, but GitHub does not provide shell access.
```

## Extensions

If you've verified the above is complete, please work through the following:

-   Customize your terminal - colors/themes, default directory, aliases, etc.
-   Customize your Slack profile (name and/or profile picture help your team identify you)
-   Add your GitHub username/profile link to your Slack profile
