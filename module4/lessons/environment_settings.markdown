---
layout: page
title: Environment Settings
length: 90
tags: workflow, professional skills
---

## Learning & Completion Goals

### Environment Variables

* Student can explain the role and usage of a shell profile like `.bash_profile`
* Student can define environment variables in a shell profile
* Student can access environment variables from a running Ruby process
* Student can define environment variables in a Heroku application
* Student can access environment variables on a running Heroku application

### Environments in Rails

* Student can use the environment configuration files to define per-environment settings
* Student can use command-line flags to set the application environment
* Student can explain how the database.yml works with the application environment to allow for per-environment settings

## Session Plan

### Schedule

Recapping what goes into a local dev environment, staging, production.

### Part 1: Shell Profile

What are environment variables? Environment (`ENV` or `env`) variables are name=value pairs set to dynamically describe the environment a machine and or program is going to run in. These values can dictate the way a program will run. Let's look at a common environment variable, `PATH` or `$PATH`. You often see `env` variable mentioned with a `$` because the dollar sign is the SHELL syntax to refer to a variable. `PATH` and `$PATH` are referring to the same variable.

#### Investigating Variables

Let's explore a few commands to help us investigate the environment variables.

You can see the values of your variables by running the command ,`env` in your terminal. The command `printenv` will show you the same output. Another command you can use to investigate the environment is `set`. The `set` command will return to you all env functions and their values too and this can be a little verbose. You can run `set \ less` to see the output without all the functions. All three of these commands generally give you the same output.

Spend a minute or two investigating these commands:

* `env`
* `printenv`
* `set`
* `set | less`


These command allow us to see all the environment variables. If you want to investigate a single variable you can use the `echo` command referring to the shell variable (ex: $SHELL). Try this: `echo $SHELL` and or `echo $PATH`. You will also most likely have variables for $TERM and $USER if you want to look at these.

#### Setting and Unsetting Temporary Variables

Now that we know how to investigate current environment variables, we can look at declaring new, or overriding existing variables temporarily. The `HOME` varaible is a common env variable we should all have. It declares what is the root of your machine. Mine for example is `/Users/Carmer`. If I navigate to my machines home or root ( `cd` or `cd ~`), I will be taken to `/User/Carmer`. You can temporarily override this, and any variable in the command line.

Setting variables is done with the `export` command. If we want to override the `HOME` variable, we can do that with the command `export HOME=/Path/I/Want/To/NavigateTo`. I'll temporarily change mine to the desktop `/Users/Carmer/Desktop`.

* `export HOME=/Users/$USER/Desktop`

You could change this to any directory you'd like. Keep in mind we are currently setting *TEMPORARY VARIABLES* for the current shell only. That means that a different window in your terminal will not have these values. Also, once you close your terminal or shell session you will lose these variables. You can see this in action:

In one window run:

* `echo $HOME`
* `export HOME=/Users/$USER/Desktop`
* `echo $HOME`

You should see the output of the echo command change to `/Users/Carmer/Desktop`. Now open a new terminal window with `command t` or up in the menu bar with Shell -> New Window.

If you run `echo $HOME` now, you will see the $HOME variable is back to it's original value. You can even flip back to the old window and see the temporary value is still what you changed it too.

Alternatively we can set completely new variables too. Let's play around with this a little.

Use the export command to set some random variables. Then use the commands that we learned to investigate the values that we set:

example: `export RANDOMVARIABLENAME="HellowWOWOWOWVariable"`

To unset or remove a temporary environment variable you can use the `unset` command followed by the Shell variable name you want to unset. `unset $RANDOMVARIABLENAME`.

#### Pragmatically, Why?

What might we use this for?? Let's get into the mindset of a Rails Developer. If I want to run a bunch of commands in a different environment, say `staging` or `production`, we can set a temporary env variable in the current Shell session so we don't have to manually declare the name of the environment every time we run a rails command.

### Part 2: Rails

#### Boot Cycle for a Rails App

I think it's important to first dig into how a Rails app boots up. [Here are the Rails Guides](http://guides.rubyonrails.org/initialization.html) for the initialization process. 


### Part 3: Heroku

*Note: setting env variable can happen on the fly. no need to re deploy. use-case: ecommerce site front page with dynamic content. Could have some env variable something like 'low bandwidth true -> make sure you render static plain site'*
