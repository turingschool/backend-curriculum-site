---
layout: page
title: Sending Email Tutorial
length: 30
tags: rails, email, sendgrid, smtp, action mailer
---

This lesson was last updated to work with Rails 5.2.0 and Ruby 2.4.1.

## WarmUp

* Let's define email.
* What do emails have to do with web apps?
* What are examples of things we can do with email in our apps?

## Sending Email with SendGrid

We'll explore sending email in Rails by building a project that requires this functionality. By the end you should understand:

* How to use ActionMailer
* How to setup  SendGrid
* Send email locally using Mailcatcher

### You've Changed

Sometimes in life, people change. Like a frog boiled slowly in a pot of
water, they may not notice. It's our job as friends to let people know:
"You've Changed".

However in-person communication is sometimes a bit dicey. Let's build an
app that lets us do this electronically via email.

What we'd like our app to do:

1. Allow us to sign up / log in
2. Allow us to enter a friend's email address
3. Send that friend a passive-aggressive email notifying them that
   "You've changed".  

## Researching with the Docs  
* [What is SMTP?](http://whatismyipaddress.com/smtp)
* [Action Mailer](http://guides.rubyonrails.org/action_mailer_basics.html)

### SMTP

* Simple Mail Transfer Protocol
* Protocol used only to send emails.
* Often limited. Comcast customers cap at 1,000 outgoing emails a day
* Gmail caps at 150 a day using a client, and 500 through the web.
* Why be there caps?
* What if you get identified as a bad person?

### Action Mailer

* NOT a super hero.
* Kind of works like a controller but for emails. Stay with me, this will make
sense later.
* If we have a controller, we have... views... but not views... emails. Views ARE the emails when it comes to Action Mailer. Just go with me on this one.

### Mailcatcher

* Mailcatcher is a local SMTP server that you run on your computer.
* Only it also receives email.
* It lets us test locally that emails are being sent the way we want them to.
* It sends emails locally but they never leave.
* We don't use mailcatcher to actually send emails, we will be using a third party service to do this - SendGrid.


## Sending Email locally with Mailcatcher

### Getting Started

For this tutorial, we are going to setup our emails to "send" through mailcatcher locally. And in production, the emails will actually send through Sendgrid. If you want to setup an account with Sendgrid in order to send emails both locally and in production, you can set up an account with them. Keep in mind that Sendgrid will provision your account at first so it might take some time to get the account set up. You should sign up for the free account.

First things first, go ahead and clone down the repo.

```shell
$ git clone https://github.com/turingschool-examples/youve_changed_v2.git youve_changed
$ cd youve_changed
$ bundle
$ rake db:{create,migrate}
```

### Rails Setup  
Run your server to see what we've already got in our repo
```
rails s
```  

So you can create an account and when you're logged in we have a form with a button that says ,"Tell them."

Where does that button take us? Welp, there's no route for that, so we have to go make one.


```rb
post '/notification' => 'notification#create'
```

So at this point we've got a route which will hit a notification controller, and we need to make a notificaion controller. Then the create action here will call our mailer. And the hip bone is connected to the leg bone, etc etc.

### Create Yonder Mailer

Lets take a quick look at the [documentation](http://guides.rubyonrails.org/action_mailer_basics.html)

Looks like our steps are as follows:

* Generate a mailer
* Edit the mailer
* Edit the mailer view

At this point we are going to kind of work backwards from our pseudo view in a similar vein to how we did things with our consuming an API.

Let's use the generator to set up our mailer, because it'll create a bunch of files for us.

```
rails g mailer FriendNotifier
```

Let's look at two files in particular. When you generated your mailer, two layouts were added to app/views/layouts - mailer.html.erb and mailer.text.erb.  Take a look at these files, what are they doing? Why do we get both an HTML and txt layout?

We're going to say that the email is going to inform them, so, in app/views/friend_notifier create two files, inform.html.erb and inform.text.erb

Depending on the person's email client you're sending the email to, it will render either the plain text or the html view. We don't have control over that, so we'll make them have the same content.

We are going to make the decision here that the recipient should know who wants them to change. For extra fun, you could probably bring in the Faker gem.

```rb
# inform.html.erb and inform.text.erb

Your "friend" <%= @user.name.capitalize %> wanted to let you know that you've changed. Tell someone else that they've changed. It's your duty.
```

Let's also change the default address the email gets sent from:

```rb
# app/mailers/application_mailer.rb

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@youvechanged.io"
  layout 'mailer'
end
```

So now we have to edit our mailer. We are using the instance variable `@user` in our view, so we need to send it a user and what other information do we need for this mailer to work? The email address we are sending it to.

And this mailer should get two things, the email address of where we are sending it and info about the person sending. We are calling the method inform to match what we decided the name of the view was, `inform`.

If we look at the ActionMail documentation, we see that there's a mail method, and it takes a hash as an argument, with two keys of note, to and subject.



```rb
# mailers/friend_notifier.rb

class FriendNotifierMailer < ApplicationMailer
  def inform(user, friend_contact)
    @user = user
    mail(to: friend_contact, subject: "#{user.name} says you've changed.")
  end
end
```

So now we have to call the mailer. Documentation is available [here](http://guides.rubyonrails.org/action_mailer_basics.html#calling-the-mailer)

As you can see, you have the flexibility to send in almost anything as a hash with all of these assorted options, but we don't _have_ to use them. We've created a method in our mailer that just takes two arguments, and we can use that without too much trouble.

What I do want to draw your attention to is the `.deliver_now` and `.deliver_later` Essentially they use ActiveJob to hand off the sending of mail and not make the user wait in the middle of our request and response cycle to have the mail sent before responding. We're gonna talk about that later.

```rb

# app/controllers/notification_controller.rb

class NotificationController < ApplicationController
  def create
    FriendNotifierMailer.inform(current_user, params[:email]).deliver_now
    flash[:notice] = "Successfully told your friend that they've changed."
    redirect_to root_url
  end
end
```

### Configuring Mailcatcher

Take a moment to see what you can figure out from the [MailCatcher](https://mailcatcher.me/) docs.

Mailcatcher allows you to test sending email. It is a simple SMTP server that receives emails, and it gives you a web interface that allows you to inspect outgoing emails. Mailcatcher does not allow the emails to actually go out, and so you are able to test that emails send, without having to worry about that email being flooded with emails.

Let's get it set up.

You want to install the Mailcatcher gem, but you do not want to add it to your gemfile in order to prevent conflicts with your applications gems.

```sh
$ gem install mailcatcher
```

Now let's setup our development config to send the emails to the mailcatcher port. Add the following code to your environments/development.rb file.

```rb
# environments/development.rb

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
```

The mail is sent through port 1025, but in order to view the mailcatcher interface we want to visit port 1080. To start up mailcatcher:

```sh
$ mailcatcher
```

Now open up http://localhost:1080 and you should see the interface for where emails are sent. Now let's test to see emails come through.

If you open up the app in a browser locally, and run through the steps to send an email, you should see the email come through on mailcatcher.

## Setting up Sendgrid email through a Heroku addon

Heroku makes it really easy to setup Sendgrid through an add on. In order to do this, you will first need to push your app to heroku.

```sh
$ heroku create
$ git push heroku master
$ heroku run rake db:migrate
```

Now, let's walk through the [SendGrid/Heroku Docs](https://devcenter.heroku.com/articles/sendgrid#actionmailer). Notice this link takes us to the `ActionMailer` section. You can send email using the SendGrid Ruby gem but we'll be using `ActionMailer` in combination with the gem. Make sure the documentation you are referencing is specific to `ActionMailer`.

Some stuff to copy and paste:

```rb
#application.rb

module YouveChangedV2
  class Application < Rails::Application
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address:              'smtp.sendgrid.net',
      port:                 '587',
      domain:               'example.com',
      user_name:            ENV["SENDGRID_USERNAME"],
      password:             ENV["SENDGRID_PASSWORD"],
      authentication:       'plain',
      enable_starttls_auto: true
    }
  end
end
```

### Don't Forget Figaro

Let's setup figaro so that we can add our username and password we got above in our command line to our application.yml file.

```rb
# Gemfile

gem 'figaro'
```

```sh
$ bundle
$ bundle exec figaro install
```

This creates an application.yml file and adds it to your .gitignore
For now, let's put our Sendgrid username and password into the newly created application.yml file.

```rb
# config/application.yml

SENDGRID_USERNAME: abcdefghijklmnop
SENDGRID_PASSWORD: 123456789
```

And remember, don't add the application.yml to your commits! We never push up our keys to Github.

Push up your changes to heroku:

```sh
$ git add .
$ git commit -m "email changes"
$ git push heroku master
```

Now that this is all setup, go out to your production app, send an email to yourself and watch it appear in your inbox (Be patient, it takes a couple minutes). Huzzah!

### Materials

* [ Repo ](https://github.com/turingschool-examples/youve_changed)
* [ Slides ](https://www.dropbox.com/s/ev7tya328sv9jyh/Turing%20-%20Sending%20Email.key?dl=0)
* [ Notes ](https://www.dropbox.com/s/p496zd4xthyrnt6/Turing%20-%20Sending%20Email%20%28Notes%29.pages?dl=0)
* [Heroku Docs for Sendgrid Addon](https://devcenter.heroku.com/articles/sendgrid#provisioning-the-add-on)
