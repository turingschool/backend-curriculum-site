---
layout: page
title: Introduction to Virtual Servers - Rails Setup
tags: workflow, environment
---

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
