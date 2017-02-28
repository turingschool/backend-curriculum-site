---
layout: page
title: Part 3 - Serving an Application & Cloning the Image
tags: workflow, environment
---

Now that our virtual server, operating system, and required tooling are setup, let's deploy a Rails application.

## Deploy a Rails Application

For this exercise you can use any project you're comfortable with. We'll use a small sample project  called `platform_validator`, but you're welcome to substitute in any one of your projects and follow all the same steps.

Note that this project uses Ruby 2.1. If the project you use needs a different version of Ruby, install it with RVM like you did before in Part 2.

### Clone the Project

Within your virtual server:

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

## Cloning the Virtual Machine

Now it gets really cool. Because a VM is essentially a file, you can treat it like a file: copy it, back it up, share it, version it, etc.

Let's create a copy of the virtual machine and run *two* instances at once -- effectively two different servers running the same application.

### Stopping

* `ctrl-c` your running Rails app
* run `sudo shutdown now` to shutdown the VM and exit automatically

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

### Provision the Box

Now move to the project directory where the `Vagrantfile` and your application code will live. Then:

```
$ vagrant init rails_box
```

### Setup the Network

The box you create will have the same settings as the original. But let's set it up so the network ports don't overlap.

Open the `Vagrantfile` of this new copy in a text editor and modify line 22 so it looks like this:

```
config.vm.network "forwarded_port", guest: 3000, host: 3001
```

So that way port 3001 on our MacOS will map to port 3000 of the image.

### Boot & Access

Start the server, ssh in, and start the Rails app:

```
$ vagrant up
$ vagrant ssh
$ git clone https://github.com/JumpstartLab/platform_validator.git
$ cd platform_validator
$ rails server
```

### Double Vision

Open another terminal tab, switch to the directory of your first `Vagrantfile` then do the same:

```
$ vagrant up
$ vagrant ssh
$ cd platform_validator
$ rails server
```

Now each of your two tabs is running unique copies of the same VM with the same app.

Visit `http://localhost:3000` and `http://localhost:3001` in different tabs -- each one running on a different server.
