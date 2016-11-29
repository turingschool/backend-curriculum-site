---
layout: page
title: Introduction to Vagrant
length: 90
tags: workflow, environment
---

Vagrant is a neat tool for experimenting with Virtualization. A virtualized environment:

* has it's own operating system
* runs on top of the primary operating system
* exists as a data file or "image" in the primary file system

## Goals

Let's build a development-ready environment including the following:

* Ruby Version Manager (RVM)
* Ruby 2.2
* Git
* PostgreSQL 9+
* VirtualBox
* Vagrant
* Ubuntu Linux

## Setup Process

### VirtualBox

VirtualBox is an application for running virtual machines. It's free and available for every major platform. You can [learn more about it](https://www.virtualbox.org/), or jump straight to the download page here:

<https://www.virtualbox.org/wiki/Downloads>

Look under "VirtualBox platform packages" for the binary distribution appropriate for your platform. **Run the installer and follow the instructions**.

### Vagrant

Vagrant is a system for easily managing and interacting with VirtualBox-based virtual machines. Using vagrant we can do everything from the command line and rarely if ever need to open the actual VirtualBox application. You can [learn more on the Vagrant website](http://vagrantup.com).

First, download the appropriate binary (matching your primary OS) from <http://www.vagrantup.com/downloads.html> and run the installer. The following steps in this tutorial are based on the [Vagrant Getting Started Guide](https://www.vagrantup.com/docs/getting-started/) which can be a good secondary reference.

#### Setting Up Ubuntu

The easiest way to get going is to use an Ubuntu image preconfigured and vetted by the Vagrant project team. Drop into a terminal and **change to a directory** where you'll build your project (such a `~/projects/vagrant_example`) and store the configuration for your virtual machine.

Then in that directory:

```
$ vagrant init hashicorp/precise64
```

That'll generate a `Vagrantfile`. Before starting the virtual machine, we want to setup a bridged port so we can later access a web server running in Vagrant from our host operating system.

Open that `Vagrantfile` in a text editor and modify line 22 so it looks like this:

```
config.vm.network "forwarded_port", guest: 3000, host: 3000
```

Save the file and close your editor. Return to the terminal and start the VM:

```
$ vagrant up
```

When you run `up` it'll try and boot that image, see that it's not available on the local system, then fetch an image of Ubuntu 12.04 "Precise Pangolin". Once downloaded and setup, it'll be started.

Other operating system "boxes" can be found at <https://vagrantcloud.com/discover/featured> .

#### Entering the Virtual Machine

You can now SSH into the running virtual machine:

```
$ vagrant ssh
```

You're now inside the fully-functioning virtualized operating system.

#### Synched Folders

You can share files seamlessly between your host operating system and your virtual machine. This is useful if, for instance, you'd like to use a graphical editor in the host operating system, but run the code inside the VM.

The folder that you used to store the vagrant configuration is *automatically* shared with the virtual machine. So...

* Say you're working in the directory `~/projects/vagrant_example`
* It currently contains the config file `~/projects/vagrant_example/Vagrantfile`
* You can create a file `~/projects/vagrant_example/README.md` using your host OS and any editor
* Within the VM's SSH session, you can interact with that file, like `cat /vagrant/README.md`

Check out <http://docs.vagrantup.com/v2/synced-folders/> for more complex folder synching, but this setup will be good enough for now.

### Git

You'll of course need Git for source control. Install it within the SSH session:

```
$ sudo apt-get update
$ sudo apt-get install git
```

And respond `y` to the prompt. You might notice that the `sudo` didn't ask for a password. Your Vagrant VM is setup to "trust" you. No one can login to the VM unless they're an authenticated user of your host operating system, so this is safe.

### RVM

There are several options for managing Ruby versions, but we'll use RVM with the standard "single user" method.

#### Initial Setup

From your SSH session, we first need to install the `curl` tool for fetching files, then can use a script provided by the RVM team for easy setup:

```
$ sudo apt-get install curl
$ \curl -sSL https://get.rvm.io | bash
```

As it says in the post-install instructions, we need to load RVM into the current environment by running:

```
$ source /home/vagrant/.rvm/scripts/rvm
```

Note that there will be no output from this command, but you can now see RVM:

```
$ which rvm
/home/vagrant/.rvm/bin/rvm
```

#### Requirements

The RVM tool has an awesome tool for installing all the various compilers and packages you'll need to build Ruby and common libraries. Run it like this:

```
$ rvm requirements
```

#### Ruby 2.2

You can see all the Rubies available through RVM with this command:

```
$ rvm list known
```

Then install both Ruby 2.2:

```
$ rvm install 2.2
```

It'll take awhile to compile/install.

#### Default Ruby

Run this to set your default Ruby:

```
$ rvm use 2.2 --default
```

And verify it:

```
$ which ruby
/home/vagrant/.rvm/rubies/ruby-2.1.1/bin/ruby
$ ruby -v
ruby 2.1.1p76 (2014-02-24 revision 45161) [i686-linux]
```

#### Bundler

Just about every project uses Bundler, so let's install it:

```
$ gem install bundler
```

#### JavaScript Runtime

Rails' Asset Pipeline needs a JavaScript runtime. There are several options, but let's install NodeJS:

```
$ sudo apt-get install nodejs
```

### PostgreSQL

Installing PostgreSQL isn't the most straightforward process, but let's give it a shot.

#### Locale

Postgres uses information from the operating system to determine the language and encoding of databases. Let's set that default locale before install postgres:

```
$ sudo /usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
```

#### Install

Let's get it installed with apt along with the "dev" headers that'll be needed when we later install the `pg` gem:

```
$ sudo apt-get install postgresql libpq-dev
```

#### Creating the Database Instance & Adding a User

Once installed, we need to create the database instance. Within the SSH session:

```
$ sudo mkdir -p /usr/local/pgsql/data
$ sudo chown postgres:postgres /usr/local/pgsql/data
$ sudo su postgres
$ /usr/lib/postgresql/9.1/bin/initdb -D /usr/local/pgsql/data
$ createuser vagrant
```

Respond "Y" to `Shall the new role be a superuser?` Then you can exit the `su` subshell:

```
$ exit
```

Now you're back to your Vagrant user session.

#### Add privilege for Vagrant to create database.

Postgres keeps it's own internal user system. Users can be setup to only read data, read and write, etc. Let's give the `vagrant` user permission to create databases:

```
vagrant@vagrant-ubuntu-trusty-64:~$ psql postgres
psql (9.3.5)
Type "help" for help.

postgres=> ALTER ROLE vagrant CREATEDB;
postgres-> \q
vagrant@vagrant-ubuntu-trusty-64:~$
```

#### Verifying Install and Permissions

You should now be back to the normal `vagrant@precise64:~$` prompt. Let's create a database and connect to it:

```
$ createdb sample_db`
$ psql sample_db
```

You should see the following:

```
$ psql sample_db
psql (9.1.12)
Type "help" for help.

sample_db=# \q
```

## Does it Work???

Let's clone and run a sample Rails application to make sure everything is setup correctly.

### Clone the Project

You can clone a project of your own and go through the same steps, or use this small sample project:

```
$ cd /vagrant
$ git clone https://github.com/JumpstartLab/platform_validator.git
$ cd platform_validator
```

### Rails Setup

Next we need to install dependencies and setup the database:

```
$ bundle
$ rake db:create db:migrate db:seed
```

### Rails Console

Check that the console is working properly:

```
$ rails console
2.1.1 :001 > Person.count
   (0.3ms)  SELECT COUNT(*) FROM "people"
 => 6
2.1.1 :002 > Person.all
  Person Load (0.6ms)  SELECT "people".* FROM "people"
```

### Run the Server

```
$ rails server
=> Booting Thin
=> Rails 4.0.4 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
Thin web server (v1.6.2 codename Doc Brown)
Maximum connections set to 1024
Listening on 0.0.0.0:3000, CTRL+C to stop
```

Then, in your host operating system, open <http://localhost:3000> in a browser. You should see the *Welcome aboard* page -- you're done!

## Cloning

Now it gets really cool. Because a VM is essentially a file, you can treat it like a file: copy it, back it up, share it, version it, etc.

### Creating the Image

Start within the same folder as the `Vagrantfile` and:

```
$ vagrant package
```

It'll shutdown the VM if it's running, then export a movable image named `package.box` which is about 650mb.

Move that `package.box` to another folder on your machine (like `~/projects/vagrant_2/`). Then switch to that second folder for the rest of these steps.

### Setup the Box

In a terminal from the same directory where the `package.box` file is, run the following:

```
$ vagrant box add package.box --name rails_box
```

That will "download" the box file to the local Vagrant install's set of known boxes.

### Provision and Start the Box

Now move to the project directory where the `Vagrantfile` and your application code will live. Then:

```
$ vagrant init rails_box
$ vagrant up
```

It'll clone the box then boot. Now you can `vagrant ssh` and you're ready to go!

### Double Down

Open another terminal tab, switch to the directory of your first `Vagrantfile` then `vagrant up` and `vagrant ssh`. Now each of your two tabs is running unique copies of the same VM.

Confirm that they're unique by creating a database in one VM and proving that it *isn't* present in the other VM.
