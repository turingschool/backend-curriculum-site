---
layout: page
title: Rails Encrypted Credentials
length: 180
tags: apis, rails, refactoring
---

## Introduction

Would you post your password for your email account online? No, of course you wouldn’t. Just imagine the amount of damage a person could do with having access to your email account. 

So by extension, would you post your keys for the APIs that you are using on GitHub? Hopefully you haven’t been doing so, but you shouldn’t. You’ve probably been using only free APIs so far, but if you were using one that cost money or gave you access to potentially sensitive information, this is something at you would want to keep secret.

This is a real world example. People have inadvertently pushed their Amazon Web Services keys to GitHub, where someone with nefarious intentions got a hold of them and then used those credentials to spin up thousands of EC2 instances to mine bitcoin. The culprit made off with essentially free money from the careless developer’s mistake, and they were also left holding the bag for an AWS bill in the tens of thousands of dollars. Don’t make this potentially very dangerous mistake.

## How It Works

This is indeed a problem, and we have solved it in the past by using gems such as Figaro, but the kind developers on the Rails Core Team have given us the functionality to keep our secrets safe built into Rails.

We are going to assume that we are working with a fresh rails application.

You can start using rails encrypted credentials by typing in this following command.  (We are going to presume that you are using VS Code and that you’ve set it up so that you can launch it from the command line. If you don’t have that set up, documentation on how to do so is available at this [link](https://www.notion.so/Code-Notes-46f85841a678487886ddac437e95bcc8?pvs=21).

```bash
$ EDITOR="code --wait" rails credentials:edit
```

This does a couple of things. 

- The first is that it looks for a `master.key` file in your `config` folder.
- If it finds one it uses the key within, if it does not find the file, it will generate a key and place it inside the `master.key` file.
- Next it will create a temporary credentials file and open it in your code editor.

When we look at what we type in the command line above, it means that we are going to use VS Code to edit our rails encrypted credentials, but we are telling it explicitly that we want it to wait until we are finished editing it before rails will be allowed to encrypt it.

So in our editor we get a YAML file and within this file we are going to put in our keys.

```yaml
propublica:
  key: asdsa3498serghjirteg978ertertwhter

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: ugsdfeadsfg98a7sd987asjkas98asd87asdkdwfdg876fgd
```

This is what it should look like when we are done. Disregard the `secret_key_base` for now, it’s important but nothing we need to worry about right now. 

Note that we are nesting the key *****under***** propublica, so that we can stay organized. And now we should save the file and close the file in our editor. When this happens, if you keep an eye on the terminal, you can see that as soon as you closed the file rails detected it and then encrypted your keys. 

We have our keys saved and encrypted. How do we access them?  It’s essentially a big hash so there’s different ways to do it. Easiest way to demonstrate is by opening up a `rails console`.

```bash
irb(main):001:0> Rails.application.credentials.propublica
=> {:key=>"asdsa3498serghjirteg978ertertwhter"}
```

So we can see here that it’s just an embedded hash, and we can get the key any assortment of ways.

```ruby
Rails.application.credentials.propublica[:key]
```

```ruby
Rails.application.credentials.dig(:propublica, :key)
```

## Playing Nice With Others

One of the advantages with using rails encrypted credentials is that it makes it a lot easier for us to share things like API keys, especially on larger or more complex projects. Without this feature, whenever a new person would clone down a project from GitHub, someone would have to give them all the keys and they’d have to figure out how to integrate them.

What the process looks like now is wholly different. Because the `credentials.yml.enc` file is encrypted, it is safe to upload it to GitHub. What doesn’t get shared is the `master.key`. So when you are working with other people make sure the credentials file is on GitHub.

When you clone down the application, create a `master.key` file in the `config` directory. And then you’re going to get the master key and put it in that file and save. Once you do that you can try to edit the credentials. If you have the right key and put it in the master.key file it should let you decrypt the credentials file and edit it. If the key is incorrect, there will be a message in the terminal informing you as such.
